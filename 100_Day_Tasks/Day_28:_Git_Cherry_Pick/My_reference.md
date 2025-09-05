
https://tundedamian.medium.com/day-28-of-100-days-of-devops-real-world-git-surgery-in-a-devops-workflow-26495a8956a7

https://www.atlassian.com/git/tutorials/cherry-pick

https://git-scm.com/docs/git-cherry-pick

*Running git log feature --oneline*
- Branch requirement: Doesn't matter which branch you're on.
- Effect: Shows commit history of feature branch in one-line format regardless of current branch.

Reason
- git log <branch> views history of specified branch.
- Current checked-out branch doesn't affect this.

Do you need help with:
- Viewing history of specific Git branches?
- Working with Git branches and commands?
- Something else related to Git?

*Checking if git cherry-pick 364366e Worked*
- Command: git log --oneline
- Check for:
- Commit 364366e's changes now on current branch (master).
- A new commit applying those changes.

Alternative Check
- git show HEAD: Shows latest commit (the cherry-pick result).

Notes
- If conflicts occurred, you'd need to resolve them before completing cherry-pick.
- git status can also show if cherry-pick is in progress.

Do you need help with:
- Verifying Git operations like cherry-pick?
- Resolving Git conflicts?
- Something else related to Git?

## *Command: git log feature --oneline*
- Effect: Shows commit history of feature branch in one-line format.
- Output: Compact view with commit hashes and messages.

Example Output

abc123 Update info.txt
def456 Add new feature code
ghi789 Initial commit on feature


Exiting Git Log Page
- Method: Press q (for quit).
- Context: git log uses a pager (like less) to show output.
- Result: Pressing q exits the log view and returns to terminal.


