# Container Orchestration

## What is Container Orchestration?

Suppose you have developed a wonderful application that will be used by millions of users. How will it be deployed efficiently without having a single point of failure to handle a large number of requests?

Managing systems at a large scale is very difficult. Millions of containers run on different machines. How will you track which container has stopped or which service is no longer running?

Managing this cluster of containers effectively is called container orchestration. At present, there are three major tools available that help in container orchestration, namely:
- Docker Swarm
- Kubernetes
- Apache Mesos

---

## What is Docker Swarm?

Docker Swarm is a container orchestration tool that allows a user to manage multiple containers deployed across multiple host machines. Docker Swarm has different components that help it manage the cluster effectively.

### Docker Swarm Architecture

A **worker node** is something on which tasks are created by the manager. It will have services running on it to maintain the state defined in the YAML file.

In this architecture, there is only one YAML file. That’s the power of the YAML file. A stack of services is created and deployed on each worker node using the YAML file.

- A **node** is a machine. It can act as a manager, worker, or both. We can also have multiple manager nodes, but there will always be a primary node to manage the swarm cluster.

### Characteristics of the Manager Node:
- It always knows the exact state of the cluster.
- It is responsible for maintaining the state of the cluster described in the YAML file.
- It creates different tasks on worker nodes to maintain the desired service state.
- It keeps backups in case a node fails and starts new containers from backups on available nodes to maintain the count of containers.

### Building Blocks of Docker Swarm
A swarm cluster can have the following components:

- **Node**: The host machine. A machine can act as a worker, manager, or both.
- **Stack**: A set of services combined is called a stack.
- **Service**: The definition of tasks to execute on the manager or worker nodes.
- **Task**: Responsible for maintaining the desired replica set of the service.

---

## Creating Services in Docker Swarm

Like creating containers using `docker run`, a service does the same thing for a swarm cluster.

```sh
docker service create <service name>
```
Example:
```sh
docker service create --name web_app -p 4000:5000 flask_app:3.0
```

To list all services:
```sh
docker service ls
```

To create an overlay network:
```sh
docker network create --driver=overlay app
```

### Updating Services
To update a service:
```sh
docker service update --network-add <network name> <service name/ID>
```

### Scaling App Containers
To scale a service:
```sh
docker service scale <service ID/Name>=Replicas_number
```
Example:
```sh
docker service scale rnlrh4e262ae=3
```

---

## Running Swarm Cluster Visualization

To run a visualizer as a container:
```sh
docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock dockersamples/visualizer
```

To run it as a service:
```sh
docker service create --name=viz --publish=8080:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer
```

Open a browser and go to `localhost:8080`.

---

## Automating Deployments Using Docker Stack

A Docker Compose alternative for a swarm cluster:

```yaml
version: '3'
services:
  web:
    image: flask_app:3.0
    ports:
      - "4000:5000"
    networks:
      - app
    deploy:
      replicas: 3
  
  database:
    image: mysql/mysql-server:5.7
    env_file:
      - ./.env
    volumes:
      - "/Users/mohanadgad/Desktop/learn-docker/flask_app/db/init.sql:/docker-entrypoint-initdb.d/init.sql"
    deploy:
      replicas: 2
    networks:
      - app
  
  viz:
    image: dockersamples/visualizer
    ports:
      - "8080:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    networks:
      - app

networks:
  app:
```

---

## Managing Services in Docker Swarm

### Listing Services
```sh
docker service ls
```

### Inspecting a Service
```sh
docker service inspect <service_name>
```
Example:
```sh
docker service inspect login_app_web
```

### Viewing Service Logs
```sh
docker service logs <service_name>
```

### Scaling a Service
```sh
docker service scale <service_name>=<replica_count>
```

### Removing a Service
```sh
docker service rm <service_name>
```

### Updating a Service
```sh
docker service update --image myrepo/login_app:latest login_app_web
```

### Restarting a Service
```sh
docker service update --force <service_name>
```

### Deploying a Stack
```sh
docker stack deploy <stack name> --compose-file=docker-compose.yml
```

---

## Docker Swarm Commands Cheat Sheet

| Command | Options | Explanation |
|---------|---------|-------------|
| `docker swarm init` | | Makes the current machine a swarm node |
| `docker swarm leave` | `-f` | Removes the current node from a swarm cluster |
| `docker service create <image name>` | `-p`, `--env_file`, `--name`, `mount` | Creates a service from an image |
| `docker network create <name>` | `--driver` | Creates a new network |
| `docker service update [Options] <service ID>` | `--network-add` | Updates an existing service |
| `docker service ls` | | Lists all running services |
| `docker service scale <service Id>=<replica number>` | | Scales services up and down |
| `docker stack deploy <stack name>` | `--compose-file` | Deploys a new stack of services |
| `docker stack ls` | | Provides information about the current stack |
| `docker stack ps <stack_name>` | | Lists all tasks/containers of a stack |
| `docker stack services <stack name>` | | Lists all services in the stack |
| `docker stack rm <stack name>` | | Removes the stack from swarm |


