Image Building
--------------

.. code-block:: bash

    sudo docker run -d \
      --name docker-in-docker \
      --privileged=true \
      --net=host \
      -v /var/lib/docker \
      -v ${HOME}/.docker/config.json:/root/.docker/config.json:ro\
      docker.io/docker:17.07.0-dind \
      dockerd \
        --pidfile=/var/run/docker.pid \
        --host=unix:///var/run/docker.sock \
        --storage-driver=overlay2
    sudo docker exec docker-in-docker apk update
    sudo docker exec docker-in-docker apk add git

    sudo docker exec docker-in-docker docker build --force-rm --pull --no-cache \
        https://git.openstack.org/openstack/loci.git \
        --network host \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT=requirements \
        --build-arg PROJECT_REF=stable/newton \
        --tag docker.io/openstackhelm/requirements:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/requirements:newton

    sudo docker exec docker-in-docker docker build https://git.openstack.org/openstack/loci.git \
        --build-arg PROJECT=keystone \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT_REF=newton-eol \
        --build-arg PROFILES="apache" \
        --build-arg PIP_PACKAGES="pycrypto" \
        --build-arg WHEELS=openstackhelm/requirements:newton \
        --tag docker.io/openstackhelm/keystone:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/keystone:newton

    sudo docker exec docker-in-docker docker build https://git.openstack.org/openstack/loci.git \
        --build-arg PROJECT=heat \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT_REF=newton-eol \
        --build-arg PROFILES="apache" \
        --build-arg PIP_PACKAGES="pycrypto" \
        --build-arg WHEELS=openstackhelm/requirements:newton \
        --tag docker.io/openstackhelm/heat:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/heat:newton

    sudo docker exec docker-in-docker docker build --force-rm --pull --no-cache \
        https://git.openstack.org/openstack/loci.git \
        --build-arg PROJECT=glance \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT_REF=newton-eol \
        --build-arg PROFILES="glance ceph" \
        --build-arg PIP_PACKAGES="pycrypto python-swiftclient" \
        --build-arg WHEELS=openstackhelm/requirements:newton \
        --tag docker.io/openstackhelm/glance:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/glance:newton

    sudo docker exec docker-in-docker docker build --force-rm --pull --no-cache \
        https://git.openstack.org/openstack/loci.git \
        --build-arg PROJECT=cinder \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT_REF=newton-eol \
        --build-arg PROFILES="cinder lvm ceph" \
        --build-arg PIP_PACKAGES="pycrypto python-swiftclient" \
        --build-arg WHEELS=openstackhelm/requirements:newton \
        --tag docker.io/openstackhelm/cinder:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/cinder:newton

    sudo docker exec docker-in-docker docker build --force-rm --pull --no-cache \
        https://git.openstack.org/openstack/loci.git \
        --build-arg PROJECT=neutron \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT_REF=newton-eol \
        --build-arg PROFILES="neutron linuxbridge openvswitch" \
        --build-arg PIP_PACKAGES="pycrypto" \
        --build-arg WHEELS=openstackhelm/requirements:newton \
        --tag docker.io/openstackhelm/neutron:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/neutron:newton

    sudo docker exec docker-in-docker docker build --force-rm --pull --no-cache \
        https://git.openstack.org/openstack/loci.git \
        --build-arg PROJECT=nova \
        --build-arg FROM=gcr.io/google_containers/ubuntu-slim:0.14 \
        --build-arg PROJECT_REF=stable/newton \
        --build-arg PROFILES="nova ceph linuxbridge openvswitch configdrive qemu apache" \
        --build-arg PIP_PACKAGES="pycrypto" \
        --build-arg WHEELS=openstackhelm/requirements:newton \
        --tag docker.io/openstackhelm/nova:newton
    sudo docker exec docker-in-docker docker push docker.io/openstackhelm/nova:newton
