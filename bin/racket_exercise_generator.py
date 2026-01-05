import json, toml, os, argparse, sys, string
from custom_json_encoder import CustomJSONEncoder


def find_racket_main():
    up_one = os.path.split(os.getcwd())[0]
    return ".." if os.path.split(up_one)[1] == "racket" else "."


TARGET = os.path.abspath(find_racket_main() + "/exercises/practice")


def create_directory_structure(exercise_name):
    """
    Creates the exercise, .meta, and .docs directories.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.
    """
    if not os.path.exists(exercise := f"{TARGET}/{exercise_name}"):
        os.makedirs(exercise)
    if not os.path.exists(meta := f"{exercise}/.meta"):
        os.makedirs(meta)
    if not os.path.exists(docs := f"{exercise}/.docs"):
        os.makedirs(docs)


def create_meta_config(exercise_name, prob_spec_exercise, author):
    """
    Auto-generates the .meta/config.json file.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter prob_spec_exercise: A filepath to the location of the exercise folder
    in the problem-specifications repository.
    Precondition: prob_spec_exercise is a string of a valid filepath.

    Parameter author: The Github handle of the author.
    Precondition: author is a string.
    """
    config_data = None
    with open(f"{prob_spec_exercise}/metadata.toml") as file:
        config_data = toml.load(file)  # Get the blurb, source, and source_url

    # Add the files, authors, and contributors to the config_data
    config_data["files"] = {}
    config_data["files"]["test"] = [f"{exercise_name}-test.rkt"]
    config_data["files"]["solution"] = [f"{exercise_name}.rkt"]
    config_data["files"]["example"] = [".meta/example.rkt"]
    config_data["authors"] = [author]
    config_data["contributors"] = []

    with open(f"{TARGET}/{exercise_name}/.meta/config.json", "w") as file:
        # Encode into a string in json format and write to file
        # TODO: Use configlet instead? What about the author?
        file.write(json.dumps(config_data, cls=CustomJSONEncoder, indent=3))
        file.write("\n")


def create_instructions(exercise_name, prob_spec_exercise):
    """
    Auto-generates the .docs/instructions.md file

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter prob_spec_exercise: A filepath to the location of the exercise folder
    in the problem-specifications repository.
    Precondition: prob_spec_exercise is a string of a valid filepath.
    """
    input_file = f"{prob_spec_exercise}/description.md"
    output_file = f"{TARGET}/{exercise_name}/.docs/instructions.md"
    with open(input_file, "r", encoding="utf-8") as read_from:
        with open(output_file, "w", encoding="utf-8") as write_to:
            # Replace first line with "# Instructions\n" during copy process
            write_to.write(
                "# Instructions\n" + "\n".join(read_from.read().split("\n")[1:])
            )


def create_test_example_solution_files(exercise_name, prob_spec_exercise):
    """
    Auto-generates the test file.

    Function creates the test file in its own right, but also calls the
    create_example_and_solution_files function.  This function also creates
    the parameters to feed into the create_example_and_solution_files function.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter prob_spec_exercise: A filepath to the location of the exercise folder
    in the problem-specifications repository.
    Precondition: prob_spec_exercise is a string of a valid filepath.
    """
    data = None
    with open(f"{prob_spec_exercise}/canonical-data.json") as file:
        data = json.load(file)

    # Boilerplate test code.  Multiline docstring format used to maintain
    # correct indentation and to increase readability.
    exercise_string = """#lang racket/base

(require "{0}.rkt")

(module+ test
  (require rackunit rackunit/text-ui)
""".format(
        exercise_name
    )

    # Check if some tests expect errors
    expect_errors = any(
        [
            "error" in case["expected"].keys()
            for case in data["cases"]
            if isinstance(case["expected"], dict)
        ]
    )

    # If so, add the definition of the helper function to test returned errors
    if expect_errors:
        exercise_string += """
  (define (exn-msg-matches? msg f)
    (with-handlers ([exn:fail? (lambda (exn)
                                 (string=? (exn-message exn) msg))])
      (f)))
"""

    exercise_string += """
  (define suite
    (test-suite
     \"{0} tests\"""".format(
        exercise_name
    )

    # func_name_dict is a dictionary of all function names and their
    # expected input argument names.
    func_name_dict, tests_string = create_test(data["cases"], exercise_name)

    # tests_string is sandwiched between exercise_string and more boilerplate
    # code at the end of the file.
    exercise_string += (
        tests_string
        + """))

  (run-tests suite))
"""
    )

    with open(f"{TARGET}/{exercise_name}/{exercise_name}-test.rkt", "w") as file:
        file.write(exercise_string)

    create_example_and_solution_files(exercise_name, func_name_dict)


def create_test(cases, exercise_name, fnd=dict()):
    """
    Auto-generates tests for the test file.

    Parameter cases: A list of test cases to be Racketified.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter fnd: A dictionary of all function names and their expected
    input argument names.
    Precondition: fnd is a dictionary.

    Returns a tuple of fnd and the test string
    """

    # Helper functions only used in create_test function
    def to_kebab_case(string):
        from_snake = string.replace("_", "-")
        from_camel = "".join(
            [f"-{c.lower()}" if c.isupper() else c for c in from_snake]
        )
        return from_camel

    def to_predicate(string, expected_result):
        # TODO: Understand, adapt and document this function
        if not isinstance(expected_result, bool):
            return string
        elif (partitioned := string.partition("-"))[2]:
            if "-" in partitioned[2] or partitioned[2][-1] == "p":
                return partitioned[2] + "-p"
            else:
                return partitioned[2] + "p"
        else:
            return partitioned[0] + ("-p" if "p" == partitioned[0][-1] else "p")

    # Normal code begins here
    output = ""
    for case in cases:
        try:
            # Add function_name and func_params to fnd
            kebab_func_name = to_kebab_case(case["property"])
            function_name = to_predicate(kebab_func_name, case["expected"])
            func_params = [to_kebab_case(param) for param in list(case["input"])]
            fnd[function_name] = func_params

            # Prepare the arguments to pass to the tested function
            args = []
            for value in case["input"].values():
                arg = racketify(value)
                args.append(arg)
            joined_args = " ".join(args)

            output += create_test_string(
                case["description"],
                joined_args,
                case["expected"],
                function_name,
            )
        except KeyError:
            # Recursively dig further into the data structure
            fnd, string = create_test(case["cases"], exercise_name, fnd)
            output += string

    return fnd, output


def create_test_string(desc, args, expected, func_name):
    # Handle errors differently
    if isinstance(expected, dict) and "error" in expected.keys():
        return create_error_test_string(desc, args, func_name)

    # TODO: Check the better way to test equality depending on the type
    equality = ""
    if isinstance(expected, int) or isinstance(expected, float):
        equality = "test-eqv?"
    elif isinstance(expected, str) and len(expected) == 1:
        equality = "test-equal?"
    elif isinstance(expected, str):
        equality = "test-equal?"
    else:
        equality = "test-equal?"

    expected_result = racketify(expected)

    # Multiline docstring format used to maintain correct indentation
    # and to increase readability.
    return """

     ({0} "{1}"
                  ({2} {3})
                  {4})""".format(
        equality,
        desc,
        func_name,
        args,
        expected_result,
    )


def create_error_test_string(desc, args, func_name):
    # Multiline docstring format used to maintain correct indentation
    # and to increase readability.
    return """

     (test-exn "{0}"
                exn:fail?
                  (lambda () ({1} {2})))""".format(
        desc,
        func_name,
        args,
    )


def create_example_and_solution_files(exercise_name, func_name_dict):
    """
    Auto-generates the .meta/example.rkt and the 'exercise'.rkt files.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter func_name_dict: A dictionary of all function names and their
    expected input argument names.
    Precondition: func_name_dict is a dictionary.
    """

    # Boilerplate code.  Multiline docstring format used to maintain
    # correct indentation and to increase readability.
    file_string = """#lang racket

(provide {0})
""".format(
        " ".join(func_name_dict.keys())
    )

    # For each function-parameters pairing, add the requisite function
    # definition to the file.
    for func, params in func_name_dict.items():
        file_string += """
(define ({0} {1})
  (error "Not implemented yet"))
""".format(
            func, " ".join(params)
        )

    with open(f"{TARGET}/{exercise_name}/{exercise_name}.rkt", "w") as file:
        file.write(file_string)

    with open(f"{TARGET}/{exercise_name}/.meta/example.rkt", "w") as file:
        file.write(file_string)


def create_test_toml(exercise_name, prob_spec_exercise):
    """
    Auto-generates the .meta/tests.toml file.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter prob_spec_exercise: A filepath to the location of the exercise folder
    in the problem-specifications repository.
    Precondition: prob_spec_exercise is a string of a valid filepath.
    """

    # Nested helper function that will either build a string in a toml
    # style, or recursively dig until it finds the data and then build
    # a string.
    def find_uuids_and_descriptions(cases):
        output = ""
        for case in cases:
            try:
                # Add lines in toml style
                output += '\n[{0}]\ndescription = "{1}"\n'.format(
                    case["uuid"], case["description"]
                )
            except KeyError:
                # Recursively dig further into the data structure
                output += find_uuids_and_descriptions(case["cases"])

        return output

    # Non-nested code starts here
    data = None
    with open(f"{prob_spec_exercise}/canonical-data.json") as file:
        data = json.load(file)

    # Boilerplate comment at top of test.toml
    toml_string = """# This is an auto-generated file.
#
# Regenerating this file via `configlet sync` will:
# - Recreate every `description` key/value pair
# - Recreate every `reimplements` key/value pair, where they exist in problem-specifications
# - Remove any `include = true` key/value pair (an omitted `include` key implies inclusion)
# - Preserve any other key/value pair
#
# As user-added comments (using the # character) will be removed when this file
# is regenerated, comments can be added via a `comment` key.
"""
    toml_string += find_uuids_and_descriptions(data["cases"])

    with open(f"{TARGET}/{exercise_name}/.meta/tests.toml", "w") as file:
        file.write(toml_string)


def brand_new_exercise(exercise_name: str, prob_spec_exercise: str, author: str = ""):
    """
    A delegation function.

    Call this function to build the exercise.

    Parameter exercise_name: Name of the exercise to be generated.
    Precondition: exercise_name is a string of a valid exercise.

    Parameter prob_spec_exercise: A filepath to the location of the exercise folder
    in the problem-specifications repository.
    Precondition: prob_spec_exercise is a string of a valid filepath.

    Parameter author: The Github handle of the author.
    Precondition: author is a string.
    """
    # This MUST be called first
    create_directory_structure(exercise_name)

    # The order that these functions are called is unimportant
    create_test_example_solution_files(exercise_name, prob_spec_exercise)
    # TODO: Use configlet instead?
    create_meta_config(exercise_name, prob_spec_exercise, author)
    create_instructions(exercise_name, prob_spec_exercise)
    create_test_toml(exercise_name, prob_spec_exercise)


def racketify(value, string_to_keyword=False):
    """
    Converts a given value from a Python data type into its Racket counterpart.

    Returns the following conversions:
        lists/arrays -> lists
        bools -> #t or #f
        ints -> ints
        floats -> floats
        strings -> strings (or chars if string len == 1) or keywords
        dicts -> hash tables (or the expected error message if key == "error")

    Parameter value: The value which needs to be converted (i.e. Racketified).
    Parameter string_to_keyword: Boolean to signal that strings should be
    converted into keywords.
    """
    if isinstance(value, list):
        return "'(" + " ".join([racketify(v) for v in value]) + ")"
    elif isinstance(value, bool):
        return "#t" if value else "#f"
    elif isinstance(value, int) or isinstance(value, float):
        return str(value)
    elif isinstance(value, str):
        if len(value) == 1:
            # TODO: Handle special chars (space, tab, ...)
            # see: https://docs.racket-lang.org/reference/reader.html#%28part._parse-character%29
            return f"#\\{value}"
        else:
            return f":{value.lower()}" if string_to_keyword else f'"{value}"'
    elif isinstance(value, dict):
        key_value_pairs = []
        for k, v in value.items():
            if k == "error":
                return f'"{v}"'
            key_value_pairs += ["({0} . {1})".format(racketify(k, True), racketify(v))]
        return "'#hash(" + " ".join(key_value_pairs) + ")"
    elif value is None:
        return "null"
    else:
        raise TypeError(
            "racketify function does not know how to handle value of type: "
            + str(type(value))
        )


def no_arguments():
    exercise_name = None
    prob_spec = None

    while prob_spec == None or not os.path.exists(f"{prob_spec}/exercises"):
        fp = input(
            "Enter the path (relative or absolute) to the problem-specifications repository: "
        )
        prob_spec = os.path.abspath(fp)

    top_loop = True
    while top_loop:
        while exercise_name == None or not os.path.exists(
            f"{prob_spec}/exercises/{exercise_name}"
        ):
            exercise_name = input(
                "Enter the name of the exercise you wish to generate: "
            )
        if os.path.exists(f"{TARGET}/{exercise_name}"):
            while True:
                confirmation = input(
                    "You are about to overwrite an existing exercise!  Confirm (Y/N): "
                )
                confirmation = confirmation.upper()
                if confirmation == "Y" or confirmation == "YES":
                    top_loop = False
                    break
                elif confirmation == "N" or confirmation == "NO":
                    exercise_name = None
                    break
        else:
            break

    author = input("Author's Github handle: ")

    prob_spec_exercise = f"{prob_spec}/exercises/{exercise_name}"
    brand_new_exercise(exercise_name, prob_spec_exercise, author)


def execute_via_cli(args):
    prob_spec = os.path.abspath(args.Path)
    if not os.path.exists(f"{prob_spec}/exercises"):
        print(
            "racket_exercise_generator: error: problem-specifications repository not found"
        )
        sys.exit()

    exercise_name = args.Exercise
    if not os.path.exists(f"{prob_spec}/exercises/{exercise_name}"):
        print(
            "racket_exercise_generator: error: exercise does not exist in problem-specifications repository"
        )
        sys.exit()

    if os.path.exists(f"{TARGET}/{exercise_name}") and not args.f:
        print(
            "racket_exercise_generator: error: exercise already exists in Racket repository"
        )
        sys.exit()

    author = args.Author
    prob_spec_exercise = f"{prob_spec}/exercises/{exercise_name}"
    brand_new_exercise(exercise_name, prob_spec_exercise, author)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="racket_exercise_generator",
        description="Practice exercise generator for Racket",
        usage="%(prog)s [-f] [path exercise author]",
    )

    parser.add_argument(
        "Path",
        metavar="path",
        action="store",
        type=str,
        help="relative or absolute path to problem-specifications repository",
        nargs="?",
    )
    parser.add_argument(
        "Exercise",
        metavar="exercise",
        action="store",
        type=str,
        help="name of the exercise to be generated",
        nargs="?",
    )
    parser.add_argument(
        "Author",
        metavar="author",
        action="store",
        type=str,
        help="author's Github handle",
        nargs="?",
    )
    parser.add_argument(
        "-f", action="store_true", help="force overwrite of existing exercise folder"
    )

    args = parser.parse_args()

    arg_states = [args.Path == None, args.Exercise == None, args.Author == None]

    if all(arg_states):
        no_arguments()
    elif any(arg_states):
        arg_num = arg_states.count(False)
        print(
            f"racket_exercise_generator: error: expected 0 or 3 arguments - received {arg_num}"
        )
        sys.exit()
    else:
        execute_via_cli(args)

    print("\nDone!")
