#!/bin/bash
sudo ./install_apt.sh
pipenv install
pipenv run ./install_galaxy.sh
