from flask import Flask, request, render_template, current_app
from werkzeug.serving import WSGIRequestHandler
import json
import os
from newsapi import NewsApiClient
import numpy as np

from objectivity_score import get_objectivity_score
from algorithms import get_polarity, init_alg, summarize_text

app = Flask(__name__)
app.config["DEBUG"] = True

categories = {"business", "entertainment", "general", "health", "science", "sports", "technology"}
sorts = {"recent", "objective", "polarity"}

@app.route('/')
def hello_world():
    return 'Hello World!'

# Pass 3 params: category, sort, and score (only needed for some cases)
@app.route('/api/articles/', methods=['GET'])
def get_recent():
    if 'category' in request.args:
        category = str(request.args['category'])
        if category not in categories:
            return category
    else:
        category = "general"

    if 'sort' in request.args:
        sort = str(request.args['sort'])
        if sort not in sorts:
            return "Error: Please specify an accurate sort"
    else:
        sort = "recent"

    with open(os.path.join(current_app.static_folder, 'db.json'), encoding='utf-8') as f:
        data = json.load(f)

    category_data = data[category]

    if sort == "objective":
        category_data["articles"] = sorted(category_data["articles"], key=lambda article : article['objectivity'], reverse=True)

    if sort == "polarity":
        user_polarity = request.args['score']
        target_polarity = 100 - user_polarity

        category_data["articles"] = sorted(category_data["articles"], key=lambda article : abs(target_polarity - article['polarity']))

    return category_data




@app.route('/api/load')
def refresh_db():
    newsapi = NewsApiClient(api_key='fc821330ca0645379a9a1477fe76fa6a')
    data = {}
    # init_alg()

    for category in categories:
        data[category] = newsapi.get_top_headlines(language='en',
                                                  country='us',
                                                  page_size=50,
                                                  category=category)

        for article in data[category]["articles"]:
            # TODO Objectivity
            content = article["content"]
            mu, sigma = 0.5, 0.2 # mean and standard deviation
            pol_np = np.random.normal(mu, sigma, 1)
            polarity = min(max(int((pol_np[0] * 100)), 0), 100)
            
            # content = article["content"]
            mu, sigma = 0.5, 0.2 # mean and standard deviation
            obj_np = np.random.normal(mu, sigma, 1)
            objectivity = min(max(int((obj_np[0] * 100)), 0), 100)
            objectivity = int(get_objectivity_score(content))
            # # # TODO Bias
            # model_filepath = '../algorithms/models/polarity_model'
            # polarity = get_polarity(content, model_filepath)

            # fallback
            # mu, sigma = 0.5, 0.1 # mean and standard deviation
            # s = np.random.normal(mu, sigma, 1)
            # polarity = int((s[0] * 100))
            # print(polarity)
            # polarity = 32

            article['objectivity'] = objectivity
            article['polarity'] = polarity

            article['imageLink'] = article.pop('urlToImage')
            article['link'] = article.pop('url')
            article['timestamp'] = article.pop('publishedAt')
            article['source'] = article.pop('source')['name']

            # summarize 
            
            article['facts'] = ['Rep. Matt Gaetz is blaning the news media.', 'The aide was concerned.']

    with open('static/db.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

    return "success"



if __name__ == '__main__':
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(host='0.0.0.0')
    # app.run()
