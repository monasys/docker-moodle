# docker-moodle

A development environment for Moodle.

This docker project is a custom implementation of [bitnami-docker-moodle](https://hub.docker.com/r/bitnami/moodle) that includes Xdebug, phpMyAdmin, development mode and utilizes Docker shared volumes to share the codebase between the container and your host system.

## Getting started

Create the directory structure and set the owner to that of your Docker user's UID. You can find the UID using: `cat /etc/group | grep docker`

```console
$ mkdir volumes && mkdir volumes/mariadb && mkdir volumes/moodle && mkdir volumes/moodledata && sudo chown -R 1001 volumes
```

Start the containers:

```console
$ docker-compose up -d
```

* Moodle code is shared in `./volumes/moodle`
* Database is shared in `./volumes/mariadb`
* Application data is shared in `./volumes/moodledata`

The Docker containers run as the `root` user by default, therefore files created within the container will be owned by `root`.
This can prove to be a problem with development as you will not be able to modify the shared files on your host. Moodle code is static, however, meaning that the container will not make any changes to it after the initial install, and as such we can change the ownership of .`/volumes/moodle` back to that of our host.

```console
$ sudo chown -R user:user volumes/moodle
```

### Debugging
Xdebug is installed on the main container and port `9003` is exposed. To activate Xdebug, set the `XDEBUG_SESSION` cookie - this can be done with a handy bookmark from PhpStorm: https://www.jetbrains.com/phpstorm/marklets

Configure your IDE to accept incoming connections from Xdebug & set a breakpoint to step through the code.
* https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html#integrationWithProduct

Often PhpStorm will automatically pick up a new incoming connection without any pre-configuration. 

## Notes
* Access Moodle on `http://localhost`
* Access phpMyAdmin on `http://localhost:8080`
* Moodle username is `user`, password is `bitnami`
* MySQL is mapped to port `33060` on the host
* MySQL database user is `bn_moodle`, there is no password set for this (development only!)
* See [bitnami-docker-moodle](https://hub.docker.com/r/bitnami/moodle) for further info.
