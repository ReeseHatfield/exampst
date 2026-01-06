# Typst Files
This folder contains all the necessary files to compile a typst document.

## Compiling

To compile typst projects, you'll likely need our local project tools packages. This directory is a valid typst package, to install this package locally:

You can copy these files to {data-dir}/typst/packages/{namespace}/{name}/{version} to make them available locally on your system. Where, {data-dir} is

- `$XDG_DATA_HOME` or `~/.local/share on Linux`
- `~/Library/Application Support` on macOS
- `%APPDATA%` on Windows

Or if you are on linux, just run the `create-local-package.sh` script.

You’ll also need to configure fonts before compiling. There are two main ways to do this:

### 1. Using the env variable
Set the `TYPST_FONT_PATHS` variable to point to your ^Fonts^ directory:
```bash
export TYPST_FONT_PATHS=$(realpath Fonts)
```
You can set this before you compile or add it to your `.bashrc` to make it permanent.

### 2. Passing a flag
Alternatively, you can specify the font path directly when compiling:
```bash
typst compile [--font-path path/to/Fonts] Project.typ output.pdf
```

Or for live development with automatic rebuilds:
```bash
typst watch [--font-path path/to/Fonts] Project.typ output.pdf
```
