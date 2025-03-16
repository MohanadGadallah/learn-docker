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

# Visualizing Port Mapping

Let’s test the setup to see if it works. Create a new container called web running NGINX on port 80 and map it to port 5005 on the Docker host.

```
$ docker run -d --name web \
  --network localnet \
  --publish 5005:80 \
  nginx
```

Verify the port mapping.

```
$ docker port web
```

# Connecting to Existing Networks and VLANs

The ability to connect containerized apps to external systems and physical networks is important. A common example is partially containerized apps where the parts running in containers need to be able to communicate with the parts not running in containers.

## MACVLAN

The built-in MACVLAN driver (transparent if you’re using Windows containers) was created with this in mind. It gives every container its own IP and MAC address on the external physical network, making each one look, smell, and feel like a physical server or VM. This is shown in the figure below.

On the positive side, MACVLAN performance is good as it doesn’t require port mappings or additional bridges. However, you need to run your host NICs in promiscuous mode, which isn’t allowed on many corporate networks and public clouds. So, MACVLAN will work on your data center networks if your network team allows promiscuous mode, but it probably won’t work on your public cloud.

## Docker MACVLAN Configuration

Now comes the requirement to attach a container to VLAN 100. To do this, you create a new Docker network with the macvlan driver and configure it with all of the following:

- Subnet info
- Gateway
- Range of IPs it can assign to containers
- Which of the host’s interfaces or sub-interfaces to use

Run the following command to create a new MACVLAN network called macvlan100 that will connect containers to VLAN 100. You may need to change the name of the parent interface to match the parent interface name on your system. For example, changing `-o parent=eth0.100` to `-o parent=enp0s1.100`. The parent interface must be connected to the VLAN.

```
$ docker network create -d macvlan \
  --subnet=10.0.0.0/24 \
  --ip-range=10.0.0.0/25 \
  --gateway=10.0.0.1 \
  -o parent=eth0.100 \        <<---- Make sure this matches your system
  macvlan100
```

## IP Ranges

We also used the `--ip-range` flag to tell the new network which subset of IP addresses it can assign to containers. It’s vital that you reserve this range of addresses for Docker, as the MACVLAN driver has no management plane feature to check if IPs are already in use.

## Deploying the Network

Once you’ve created the macvlan100 network, you can connect containers to it and Docker will assign the IP and MAC addresses on the underlying VLAN so they’ll be visible to other systems.

The following command creates a new container called mactainer1 and connects it to the macvlan100 network.

```
$ docker run -d --name mactainer1 \
  --network macvlan100 \
  alpine sleep 1d
```

However, remember that the underlying network (VLAN 100) does not see any of the MACVLAN magic, it only sees the container with its MAC and IP addresses, meaning the mactainer1 container will be able to communicate with every other system connected to VLAN 100!

**Note:** If you can’t get this to work, it might be because your host NIC isn’t in promiscuous mode. Also, remember that public cloud platforms normally block promiscuous mode.

# Chapter Summary: Docker Networking

## Quick Recap

- The Container Network Model (CNM) defines sandboxes, endpoints, and networks.
- Libnetwork is the reference implementation of CNM and enables Docker’s core networking.
- Drivers extend libnetwork capabilities, including bridge and overlay networks.
- Single-host bridge networks are basic and useful for small applications.
- Overlay networks support multi-host container communication.
- The macvlan driver connects containers to external networks, assigning them their own MAC and IP addresses but requires promiscuous mode.

## Commands

Docker networking commands:
- `docker network ls` lists all Docker networks.
- `docker network create` creates a new network.
- `docker network inspect` provides configuration details.
- `docker network prune` removes unused networks.
- `docker network rm` deletes specific networks.

Linux commands:
- `brctl show` lists kernel bridges.
- `ip link show` displays bridge configurations.

