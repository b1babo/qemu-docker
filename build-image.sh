
OWNERNAME="bibabo"
IMAGENAME="qemu-docker"
TAGNAME="v.1.0"


DOCKER_BUILDKIT=1 docker build -t $OWNERNAME/$IMAGENAME:$TAGNAME \
                               -f Dockerfile .