#here to list all docker commands 

#Managing Data for Container
docker run -it -v <host_absolute_path>:<folder path in container> -p 5000:5000 flask_app:1.

-----------------------------------------------------------------------------------------------
#To get back into the container, Type
docker exec -it <container id> bash.
-----------------------------------------------------------------------------------------------
#If your container is running in daemon mode or in the background,   to list all running containers
docker ps
-------------------------------------------------------------------------------------------------
#to access docker logs
docker logs <container_id>
------------------------------------------------------------------------------------------------------
You can further save these logs in any file by redirecting stdout to a file.

#docker logs <CONTAINER ID> >output.log

to watch real-time logs

#docker ps to check running containers
#docker attach <CONTAINER ID>     ----Why is this critical and not recommended? If you accidentally press ctrl+c or any kill signal to get back to the shell, the application will stop.
#docker logs -f <CONTAINER ID>  ----This code above will print all the logs and listen for new activity.
---------------------------------------------------------------------------------------
to Diagnose from the terminal or docker desktop 
https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/


---------------------------------------------------------------------------------------
     Figure out how much space is used by Docker. Type 
     #docker system df.

_________________
to remove all 
#docker system prune
____________
You can also prune at the granular level if you want to clean specific things like:

   # docker container prune
   # docker images prune
   #docker network prune

____________
Container inspection
#docker inspect <Container/Image/Network ID>

------

         docker hub 

         Steps to push an image#

         type docker login on the command prompt or terminal
         enter your login credentials

         
         Push the image using docker push <username>/flask_app:1.0
         If you just want to pull the image, then type docker pull <username>/flask_app:1.0.