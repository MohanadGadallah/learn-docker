# Docker Learning Progress

This repository documents my learning journey with Docker, including commonly used commands for managing containers, data, logs, and troubleshooting.

## Building a Docker Image
To build a Docker image from a `Dockerfile`:
```sh
docker build -t <image_name>:<tag> .
```
Example:
```sh
docker build -t flask_app:1.0 .
```

## Setting Environment Variables in Docker
To set environment variables in a `Dockerfile`, use the `ENV` instruction:
```dockerfile
ENV APP_ENV=production
ENV DEBUG=False
```
Alternatively, you can pass environment variables at build time using `--build-arg`:
```sh
docker build --build-arg APP_ENV=production -t flask_app:1.0 .
```
To use `ARG` in a `Dockerfile`:
```dockerfile
ARG APP_ENV=development
ENV APP_ENV=$APP_ENV
```
To pass environment variables at runtime, use `-e`:
```sh
docker run -e APP_ENV=production -e DEBUG=False flask_app:1.0
```

## Creating and Managing Docker Volumes
To create a named volume:
```sh
docker volume create <volume_name>
```
To list all volumes:
```sh
docker volume ls
```
To inspect a volume:
```sh
docker volume inspect <volume_name>
```
To remove a volume:
```sh
docker volume rm <volume_name>
```

## Managing Data for Containers
To run a container with a volume mount and expose a port:
```sh
docker run -it -v <host_absolute_path>:<folder_path_in_container> -p 5000:5000 flask_app:1.0
```

## Accessing Running Containers
To get back into a running container:
```sh
docker exec -it <container_id> bash
```
If the container is running in daemon mode (background), list all running containers:
```sh
docker ps
```

## Stopping a Running Container
To stop a running container:
```sh
docker stop <container_id>
```

## Accessing Docker Logs
To view logs of a specific container:
```sh
docker logs <container_id>
```
To save logs to a file:
```sh
docker logs <container_id> > output.log
```
To watch real-time logs:
```sh
docker logs -f <container_id>
```

## Docker Communication
![Docker Communication](./docker_communication.png)

### Linking Two Networks Without Docker Compose
To link two networks manually:
```sh
docker run --link "mysql:backenddb" -p 5000:5000 flask_app:1.0
```

## Docker Compose
Docker Compose is a tool that combines and runs multiple containers of interrelated services with a single command. It defines all application dependencies in one place and allows Docker to manage them efficiently with:
```sh
docker-compose up --build
```

### Docker Compose Commands
Every command starts with `docker-compose`. Use `docker-compose --help` to see available commands.

- **Build images:**
  ```sh
  docker-compose build
  ```
  The job of the `build` command is to get the images ready to create containers. If a service is using a prebuilt image, it will skip that service.

- **List built images:**
  ```sh
  docker-compose images
  ```
  This command lists images built using the current `docker-compose` file.

- **Run a service:**
  ```sh
  docker-compose run web
  ```
  Similar to `docker run`, this creates containers from images built for services mentioned in the compose file.

- **Start containers (build if necessary):**
  ```sh
  docker-compose up
  ```
  If images are already built, it will fork the container directly. Add `--build` to force a rebuild.

- **Stop running containers:**
  ```sh
  docker-compose stop
  ```

- **Remove containers:**
  ```sh
  docker-compose rm
  ```

- **Start stopped containers:**
  ```sh
  docker-compose start
  ```

- **Restart containers:**
  ```sh
  docker-compose restart
  ```

- **List all service containers:**
  ```sh
  docker-compose ps
  ```

- **Stop and remove all services:**
  ```sh
  docker-compose down
  ```
  This command stops all services and cleans up containers, networks, and images used by the compose file.

- **View logs:**
  ```sh
  docker-compose logs
  ```
  This command is similar to `docker logs <container ID>`. The difference is that it prints logs from all services. Use `-f` to see real-time logs.

For more details, refer to the official documentation: [Docker Compose CLI Reference](https://docs.docker.com/reference/cli/docker/compose/)

## Docker Compose File Structure
A basic `docker-compose.yml` file example:
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - db
    networks:
      - app_network
  db:
    image: postgres:latest
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    networks:
      - app_network
networks:
  app_network:
    driver: bridge
```

### Explanation of `docker-compose.yml`:
- **version:** Defines the version of the Docker Compose file syntax.
- **services:** Lists the application components (web and db in this case).
- **build:** Specifies the build context (directory containing the `Dockerfile`).
- **image:** Defines a pre-built image to be used for a service.
- **ports:** Maps container ports to the host machine (`5000:5000` means host port 5000 maps to container port 5000).
- **depends_on:** Specifies service dependencies (web depends on db, ensuring db starts first).
- **environment:** Sets environment variables required by the service.
- **networks:** Configures container networking. The `app_network` ensures both services can communicate.
- **driver:** The `bridge` network driver is the default for container communication.


# Multiple Dockerfiles in Docker-Compose

There might be a situation where we need to have multiple Dockerfiles for different services.

## Examples
- Creating a microservices app
- Dockerfile for different environments such as development, production

In these cases, you have to tell docker-compose the Dockerfile it should consider for creating that specific service.

## Specifying Dockerfile in Docker-Compose
By default, docker-compose looks for a file named `Dockerfile`. Dockerfiles can have any name. It’s just a file without any extension. We can override the default behavior using the `dockerfile: 'custom-name'` directive inside the build section.

### Parameters
- **context**: Use this to specify the directory of the Dockerfile or an alternate Dockerfile relative to the `docker-compose.yml` file.
- **dockerfile**: As mentioned above, specify the name of an alternate Dockerfile if it is not named `Dockerfile`.

## Environment Variables with Docker-Compose
### Using the `env_file`
Another method is to use the `env_file` keyword instead of the `environment` keyword in `docker-compose.yml`. In this method, it is not necessary that the `.env` file should be located in the same directory as the `docker-compose` file.

You will provide the location of the `.env` file like so:

```yaml
env_file:
  - ./.env
```

