Dash docset generator for the
[GNU C Library](https://www.gnu.org/savannah-checkouts/gnu/libc/index.html)

### Instructions

- Download the pre-built documentation 
[](https://sourceware.org/glibc/manual/latest/html_node/libc-html_node.tar.gz)

- `gnu-libc-dash-docset-generator MANUAL_SOURCE`

    - If `pipx` is installed, you can avoid `pip install`ing anything and just
    run `pipx run gnu-libc-dash-docset-generator MANUAL_SOURCE`
    - `MANUAL_SOURCE` will be the path to the html sources, which 
    should be something like `libc/`
    - For a full set of options: `gnu-libc-dash-docset-generator -h`
