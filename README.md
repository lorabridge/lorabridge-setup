> [!WARNING]
> This project is **deprecated** and was superseded by [LoRaBridge2](https://github.com/lorabridge2). The replacement for **this** repository is [setup](https://github.com/lorabridge2/setup).
> 
# LoRaBridge Ansible Setup
This repository is part of the [LoRaBridge](https://github.com/lorabridge/lorabridge) project and provides an ansible project for setting up LoRaBridge devices via ssh.
This setup method automates several steps of the installation process of bridge and gateways devices. You need to clone this repository.

You need to prepare the Raspberry Pi devices as described in the [docs]().

### Clone Setup Repository

Download the code for the Ansible setup and switch inside the folder:

```bash
git clone https://github.com/lorabridge/lorabridge-setup.git
cd lorabridge-setup
```

### Ansible Controller Requirements

You need to install the requirements listed in following files inside the repository on the host running the setup:

- `apt-requirements.txt`
- `Pipfile`
- `requirements.yml`

> Install requirements with e.g.
>```bash
>xargs apt install -y < apt-requirements.txt
># apt-get install $(cat apt-requirements.txt | tr '\n' ' ')
>pipenv install
>ansible-galaxy install -r requirements.yml
>```

### Inventory file

Copy the `inventory.sample` file, name it `inventory` and Replace the placeholders with the actual values of the bridge and gateway devices.

```ini
[bridges]
<bridges ip address> hostname=<desired hostname>

[gateways]
<gateway ip address> hostname=<desired hostname>
```

### Configuration Variables

Configuration variables are defined in following places:

```bash
group_vars/all/all.yaml
group_vars/bridges/*
group_ars/gateways/*
roles/<role name>/defaults/main.yaml
```

You can overwrite them by creating a new `yaml` file (e.g. `myconfig.yaml`) inside `group_vars/all/`, `group_vars/bridges/` or `group_vars/gateway/` and configuring the desired value in there.
Doing this inside `group_vars/all/` affects all devices, `group_vars/bridges/` affects only bridge devices and `group_vars/gateways/` affects only gateway devices.

Usually you will not need to change the configuration unless you changed the default user name.
>Example for changing the user name to user1:
>- Create a custom configuration file `group_vars/all/custom.yaml`
>- Insert the following content:
>```bash
>---
>pi_user: "user1"
>```

### Executing the setup

Start the setup with the following command:

```bash
ansible-playbook -i inventory lorabridge.yaml --ask-become-pass --ask-pass
```

## License

All the LoRaBridge software components and the documentation are licensed under GNU General Public License 3.0.

## Acknowledgements

The financial support from Internetstiftung/Netidee is gratefully acknowledged. The mission of Netidee is to support development of open-source tools for more accessible and versatile use of the Internet in Austria.
