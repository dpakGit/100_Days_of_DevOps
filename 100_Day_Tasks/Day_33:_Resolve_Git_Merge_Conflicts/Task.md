### Task:
Sarah and Max were working on writting some stories which they have pushed to the repository. Max has recently added some new changes and is trying to push them to the repository but he is facing some issues. Below you can find more details:

SSH into storage server using user max and password Max_pass123. Under /home/max you will find the story-blog repository. Try to push the changes to the origin repo and fix the issues. The story-index.txt must have titles for all 4 stories. Additionally, there is a typo in The Lion and the Mooose line where Mooose should be Mouse.

Click on the Gitea UI button on the top bar. You should be able to access the Gitea page. You can login to Gitea server from UI using username sarah and password Sarah_pass123 or username max and password Max_pass123.

Note: For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

---------------------------------------------------

### What I Did


```
thor@jumphost ~$ ssh max@172.16.238.15

max@172.16.238.15's password: 
Welcome to xFusionCorp Storage server.

max $ cd ~

max $ pwd
/home/max

max $ ls -alh
total 32
drwxr-sr-x    1 max      max         4.0K Aug 24 17:50 .
drwxr-xr-x    1 root     root        4.0K Oct 26  2020 ..
-rw-r--r--    1 max      max          202 Oct 26  2020 .bash_profile
-rw-r--r--    1 max      max          202 Oct 26  2020 .bashrc
-rw-r--r--    1 max      max           50 Oct 26  2020 .vimrc
drwxr-sr-x    3 max      max         4.0K Aug 24 17:50 story-blog

max $ cd story-blog/

max (master)$ ls -alh

total 32
drwxr-sr-x    3 max      max         4.0K Aug 24 17:50 .
drwxr-sr-x    1 max      max         4.0K Aug 24 17:50 ..
drwxr-sr-x    8 max      max         4.0K Aug 24 17:50 .git
-rw-r--r--    1 max      max          807 Aug 24 17:50 fox-and-grapes.txt
-rw-r--r--    1 max      max          792 Aug 24 17:50 frogs-and-ox.txt
-rw-r--r--    1 max      max         1.1K Aug 24 17:50 lion-and-mouse.txt
-rw-r--r--    1 max      max          102 Aug 24 17:50 story-index.txt

max (master)$ vi story-index.txt 

max (master)$ git add story-index.txt 

max (master)$ git commit "Fixed titles and typo in story-index.txt"

error: pathspec 'Fixed titles and typo in story-index.txt' did not match any file(s) known to git.

max (master)$ git commit -m "Fixed titles and typo in story-index.txt"

[master f65f8df] Fixed titles and typo in story-index.txt
 Committer: Linux User <max@ststor01.stratos.xfusioncorp.com>
Your name and email address were configured automatically based

max (master)$ git push origin master

Username for 'http://git.stratos.xfusioncorp.com': max
Password for 'http://max@git.stratos.xfusioncorp.com': 

To http://git.stratos.xfusioncorp.com/sarah/story-blog.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'http://git.stratos.xfusioncorp.com/sarah/story-blog.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

--------------------------
Error Explanation
- Error: Push rejected because local branch is behind remote master.
- Cause: Remote master has commits not in your local master.

Steps to Fix
1. Pull remote changes.

bash
git pull origin master
# Resolve any merge conflicts if prompted


2. Push again.

bash
git push origin master


Alternative: Force Push (Caution)
- If you want to overwrite remote (risk losing others' changes):

bash
git push origin master --force-with-lease


Do you need help with:
- Handling Git push rejections due to being behind?
- *Using git pull to sync with remote*?
- Something else related to Git?
---------------------------

max (master)$ git pull origin master

remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From http://git.stratos.xfusioncorp.com/sarah/story-blog
 * branch            master     -> FETCH_HEAD
   435ce9a..baa8a7a  master     -> origin/master
Auto-merging story-index.txt
CONFLICT (add/add): Merge conflict in story-index.txt
Automatic merge failed; fix conflicts and then commit the result.

max (master)$ vi story-index.txt 

max (master)$ vi story-index.txt 

max (master)$ git add .

max (master)$ git commit -m "Resolved merge conflicts"

[master 0b06a19] Resolved merge conflicts
 Committer: Linux User <max@ststor01.stratos.xfusioncorp.com>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.

max (master)$ git push origin master

Username for 'http://git.stratos.xfusioncorp.com': max
Password for 'http://max@git.stratos.xfusioncorp.com': 

Counting objects: 10, done.
Delta compression using up to 16 threads.
Compressing objects: 100% (10/10), done.
Writing objects: 100% (10/10), 1.41 KiB | 0 bytes/s, done.
Total 10 (delta 3), reused 0 (delta 0)
remote: . Processing 1 references
remote: Processed 1 references in total
To http://git.stratos.xfusioncorp.com/sarah/story-blog.git
   baa8a7a..0b06a19  master -> master
```
