# [START app]
import logging
import json
import os

from flask import Flask, request
from sklearn.externals import joblib

MODEL_EXT = None
MODEL_NEU = None
MODEL_AGR = None
MODEL_CON = None
MODEL_OPN = None


app = Flask(__name__)

@app.before_first_request
def _load_model():
    global MODEL_EXT, MODEL_NEU, MODEL_AGR, MODEL_CON, MODEL_OPN
    current_directory = os.getcwd() + "/"

    # model folder
    model_folder = "svm_gs"
    # model_folder = "nb"

    # class_labels = ['EXT','NEU','AGR','CON','OPN']

    ext_file = current_directory + "models/" + model_folder + "/ext/model.joblib"
    neu_file = current_directory + "models/" + model_folder + "/neu/model.joblib"
    agr_file = current_directory + "models/" + model_folder + "/agr/model.joblib"
    con_file = current_directory + "models/" + model_folder + "/con/model.joblib"
    opn_file = current_directory + "models/" + model_folder + "/opn/model.joblib"

    # load the model from disk
    MODEL_EXT = joblib.load(ext_file)
    MODEL_NEU = joblib.load(neu_file)
    MODEL_AGR = joblib.load(agr_file)
    MODEL_CON = joblib.load(con_file)
    MODEL_OPN = joblib.load(opn_file)


@app.route('/', methods=['POST'])
def predict():
    text = request.values.get('text', '') 
    logging.warning(text)

    ext = MODEL_EXT.predict([text]).tolist()
    neu = MODEL_NEU.predict([text]).tolist()
    agr = MODEL_AGR.predict([text]).tolist()
    con = MODEL_CON.predict([text]).tolist()
    opn = MODEL_OPN.predict([text]).tolist()
    return json.dumps({'ext': ext[0], 'neu': neu[0], 'agr': agr[0], 'con': con[0], 'opn': opn[0]}), 200

    for index, selected_trait in enumerate(class_labels):
        
        # model folder
        model_folder = "svm_gs"
        # model_folder = "nb"
        model_file = current_directory + "models/" + model_folder + "/" + selected_trait.lower() + "/model.joblib"

        # load the model from disk
        model = joblib.load(model_file)
        y = model.predict([text]).tolist()
  #       y = model.predict(text).tolist()
        # return json.dumps({'y': y}), 200

#       result = loaded_model.score(dataset.data, dataset.target)
#       label = "positive"
#       if result < 0.5:
#           label = "negative"
#       print("result: " + label + " / score: %0.2f" % (result*100))
    # return json.dumps({'y': 'test'}), 200



@app.errorhandler(500)
def server_error(e):
    logging.exception('An error occurred during a request.')
    return """
    An internal error occurred: <pre>{}</pre>
    See logs for full stacktrace.
    """.format(e), 500


if __name__ == '__main__':
    # This is used when running locally. Gunicorn is used to run the
    # application on Google App Engine. See entrypoint in app.yaml.
    app.run(host='127.0.0.1', port=8080, debug=True)
# [END app]
