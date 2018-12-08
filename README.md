# Content processings script(s)
Script(s) for current project to automate html generation.

Will improve or replace with off-the-shelf solution as my requirements are discovered.

## Script(s) included:
* **process_md.sh**\
  Finds all .md files in pwd and subdirectories, uses cmark to convert to html, writes file with same names but extension changed to .html\
  Writes output to OUTPUT_DIR (default: __output), preserving relative directory structure.
