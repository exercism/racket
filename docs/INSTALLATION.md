# Installation
You can download the latest Racket installer from [the official Racket website](https://download.racket-lang.org/).  Installers are available for Windows (64-bit and 32-bit), macOS (Apple Silicon and Intel) and Linux (64-bit).

If you prefer to use a package manager, like `brew` on MacOS, `winget` on Windows or your Linux distribution's package manager, see [the Racket Wiki](https://github.com/racket/racket/wiki/Installing-Racket) for more detailed instructions.

Please reference Racket's [Getting Started](http://docs.racket-lang.org/getting-started/) page for guidance materials.

The [Racket Guide](https://docs.racket-lang.org/guide/intro.html) introduces you to interacting with Racket. 

See [DrRacket: The Racket Programming Environment](https://docs.racket-lang.org/drracket/index.html) for guidance using the DrRacket IDE.

See [Command-Line Tools and Your Editor of Choice](https://docs.racket-lang.org/guide/other-editors.html) for an introduction to racket command line tool and using other editors.


## About the Linux installer:
The Linux build is generic enough that it should work on most distributions, including relatively old distributions. 

After downloading the installer file, run it with
```
sh racket-8.8-x86_64-linux-cs.sh
```

You man need to prefix `sudo` to the start of the command to install to a location that requires adminstrator access.

**Warning: Racket may also be available through your distribution's package manager, although it may be older than the latest Racket version.** While you may choose to do this later, as a learner you will have a much better experience if you stick to the current release available from https://download.racket-lang.org


## About the macOS installer:

If your machine uses the M1 or M2 series processors, select **Apple Silicon** in the platform dropdown menu before downloading.
