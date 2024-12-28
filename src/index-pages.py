#!/usr/bin/env python3

import os
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "..", "scripts"))
from create_table import create_table
from get_title import get_title
from insert import insert

def insert_page(db_path, html_path):
    page_name = get_title(html_path)
    page_name = page_name.replace(' (The GNU C Library)', '')

    page_type = "Guide"

    insert(db_path, page_name, page_type, os.path.join("libc", os.path.basename(html_path)))

if __name__ == '__main__':
    db_path = sys.argv[1]

    create_table(db_path)
    for html_path in sys.argv[2:]:
        insert_page(db_path, html_path)
