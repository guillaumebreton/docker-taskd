# taskd docker image

Taskd docker container.

NB: This image generates its own auto-sign certificate (which is not safe).
if you want to use your own certificate, puts them in the mounted volume /var/taskdata.

# Generate a client configuration

Acces to your container via

~~~
  docker exec -ti MY_IMAGE_NAME bash
~~~

and see : https://taskwarrior.org/docs/taskserver/user.html






