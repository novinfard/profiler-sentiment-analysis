import csv
import os
from collections import defaultdict
import sys
import re
import numpy as np
import random
import math
import json

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

def build_data_cv(datafile):
	"""
	Loads data
	"""

	with open(datafile, "rb") as csvf:
		csvreader = csv.reader(csvf,delimiter=',',quotechar='"')
		data = []
		target = np.array([])

		for index, line in enumerate(csvreader):

			# escape header
			if index < 1:
				continue

			document = unicode(line[1], errors='replace').encode("UTF-8")
			data.append([document, 'y', line[2].lower(), line[3].lower(), line[4].lower(), line[5].lower(), line[6].lower()])

		return data

# main program
if __name__=="__main__":
	current_directory = os.getcwd() + "/"
	data_file = current_directory + "essays.csv"

	class_labels = ['EXT','NEU','AGR','CON','OPN']

	data = build_data_cv(data_file)

	filepath = "cleaned_dataset.csv"
	with open(filepath, 'wb') as resultFile:
		wr = csv.writer(resultFile, dialect='excel')
		wr.writerows(data)
