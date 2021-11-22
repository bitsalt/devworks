#Using Bitsalt Devworks
## This needs to be reviewed/edited after this commit...

Devworks is a group of containers that run everything 
currently needed to support development work for 
bitSalt.com. The component containers:

* Apache web server - This is the container that will
hold the individual projects that are pulled from GitHub.
* PHP 7.4 - This container processes all php processing,
and can be swapped out for different PHP versions as
  the need arises.
* MariaDB - This is the opensource version of
  MySQL. The database runs in its own container to be
  shared by all projects.
* PHPMyAdmin - This container runs PHPMyAdmin with its
own Apache server. Databases for all active projects
  can be viewed and managed from here.
  
##Setting up a project
Projects will be pulled from github and must be 
located in the apps/ directory. The example below
will pull the Horse DB project.

1. Open a shell session
and move to the devworks directory.

        cd <path on your machine>/devworks/apps

2. Pull the project from github.
  
        git clone git@github.com:bitsalt/horse-db.git

3. Move up to the devworks root directory. Everything
   we do in the next several steps must happen from there.

        cd ..

4. You might need to add a directory for the database
   to work properly. Use the first command below to
   see if the 'data' directory exists. If it does not
   show up in the list, run the second command below.

        ls -l services/mariadb
        mkdir services/mariadb/data

5. Start the container.
   
        docker-compose up -d
   
6. Run the script to enable the site in Apache and 
   MariaDB. The script takes one argument which 
   __must match__ the name of the directory pulled 
   from github.
   
        ./enable-site.sh horse-db

7. Edit your hosts file. This will tell your browser
to look for the development domains on your
   local machine rather than on the internet. You need
   to do this as the root user, so you'll be asked
   for your password. Use the same password you use
   to log into your Macbook. Be sure that the domain
   name matches the directory from github and use ".local"
   with it.
   
        sudo echo "127.0.0.1 horse-db.local" >> /etc/hosts

8. Create a database for the site in PHPMyAdmin.
    * In a browser, navigate to localhost:8080. The
  login credentials are:  
      Server: mariadb  
      Username: root  
      Password: badRootPasswd
    * In the top menu, click 'Databases'
    * Under 'Create Database' type the name of the
  new database. It should match the directory name
      for the project you're adding. In this example,
      you would type 'horse-db' and then click 'Create'
      
9. Navigate to the new site to make sure everything
is working. In this example, open 'horse-db.local' in
   your browser.
   
10. When you're finished and want to shut down the 
container, run the command below from within the
    devworks directory.
    
        docker-compose down
   
Let me know if anything goes wrong with this, and 
I'll modify these instructions as necessary.

##Next steps
You can now start working on the new site. In your
IDE, just open it within the project directory rather
than within devworks. If you're using VS Code, you
can start it from the terminal.

    cd apps/horse-db
    code .

As you make changes, commit them to git with good
notes. This will allow you to back up to a previous
working version if things get messed up. When you 
have changes you want to keep, commit them and push
them to the repository. 
