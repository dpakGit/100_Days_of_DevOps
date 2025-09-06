### Task.md

The Nautilus application development team was working on a git repository /opt/blog.git which is cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to setup a hook on this repository, please find below more details:

Merge the feature branch into the master branch`, but before pushing your changes complete below point.

Create a post-update hook in this git repository so that whenever any changes are pushed to the master branch, it creates a release tag with name release-2023-06-15, where 2023-06-15 is supposed to be the current date. For example if today is 20th June, 2023 then the release tag must be release-2023-06-20. Make sure you test the hook at least once and create a release tag for today's release.

Finally remember to push your changes.


-------------------------------------------

### What I Did

```
thor@jumphost ~$ ssh natasha@172.16.238.15

[natasha@ststor01 ~]$ sudo -s

-----------------------
 Note: What to do where:

Operations Location
- Context: You need to set up a hook in the bare repo /opt/blog.git.
- Cloned repo location: /usr/src/kodekloudrepos.
- Hook setup location: Must be in the bare repo /opt/blog.git/hooks.

Steps Breakdown
1. *Merge feature into master*: Do this in /usr/src/kodekloudrepos.
2. *Create post-update hook*: Do this in /opt/blog.git/hooks.
3. Test hook: Push from /usr/src/kodekloudrepos to trigger hook in /opt/blog.git.

--------------------------


# - Navigate to the hooks directory in the bare repository:

[root@ststor01 ~]# cd /opt/blog.git/hooks/

[root@ststor01 hooks]# ls -alh
total 72K
drwxr-xr-x 2 root root 4.0K Aug 25 06:42 .
drwxr-xr-x 7 root root 4.0K Aug 25 06:42 ..
-rwxr-xr-x 1 root root  482 Aug 25 06:42 applypatch-msg.sample
-rwxr-xr-x 1 root root  900 Aug 25 06:42 commit-msg.sample
-rwxr-xr-x 1 root root 4.7K Aug 25 06:42 fsmonitor-watchman.sample
-rwxr-xr-x 1 root root  193 Aug 25 06:42 post-update.sample
-rwxr-xr-x 1 root root  428 Aug 25 06:42 pre-applypatch.sample
-rwxr-xr-x 1 root root 1.7K Aug 25 06:42 pre-commit.sample
-rwxr-xr-x 1 root root  420 Aug 25 06:42 pre-merge-commit.sample
-rwxr-xr-x 1 root root 1.4K Aug 25 06:42 pre-push.sample
-rwxr-xr-x 1 root root 4.8K Aug 25 06:42 pre-rebase.sample
-rwxr-xr-x 1 root root  548 Aug 25 06:42 pre-receive.sample
-rwxr-xr-x 1 root root 1.5K Aug 25 06:42 prepare-commit-msg.sample
-rwxr-xr-x 1 root root 2.8K Aug 25 06:42 push-to-checkout.sample
-rwxr-xr-x 1 root root 2.3K Aug 25 06:42 sendemail-validate.sample
-rwxr-xr-x 1 root root 3.6K Aug 25 06:42 update.sample


# - *Create a post-update hook script*:

[root@ststor01 hooks]# vi post-update

----------------------------------------
Note:
- Add the following script to the post-update file:

bash
#!/bin/bash
for ref in "$@"; do
if [ "$ref" = "refs/heads/master" ]; then
DATE=$(date +%Y-%m-%d)
git tag "release-$DATE"
fi
done

------------------------------------------

# - Make the hook executable:

[root@ststor01 hooks]# chmod +x post-update  

[root@ststor01 hooks]# git branch
  feature
* master

[root@ststor01 hooks]# git checkout master
fatal: this operation must be run in a work tree

[root@ststor01 hooks]# cd ~

[root@ststor01 ~]# pwd
/root


# Testing the Hook:
# - *Merge the feature branch into master* in the cloned repository /usr/src/kodekloudrepos:

[root@ststor01 ~]# cd /usr/src/kodekloudrepos/blog/

[root@ststor01 blog]# ls -alh
total 20K
drwxr-xr-x 3 root root 4.0K Aug 25 06:42 .
drwxr-xr-x 3 root root 4.0K Aug 25 06:42 ..
drwxr-xr-x 8 root root 4.0K Aug 25 06:42 .git
-rw-r--r-- 1 root root   22 Aug 25 06:42 feature.txt
-rw-r--r-- 1 root root   34 Aug 25 06:42 info.txt

[root@ststor01 blog]# git branch
* feature
  master

[root@ststor01 blog]# git checkout master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.

[root@ststor01 blog]# git branch
  feature
* master

[root@ststor01 blog]# git merge feature

Updating 9786952..c91608f
Fast-forward
 feature.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 feature.txt

[root@ststor01 blog]# git log
commit c91608f6134d0eed8978328d880986c396d7c9bc (HEAD -> master, origin/feature, feature)
Author: Admin <admin@kodekloud.com>
Date:   Mon Aug 25 06:42:26 2025 +0000

    Add feature

commit 9786952055dd150f92e4adcbd724157bd70330d4 (origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Mon Aug 25 06:42:26 2025 +0000

    initial commit

# - Push changes to trigger the hook:

[root@ststor01 blog]# git push origin master # Triggers hook in bare repo 

Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/blog.git
   9786952..c91608f  master -> master

[root@ststor01 blog]# git tag

[root@ststor01 blog]# git tag | grep "release-$(date +%Y-%m-%d)"


# Check the tag in Bare Repo

------------------------------
Note:
- Go to bare repo:
- Run the following commands
bash
cd /opt/blog.git
git tag 
Also
git tag | grep "release-$(date +%Y-%m-%d)"

- Verify a tag like release-2025-08-25 was created.

------------------------------------

[root@ststor01 blog]# cd ~

[root@ststor01 ~]# cd /opt/blog.git

[root@ststor01 blog.git]# git tag

release-2025-08-25

[root@ststor01 blog.git]# git tag | grep "release-$(date +%Y-%m-%d)"

release-2025-08-25

[root@ststor01 blog.git]# git log
commit c91608f6134d0eed8978328d880986c396d7c9bc (HEAD -> master, tag: release-2025-08-25, feature)
Author: Admin <admin@kodekloud.com>
Date:   Mon Aug 25 06:42:26 2025 +0000

    Add feature

commit 9786952055dd150f92e4adcbd724157bd70330d4
Author: Admin <admin@kodekloud.com>
Date:   Mon Aug 25 06:42:26 2025 +0000

    initial commit

[root@ststor01 blog.git]# #  *Tag release-2025-08-25 exists* in the bare repo /opt/blog.git.

[root@ststor01 blog.git]# git tag | grep "release-$(date +%Y-%m-%d)"release-2025-08-25

[root@ststor01 blog.git]# git tagrelease-2025-08-25

[root@ststor01 blog.git]# ls -alh
total 40K
drwxr-xr-x  7 root root 4.0K Aug 25 06:57 .
drwxr-xr-x  1 root root 4.0K Aug 25 06:42 ..
-rw-r--r--  1 root root   23 Aug 25 06:42 HEAD
drwxr-xr-x  2 root root 4.0K Aug 25 06:42 branches
-rw-r--r--  1 root root   66 Aug 25 06:42 config
-rw-r--r--  1 root root   73 Aug 25 06:42 description
drwxr-xr-x  2 root root 4.0K Aug 25 06:52 hooks
drwxr-xr-x  2 root root 4.0K Aug 25 06:42 info
drwxr-xr-x 10 root root 4.0K Aug 25 06:57 objects
drwxr-xr-x  4 root root 4.0K Aug 25 06:42 refs

[root@ststor01 blog.git]# cat hooks/post-update

#!/bin/bash
for ref in "$@"; do
if [ "$ref" = "refs/heads/master" ]; then
DATE=$(date +%Y-%m-%d)
git tag "release-$DATE"
fi
done

```
