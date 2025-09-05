https://tundedamian.medium.com/day-32-of-100-days-of-devops-git-rebase-in-action-8d8e024fc442

### Task Explanation
- Goal: Rebase feature branch onto master without losing data or adding a merge commit.
- Location: /usr/src/kodekloudrepos clone of /opt/demo.git.

Steps to Accomplish Task
1. Go to repo.

bash
cd /usr/src/kodekloudrepos


2. *Ensure on feature branch*.

bash
git checkout feature


3. *Rebase feature onto master*.

bash
git rebase master
# Resolve conflicts if any


4. Push changes (force).

bash
git push origin feature --force


Explanation of Commands
- *git rebase master*: Reapplies feature commits on top of master. Avoids merge commit.
- *git push --force*: Needed after rebase to update remote feature.

Notes
- Caution: Rebasing rewrites history. Use --force to push.
- Caution: If others work on feature, they may need to rebase/reset.

Do you need help with:
- *Using git rebase for branch updates*?
- Handling rebases and force pushes?
- Something else related to Git?


### Task Explanation
- Goal: Rebase feature branch onto master without losing data or adding a merge commit.
- Location: /usr/src/kodekloudrepos clone of /opt/demo.git.

Steps to Accomplish Task
1. Go to repo.

bash
cd /usr/src/kodekloudrepos


2. *Ensure on feature branch*.

bash
git checkout feature


3. *Rebase feature onto master*.

bash
git rebase master
# Resolve conflicts if any


4. Push changes (force).

bash
git push origin feature --force


Explanation of Commands
- *git rebase master*: Reapplies feature commits on top of master. Avoids merge commit.
- *git push --force*: Needed after rebase to update remote feature.

Notes
- Caution: Rebasing rewrites history. Use --force to push.
- Caution: If others work on feature, they may need to rebase/reset.

Do you need help with:
- *Using git rebase for branch updates*?
- Handling rebases and force pushes?
- Something else related to Git?
