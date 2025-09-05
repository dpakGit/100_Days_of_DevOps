### Task :

The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/beta present on Storage server in Stratos DC. This was just a test repository and one of the developers just pushed a couple of changes for testing, but now they want to clean this repository along with the commit history/work tree, so they want to point back the HEAD and the branch itself to a commit with message add data.txt file. Find below more details:

In /usr/src/kodekloudrepos/beta git repository, reset the git commit history so that there are only two commits in the commit history i.e initial commit and add data.txt file.

Also make sure to push your changes.

---------------------------------------

### What I Did

```
thor@jumphost ~$ ssh natasha@172.16.238.15

[natasha@ststor01 ~]$ sudo -s

[root@ststor01 natasha]# ls -alh

[root@ststor01 natasha]# cd /usr/src/kodekloudrepos/beta

[root@ststor01 beta]# ls -alh
total 20K
drwxr-xr-x 3 root root 4.0K Aug 24 13:03 .
drwxr-xr-x 3 root root 4.0K Aug 24 13:03 ..
drwxr-xr-x 8 root root 4.0K Aug 24 13:03 .git
-rw-r--r-- 1 root root   32 Aug 24 13:03 beta.txt
-rw-r--r-- 1 root root   10 Aug 24 13:03 info.txt

[root@ststor01 beta]# git log

commit 5ff0d70f673e1b6f8b505cb37a4b5c4c28858b1c (HEAD -> master, origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit10

commit 7ceb10c9326500ef235c17a4b4cb3b872308ffd3
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit9

commit d1a11857469e7cc27b7a73842efa602913853325
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit8

commit 1d6ea4ca36ce485092bf8a83f14cc459a08d838f
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit7

commit 918189ceccd825d67bdab4bc6f81ef7b931cde5d
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit6

commit 789c28a566111d5144426f0fa1f9694bb4965724
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit5

commit 939cfaf1940ccba2999618e9138c6076f618a019
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit4

commit b7b65e73e5b639023cab9c38f52abc8dc70f65e0
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit3

commit ea3b27b04e47307d87f31b64d33c7ae79b27fbb4
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit2

commit e2cd3bf5859c9d03dac6d8d99dab01ced25774d4
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    Test Commit1

commit 2ee36aa24a2dca9a40e870ec5e578049cc5bb3d3
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    add data.txt file

commit d1fffb5f5adb961d8d0a35318482a18da74662a4
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    initial commit

[root@ststor01 beta]# git log --oneline
5ff0d70 (HEAD -> master, origin/master) Test Commit10
7ceb10c Test Commit9
d1a1185 Test Commit8
1d6ea4c Test Commit7
918189c Test Commit6
789c28a Test Commit5
939cfaf Test Commit4
b7b65e7 Test Commit3
ea3b27b Test Commit2
e2cd3bf Test Commit1
2ee36aa add data.txt file
d1fffb5 initial commit

[root@ststor01 beta]# git reset --hard 2ee36aa # Reset to "add data.txt file" commit.

HEAD is now at 2ee36aa add data.txt file

[root@ststor01 beta]# git log --oneline

2ee36aa (HEAD -> master) add data.txt file

d1fffb5 initial commit

[root@ststor01 beta]# git log

commit 2ee36aa24a2dca9a40e870ec5e578049cc5bb3d3 (HEAD -> master)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    add data.txt file

commit d1fffb5f5adb961d8d0a35318482a18da74662a4
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    initial commit

[root@ststor01 beta]# git push origin master --force # Or -f will also doTotal 0 (delta 0), reused 0 (delta 0), pack-reused 0

To /opt/beta.git
 + 5ff0d70...2ee36aa master -> master (forced update)

[root@ststor01 beta]# git log

commit 2ee36aa24a2dca9a40e870ec5e578049cc5bb3d3 (HEAD -> master, origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    add data.txt file

commit d1fffb5f5adb961d8d0a35318482a18da74662a4
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 13:03:58 2025 +0000

    initial commit

[root@ststor01 beta]# git status

On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

```

### Command Sequence Explanation
1. *cd /usr/src/kodekloudrepos/beta*
- Changes directory to the beta Git repository.

2. *ls -alh*
- Lists all files/directories in the repo with detailed info.

3. *git log*
- Shows full commit history with details.

4. *git log --oneline*
- Shows commit history in compact one-line format.

5. *git reset --hard 2ee36aa*
- Resets repo to commit 2ee36aa. Discards all changes after that commit.

6. *git log --oneline & git log*
- Show commit history (now truncated to before/after reset).

7. *git push origin master --force*
- Force-pushes local master history to remote. Overwrites remote history.

8. *git log & git status*
- git log: Shows commit history again.
- git status: Shows working directory status (should be clean after reset).

Do you need help with:
- *Understanding effects of git reset --hard*?
- *Using Git history commands like git log*?
- Something else related to Git?
