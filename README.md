# Cumulus Networks Quagga Container

This is a fork of cumulusnetworks/frrouting frr container

The container is designed to be run on Linux hosts in privileged mode. It can
be used to advertise service IP addresses which have been added to the host to
support new applications or to advertise other containers which have been
turned-up on the host.

To run the container:

    $ docker pull zioproto/frrouting
    $ docker run -t -d --net=host --privileged --name frr zioproto/frrouting:latest

Log into the Container and examine the routing configuration.

    $ docker exec -i -t frr /usr/bin/vtysh
    $ show run

Run the container with ansible:

    ---

    - name: "create/start FRR container"
      docker_container:
        name: FRR
        image: "{{frr_docker_image}}"
        restart_policy: "unless-stopped"
        state: "{{state}}"
        pull: true
        network_mode: host
        privileged: true
        volumes:
          - "/etc/frr/frr.conf:/etc/frr/frr.conf"
          - "/etc/frr/daemons:/etc/frr/daemons"
          - "/dev/log:/dev/log"
