#!/usr/bin/env sh

DB_PATH="$1"
shift

create_table() {
	sqlite3 "$DB_PATH" "CREATE TABLE IF NOT EXISTS searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);"
	sqlite3 "$DB_PATH" "CREATE UNIQUE INDEX IF NOT EXISTS anchor ON searchIndex (name, type, path);"
}


get_title() {
	FILE="$1"

	pup -p -f "$FILE" 'title text{}' | \
		tr -d \\n | \
		sed 's/\"/\"\"/g'
}

insert() {
	NAME="$1"
	TYPE="$2"
	PAGE_PATH="$3"

	sqlite3 "$DB_PATH" "INSERT INTO searchIndex(name, type, path) VALUES (\"$NAME\",\"$TYPE\",\"$PAGE_PATH\");"
}

insert_pages() {
	# Get title and insert into table for each html file
	while [ -n "$1" ]; do
		unset PAGE_NAME
		unset PAGE_TYPE
		PAGE_NAME="$(get_title "$1")"
		PAGE_TYPE="Guide"
		if [ -n "$PAGE_NAME" ]; then
			insert "$PAGE_NAME" "$PAGE_TYPE" "$(basename "$1")"
		fi
		shift
	done
}

create_table
insert_pages "$@"
