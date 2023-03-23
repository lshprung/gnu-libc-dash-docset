# Dash Docset Template

This is a repository providing a template to package a Dash docset from HTML source documentation. Files that need to be manually configured are listed below. Additional fine tuning is also recommended, depending on the quirks of the documentation being packaged. An example docset packaging script for GNU Make using this template can be seen [here](https://github.com/lshprung/gnu-make-dash-docset)

### `README.template`

This file will provide a README for the packaging script. Replace `<NAME>`, `<UPSTREAM LINK>`, and `<UPSTREAM HOST>` with appropriate values.

### `Makefile`

This file will build the docset.

- `DOCSET_NAME` must be set
- `MANUAL_FILE` must be set
	- If the script should download documentation from the internet, `MANUAL_URL` must also be set. If not, ensure a `.tgz` archive of the HTML documentation exists at `tmp/MANUAL.tgz` (where MANUAL is the name of the archive)

### `src/icon.png`

If you want to associate an icon with the docset, it should be saved to `src/icon.png`.

### `src/index.sh`

This is the main script that builds the docset index. This script does not require any manual modifications, but you will probably want to make additions/changes to improve the quality of your docset and accomodate any quirks.

### `src/Info.plist`

This file contains metadata for the docset. Replace `<!-- VALUE -->` with appropriate values. It may be useful to refer to the `Info.plist` file of an existing docset for reference.
