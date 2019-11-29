# Standford-NER-python-wrapper
A python wrapper and server implementation for Stanford NER

# Requirements 
Python 3.6, Java RE

# Installation 
Run the following command to install the dependencies.

    ./install.sh

# Usage

POST $IP:8080/classify

    Request  : JSON encoded text body
    Response : [
    [
       Value,
       Class
    ],
    [
       Value,
       Class
    ]
    ] 