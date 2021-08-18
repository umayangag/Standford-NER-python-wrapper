FROM python:3.6-slim-buster
WORKDIR /Standford-NER-python-wrapper

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y ant && \
    apt-get clean;

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY classify.py classify.py
ADD stanford-ner stanford-ner
ADD venv/nltk_data /usr/local/nltk_data

EXPOSE 8081
CMD [ "python3.6", "classify.py"]
