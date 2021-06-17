# -*- coding: utf-8 -*-

from nltk.tag import StanfordNERTagger
from nltk.tokenize import word_tokenize
from flask import Flask
from flask_restful import Api, Resource, reqparse
from flask import request
from waitress import serve

app = Flask(__name__)
api = Api(app)

st = StanfordNERTagger('stanford-ner/classifiers/english.all.3class.distsim.crf.ser.gz',
                       'stanford-ner/stanford-ner.jar',
                       encoding='utf-8')


# sort the NER result to merge entities of same class together
def sort_entities(classified_text):
    classified_text.append([" ", "O"])
    sorted_array = []
    previous_word = ""
    previous_class = ""

    for current_word, current_class in classified_text:
        if current_class == previous_class:
            previous_word += " " + current_word
        else:
            if [previous_word, previous_class] not in sorted_array and previous_word != "" and previous_class != "O":
                sorted_array.append([previous_word, previous_class])
            previous_word = current_word
            previous_class = current_class
    return sorted_array


class NER(Resource):
    def post(self):
        if request.get_json() is None:
            return {"error": "invalid input"}, 500

        text = request.get_json().replace("\n", "\n<<enter>> ")
        tokenized_text = word_tokenize(text)
        classified_text = st.tag(tokenized_text)

        return sort_entities(classified_text), 200


class HealthCheck(Resource):
    def get(self):
        return "health is okay", 200


api.add_resource(NER, "/classify")
api.add_resource(HealthCheck, "/health")
serve(app, port=8080)  # Change port number for production
