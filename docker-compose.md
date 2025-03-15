## Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. Using a YAML file, you can define the services, networks, and volumes that your application requires. This allows you to manage complex applications with multiple containers, making it easier to set up, manage, and scale your environment. By using Docker Compose, you can streamline workflows, ensuring that all services are configured and connected properly, and can be easily deployed and maintained.

You can use the `-f` flag to point to a Compose file with a different name in a different directory:
```sh
$ docker compose -f apps/ddd-book/sample-app.yml up &
```

You'll normally use the `--detach` flag to bring the app up in the background.

### The `docker compose down` Command

Run the following command to shut down the app:
```sh
docker compose down
```

The volume still exists, including the counter data stored in it. This is because Docker knows that we store important information in volumes and might not want to delete them with other application resources. With this in mind, Docker decouples the lifecycle of volumes from the rest of the application.

### The `docker compose ps` Command

Check the current state of the app with the `docker compose ps` command:
```sh
$ docker compose ps
```

The output shows both containers, the commands they’re executing, their current state, and the network ports they’re listening on.

### The `docker compose top` Command

Run a `docker compose top` to list the processes inside each container:
```sh
$ docker compose top
```

The PID numbers returned are the PID numbers as seen from the Docker host (not from within the containers).

### The `docker compose stop` Command

Run the following command to stop the app:
```sh
$ docker compose stop
```

You’re about to stop and restart the app.

### The `docker compose restart` Command

Restart the app with the `docker compose restart` command:
```sh
$ docker compose restart
```

### Verify the Operation Worked

Run the following command to verify the operation:
```sh
$ docker compose ls
```

### Clean Up

Learn how to stop and delete a Compose application using the `docker compose down` command.

Run the following command to stop and delete the app. The `--volumes` flag will delete all of the app’s volumes, and the `--rmi all` will delete all of its images.
```sh
$ docker-compose down --volumes --rmi all
```

Use `docker volume ls` and `docker-compose ps -a` to verify whether the resources have been removed or not.

