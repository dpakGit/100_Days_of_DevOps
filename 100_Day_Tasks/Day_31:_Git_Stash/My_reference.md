https://tundedamian.medium.com/day-31-of-100-days-of-devops-restoring-committing-stashed-git-changes-9c68a238dddc


### Task Explanation
- Goal: Restore stashed changes with identifier stash@{1} in /usr/src/kodekloudrepos/demo.
- Action: Apply stash, commit, and push.

Steps to Accomplish Task
1. Go to repo.

bash
cd /usr/src/kodekloudrepos/demo


2. List stashes.

bash
git stash list
# Check if stash@{1} exists


3. Apply stash@{1}.

bash
git stash apply stash@{1}


4. Commit changes.

bash
git add .
git commit -m "Restored stash@{1} changes"


5. Push change
bash
git push origin <branch> # Replace <branch> with current branch


Explanation of Commands
- *git stash list*: Shows stashed changes.
- *git stash apply*: Applies stash without removing it from stash list.
- *git add & git commit*: Commits applied changes.
- *git push*: Pushes to remote.

Do you need help with:
- Working with Git stashes?
- Applying and managing stashed changes?
- Something else related to Git?

