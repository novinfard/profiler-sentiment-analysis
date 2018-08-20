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
from sklearn.linear_model import SGDClassifier
from sklearn import metrics
from sklearn.model_selection import GridSearchCV
from sklearn.externals import joblib
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
import pickle

def build_data_cv(datafile, trait_number):
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

			document = unicode(line[1], errors='replace')

			data.append(document)

			index_of_trait = trait_number + 2

			if line[index_of_trait].lower()=='y':
				target = np.append(target, 1.0)
			else:
				target = np.append(target, 0.0)

		dataset = sklearn.datasets.base.Bunch(data=data, target=target)
		dataset.target_names = ["positive", "negative"]

		return dataset

# main program
if __name__=="__main__":
	current_directory = os.getcwd() + "/"
	data_file = current_directory + "essays.csv"

	class_labels = ['EXT','NEU','AGR','CON','OPN']

	for index, selected_trait in enumerate(class_labels):
		print selected_trait

		dataset = build_data_cv(data_file, index)
		
		X_train, X_test, y_train, y_test = train_test_split(dataset.data, dataset.target, test_size=0.2, random_state=0)

		clf = Pipeline([('vect', CountVectorizer(decode_error='replace')),
                      ('tfidf', TfidfTransformer()),
                      ('clf', SGDClassifier(loss='hinge', penalty='l2',
                                            alpha=1e-3, random_state=42,
                                            max_iter=5, tol=None)),
        ])
		# clf.fit(X_train, y_train)
		
		parameters = {'vect__ngram_range': [(1, 1), (1, 2)],
               'tfidf__use_idf': (True, False),
               'clf__alpha': (1e-2, 1e-3),
		}
		gs_clf = GridSearchCV(clf, parameters, n_jobs=-1)
		
		# fit the model
		gs_clf.fit(X_train, y_train)
		
		# simple test score
		# print clf.score(X_test, y_test)
		
		# 10-fold cross-validation score
		scores = cross_val_score(gs_clf, dataset.data, dataset.target, cv=10)
		print("Accuracy: %0.4f (+/- %0.4f)" % (scores.mean(), scores.std() * 2))

		# Export the classifier to a file
		joblib.dump(gs_clf, 'svm_gs_'+selected_trait+'.joblib')
#		with open('svm_gs_'+selected_trait+'.pkl', 'wb') as f:
#			pickle.dump(gs_clf, f)

		print "______________________"
		
		# single entity test
		#		docs_new = ["""
		#			I have to go to the SI unit and then the Crew meeting and come home, shower, get ready, and meet Ann and Chad for dinner. I should have some time tonight to do homework. I'm still tired from last night, maybe I can take a nap sometime today. Otherwise, I can always sleep in tomorrow. Having only afternoon classes will be interesting. My lab might be hard because it's at night, but it seems really lax. It's such a difference from the chem labs. I'm so glad it doesn't seem hard at all. I hope my physics lab is easy as well. One can only hope. Not having lab the first week is nice. It worked out well so I could be home to help my parents help move our stuff. It's such a pain to have to move when school is already in session. I'm a little shocked the manager didn't have us sign the lease before we moved in. I hope that's not an indication of how much she cares about the renters. At least there's a lady downstairs who has lived here for 20 years that knows everything about this place. It's so nice having an apartment right next to a bus stop. I think it's fate we moved in here. After all the hassles we've had it looks like its going to be worth it. I still have to hang up all my clothes, but everything else is done. I can't forget to meet Dan at 10am on Monday in the PCL to work on physics homework. It's 6 pages long. I hope it's as easy as the first homework. It still took a while to finish though. From 7pm to 1am. This time I'll start earlier. I'm glad that my sister is coming in town, but she picked a bad weekend. I have a lot of reading to do and 2 tests to study for. I need to start seriously studying the PCAT. I can't believe I almost missed the deadline on that again. This is ridiculous. I hope I get into UT Austin. That's the only place I'd really like to go. Except maybe UCSF or University of Washington. UCSF is probably too expensive. I'd want to live in San Fran when I have money so really I only want to got o Pharmacy school in Austin or Seattle. The only thing about Seattle is I hope Sylvia has gotten cleaner. I know she never cooks anymore, so probably. We'd have to get a bigger place than what she has now and I might just have to leave all my stuff here and buy new stuff. That's going to be expensive. I hope whatever happens, Mom and Dad aren't disappointed in me. They need a web page for PAC so I know when I need to get in line and for what. The draw system for the football team is so much more efficient, even though they don't give out all the information I need either. Maybe next year I won't buy either. It's so much of a pain. I don't even feel like going. I bet that's how they make their money. I don't know about the plays, but at the games students get crappy seats. I know they were trying to improve that, I wonder if that went through. Probably not. As a whole, UT just cares about money and not the poor students. That's why alumni get everything. Good luck to the ""sick"" staff."
		#		 """]
		#
		#		predicted = gs_clf.predict(docs_new)
		#		print predicted
#		break
