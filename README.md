

# Introduction
Get IFTTT Notifications When Containers Run Into Issues

Forked from the slack-based version: https://github.com/DennyZhang/monitor-docker-slack

# General Idea
1. Start a container in the target docker host.
2. This container will query status for all containers.

```curl -XGET --unix-socket /var/run/docker.sock http://localhost/containers/json```

3. Send notifications when container status is "unhealthy"

# How To Use
- set up a IFTTT webhook applet to e.g. get a notification on your android phone from the IFTTT app
- in the notification text put `{{Value1}}` 
- make note of the event name and service key

# How To Use: Plain Container
- Specify IFTTT credentials via env

```
export IFTTT_EVENT_NAME="#XXX"
export IFTTT_SERVICE_KEY="XXX"
export MSG_PREFIX="Monitoring On XX.XX.XX.XX"
```

- Start container to check
```
container_name="monitor-docker"
# Stop and delete existing container
docker stop $container_name; docker rm "$container_name"

# Start container to monitor docker healthcheck status
docker run -v /var/run/docker.sock:/var/run/docker.sock \
   -t -d -h $container_name --name $container_name \
   -e IFTTT_EVENT_NAME="$IFTTT_EVENT_NAME" -e IFTTT_SERVICE_KEY="$IFTTT_SERVICE_KEY" \
   -e MSG_PREFIX="$MSG_PREFIX" -e WHITE_LIST="$WHITE_LIST" --restart=always \
   poohsen/monitor-docker:latest

# Check status
docker logs "$container_name"
```

# How To Use: Docker-compose
```
version: '2'
services:
  monitor-docker:
    container_name: monitor-docker
    image: poohsen/monitor-docker:latest
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
    environment:
      IFTTT_EVENT_NAME: "#XXX"
      IFTTT_SERVICE_KEY: "XXX"
      MSG_PREFIX: "Monitoring On XX.XX.XX.XX"
    restart: always
```

# More customization
- Add message prefix for the slack notification
```
export MSG_PREFIX="Notification: "
```

- Skip checking certain containers by customizing WHITE_LIST env.
```
export WHITE_LIST="nodeexporter,ngin.*"
```

Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
