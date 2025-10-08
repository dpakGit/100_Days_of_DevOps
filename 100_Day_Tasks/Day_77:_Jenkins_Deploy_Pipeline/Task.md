### Task : Jenkins Deploy Pipeline


### What I Did

Jumphost terminal
```
[root@ststor01 natasha]# yum install java-17-openjdk-devel.x86_64

[root@ststor01 natasha]# java --version

[root@ststor01 natasha]# cd /var/www/

[root@ststor01 www]# ls
html

[root@ststor01 www]# ls -l
total 4

drwxr-xr-x 3 sarah sarah 4096 Oct  8 09:17 html

[root@ststor01 www]# chown -R natasha html/

[root@ststor01 www]# ls -l
total 4
drwxr-xr-x 3 natasha sarah 4096 Oct  8 09:17 html

[root@ststor01 www]# cd html/

[root@ststor01 html]# ls
index.html  remoting  remoting.jar

[root@ststor01 html]# rm index.html 
rm: remove regular file 'index.html'? y

[root@ststor01 html]# ls
remoting  remoting.jar

[root@ststor01 html]# ls
caches  index.html  remoting  remoting.jar  workspace

[root@ststor01 html]# rm index.html 
rm: remove regular file 'index.html'? y

[root@ststor01 html]# ls
caches  index.html  remoting  remoting.jar  workspace
```

### Pipeline Code

```
pipeline {
    agent {
        label 'ststor01'
    }
    
    stages {
        stage('Deploy') {
            steps {
                git branch: "master",
                    url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git"
                
                sh "cp -r /var/www/html/workspace/xfusion-webapp-job/* /var/www/html/"
            }
        }
    }
}
```

OR

```
pipeline {
    agent {
        label 'ststor01'
    }
    stages {
        stage('Deploy') {
            steps {
                git url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git", 
                    branch: "master"
                sh "cp -r * /var/www/html/"
            }
        }
    }
}
```
