#!/bin/bash
sudo docker pull ldflk/ner_classifier
sudo docker kill local_ner_classifier
sudo docker run --rm -p 8081:8081 -d --name local_ner_classifier ldflk/ner_classifier