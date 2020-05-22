ARG kube_version="v1.18.1"
FROM registry.aliyuncs.com/google_containers/kube-controller-manager:${kube_version}

RUN apt update && apt install -y wget  gnupg lsb-release

ARG ceph_version="octopus"
RUN wget -q -O - https://mirrors.aliyun.com/ceph/keys/release.asc | apt-key add - && \
      echo deb https://mirrors.aliyun.com/ceph/debian-${ceph_version}/ $(lsb_release -sc) main > /etc/apt/sources.list.d/ceph.list && \
      apt update && \
      apt install -y ceph-common ceph-fuse 

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
