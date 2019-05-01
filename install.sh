#!/bin/bash
sudo apt-get install python3-pip
sudo pip3 install virtualenv
virtualenv -p /usr/bin/python3.6 venv
source venv/bin/activate
pip install --upgrade pip
pip install ntlk flask flask_restful
wget https://nlp.stanford.edu/software/stanford-ner-2018-10-16.zip