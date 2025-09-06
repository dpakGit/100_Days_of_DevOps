### Task:


### What I Did

```
thor@jumphost ~$ ssh tony@stapp01

[tony@stapp01 ~]$ sudo -s

[root@stapp01 tony]# docker network ls

NETWORK ID     NAME      DRIVER    SCOPE
273fad386718   bridge    bridge    local
f6d1adacc649   host      host      local
618daa3e8ec1   none      null      local

[root@stapp01 tony]# docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE


[root@stapp01 tony]# docker network --help

Usage:  docker network COMMAND

Manage networks

Commands:
  connect     Connect a container to a network
  create      Create a network
  disconnect  Disconnect a container from a network
  inspect     Display detailed information on one or more networks
  ls          List networks
  prune       Remove all unused networks
  rm          Remove one or more networks

Run 'docker network COMMAND --help' for more information on a command.

[root@stapp01 tony]# docker network create beta -d macvlan  --subnet=172.168.0.0/24 --ip-range=172.168.0.0/24
9272786c5f87b34c74217dd821ce06f2f6869007acdd2eaecb71aea5d57e065e

[root@stapp01 tony]# docker network ls

NETWORK ID     NAME      DRIVER    SCOPE
9272786c5f87   beta      macvlan   local
273fad386718   bridge    bridge    local
f6d1adacc649   host      host      local
618daa3e8ec1   none      null      local

[root@stapp01 tony]# docker network inspect beta

[
    {
        "Name": "beta",
        "Id": "9272786c5f87b34c74217dd821ce06f2f6869007acdd2eaecb71aea5d57e065e",
        "Created": "2025-09-01T14:34:08.270872402Z",
        "Scope": "local",
        "Driver": "macvlan",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.168.0.0/24",
                    "IPRange": "172.168.0.0/24"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]

```

```
Here's a step-by-step guide to create a Docker network with the specified requirements:

Task: Create a Docker network named beta on App Server 1 in Stratos DC with the following configuration:

- Driver: macvlan
- Subnet: 172.168.0.0/24
- IP range: 172.168.0.0/24

Step 1: Connect to App Server 1

First, connect to App Server 1 in Stratos DC using SSH or any other remote access method.

Step 2: Create the Docker network

Use the following command to create the Docker network:

bash
docker network create -d macvlan --subnet 172.168.0.0/24 --ip-range 172.168.0.0/24 beta

Let's break down the command:

- docker network create: This command creates a new Docker network.
- -d macvlan: This option specifies the driver to use for the network. In this case, we're using macvlan, which allows containers to have their own MAC addresses and IP addresses on the host network.
- --subnet 172.168.0.0/24: This option specifies the subnet for the network.
- --ip-range 172.168.0.0/24: This option specifies the IP range for the network. In this case, it's the same as the subnet.
- beta: This is the name of the network we're creating.

Step 3: Verify the network

To verify that the network has been created successfully, use the following command:

bash
docker network ls

This command lists all the Docker networks on the system. You should see the beta network in the list.

To get more information about the beta network, use the following command:

bash
docker network inspect beta

This command provides detailed information about the network, including its configuration and settings.

Use case:

The macvlan driver is useful when you need to attach containers directly to a physical network. This allows containers to have their own IP addresses on the host network, making it easier to integrate them with existing infrastructure.

By creating a Docker network with a specific subnet and IP range, you can ensure that containers attached to this network will have IP addresses within that range. This can be useful for a variety of use cases, such as:

- Integrating containers with existing network infrastructure
- Providing containers with direct access to the host network
- Improving network performance by reducing the need for NAT and port mapping

In this specific case, the beta network is configured to use the 172.168.0.0/24 subnet and IP range, which means that containers attached to this network will have IP addresses within that range.
```



[root@stapp01 tony]# history | cut -c 8-

docker network ls

docker network --help

docker network create beta -d macvlan  --subnet=172.168.0.0/24 --ip-range=172.168.0.0/24

-# By adding the equals sign, you're ensuring that the --ip-range option is correctly parsed by the docker network create command.


docker network ls

docker network inspect beta

