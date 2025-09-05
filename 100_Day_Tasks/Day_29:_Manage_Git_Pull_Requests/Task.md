### Task:

Max want to push some new changes to one of the repositories but we don't want people to push directly to master branch, since that would be the final version of the code. It should always only have content that has been reviewed and approved. We cannot just allow everyone to directly push to the master branch. So, let's do it the right way as discussed below:


SSH into storage server using user max, password Max_pass123 . There you can find an already cloned repo under Max user's home.


Max has written his story about The 🦊 Fox and Grapes 🍇


Max has already pushed his story to remote git repository hosted on Gitea branch story/fox-and-grapes


Check the contents of the cloned repository. Confirm that you can see Sarah's story and history of commits by running git log and validate author info, commit message etc.


Max has pushed his story, but his story is still not in the master branch. Let's create a Pull Request(PR) to merge Max's story/fox-and-grapes branch into the master branch


Click on the Gitea UI button on the top bar. You should be able to access the Gitea page.


UI login info:

- Username: max

- Password: Max_pass123

PR title : Added fox-and-grapes story

PR pull from branch: story/fox-and-grapes (source)

PR merge into branch: master (destination)


Before we can add our story to the master branch, it has to be reviewed. So, let's ask tom to review our PR by assigning him as a reviewer


Add tom as reviewer through the Git Portal UI

Go to the newly created PR

Click on Reviewers on the right

Add tom as a reviewer to the PR

Now let's review and approve the PR as user Tom


Login to the portal with the user tom


Logout of Git Portal UI if logged in as max


UI login info:

- Username: tom

- Password: Tom_pass123

PR title : Added fox-and-grapes story

Review and merge it.

Great stuff!! The story has been merged! 👏


Note: For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.




- https://www.youtube.com/watch?v=vWm_seUz2xk


- https://tundedamian.medium.com/day-29-of-100-days-of-devops-implementing-git-branch-protection-and-pr-workflow-in-gitea-fad07886f6ae
thor@jumphost ~$ ssh max@172.16.238.15
The authenticity of host '172.16.238.15 (172.16.238.15)' can't be established.
ED25519 key fingerprint is SHA256:afxZ0/bJkwUsMGoYnu8349m7ZQi+MTkp5aH/+DqgitM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.16.238.15' (ED25519) to the list of known hosts.
max@172.16.238.15's password: 
Welcome to xFusionCorp Storage server.
max $ pwd
/home/max
max $ cd ~
max $ pwd
/home/max
max $ ls -alh
total 36
drwxr-sr-x    1 max      max         4.0K Aug 23 16:29 .
drwxr-xr-x    1 root     root        4.0K Oct 26  2020 ..
-rw-r--r--    1 max      max          202 Oct 26  2020 .bash_profile
-rw-r--r--    1 max      max          202 Oct 26  2020 .bashrc
-rw-r--r--    1 max      max           56 Aug 23 16:29 .gitconfig
-rw-r--r--    1 max      max           50 Oct 26  2020 .vimrc
drwxr-sr-x    3 max      max         4.0K Aug 23 16:29 story-blog
max $ cd story-blog/
max (story/fox-and-grapes)$ ls -alh
total 28
drwxr-sr-x    3 max      max         4.0K Aug 23 16:29 .
drwxr-sr-x    1 max      max         4.0K Aug 23 16:29 ..
drwxr-sr-x    8 max      max         4.0K Aug 23 16:29 .git
-rw-r--r--    1 max      max          807 Aug 23 16:29 fox-and-grapes.txt
-rw-r--r--    1 max      max          792 Aug 23 16:29 frogs-and-ox.txt
-rw-r--r--    1 max      max         1.1K Aug 23 16:29 lion-and-mouse.txt
max (story/fox-and-grapes)$ git status
On branch story/fox-and-grapes
Your branch is up-to-date with 'origin/story/fox-and-grapes'.
nothing to commit, working directory clean
max (story/fox-and-grapes)$ git log
commit b5a3b66d07f6d94284aa4034be00aa378e0f920e
Author: max <max@stratos.xfusioncorp.com>
Date:   Sat Aug 23 16:29:51 2025 +0000

    Added fox-and-grapes story

commit f8fcdea69028a77bfdb295be2219d57a2736b713
Merge: cb99e35 62eb3ea
Author: sarah <sarah@stratos.xfusioncorp.com>
Date:   Sat Aug 23 16:29:50 2025 +0000

    Merge branch 'story/frogs-and-ox'

commit cb99e35f61b1c434ee54fd397cede66734162690
Author: sarah <sarah@stratos.xfusioncorp.com>
Date:   Sat Aug 23 16:29:50 2025 +0000

    Fix typo in story title

commit 62eb3eab9de9d1d9995b33c3a6f8fc7a97c48de7
Author: sarah <sarah@stratos.xfusioncorp.com>
Date:   Sat Aug 23 16:29:50 2025 +0000

    Completed frogs-and-ox story

commit 6b424e57f6e51087509e498f9269f563fe092b43
Author: sarah <sarah@stratos.xfusioncorp.com>
Date:   Sat Aug 23 16:29:50 2025 +0000

    Added the lion and mouse story

commit d09698c378b6333ab8aea8124675734de6c9cd7b
Author: sarah <sarah@stratos.xfusioncorp.com>
Date:   Sat Aug 23 16:29:50 2025 +0000

    Add incomplete frogs-and-ox story
max (story/fox-and-grapes)$ 
max (story/fox-and-grapes)$ git remote -v
origin  http://max:Max_pass123@git.stratos.xfusioncorp.com/sarah/story-blog.git (fetch)
origin  http://max:Max_pass123@git.stratos.xfusioncorp.com/sarah/story-blog.git (push)
max (story/fox-and-grapes)$ git status
On branch story/fox-and-grapes
Your branch is up-to-date with 'origin/story/fox-and-grapes'.
nothing to commit, working directory clean
max (story/fox-and-grapes)$ historuy | cut -c 8-
-bash: historuy: command not found
max (story/fox-and-grapes)$ history | cut -c 8-
pwd
cd ~
pwd
ls -alh
cd story-blog/
ls -alh
git status
git log
git remote -v
git status
historuy | cut -c 8-
history | cut -c 8-
max (story/fox-and-grapes)$ 

<img width="1920" height="1080" alt="Screenshot (115)" src="https://github.com/user-attachments/assets/65da63e4-780d-4e1f-af3b-7b5648d1d64a" />

<img width="1920" height="1080" alt="Screenshot (114)" src="https://github.com/user-attachments/assets/657de163-305a-4ea8-82db-1fcd4e6cb34c" />


<img width="1920" height="1080" alt="Screenshot (113)" src="https://github.com/user-attachments/assets/87730edc-b369-45c0-8850-a9c9a8a6327a" />

<img width="1920" height="1080" alt="Screenshot (112)" src="https://github.com/user-attachments/assets/9e7bd558-27d8-439b-9d83-575c56002eaa" />

<img width="1920" height="1080" alt="Screenshot (111)" src="https://github.com/user-attachments/assets/d3e63b2d-d64a-4359-83a9-83b7c9526592" />

<img width="1920" height="1080" alt="Screenshot (110)" src="https://github.com/user-attachments/assets/810921be-5d20-4559-a5d4-3ce0e28dc7c7" />

<img width="1920" height="1080" alt="Screenshot (109)" src="https://github.com/user-attachments/assets/2b412469-ecf5-486a-8951-fb90af8a6841" />

<img width="1920" height="1080" alt="Screenshot (108)" src="https://github.com/user-attachments/assets/486cd62c-0fbd-4c65-8bc6-6313c7001993" />

<img width="1920" height="1080" alt="Screenshot (107)" src="https://github.com/user-attachments/assets/e52beb94-bc6e-479e-b3f0-c4c29a3ce0cf" />

<img width="1920" height="1080" alt="Screenshot (106)" src="https://github.com/user-attachments/assets/a422c1b1-f640-43e8-be3f-f49e2b2a2fe4" />

<img width="1920" height="1080" alt="Screenshot (105)" src="https://github.com/user-attachments/assets/46f060b8-c915-406e-a105-ba5d91e7c87a" />
