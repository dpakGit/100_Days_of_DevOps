https://tundedamian.medium.com/day-30-of-100-days-of-devops-resetting-git-history-to-a-specific-commit-b582fa47032a

### Task Explanation
- Goal: Reset /usr/src/kodekloudrepos/beta repo's history to have only two commits: "initial commit" and "add data.txt file".
- Action: Move HEAD and branch to "add data.txt file" commit, removing later commits.

Steps to Accomplish Task
1. SSH to Storage server.

bash
ssh storage-server # Assume credentials if needed


2. Go to repo.

bash
cd /usr/src/kodekloudrepos/beta


3. Find commit hash for "add data.txt file".

bash
git log --oneline
# Find hash for "add data.txt file" (e.g., abc123)


4. Reset to "add data.txt file" commit.

bash
git reset --hard abc123 # Replace abc123 with actual hash


5. Push changes (force).

bash
git push origin <branch> --force # Replace <branch> with actual branch (e.g., master/main)


Explanation of Commands
- *git log --oneline*: Shows short commit history.
- *git reset --hard abc123*: Moves HEAD to commit abc123, discarding later commits.
- *git push --force*: Force-pushes changes (use carefully).

Notes
- Caution: git reset --hard discards changes after target commit.
- Caution: push --force rewrites remote history.

Do you need help with:
- *Using git reset for history cleanup*?
- Force pushing to Git remotes?
- Something else related to Git?

### *Using git reset for Target Commit*
- Goal: Keep only "initial commit" and "add data.txt file".
- Action: You want to reset to the "add data.txt file" commit.
- Command: Use git reset --hard eb2fb58 ("add data.txt file").

Why Not Both?
- Running git reset --hard twice in succession like that would:
- First reset to "initial commit".
- Then reset to "add data.txt file" (latter overrides former).
- Correct: Only need git reset --hard eb2fb58 to end up with two commits: "initial commit" and "add data.txt file".

*sudo Usage*
- Typically don't need sudo for Git commands unless repo permissions require it.

Do you need help with:
- *Using git reset correctly*?
- Understanding Git history manipulation?
- Something else related to Git?
