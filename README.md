# Docker Learning Progress

This repository documents my learning journey with Docker, including commonly used commands for managing containers, data, logs, and troubleshooting.

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

⚠ **Warning:** Avoid using `docker attach <container_id>` unless necessary. Pressing `Ctrl+C` may stop the running application.

## Troubleshooting
For diagnosing issues using the terminal or Docker Desktop, refer to:
[Docker Troubleshooting Guide](https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/)

## Managing Docker Space
To check how much space Docker is using:
```sh
docker system df
```
To remove all unused data:
```sh
docker system prune
```
To clean specific elements:
```sh
docker container prune  # Remove stopped containers
docker image prune      # Remove unused images
docker network prune    # Remove unused networks
```

## Inspecting Containers
To inspect a container, image, or network:
```sh
docker inspect <container_id | image_id | network_id>
```

## Working with Docker Hub
### Pushing an Image to Docker Hub
1. Log in to Docker Hub:
   ```sh
   docker login
   ```
   Enter your Docker Hub credentials.

2. Push an image:
   ```sh
   docker push <username>/flask_app:1.0
   ```

### Pulling an Image from Docker Hub
To download an image from Docker Hub:
```sh
docker pull <username>/flask_app:1.0
```

---

This `README.md` will be updated as I progress in learning Docker. 🚀

