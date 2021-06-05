# Bytemine

## Production Deployment

**Fork and clone this repo**

```bash
git clone https://github.com/marcelogrsp/Bytemine.git
```

### Install requirements.txt

If you don't have pip installed, first:

```bash
sudo apt install python3-pip
```

Then:

```bash
pip3 install -r requirements.txt 
```

### Set Environment Variable

Add `export FLASK_ENV=production` to the end of `./.profile`

```bash
sudo nano ./.profile
```

```bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export FLASK_ENV=production
```

### Install MySQL

**Step 1 — Installing MySQL**

On Ubuntu 20.04, you can install MySQL using the APT package repository.

To install it, update the package index on your server if you’ve not done so recently:

```bash
sudo apt update
```

 Then install the `mysql-server` package:

```bash
sudo apt install mysql-server
```

This will install MySQL, but will not prompt you to set a password or make any other configuration changes. Because this leaves your installation of MySQL insecure, we will address this next.

**Step 2 — Configuring MySQL**

For fresh installations of MySQL, you’ll want to run the DBMS’s included security script. This script changes some of the less secure default options for things like remote root logins and sample users.

Run the security script with `sudo`:

```bash
sudo mysql_secure_installation
```

This will take you through a series of prompts where you can make some changes to your MySQL installation’s security options. The first prompt will ask whether you’d like to set up the Validate Password Plugin, which can be used to test the password strength of new MySQL users before deeming them valid.

We will choose option `0` in this tutorial but is recomended to use option `2`

```bash
OutputSecuring the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. 
```

```bash
Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No: Y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:
0
```

Regardless of whether you choose to set up the Validate Password Plugin, the next prompt will be to set a password for the MySQL **root** user. 

Enter `bytemine` as password:

```
Please set the password for root here.

New password: 

Re-enter new password: 

Estimated strength of the password: 50 
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y
```

Note that even though you’ve set a password for the **root** MySQL user, this user is not currently configured to authenticate with a password when connecting to the MySQL shell.

If you used the Validate Password Plugin, you’ll receive feedback on the strength of your new password. Then the script will ask if you want to continue with the password you just entered or if you want to enter a new one. Assuming you’re satisfied with the strength of the password you just entered, enter `Y` to continue the script:

```
OutputEstimated strength of the password: 100 
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : Y
```

From there, you can press `Y` and then `ENTER` to accept the defaults for all the subsequent questions. This will remove some anonymous users and the test database, disable remote root logins, and load these new rules so that MySQL immediately respects the changes you have made.

Once the script completes, your MySQL installation will be secured. You can now move on to creating a dedicated database user with the MySQL client.

**Step 3 — Creating a Dedicated MySQL User and Granting Privileges**

Upon installation, MySQL creates a **root** user account which you can use to manage your database. This user has full privileges over the MySQL server, meaning it has complete control over every database, table, user, and so on. Because of this, it’s best to avoid using this account outside of administrative functions. This step outlines how to use the **root** MySQL user to create a new user account and grant it privileges.

In Ubuntu systems running MySQL `5.7` (and later versions), the **root** MySQL user is set to authenticate using the `auth_socket` plugin by default rather than with a password. This plugin requires that the name of the operating system user that invokes the MySQL client matches the name of the MySQL user specified in the command, so you must invoke `mysql` with `sudo` privileges to gain access to the **root** MySQL user:

```bash
sudo mysql
```

**Note:** If you installed MySQL with another tutorial and enabled password authentication for **root**, you will need to use a different command to access the MySQL shell. The following will run your MySQL client with regular user privileges, and you will only gain administrator privileges within the database by authenticating:`mysql -u root -p ` Copy

Now we need to create the database schema.

```sql
CREATE SCHEMA BYTEMINE;
```

Change schema:

````sql
USE BYTEMINE;
````

Once you have access to the MySQL prompt, we create the user used by the app using `CREATE USER` statement. 

```sql
CREATE USER 'bytemine'@'localhost' IDENTIFIED BY 'bytemine';
```

After creating the `bytemine` user, let's grant it the appropriate privileges:

```sql
GRANT ALL ON BYTEMINE.* TO 'bytemine'@'localhost';
```

 Following this, it’s good practice to run the `FLUSH PRIVILEGES` command. This will free up any memory that the server cached as a result of the preceding `CREATE USER` and `GRANT` statements:

```bash
FLUSH PRIVILEGES;
```

 Then you can exit the MySQL client:

```bash
exit
```

 In the future, to log in as your new MySQL user, you’d use a command like the following:

```bash
mysql -u bytemine -p
```

 The `-p` flag will cause the MySQL client to prompt you for your MySQL user’s password in order to authenticate.

Finally, let’s test the MySQL installation.

### Restore Schema

Now we need to restore the database schema. If you cloned the repo in your home folder, otherwise, change the current folder to the folder where you cloned the repo.

In a new terminal, run

```bash
sudo mysql BYTEMINE < bytemine.sql
```

### Setup NGINX

**Step 1 – Installing Nginx**

Because Nginx is available in Ubuntu’s default repositories, it is possible to install it from these repositories using the `apt` packaging system.

Since this is our first interaction with the `apt` packaging system in this session, we will update our local package index so that we have access to the most recent package listings. Afterwards, we can install `nginx`:

```bash
sudo apt update
sudo apt install nginx
```

After accepting the procedure, `apt` will install Nginx and any required dependencies to your server.

**Step 2 – Adjusting the Firewall**

Before testing Nginx, the firewall software needs to be adjusted to allow access to the service. Nginx registers itself as a service with `ufw` upon installation, making it straightforward to allow Nginx access.

List the application configurations that `ufw` knows how to work with by typing:

```bash
sudo ufw enable && sudo ufw app list
```

You should get a listing of the application profiles:

```
OutputAvailable applications:
  Nginx Full
  Nginx HTTP
  Nginx HTTPS
  OpenSSH
```

As demonstrated by the output, there are three profiles available for Nginx:

- **Nginx Full**: This profile opens both port 80 (normal, unencrypted web traffic) and port 443 (TLS/SSL encrypted traffic)
- **Nginx HTTP**: This profile opens only port 80 (normal, unencrypted web traffic)
- **Nginx HTTPS**: This profile opens only port 443 (TLS/SSL encrypted traffic)

In our case we should activate **Nginx Full**:

You can enable this by typing:

```bash
sudo ufw allow 'Nginx Full'
```

Also, to avoid problems with SSH connection, activate **OpenSSH**:

```bash
sudo ufw allow 'OpenSSH'
```

You can verify the change by typing:

```bash
sudo ufw status
```

The output will indicated which HTTP traffic is allowed:

```
Status: active

To                         Action      From
--                         ------      ----
Nginx Full                 ALLOW       Anywhere                  
OpenSSH                    ALLOW       Anywhere                  
Nginx Full (v6)            ALLOW       Anywhere (v6)             
OpenSSH (v6)               ALLOW       Anywhere (v6)
```

**Step 3 – Checking your Web Server**

At the end of the installation process, Ubuntu 20.04 starts Nginx. The web server should already be up and running.

We can check with the `systemd` init system to make sure the service is running by typing:

```bash
systemctl status nginx
```

```
Output● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2020-04-20 16:08:19 UTC; 3 days ago
     Docs: man:nginx(8)
 Main PID: 2369 (nginx)
    Tasks: 2 (limit: 1153)
   Memory: 3.5M
   CGroup: /system.slice/nginx.service
           ├─2369 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
           └─2380 nginx: worker process
```

As confirmed by this out, the service has started successfully. However, the best way to test this is to actually request a page from Nginx.

Edit the file `/etc/nginx/nginx.conf`. Remove the comment of the line `# server_names_hash_bucket_size 64;`

Now edit the file `/etc/nginx/sites-enabled/default`. Comment the lines:

```
listen 80 default_server;
listen [::]:80 default_server;
```

### Install SSL

**Step 1 - Download the Let’s Encrypt Client**

First, download the Let’s Encrypt client, `certbot`.

```bash
sudo apt-get update && sudo apt-get install certbot && sudo apt-get install python3-certbot-nginx
```

**Step 2 -- Set Up NGINX**

Create a new file in the **/etc/nginx/conf.d** directory named **www.vsbapi.bytemine.io.conf **:

```bash
sudo nano /etc/nginx/conf.d/www.vsbapi.bytemine.io.conf 
```

Add the following content to the new file:

```
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    location /api {
        proxy_pass http://localhost:5000/api;
    }
    server_name vsbapi.bytemine.io www.vsbapi.bytemine.io;
}
```

Save the file, then run this command to verify the syntax of your configuration and restart NGINX:

```bash
sudo nginx -t && sudo nginx -s reload
```

Expected output:

```bash
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

**Step 3 - Obtain the SSL/TLS Certificate**

The NGINX plug‑in for `certbot` takes care of reconfiguring NGINX and reloading its configuration whenever necessary.

Run the following command to generate certificates with the NGINX plug‑in:

```bash
sudo certbot --nginx -d vsbapi.bytemine.io -d www.vsbapi.bytemine.io
```

> Note: be assured that you have a A record pointing to **www.vsbapi.bytemine.io**

Respond to prompts from `certbot` to configure your HTTPS settings, which involves entering your email address and agreeing to the Let’s Encrypt terms of service.

When certificate generation completes, NGINX reloads with the new settings. `certbot` generates a message indicating that certificate generation was successful and specifying the location of the certificate on your server.

```
Congratulations! You have successfully enabled https://vsbapi.bytemine.io and
https://www.vsbapi.bytemine.io

You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=vsbapi.bytemine.io
https://www.ssllabs.com/ssltest/analyze.html?d=www.vsbapi.bytemine.io
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/vsbapi.bytemine.io/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/vsbapi.bytemine.io/privkey.pem
   Your cert will expire on 2021-09-01. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

If you look at  **www.vsbapi.bytemine.io.conf ** you see that `certbot` has modified it:

```
server {
    location /api {
        proxy_pass http://localhost:5000/api;
    }
    server_name vsbapi.bytemine.io www.vsbapi.bytemine.io;

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/vsbapi.bytemine.io/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/vsbapi.bytemine.io/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = www.vsbapi.bytemine.io) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = vsbapi.bytemine.io) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80 default_server;
    listen [::]:80 default_server;
    server_name vsbapi.bytemine.io www.vsbapi.bytemine.io;
    return 404; # managed by Certbot
}
```

**Step 4 - Automatically Renew Let’s Encrypt Certificates**

Let’s Encrypt certificates expire after 90 days. We encourage you to renew your certificates automatically. Here we add a [`cron`](https://en.wikipedia.org/wiki/Cron) job to an existing **crontab** file to do this.

Open the **crontab** file.

```bash
crontab -e
```

Add the `certbot` command to run daily. In this example, we run the command every day at noon. The command checks to see if the certificate on the server will expire within the next 30 days, and renews it if so. The `--quiet` directive tells `certbot` not to generate output.

```
0 12 * * * /usr/bin/certbot renew --quiet
```

Save and close the file. All installed certificates will be automatically renewed and reloaded.
