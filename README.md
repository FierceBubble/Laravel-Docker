# Deploying Laravel in Docker container

## Prerequisite
```
1. Create the db user used by the web app
2. Initiate Laravel project beforehand
3. Copy the Dockerfile, docker-compose.yml, and
    Docker folder into your main directory of your project
4. Copy Makefile if you want to use shorthand commands for docker commands
```

### Changing the port Nginx is listening from
Go to ./Docker/default.conf and change the value from '8000' to any other port
### Running web application in HTTPS
Go to sudo nano ./app/Providers/AppServiceProvider.php
add this condition to boot() function

```
\URL::forceScheme('https');
```

### Running MySQL ^8.0 
In MySQL ^8.0, the way it handles authentication is different. It is important to change the way MySQL identify user, reverting it back to be identifiable by password. Run in MySQL CLI:

```
ALTER USER '{your_username}'@'{localhost}' 
IDENTIFIED WITH mysql_native_password BY '{your_password}';
```

### Makefile commands

##### Building Laravel php image into laravel-docker:latest
```make
make build
```

##### Stopping web application stack, stopping all running containers
```make
make stop
```

##### Starting web application stack, bringing up all containers
```make
make up
```

##### Bringing down the entire stack and removing the containers
```make
make down
```

##### Do a fresh startup of the web app as if it was just deployed
```make
make restart
```

##### Starting web application stack while rebuillding the image from the beginning
```make
make ub
```

##### Enter php CLI environment, for running php and artisan commands to the web application
```make
make it
```

