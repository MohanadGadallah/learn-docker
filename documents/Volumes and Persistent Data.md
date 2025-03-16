# Introduction to Volumes and Persistent Data

Let's take an overview of volumes and persistent data in Docker.

Stateful applications that create and manage data are a big part of modern cloud-native apps. This chapter explains how Docker volumes help stateful applications manage their data.

## Persistent vs. Non-Persistent Data

Persistent data is the stuff you care about and need to keep. It includes things like customer records, financial data, research results, audit data, and even some types of logs. Non-persistent data is the stuff you don’t care about and don’t need to keep. We call applications that create and manage persistent data stateful apps, and applications that don’t create or manage persistent data stateless apps. Both are important, and Docker has solutions for both.

For stateless apps, Docker creates every container with an area of non-persistent local storage that’s tied to the container lifecycle. This storage is suitable for scratch data and temporary files, but you’ll lose it when you delete the container or the container terminates.

Docker has volumes for stateful apps that create and manage important data. Volumes are separate objects that you mount into containers, and they have their own lifecycles. This means you don’t lose the volumes or the data on them when you delete containers. You can even mount volumes into different containers.

## Containers and Persistent Data

There are three main reasons you should use volumes to handle persistent data in containers:

- **Volumes are independent objects that are not tied to the lifecycle of a container.**
- **You can map volumes to specialized external storage systems.**
- **Multiple containers on different Docker hosts can use volumes to access and share the same data.**

At a high level, you create a volume, then create a container, and finally mount the volume into the container. When you mount it into the volume, you mount it into a directory in the container’s filesystem, and anything you write to that directory gets stored in the volume. If you delete the container, the volume and data will still exist. You’ll even be able to mount the surviving volume into another container.

## Creating a Container with a Volume

Run the following command to create a new standalone container called `voltainer` that mounts a volume called `bizvol`.

```sh
$ docker run -it --name voltainer \
    --mount source=bizvol,target=/vol \
    alpine
```

## Volumes and Persistent Data

### Summary of the Concepts Covered in This Chapter

### Commands

Let's explore all the commands covered in this chapter:

- `docker volume create` creates new volumes. By default, it creates them with the local driver, but you can use the `-d` flag to specify a different driver.
- `docker volume ls` lists all volumes on your Docker host.
- `docker volume inspect` shows you detailed volume information. You can use this command to see where a volume exists in the Docker host’s filesystem.
- `docker volume prune` deletes all volumes not in use by a container or service replica. **Use with caution!**
- `docker volume rm` deletes specific volumes that are not in use.

### Quick Recap

There are two main types of data: **persistent** and **non-persistent**.

- **Persistent data** is data you need to keep, and **non-persistent data** is data you don’t need to keep.
- By default, all containers get a layer of writable, **non-persistent storage** that lives and dies with the container. We sometimes call this **local storage**, and it’s ideal for non-persistent data. However, if your apps create data you need to keep, you should store the data in a **Docker volume**.
- **Docker volumes** are first-class objects in the Docker API, and you manage them independently of containers using their own `docker volume` sub-command. This means deleting containers doesn’t delete the data in their volumes.
- A few third-party plugins exist that provide Docker with access to specialized external storage systems.
- **Volumes** are the recommended way to work with persistent data in Docker environments.

