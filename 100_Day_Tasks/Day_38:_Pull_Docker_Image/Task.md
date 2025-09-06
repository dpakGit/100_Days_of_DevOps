### Task:

Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:

a. Pull busybox:musl image on App Server 2 in Stratos DC and re-tag (create new tag) this image as busybox:media.



### What I Did

thor@jumphost ~$ ssh steve@stapp02

[steve@stapp02 ~]$ sudo -s

[root@stapp02 steve]# docker pull busybox:musl
musl: Pulling from library/busybox
8e7bef4a92af: Pull complete 
Digest: sha256:254e6134b1bf813b34e920bc4235864a54079057d51ae6db9a4f2328f261c2ad
Status: Downloaded newer image for busybox:musl
docker.io/library/busybox:musl

[root@stapp02 steve]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
busybox      musl      44f1048931f5   11 months ago   1.46MB

[root@stapp02 steve]# docker tag busybox:musl busybox:media

[root@stapp02 steve]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
busybox      media     44f1048931f5   11 months ago   1.46MB
busybox      musl      44f1048931f5   11 months ago   1.46MB

[root@stapp02 steve]# docker images busybox:media
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
busybox      media     44f1048931f5   11 months ago   1.46MB
[root@stapp02 steve]# docker images -q busybox:musl
44f1048931f5
[root@stapp02 steve]# docker images -q
44f1048931f5
44f1048931f5
