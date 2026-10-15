#!/bin/sh
# Render notebooks/*.ipynb as .html pages inside a built site, then point every
# link at them. Links in the source say .ipynb so they work on GitHub and in
# VS Code; only the built copies are changed.
#
#   sh tools/render_notebooks.sh [site-dir]     (default: _site)
set -e
site=${1:-_site}

jupyter nbconvert --to html --output-dir "$site/notebooks" notebooks/*.ipynb

# 1. every link to a notebook goes to its rendered page instead
# 2. the cheat-sheet link inside the notebooks goes to its page on the site
# 3. drop nbconvert's optional ELK layout plugin: while it loads, mermaid
#    auto-renders the first diagram on its own and nbconvert then breaks it
find "$site" -name '*.html' -exec sed -i -E \
  -e 's#(href="[^"]*)\.ipynb(["\#])#\1.html\2#g' \
  -e 's#href="\.\./docs/09-cheat-sheet\.md"#href="../09-cheat-sheet/"#g' \
  -e 's#const elkUrl = "[^"]*";#const elkUrl = "";#' \
  {} +

# 4. the copy button on code cells, as on the pages
sed -i \
  -e 's#</head>#<link rel="stylesheet" href="../assets/css/notebook.css">\n</head>#' \
  -e 's#</body>#<script src="../assets/js/copy-code.js"></script>\n</body>#' \
  "$site"/notebooks/*.html
