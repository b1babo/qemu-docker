FROM ubuntu:16.04
ENV COPY_TO_DOCKER copy-to-docker



# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
# RUN apk update
# RUN apk add  gdb-multiarch

RUN mkdir /root/.pip 
COPY $COPY_TO_DOCKER/.pip/pip.conf /root/.pip/pip.conf

RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends python python-pip python-setuptools python-wheel && \
    apt-get install -y --no-install-recommends python3 python3-pip python3-setuptools python3-wheel && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple "pip < 21.0" -U && pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple "pip < 21.0" -U && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    apt-get install -y --no-install-recommends iputils-ping vim-tiny net-tools nmap telnet wget
    # rm -rf /var/lib/apt/lists/*





RUN apt-get install -y qemu-user-static  \
	&& apt-get install -y --no-install-recommends gdb-multiarch \
	&& apt-get install -y xz-utils gcc make gcc-arm-linux-gnueabi gcc-mips-linux-gnu gcc-mipsel-linux-gnu 


RUN mkdir /root/gdbserver
COPY $COPY_TO_DOCKER/gdbserver/run.sh /root/gdbserver/run.sh
COPY $COPY_TO_DOCKER/gdbserver/7.11.1/gdb-7.11.1.tar.xz /root/gdbserver/7.11.1/gdb-7.11.1.tar.xz

WORKDIR /root
# RUN chmod +x /root/gdbserver/run.sh \
# 	&&  /root/gdbserver/run.sh 7.11.1

RUN mkdir /root/workspace

