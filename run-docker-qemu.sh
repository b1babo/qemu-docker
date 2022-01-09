OWNERNAME="bibabo"
IMAGENAME="qemu-docker"
TAGNAME="v.1.0"

PORTSTRING=""

if [ "${PORTFWD}" = "" ]
then
   PORTFWD="20080:80,20443:443,28080:8080,24433:4433,9999:9999"
fi

PORTFWD=$(echo ${PORTFWD} | tr -cd [0-9,:])

IFS=',' read -ra PORTLIST <<< "${PORTFWD}"
for PORTPAIR in "${PORTLIST[@]}"
do
   SPORT=$(echo ${PORTPAIR} | cut -d':' -f1)
   PORTSTRING="${PORTSTRING} -p ${SPORT}:${SPORT}"
done

docker run \
	-it \
	${PORTSTRING} \
	-e PORTFWD="${PORTFWD}" \
	--rm \
	--cap-add=NET_ADMIN \
	--cap-add=SYS_ADMIN \
	--security-opt apparmor=unconfined \
	--device=/dev/net/tun \
	--name qemu-docker \
	--mount "type=bind,src=$(pwd)/workspace,dst=/root/workspace" \
	$OWNERNAME/$IMAGENAME:$TAGNAME $*