# Why?
This stage for autoPwn is simply to speed up building. By downloading the Ghidra requirements separately, then using multi-stage build copy, it allows dockerhub to use internal file transfer rather than external, which should significantly improve the build speed and make it less reliant on ghidra website being responsive.

# Want to run just Ghidra?
Since this is just a base image for Ghidra, you can run it directly from this as well. 

```bash
sudo docker run -it --rm --privileged -v $PWD:/mount -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --shm-size=2G --network=host bannsec/autopwn-stage-ghidra
```
