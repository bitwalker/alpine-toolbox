## Alpine Toolbox

This is an Alpine Linux image I use for troubleshooting within OpenShift. It's got things I use, but those things may be
different than the things you want. Grab and modify if desired, or use as is!

## Usage

```
# From a machine where host uids are mapped to container uids
# The user does not have to be root
$ docker run -it --user=root bitwalker/alpine-toolbox:latest sh

# If you are on a system where container uids are private, you do not need to pass `user`,
# as the container will run with a `default` user with limited access
$ docker run -it bitwalker/alpine-toolbox:latest sh
```

## License

MIT
