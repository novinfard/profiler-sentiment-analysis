import csv
import os
from collections import defaultdict
import sys
import re
import numpy as np
import random
import math

import sklearn.datasets
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import Pipeline
from sklearn import metrics
from sklearn.model_selection import GridSearchCV
from sklearn.externals import joblib
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score

def warn(*args, **kwargs):
    pass
import warnings

def build_data_cv(datafile, trait):
	"""
	Loads data
	"""

	with open(datafile, "rb") as csvf:
		csvreader = csv.reader(csvf,delimiter=',')
		data = []
		target = np.array([])

		for index, line in enumerate(csvreader):
			
			# escape header
			if index < 1:
				continue

			# if line[1] != "HillaryClinton": # Clinton
			if line[1] != "realDonaldTrump": # Trump
				continue

			target_of = {
				"EXT" : 1.0,
				"NEU" : 1.0,
				"AGR" : 0.0,
				"CON" : 0.0,
				"OPN" : 0.0
			}

			document = unicode(line[2], errors='replace')

			data.append(document)

			target = np.append(target, target_of[trait])

		dataset = sklearn.datasets.base.Bunch(data=data, target=target)
		dataset.target_names = ["positive", "negative"]

		return dataset

# main program
if __name__=="__main__":
	warnings.warn = warn

	current_directory = os.getcwd() + "/"
	data_file = current_directory + "tweets.csv"

	class_labels = ['EXT','NEU','AGR','CON','OPN']

	for index, selected_trait in enumerate(class_labels):
		print selected_trait

		dataset = build_data_cv(data_file, selected_trait)
		print len(dataset.data)

		# model folder
		model_folder = "svm_gs"
		# model_folder = "nb"

		model_file = current_directory + "models/" + model_folder + "/" + selected_trait.lower() + "/model.joblib"

		# load the model from disk
		loaded_model = joblib.load(model_file)
		result = loaded_model.score(dataset.data, dataset.target)
		label = "positive"
		if result < 0.5:
			label = "negative"
		print("result: " + label + " / score: %0.2f" % (result*100))
		print "______________________"
