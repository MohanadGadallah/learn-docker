Every new Docker host gets a default single-host bridge network called bridge that Docker connects new containers to unless you override it with the --network flag.

# The docker network ls Command

The following commands show the output of a docker network ls command on Docker installation.

```
$ docker network ls
```

# The docker network inspect Command

As always, you can run docker inspect commands to get more information. We highly recommend running the command on your own system and studying the output.

```
$ docker network inspect bridge
```

# Create a New Network

In the next few steps, we’ll complete all of the following:

- Create a new Docker bridge network
- Connect a container to the new network
- Inspect the new network
- Test name-based discovery

Run the following command to create a new single-host bridge network called localnet.

```
$ docker network create -d bridge localnet
```

# Connect a Container to the Network

Let’s create a new container called c1 and attach it to the new localnet bridge network.

```
$ docker run -d --name c1 \
  --network localnet \
  alpine sleep 1d
```

Once you’ve created the container, inspect the localnet network and verify the container is connected to it. You’ll need the jq utility installed for the command to work. Leave off the "| jq" if it doesn’t work.

```
$ docker network inspect localnet --format '{{json .Containers}}' | jq
```

# Test Name Resolution Between Containers

If you add more containers to the localnet network, they’ll all be able to communicate using names. This is because Docker automatically registers container names with an internal DNS service and allows containers on the same network to find each other by name. The exception to this rule is the built-in bridge network that does not support DNS resolution.

Let’s test name resolution by creating a new container called c2 on the same localnet network and seeing if it can ping the c1 container. Run the following command to create the c2 container on the localnet network. You’ll need to type `exit` if you’re still logged in to the c1 container.

```
$ docker run -it --name c2 \
  --network localnet \
  alpine sh
```

Your terminal will switch into the c2 container. Try to ping the c1 container by name.

```
# ping c1
```

It works! This is because all containers run a DNS resolver that forwards name lookups to Docker’s internal DNS server that holds name-to-IP mappings for all containers started with the `--name` or `--net-alias` flag.

