# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8
SHELL ["/bin/bash", "-c"] 
WORKDIR /app
COPY . /app

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN pip3 install virtualenv
RUN python -m pip install -r requirements.txt

# Install stanford-ner
RUN wget https://nlp.stanford.edu/software/stanford-ner-2018-10-16.zip
RUN unzip stanford-ner-2018-10-16.zip
RUN mv stanford-ner-2018-10-16/ stanford-ner
RUN rm stanford-ner-2018-10-16.zip
# RUN python3 import nltk
RUN python3 -m nltk.downloader -d /home/appuser/nltk_data punkt

# Install JRE
RUN apt update
RUN apt install openjdk-11-jre -y
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"    


# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

EXPOSE 8081

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python", "classify.py"]
