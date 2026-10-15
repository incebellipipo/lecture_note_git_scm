# 9. Cheat sheet

Every command in the course on one page, then what to do when something has
gone wrong.

## Starting

| Command | What it does |
| - | - |
| `git init` | make the current directory a repository |
| `git clone <url>` | copy a repository, setting up `origin` |
| `git clone --recurse-submodules <url>` | ... and fill its submodules |
| `git config --global user.name "..."` | set the name on your commits |
| `git config --global --list --show-origin` | every setting, and where it lives |

## Every day

| Command | What it does |
| - | - |
| `git status` | where everything is — run it whenever unsure |
| `git status --short` | the compact version |
| `git add <file>` | stage a file for the next commit |
| `git add -p` | stage a change hunk by hunk |
| `git commit -m "..."` | record what is staged |
| `git commit -am "..."` | stage every tracked change, then commit |
| `git diff` | your files against the staging area |
| `git diff --staged` | the staging area against the last commit |
| `git log --oneline` | the history, one line each |
| `git log --oneline --graph --all --decorate` | the shape of everything |
| `git show <commit>` | one commit and its diff |

## Branches

| Command | What it does |
| - | - |
| `git switch -c <name>` | create a branch here and move onto it |
| `git switch <name>` | move to a branch |
| `git branch -v` | list branches with their latest commit |
| `git branch -d <name>` | delete, refusing to orphan commits |
| `git merge <branch>` | join a branch into this one |
| `git merge --no-ff <branch>` | ... always making a merge commit |
| `git merge --abort` | abandon a merge in progress |
| `git rebase <branch>` | replay this branch's commits on top of another |
| `git rebase -i HEAD~3` | reorder, squash, reword, drop the last three |
| `git cherry-pick <commit>` | copy one commit onto this branch |
| `git stash` / `git stash pop` | park uncommitted changes, get them back |

## Remotes

| Command | What it does |
| - | - |
| `git remote -v` | which remotes, and their URLs |
| `git remote add <name> <url>` | add one (`origin`, `upstream`) |
| `git fetch` | download new commits, change nothing else |
| `git fetch --prune` | ... and drop stale `origin/*` names |
| `git pull --rebase` | fetch, then replay your commits on top |
| `git pull --no-rebase` | fetch, then merge |
| `git push` | send commits to the tracked branch |
| `git push -u origin <branch>` | publish a branch and track it |
| `git push origin --delete <branch>` | delete a branch on the server |
| `git branch -vv` | what tracks what |
| `git log --oneline main..origin/main` | what they have that you do not |

## Undoing

| Situation | Command |
| - | - |
| Discard a change in a file | `git restore <file>` |
| Unstage a file, keep the change | `git restore --staged <file>` |
| Fix the last commit's message | `git commit --amend -m "..."` |
| Add a forgotten file to the last commit | `git add <file>` then `git commit --amend --no-edit` |
| Undo a commit, keeping the changes staged | `git reset --soft HEAD~1` |
| Undo a commit and its changes | `git reset --hard HEAD~1` (destructive) |
| Undo a commit that is already pushed | `git revert <commit>` |
| Find a commit you think you lost | `git reflog` |

`git revert` makes a **new** commit that undoes an old one, which is why it is
the safe choice on a shared branch: it adds to history instead of rewriting it.

## When something has gone wrong

**"I am in a conflict and I do not understand."** `git status` lists the
unresolved files; `git diff --name-only --diff-filter=U` lists only their names.
Edit each one until it is right, delete the `<<<<<<<`, `=======` and `>>>>>>>`
lines, `git add` it, then `git commit` (merge) or `git rebase --continue`
(rebase). Or get out: `git merge --abort`, `git rebase --abort`,
`git cherry-pick --abort`.

**"My push was rejected."** Somebody else pushed first. `git pull --rebase`,
then push again. Never `git push --force` on a shared branch.

**"I committed on the wrong branch."** `git switch right-branch`,
`git cherry-pick <the commit>`, then go back and drop it from the wrong branch
with `git rebase -i`.

**"I committed a secret."** Change the secret — assume it is compromised. Then,
if it is not yet pushed, `git reset --soft HEAD~1`, remove it, add it to
`.gitignore` and commit again.

**"I think I lost a commit."** You almost certainly have not. `git reflog` lists
everywhere HEAD has been, including commits no branch points at, and
`git switch -c rescue <hash>` brings one back. Unreachable commits survive for
weeks before garbage collection.

**"My submodule directory is empty."** `git submodule update --init --recursive`.

**"I have no idea where I am."** This sequence is always safe and usually
enough:

```bash
git status
git fetch
git log --oneline --graph --all --decorate
```

## Three habits worth more than any command

1. **Commit small and often, with messages that say why.** A commit you can
   describe in one line is a commit you can revert, cherry-pick, or explain in
   a viva.
2. **Branch for everything, and merge soon.** Branches are free; long-lived
   branches are not.
3. **Before you rewrite history, ask who else has it.** Amend and rebase are
   excellent on your own unpushed work and a menace on anything shared.

Back to the [contents](index.md).
