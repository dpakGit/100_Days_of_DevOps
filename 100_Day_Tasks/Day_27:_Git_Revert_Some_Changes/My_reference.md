https://tundedamian.medium.com/day-27-of-100-days-of-devops-git-revert-and-commit-rewrite-in-production-8df34c580b25

[22-Aug-25 6:57 PM] Meta AI: *sudo git revert HEAD --no-edit*
- Command does:
- Reverts changes made by the latest commit (HEAD).
- Creates a new commit that undoes those changes.
- --no-edit: Uses default revert message without opening editor.
- Effect:
- Preserves history by adding a new "revert" commit.

Notes
- Doesn't require sudo typically for Git operations unless dealing with permissions issues.
- Revert creates a new commit; use git reset if you want to alter history.

Do you need help with:
- Understanding Git revert vs reset?
- Working with Git history and commits?
- Something else related to Git?
[22-Aug-25 6:59 PM] Meta AI: *sudo git commit --amend -m "revert official"*
- Command does:
- Modifies the most recent commit.
- Changes commit message to "revert official".
- Notes:
- sudo typically not needed for Git commands unless permissions issues.
- --amend alters last commit; use carefully as it changes history.

Context
- If you ran git revert before, this would change the revert commit's message.

Do you need help with:
- Using Git commit --amend?
- Working with Git history and commits?
- Something else related to Git?



[22-Aug-25 7:11 PM] Meta AI: *Error with git revert --no-edit HEAD -m "revert apps"*
- Issue: -m option is for specifying parent number for merge commits.
- HEAD is likely not a merge commit.
- Error cause:
- Git expects a number (parent) with -m for merge reverts.

Fix
- For non-merge commits, don't use -m:

bash
git revert --no-edit HEAD

- If you want to specify message:

bash
git revert --no-edit -m "revert apps" HEAD # doesn't work as expected due to -m
git revert -m "revert apps" HEAD           # doesn't work due to -m misuse
# Correct:
git revert --no-edit HEAD
# Or customize message with edit
git revert -e HEAD
# then edit message in editor to "revert apps"


Corrected command

bash
git revert --no-edit HEAD


Do you need help with:
- Reverting non-merge commits in Git?
- Working with Git commits and messages?
- Something else related to Git?
[22-Aug-25 7:12 PM] Meta AI: Command You Used
- You used:

bash
git revert --no-edit HEAD -m "revert apps"

- Context:
- Attempted to revert latest commit (HEAD) with message "revert apps".
- -m caused error since HEAD isn't a merge commit.

Do you need help with:
- Understanding Git revert for non-merge commits?
- Working with Git commits and messages?
- Something else related to Git?
