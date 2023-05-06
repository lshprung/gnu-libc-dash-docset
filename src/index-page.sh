#!/usr/bin/env sh

# shellcheck source=./lib/create_table
. "$(dirname "$0")"/lib/create_table
# shellcheck source=./lib/insert
. "$(dirname "$0")"/lib/insert

DB_PATH="$1"
shift

get_title() {
	FILE="$1"

	pup -p -f "$FILE" 'title text{}' | \
		sed 's/ (The GNU C Library)//g' | \
		tr -d \\n | \
		sed 's/\"/\"\"/g'
}

insert_pages() {
	# Get title and insert into table for each html file
	while [ -n "$1" ]; do
		unset PAGE_NAME
		unset PAGE_TYPE
		PAGE_NAME="$(get_title "$1")"
		PAGE_TYPE="Guide"
		if [ -n "$PAGE_NAME" ]; then
			insert "$DB_PATH" "$PAGE_NAME" "$PAGE_TYPE" "$(basename "$1")"
		fi
		shift
	done
}

create_table "$DB_PATH"
insert_pages "$@"
