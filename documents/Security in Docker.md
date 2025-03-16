# Security in Docker

Docker also has its own security technologies, including Docker Scout and Docker Content Trust.

## Docker Scout and Content Trust

Docker Scout offers class-leading vulnerability scanning that scans your images, provides detailed reports on known vulnerabilities, and recommends solutions. Docker Content Trust (DCT) lets you cryptographically sign and verify images.

## Security in Docker Swarm

If you use Docker Swarm, you’ll also get all of the following that Docker automatically configures:
- Cryptographic node IDs
- Mutual authentication (TLS)
- Automatic CA configuration and certificate rotation
- Secure cluster join tokens
- An encrypted cluster store
- Encrypted networks
- And more

# Linux Security Technologies

Learn how Linux namespaces create isolated environments for containers and how Docker uses them to enhance security and efficiency.

## Kernel Namespaces

Kernel namespaces, usually shortened to namespaces, are the main technology for building containers. Let's quickly compare namespaces and containers with hypervisors and virtual machines (VM).

Namespaces virtualize operating system constructs such as process trees and filesystems, whereas hypervisors virtualize physical resources such as CPUs and disks. In the VM model, hypervisors create virtual machines by grouping virtual CPUs, virtual disks, and virtual network cards so that every VM looks, smells, and feels like a physical machine. In the container model, namespaces create virtual operating systems (containers) by grouping virtual process trees, virtual filesystems, and virtual network interfaces so that every container looks, smells, and feels exactly like a regular OS.

## Namespace Security and Limitations

At a very high level, namespaces provide lightweight isolation but do not provide a strong security boundary. Compared with VMs, containers are more efficient, but virtual machines are more secure. Don’t worry, though. Platforms like Docker implement additional security technologies, such as cgroups, capabilities, and seccomp, to improve container security.

Namespaces are a tried and tested technology that’s existed in the Linux kernel for a very long time. However, they were complex and hard to work with until Docker came along and hid all the complexity behind the simple `docker run` command and a developer-friendly API.

## Docker on Linux

At the time of writing, every Docker container gets its own instance of the following namespaces:

- Process ID (pid)
- Network (net)
- Filesystem/mount (mnt)
- Inter-process Communication (ipc)
- User (user)
- UTS (uts)

The figure below shows a single Docker host running two containers. The host OS has its own collection of namespaces we call the root namespaces, and each container has its own collection of equivalent isolated namespaces. Applications in containers think they’re running on their own host and are unaware of the root namespaces or namespaces in other containers.

# Control Groups and Capabilities

## Control Groups (cgroups)

If namespaces are about isolation, control groups (cgroups) are about limits.

Think of containers as similar to rooms in a hotel. While each room might appear to be isolated, they actually share many things, such as water, electricity, air conditioning, a swimming pool, a gym, elevators, a breakfast bar, and more. Containers are similar—even though they’re isolated, they share many common resources, such as the host’s CPU, RAM, network I/O, and disk I/O.

Docker uses cgroups to limit a container’s use of these shared resources and prevent any container from consuming them all and causing a denial of service (DoS) attack.

## Capabilities

The Linux root user is extremely powerful, and you shouldn’t use it to run apps and containers.

However, it’s not as simple as running them as non-root users, as most non-root users are so powerless that they are practically useless. What’s needed is a way to run apps and containers with the exact set of permissions they need — nothing more, nothing less.

This is where capabilities come to the rescue. Under the hood, the Linux root user is a combination of a long list of capabilities. Some of these capabilities include:

- **CAP_CHOWN**: lets you change file ownership
- **CAP_NET_BIND_SERVICE**: lets you bind a socket to low-numbered network ports
- **CAP_SETUID**: lets you elevate the privilege level of a process
- **CAP_SYS_BOOT**: lets you reboot the system

The list goes on and is long.

Docker leverages capabilities so that you can run containers as root but strip out all the capabilities you don’t need. For example, suppose the only capability your container needs is the ability to bind to low-numbered network ports. In that case, Docker can start the container as root, drop all root capabilities, and then add back the `CAP_NET_BIND_SERVICE` capability.

This is a good example of implementing the principle of least privilege as you end up with a container that only has the capabilities it needs. Docker also sets restrictions to prevent containers from re-adding dropped capabilities. Docker ships with sensible out-of-the-box capabilities, but you should configure your own for your production apps and containers. However, configuring your own requires extensive effort and testing.

# Docker Scout and Vulnerability Scanning

Learn about image scanning, a crucial security practice that analyzes container images for vulnerabilities, ensuring the security of your containerized applications.

Every container runs multiple software packages that are susceptible to bugs and vulnerabilities that malicious actors can exploit.

# Signing and Verifying Images with Docker Content Trust

Let's see how Docker Content Trust makes it smooth to verify the integrity and the publisher of Docker images.

## Ensuring Image Integrity with DCT

Docker Content Trust (DCT) makes it simple for you to verify the integrity and publisher of images and is especially important when you're pulling images over untrusted networks such as the internet. At a high level, DCT lets you sign your images when you push them to registries like Docker Hub. It also lets you verify the images you pull and run as containers.

You can also use DCT to provide context, such as whether or not a developer has signed an image for use in a particular environment, such as prod or dev, or whether an image has been superseded by a newer version and is, therefore, stale.

## Setting up Docker Content Trust

The following steps walk you through configuring Docker Content Trust, signing and pushing an image, and then pulling the signed image.

If you plan on following along, you’ll need a cryptographic key pair. If you don’t already have one, you can run the following `docker trust` command to generate one. The command generates a new key pair called `nigel` and loads it to the local trust store ready for use. It will prompt you to enter a passphrase; don’t forget it.

