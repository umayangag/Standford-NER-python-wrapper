#!/bin/bash
sudo apt-get install python3-pip &&
sudo pip3 install virtualenv &&
virtualenv -p /usr/bin/python3.6 venv &&
source venv/bin/activate &&
pip3 install --upgrade pip &&
pip3 install -r requirements.txt &&
pip3 install nltk flask flask_restful waitress &&
wget https://nlp.stanford.edu/software/stanford-ner-2018-10-16.zip &&
unzip stanford-ner-2018-10-16.zip &&
mv stanford-ner-2018-10-16/ stanford-ner &&
rm stanford-ner-2018-10-16.zip &&
python3 -m nltk.downloader -d venv/nltk_data punkt