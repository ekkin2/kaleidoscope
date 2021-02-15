import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from tqdm.notebook import tqdm 

import re
import nltk
import string
from nltk.corpus import stopwords

from sklearn.model_selection import train_test_split

import tensorflow as tf
from tensorflow.keras import Input
from tensorflow.keras.models import Sequential, Model
from tensorflow.keras.layers import Dense, LSTM, Reshape, Bidirectional
from tensorflow.keras import backend as K

import gensim.downloader as api

from snorkel.labeling import labeling_function

# global vars
wv = None

def init_alg(): 
    '''
    This function should be run when server side is intialized.
    '''
    global wv
    wv = api.load('word2vec-google-news-300')

def clean_text(x): 
    '''
    This function takes in raw text as a string, and cleans it
    by removing extraneous text. 
    '''
#     nltk.download()
#     stop_words = stopwords.words("english")
    x = x.lower()
#     x = ' '.join([word for word in x.split(' ') if word not in stop_words])
    x = x.encode('ascii', 'ignore').decode()
    x = re.sub(r'https*\S+', ' ', x)
    x = re.sub(r'@\S+', ' ', x)
    x = re.sub(r'#\S+', ' ', x)
    x = re.sub(r'\'\w+', '', x)
    x = re.sub('[%s]' % re.escape(string.punctuation), ' ', x)
    x = re.sub(r'\w*\d+\w*', '', x)
    x = re.sub(r'\s{2,}', ' ', x)
    return x

def preprocess_text(text): 
    '''
    This function returns an embedding for the article as 
    a numpy array of shape (300,). 
    
    The function assumes that init has already been run, 
    and wv is stored as a global variable. 
    '''
    global wv 
    
    X = []
    found_words = []

    text = clean_text(text)
    words = text.split()
    for word in words: 
        try:
            # creates 300 vectors per word
            found_words.append(wv[word])
        except: 
            continue
      
    embedding = np.asarray(found_words)
    mean = np.mean(embedding, axis=0)
    mean = mean.tolist()

    if type(mean) == list: 
        X.append(mean)

    X = np.array(X)
    return X
    
def get_polarity(text, model_filepath): 
    '''
    This function takes in the raw text of an article, preprocesses it, and computes
    a polarity score as a double from the deep learning model.
    
    The model should be located in /algorithms/models/
    '''
    if text is None:
        return 50; 
    
    print(text)
    embedding = preprocess_text(text)
    print(embedding)

    # model = tf.keras.models.load_model(model_filepath)
    # pred = model.predict(embedding)[0] # (# samples, 3)
    
    # def compute_polarity(pred): 
    #     '''
    #     This function computes a weighted sum of labels to get a quantitative
    #     polarity score as an integer. 
    #     '''
    #     left = pred[0]
    #     center = pred[1]
    #     right = pred[2]
        
    #     polarity = left*0 + center*(0.5) + right*(1)
    #     polarity = int(polarity * 100)
        
    #     return polarity
    
    # vf = np.vectorize(compute_polarity)
    # polarity = vf(pred)

    return 50
    
    # return polarity

def summarize_text(text):
    import openai
    openai.api_key = "sk-2AOgwDwVGEUEQVcPFs0S7xR2Omlg30G6EJn3RUQJ"
    prompt = 'I rephrased it for him, in plain language a second grader can understand:'
    # article_content = "hi this is a test article this isn't actually real content"
    if text is None: 
        return ""
    response = openai.Completion.create(engine="davinci", prompt=text + " \n" + prompt, max_tokens=64)

    print(response["choices"][0]["text"])
    result = response["choices"][0]["text"] # summary as text
    return result