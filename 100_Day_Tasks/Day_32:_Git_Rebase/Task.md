
### Task:
The Nautilus application development team has been working on a project repository /opt/demo.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:

One of the developers is working on feature branch and their work is still in progress, however there are some changes which have been pushed into the master branch, the developer now wants to rebase the feature branch with the master branch without loosing any data from the feature branch, also they don't want to add any merge commit by simply merging the master branch into the feature branch. Accomplish this task as per requirements mentioned.

Also remember to push your changes once done.

---------------------------------------------------------

### What I Did

```
thor@jumphost ~$ ssh natasha@ststor01

[natasha@ststor01 ~]$ sudo -s

[root@ststor01 ~]# cd /usr/src/kodekloudrepos/demo/

[root@ststor01 demo]# ls -alh

total 20K
drwxr-xr-x 3 root root 4.0K Aug 24 16:50 .
drwxr-xr-x 3 root root 4.0K Aug 24 16:50 ..
drwxr-xr-x 8 root root 4.0K Aug 24 16:50 .git
-rw-r--r-- 1 root root   22 Aug 24 16:50 feature.txt
-rw-r--r-- 1 root root   34 Aug 24 16:50 info.txt

[root@ststor01 demo]# git branch

* feature

  master

[root@ststor01 demo]# git status

On branch feature
nothing to commit, working tree clean

[root@ststor01 demo]# git log

commit a3f2e8dc2578edb3b2c8073e115cf8353431f89c (HEAD -> feature, origin/feature)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:44 2025 +0000

    Add new feature

commit fbc071d26a9f066faacd185e5cc3fae4888f3164
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:43 2025 +0000

    initial commit

[root@ststor01 demo]# git checkout feature
Already on 'feature'

[root@ststor01 demo]# git rebase master

Successfully rebased and updated refs/heads/feature.

[root@ststor01 demo]# git log

commit 5238ff0a35a823512ef5fb19ea8822ec26fba56b (HEAD -> feature)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:44 2025 +0000

    Add new feature

commit 1735e0f0f98ae3d2d07ffeef9ac4af0f2a3c7039 (origin/master, master)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:44 2025 +0000

    Update info.txt

commit fbc071d26a9f066faacd185e5cc3fae4888f3164
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:43 2025 +0000

    initial commit

[root@ststor01 demo]# git push origin feature --force-with-lease

Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 295 bytes | 295.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/demo.git
 + a3f2e8d...5238ff0 feature -> feature (forced update)

[root@ststor01 demo]# git log

commit 5238ff0a35a823512ef5fb19ea8822ec26fba56b (HEAD -> feature, origin/feature)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:44 2025 +0000

    Add new feature

commit 1735e0f0f98ae3d2d07ffeef9ac4af0f2a3c7039 (origin/master, master)
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:44 2025 +0000

    Update info.txt

commit fbc071d26a9f066faacd185e5cc3fae4888f3164
Author: Admin <admin@kodekloud.com>
Date:   Sun Aug 24 16:50:43 2025 +0000

    initial commit
```

### Command Sequence Explanation
1. *cd /usr/src/kodekloudrepos/demo/*
- Goes to the demo repo directory.

2. *ls -alh*
- Lists files/directories with detailed info.

3. *git branch*
- Shows local branches, highlights current.

4. *git status*
- Shows working directory status.

5. *git log*
- Shows commit history.

6. *git checkout feature*
- Switches to feature branch.

7. *git rebase master*
- Rebases feature onto master.

8. *git log*
- Shows updated commit history post-rebase.

9. *git push origin feature --force-with-lease*
- Force-pushes rebased feature to remote, safer check.

10. *git log*
- Shows commit history again after push.

Do you need help with:
- Understanding this Git workflow?
- Working with rebases and force pushes?
- Something else related to Git?
