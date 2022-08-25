# LoRaBridge Setup

This repository provides an ansible project for setting up LoRaBridge devices.

## Ansible Controller Requirements

Requirements listed in files:

- `apt-requirements.txt`
- `Pipfile`
- `requirements.yml`

> Install requirements with e.g.

```bash
xargs apt install -y < apt-requirements.txt
# apt-get install $(cat apt-requirements.txt | tr '\n' ' ')
pipenv install
ansible-galaxy install -r requirements.yml
```

> ```bash
> ansible-vault encrypt_string --ask-vault-pass --stdin-name password
> ```

## Inventory file

Copy the `inventory.sample` file, name it `inventory` and insert the dhcp address of the new vm.

## Command

- Default playbook
  - `ansible-playbook -i inventory lorabridge.yaml --ask-become-pass --ask-pass`

**Note:**

- The repo directory **needs** to have `o-w` permissions
- If you add a ssh key to the vm, remove the `--ask-pass`
- Add `--ask-vault-pass` if you are using vault strings for passwords
- WSL and Vagrant users *should* read [this](#wslvagrant)

### WSL/Vagrant

Since Ansible 2.4.6 `./ansible.cfg` inside a `o+w` folder is **not loaded**:

> If Ansible were to load ansible.cfg from a world-writable current working directory, it would create a serious security risk. Another user could place their own config file there, designed to make Ansible run malicious code both locally and remotely, possibly with elevated privileges. For this reason, Ansible will not automatically load a config file from the current working directory if the directory is world-writable.

The "correct fix" is to correct the mount options, in order to enable changing permissions on NTFS filesystems:

> For more details on the correct settings, see:
>
> - for Vagrant, Jeremy Kendall's [blog post](http://jeremykendall.net/2013/08/09/vagrant-synced-folders-permissions/) covers synced folder permissions.
> - for WSL, the [WSL docs](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings) and this [Microsoft blog post](https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/) cover mount options.

Since this repository is intended to work *without* changing your environment, one can use this alternative commands instead:

**WARNING: USE AT YOUR OWN RISK**

```bash
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i inventory lorabridge.yaml --ask-become-pass --ask-pass --ask-vault-pass
```
