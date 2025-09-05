### Task

The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/demo present on Storage server in Stratos DC. One of the developers stashed some in-progress changes in this repository, but now they want to restore some of the stashed changes. Find below more details to accomplish this task:

Look for the stashed changes under /usr/src/kodekloudrepos/demo git repository, and restore the stash with stash@{1} identifier. Further, commit and push your changes to the origin.

---------------------------


### What I Did

```
thor@jumphost ~$ ssh natasha@ststor01

[natasha@ststor01 ~]$ sudo -s

[root@ststor01 natasha]# cd /usr/src/kodekloudrepos/demo

[root@ststor01 demo]# ls -alh
total 16K
drwxr-xr-x 3 root root 4.0K Aug 24 13:49 .
drwxr-xr-x 3 root root 4.0K Aug 24 13:49 ..
drwxr-xr-x 8 root root 4.0K Aug 24 13:49 .git
-rw-r--r-- 1 root root   34 Aug 24 13:49 info.txt

[root@ststor01 demo]# git stash list

stash@{0}: WIP on master: 757bdda initial commit

stash@{1}: WIP on master: 757bdda initial commit

[root@ststor01 demo]# git stash apply stash@{1}

On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   welcome.txt

# welcome.txt is already staged after git stash apply. 
# *git add .*: Not needed since welcome.txt is already staged.
   

[root@ststor01 demo]# git commit -m "Restored stash@{1} changes"

[master 4268344] Restored stash@{1} changes
 1 file changed, 1 insertion(+)
 create mode 100644 welcome.txt

[root@ststor01 demo]# git branch # To see we are in which branch
* master

[root@ststor01 demo]# git push origin master
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 317 bytes | 317.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/demo.git
   757bdda..4268344  master -> master

[root@ststor01 demo]# git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

[root@ststor01 demo]# git log
commit 42683448f058e25ec20a197c625a16e1f7f3dd2e (HEAD -> master, origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:56:52 2025 +0000

    Restored stash@{1} changes

commit 757bddadbf35300bb7b5076c2b45d296549602eb
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:49:12 2025 +0000

    initial commit
```


### Command Sequence Explanation
1. *cd /usr/src/kodekloudrepos/demo*
- Changes directory to the demo Git repository.

2. *ls -alh*
- Lists all files/directories in the repo with detailed info.

3. *git stash list*
- Shows list of stashed changes.

4. *git stash apply stash@{1}*
- Applies changes from stash@{1}.

5. *git commit -m "Restored stash@{1} changes"*
- Commits applied stash changes.

6. *git branch*
- Shows current branch (confirms you're on a branch like master).

7. *git push origin master*
- Pushes commit to master on remote origin.

8. *git status*
- Shows working directory status (should be clean now).

9. *git log*
- Shows commit history including new commit.

Do you need help with:
- Understanding Git workflow like this?
- Working with Git stashes and commits?
- Something else related to Git?
