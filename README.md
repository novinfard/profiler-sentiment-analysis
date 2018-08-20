# Profiler Application using Sentiment Analysis

## Abstract
We send many posts and pictures over the time on our social channels such as Facebook, Instagram or Twitter. This phenomenon creates some unstructured data stream. On the other side, it is interesting for most people to know about their personality which may help them to know themselves better. In addition, there are times which predicting the other’s personality regarding the employment process, could lead to making a better team. The idea behind this project is to create a mobile application that helps a user to predict their own or others personality. After collecting enough data from the user, we applied sentiment analysis algorithms to this data and classified user’s personality trait according to Big Five Factor model. Then the result is presented in an interface designed and evaluated during three iterations and evaluation process based on user interface principles.

## Installation
### Sentiment Analysis ML Models
The prediction model is written in python. The model implementation placed in `ml-model` folder. First make sure that python is already installed in your machine. The python libraries used for creating our model can be installed in Terminal:

```sh
$ pip install -U scikit-learn==1.14.3
$ pip install -U numpy==1.14.3
```

**Input Dataset**: To automate personality recognition, Pennebaker and King provided a dataset of essays which are tagged with different personalities. The dataset includes 2,465 stream-of-consciousness essays. The personality categories are based on the Big Five Factor model with EXT, NEU, AGR, CON and OPN labels.

The dataset file named `essays.csv` is available in model folder.

For training the model by Naive Bayes algorithm, run the following command in Terminal:

```sh
$ python process_naive_bayesian.py 
```

Similarly, for training the model by Support Vector Machine, run the following command:

```sh
$ python process_svm_with_gridsearch.py
```
The output of this process, will be accuracy measurement of model by 10-fold cross validation technique. In addition, the model output file as `joblib` will be created by the process which is used for deployment of the model.

#### Special test cases
On the better evaluation of our algorithm, we tested our model against two specific cases: Donald Trump and Hillary Clinton. We used about 3000 tweets of each of these American presidential candidates in 2016. To run the test, write the following command in your Terminal:

```sh
$ python process_test.py
```

### Deploy model in Server
You should deploy an HTTP server to serve the prediction model to mobile clients. We used the Python language with `Flask` library to achieve this goal.  The implementation of server deployment placed in `server` folder. First, you need to install the following python libraries with `virtualenv `:

```sh
$ sudo pip install virtualenv
$ mkdir myproject
$ cd myproject
$ virtualenv venv
$ pip install -U scikit-learn==1.0.2
```

Now, with running the following command the server will run:

```sh
$ python server.py
```

### iOS Application
To run the iOS application, the Xcode software should be already have setup in your macOS system.

The iOS application have used the Cocoapod as dependecy manager. Read more about it here:
[https://cocoapods.org]()

To Run the mobile application, go to the root of mobile application in `ios_app` folder, open your terminal and follow these steps:

**Install Cocoapods**

```sh
$ sudo gem install cocoapods
```

**Run the pod file**

To install the required dependecies, run the following command in your terminal:

```sh
$ pod install
```

**Open the workspace**

Open the `ProfilerSA.xcworkspace` file with `Xcode` program.

**Run the application**

Click on run botom at top left side of Xcode or press `⌘ + R` on your keyboard.

## User Interface
The implementation of interface started with creating a low-fidelity prototype. We just used papers and markers to create this paper-based interface.
Before start working on a high-fidelity prototype, we should have created our colour scheme. We used “Adobe Colour CC” (https://color.adobe.com), an online tool for creating our colour set for this purpose. Although it has a complex interface, it offers professional toolset for colour mixing.
In the next stage, we used an online tool named “MarvelApp” (https://marvelapp.com) for creating a high-fidelity prototype. MarvelApp provides core user interface tools and functionality needed for creating a suitable prototype, wireframes or mock-ups. The final implementation of the user interface is accessible at the following link:

* First hi-fidelity version (iteration 3)
[https://marvelapp.com/5f1375b 
]()
* Second hi-fidelity version (final version)
[https://marvelapp.com/18gg77h6/
]()

