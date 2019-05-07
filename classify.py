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


def sort_entities(classified_text):
    classified_text.append([" ", "O"])
    sorted_array = []
    previous_word = ""
    previous_class = ""

    for current_word, current_class in classified_text:
        if current_class == previous_class:
            previous_word += " " + current_word
        else:
            # TODO: bug: if same word with different class is found its added to the list
            if [previous_word, previous_class] not in sorted_array and previous_word != "" and previous_class != "O":
                sorted_array.append([previous_word, previous_class])
            previous_word = current_word
            previous_class = current_class
    return sorted_array


class NER(Resource):
    def post(self):
        text = request.get_json()
        tokenized_text = word_tokenize(text)
        classified_text = st.tag(tokenized_text)

        return sort_entities(classified_text), 200


api.add_resource(NER, "/classify")
serve(app, port=8080)
