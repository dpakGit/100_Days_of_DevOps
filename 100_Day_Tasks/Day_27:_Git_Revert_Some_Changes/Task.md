### Task:

```
thor@jumphost ~$ ssh natasha@ststor01

[natasha@ststor01 ~]$ sudo -s

[root@ststor01 natasha]# cd /usr/src/kodekloudrepos/apps

[root@ststor01 apps]# ls -alh
total 16K
drwxr-xr-x 3 root root 4.0K Aug 22 13:35 .
drwxr-xr-x 3 root root 4.0K Aug 22 13:35 ..
drwxr-xr-x 8 root root 4.0K Aug 22 13:35 .git
-rw-r--r-- 1 root root   33 Aug 22 13:35 apps.txt

[root@ststor01 apps]# git log

commit cd4c9f1db7a93851f43a0e184f6a058153c7f3c0 (HEAD -> master, origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Fri Aug 22 13:35:59 2025 +0000

    add data.txt file

commit cc8c9ea8b0f2384f63526f2807883537523b5a04
Author: Admin <admin@kodekloud.com>
Date:   Fri Aug 22 13:35:59 2025 +0000

    initial commit

[root@ststor01 apps]# git log --oneline


cd4c9f1 (HEAD -> master, origin/master) add data.txt file
cc8c9ea initial commit

[root@ststor01 apps]# git revert --no-edit HEAD -m "revert apps"
error: option `mainline' expects a number greater than zero

[root@ststor01 apps]#  git revert HEAD --no-edit

[master b1ab4f6] Revert "add data.txt file"
 Date: Fri Aug 22 13:45:06 2025 +0000
 1 file changed, 1 insertion(+)
 create mode 100644 info.txt

[root@ststor01 apps]# git log --oneline

b1ab4f6 (HEAD -> master) Revert "add data.txt file"
cd4c9f1 (origin/master) add data.txt file
cc8c9ea initial commit

[root@ststor01 apps]# sudo git commit --amend -m "revert apps"

[master ee7d6da] revert apps
 Date: Fri Aug 22 13:45:06 2025 +0000
 1 file changed, 1 insertion(+)
 create mode 100644 info.txt


[root@ststor01 apps]# git log --oneline

ee7d6da (HEAD -> master) revert apps
cd4c9f1 (origin/master) add data.txt file
cc8c9ea initial commit
```

```
[root@ststor01 apps]# history |cut -c 8-
cd /usr/src/kodekloudrepos/apps
ls -alh
git log
git log --oneline
git revert HEAD --no-edit
git log --oneline
git commit --amend -m "revert apps"
git log --oneline
history |cut -c 8-
```

```
 Sequence of Commands Explained
1. *cd /usr/src/kodekloudrepos/apps*

- Changed directory to /usr/src/kodekloudrepos/apps.

2. *ls -alh*

- Listed all files/directories in apps with detailed info.

3. *git log*

- Showed commit history in default format.

4. *git log --oneline*

- Showed commit history in compact one-line format.

5. *git revert HEAD --no-edit*

- Reverted changes of latest commit (HEAD).

- Created a new commit undoing those changes (with default message).

6. *git log --oneline*

- Showed updated commit history in one-line format.

7. *git commit --amend -m "revert apps"*

- Changed message of the revert commit to "revert apps".

8. *git log --oneline*

- Showed final commit history in one-line format.

Effect

- Reverted latest commit.

- Changed revert commit's message to "revert apps".
```

https://git-scm.com/docs/git-revert

#### Note : The command  "git revert HEAD --no-edit performs the following actions":

Reverts the last commit (HEAD):

git revert is a command used to undo changes introduced by a specific commit. When HEAD is specified, it targets the most recent commit on the current branch.

Creates a new "revert" commit:

Unlike git reset, which modifies the commit history, git revert creates a new commit that contains the inverse of the changes introduced by the targeted commit. This preserves the project's history, making it suitable for shared repositories or when you need to undo changes without rewriting history.

Suppresses the commit message editor:

The --no-edit option prevents Git from launching the default text editor (e.g., Vim, Nano) to allow you to customize the commit message for the revert commit. Instead, Git automatically generates a default commit message, typically indicating that the commit is a revert of the specified commit.

The --no-edit flag will allow you to make the amendment to your commit without changing its commit message.

In essence, git revert HEAD --no-edit safely undoes the changes of the last commit by creating a new commit that reverses those changes, without requiring manual input for the commit message.


#### Note : The command "git commit --amend -m "revert apps"

https://www.atlassian.com/git/tutorials/rewriting-history#:~:text=Use%20git%20commit%20%2D%2Damend,than%20a%20standard%20git%20rebase.

Adding the -m option allows you to pass in a new message from the command line without being prompted to open an editor.
