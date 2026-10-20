# Tutorial: git version control system

A short, practical git course for anyone, written as **runnable Jupyter notebooks** that also build into a website.
You execute the commands one cell at a time, in a throwaway repository you cannot break.
The example being versioned is a few dozen lines of naval architecture for a box-shaped barge, not a web application.

**The notebooks are the course.**
There is no written-up copy of them to keep in step: one chapter is one notebook, and editing it is the whole edit.
GitHub renders notebooks in the browser, so they read fine without running anything.

`docs/` holds just two pages: the contents, and the cheat sheet.

Start from [docs/index.md](docs/index.md), or open [notebooks/00-setup.ipynb](notebooks/00-setup.ipynb).

## Contents

| Chapter | Covers |
| - | - |
| [0. Setting up](notebooks/00-setup.ipynb) | install, identity, config, the sample code |
| [1. Commits](notebooks/01-commits.ipynb) | staging area, commits, diffs, `amend`, `restore`, `.gitignore` |
| [2. Branches](notebooks/02-branches.ipynb) | `switch`, HEAD, the graph view |
| [3. Merging](notebooks/03-merging.ipynb) | fast-forward, merge commits, conflicts |
| [4. Rebase](notebooks/04-rebase.ipynb) | replaying commits, `rebase -i`, the golden rule |
| [5. Remotes and origin](notebooks/05-remotes.ipynb) | bare servers, `push`, `fetch`, `pull`, tracking |
| [6. Forks](notebooks/06-forks.ipynb) | `upstream`, pull requests, syncing a fork |
| [7. Cherry-pick](notebooks/07-cherry-pick.ipynb) | backporting one commit to a release |
| [8. Submodules](notebooks/08-submodules.ipynb) | the pin, fresh clones, updating, pitfalls |
| [9. Cheat sheet](docs/09-cheat-sheet.md) | every command, and how to get unstuck |

## Running the notebooks

They need git and Python 3.12 or newer with Jupyter, and run the same on Windows, macOS and Linux:

```bash
pip install jupyterlab
jupyter lab notebooks/00-setup.ipynb
```

A cell starting with `!` runs a shell command, so `!git status` in a notebook is exactly the `git status` you would type in a terminal.
Each notebook works in its own directory under `~/git-course/`, wiped and recreated by its first cell, so you can re-run a chapter from the top as often as you like and nothing you do touches your real repositories.

Remotes, forks and submodule servers are local bare repositories rather than GitHub accounts, so there is nothing to sign up for and you can see that a git server is only a repository without a working tree.
Every command is the one you would type against a real URL.

## Working on the course

```bash
make test     # run all nine notebooks top to bottom in a throwaway HOME
make serve    # preview the website locally
```

`make test` executes every notebook from the first cell, in a temporary `HOME` with its own git identity, so it never touches your configuration or your repositories.
If Jupyter lives in a virtualenv, pass its path: `make test JUPYTER=~/ros_ws/venv/bin/jupyter`.

## Layout

```text
notebooks/   the course: one runnable notebook per chapter
docs/        the site's two pages: the contents, and the cheat sheet
_layouts/    page layout
_includes/   the contents sidebar (toc.html), MathJax and Mermaid
assets/      stylesheet (LaTeX-article look), scripts and Computer Modern fonts
llms.txt     index for language models
Makefile     test, serve
```

## Website

**Preview locally** with Docker:

```bash
docker compose up
# open http://localhost:4000/lecture_notes_git/
```

This builds the site the same way GitHub Pages does — Jekyll for the pages, then `tools/render_notebooks.sh` to turn each notebook into a page — and serves the result.
It builds once, so run it again after editing.

**Publish** with GitHub Pages: push to `main`, then set *Settings > Pages > Source* to *GitHub Actions*.
The workflow in `.github/workflows/pages.yml` builds and deploys the site at `https://<user>.github.io/<repository>/`.
If your default branch is `master`, change the branch in that workflow to match.

Every page has a contents sidebar listing the pages in filename order, then the notebooks, with the current page's sections; it folds into a drawer on small screens.
The title links to the front page, and `\url[mainpage]{…}` in the top right links to the root of the domain the site is served from.

The page design is after [Gradfolio](https://github.com/jitinnair1/gradfolio) and [LatexJekyll](https://github.com/Hammie217/LatexJekyll).

## License

MIT. See [LICENSE.md](LICENSE.md).
