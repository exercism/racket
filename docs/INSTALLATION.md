# Installation

You can download the latest Racket installer from [the official Racket website][racket-dl].  
Installers are available for Windows (64-bit and 32-bit), macOS (Apple Silicon and Intel) and Linux (64-bit).

If you prefer to use a package manager, like `brew` on MacOS, `winget` on Windows or your Linux distribution's package manager, see [the Racket Wiki][racket-wiki-install] for more detailed instructions.

## Linux

The Linux build is generic enough that it should work on most distributions, including relatively old distributions.
After downloading the installer file, run it with

```shell
sh racket-8.8-x86_64-linux-cs.sh
```

You may need to prefix `sudo` to the start of the command to install to a location that requires administrator access.

~~~~exercism/caution
Racket may also be available through your distribution's package manager, although it may be older than the latest Racket version.
While you may choose to use your package manager's version now and upgrade to the current version later, as a learner you will have a much better experience if you stick to the current release available from the official download site.
~~~~

## macOS

If your machine uses the M1 or M2 series processors, select **Apple Silicon** in the platform dropdown menu before downloading.

## IDEs

See [DrRacket: The Racket Programming Environment][racket-drracket] for guidance using the DrRacket IDE.

See [Command-Line Tools and Your Editor of Choice][racket-clt] for an introduction to racket command line tool and using other editors.

[racket-dl]: https://download.racket-lang.org
[racket-wiki-install]: https://github.com/racket/racket/wiki/Installing-Racket
[racket-drracket]: https://docs.racket-lang.org/drracket/index.html
[racket-clt]: https://docs.racket-lang.org/guide/other-editors.html
