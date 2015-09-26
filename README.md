## How to move repo from bitbucket to github

http://commandliners.com/2015/02/moving-a-repository-from-bitbucket-to-github/

MOVING A REPOSITORY FROM BITBUCKET TO GITHUB
09.Feb.15 | rafacas | No Comments
Some people have asked me how they can move a repository from Bitbucket to Github (or vice versa). To know how to do it we need to understand Git’s remote repositories. Remote repositories are versions of your project that are hosted on the Internet or network somewhere (you can have several of them).
First, let’s clone the Bitbucket repository:
$ git clone https://bitbucket.org/rafacas/test.git
Cloning into ’test'...
remote: Counting objects: 124, done.
remote: Compressing objects: 100% (120/120), done.
remote: Total 124 (delta 42), reused 0 (delta 0)
Receiving objects: 100% (124/124), 1.31 MiB | 541.00 KiB/s, done.
Resolving deltas: 100% (42/42), done.
Checking connectivity... done.
To see which remote servers you have configured, you can run the git remote command. It lists the shortnames of each remote handle you have specified. After cloning your repository you will see origin (that is the default name Git gives to the server you cloned from):
$ cd test
$ git remote
origin
If you use the -v option it will show the URLs that Git has stored for the shortname to be used when reading and writing to that remote:
$ git remote -v
origin    https://bitbucket.org/rafacas/test.git (fetch)
origin    https://bitbucket.org/rafacas/test.git (push)
Right now origin (our only remote repository) is pointing to Bitbucket, so we could create another remote repository called github and point it to the Github repository we want to move it to. After creating it you could work with both repositories.
Because what we really want is moving it and stop using our original remote repository we should change where origin points to.
We will start renaming origin to bitbucket:
$ git remote rename origin bitbucket
If we want to check it has been renamed we will type:
$ git remote
bitbucket
Then we will add a new remote repository called origin that points to the Github repository we want to move it to:
$ git remote add origin https://github.com/rafacas/test.git
Now we have two remote repositories (bitbucket and origin):
$ git remote
bitbucket
origin
We can check where they point to:
$ git remote -v
bitbucket     https://bitbucket.org/rafacas/test.git (fetch)
bitbucket     https://bitbucket.org/rafacas/test.git (push)
origin     https://github.com/rafacas/test.git (fetch)
origin     https://github.com/rafacas/test.git (push)
Then we will push our master branch to the origin remote repository (Github):
$ git push origin master
Once you check the push has been successful you can delete the remote bitbucket repository:
$ git remote rm bitbucket
$ git remote -v
origin     https://github.com/rafacas/test.git (fetch)
origin     https://github.com/rafacas/test.git (push)
You can follow the same process if you want to move a repository from Github to Bitbucket. Just be careful with the repository URLs.
