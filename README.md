# Content processings script(s)
Script(s) for current project to automate html generation.

Will improve or replace with off-the-shelf solution as my requirements are discovered.

## Script(s) included:
* **process_md.sh**\
  Finds all .md files in pwd and subdirectories, uses cmark to convert to html, writes file with same names but extension changed to .html\
  Wraps content from .md file in a body tag and adds a doctype, lang, charset, and viewport settings.
  If a file named style.css is included in pwd, the file is copied to a OUTPUT_DIR/css and the css file is linked in all output documents.
  Writes output to OUTPUT_DIR (default: __output), preserving relative directory structure.

## Installation
Copy script(s) to a location listed in your PATH environment variable
