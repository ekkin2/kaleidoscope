import numpy as np
import pandas as pd
# from snorkel.labeling import labeling_function

import json
import glob

import os
bias_dict = {"abcnews.json": "left", "addictinginfo.json": "left", "airwars.json": "center", "anonymousconservative.json": "right", "bbc.json": "center", "bearingarms.json": "right", "bigleaguepolitics.json": "right", "bipartisanreport.json": "left", "breitbart.json": "right", "businessinsider.json": "center", "buzzfeed.json": "left", "cbsnews.json": "left", "chicagotribune.json": "center", "citizenfreepress.json": "right", "clashdaily.json": "right", "cnbc": "center", "cnn.json": "left", "cnsnews.json": "right", "crooksandliars.json": "left", "csmonitor.json": "center", "dailybeast.json": "left", "dailykos.json": "left", "dailymail.json": "right", "dailysignal.json": "right", "dailystormer.json": "right", "democracynow.json": "left", "drudgereport.json": "right", "fivethirtyeight.json": "center", "foreignpolicy.json": "left", "fortune.json": "center", "foxnews.json": "right", "freebeacon.json": "right", "hangthebankers.json": "right", "infowars.json": "right", "intellectualconservative.json": "right", "liveaction.json": "right", "mcclatchydc.json": "center", "mercurynews.json": "left", "motherjones.json": "left", "msnbc.json": "left", "nationalinterest.json": "center", "nationalreview.json": "right", "newyorkdailynews.json": "left", "newyorker.json": "left", "newyorkpost.json": "right", "npr.json": "center", "pbs.json": "center", "politico.json": "left", "rawstory.json": "left", "redstate.json": "right", "reuters.json": "center", "rollcall.json": "center", "salon.json": "left", "slate.json": "left", "theamericanconservative.json": "right", "theatlantic.json": "left", "thecollegefix.json": "right", "thedailycaller.json": "right", "theepochtimes.json": "right", "thegatewaypundit.json": "right", "theguardian.json": "left", "thehill.json": "center", "theindependent.json": "left", "theintercept.json": "left", "thenewyorktimes.json": "left", "theonion.json": "left", "theseattletimes.json": "center", "thetelegraph.json": "right", "theverge.json": "left", "usatoday.json": "center", "vox.json": "left", "washingtonmonthly.json": "left", "washingtonpost.json": "left", "westernjournal.json": "right", "wnd.json": "right"}

# for all files in directory

json_files = [pos_json for pos_json in os.listdir('nela-eng-2019/') if pos_json.endswith('.json')]
# print(json_files)

# for file in json_files:
# 	print(len(file))

# here I define my pandas Dataframe with the columns I want to get from the json
df = pd.DataFrame()
# columns=["id", "date", "source", "title", "content", "author", "url", "published", "published_utc", "collection_utc"]

'''
df = pd.read_json("nela-eng-2019/abcnews.json")
df["bias"] = bias_dict["abcnews.json"]
print(len(df))
print(df.head())
'''

# we need both the json and an index number so use enumerate()

# row_number = 0
file_number = 0
for index, js in enumerate(json_files):
    with open(os.path.join('nela-eng-2019/', js)) as json_file:
        # print(json_file)

        json_file_path = os.path.join('nela-eng-2019/', js)
        # print(json_file_path)
        if file_number == 173:
        	file_number += 1
        	continue
        # json_text = json.load(json_file)
        # print(js)

        if js in bias_dict:
        	next_file = pd.read_json(json_file_path)
        	# add bias to the last column
        	next_file["bias"] = bias_dict[js]
        	# print(next_file.head())
        	df = df.append(next_file)
        # print(file_number)
        file_number += 1


'''
        for article in json_text:
        	article_id = article["id"]
        	article_date = article["date"]
        	article_source = article["source"]
        	article_title = article["title"]
        	article_content = article["content"]
        	article_author = article["author"]
        	article_url = article["url"]
        	article_published = article["published"]
        	article_published_utc = article["published_utc"]
        	article_collection_utc = article["collection_utc"]

        	# article_bias = bias[js]
        
        	# here I push a list of data into a pandas DataFrame at row given by 'row_number'
        	jsons_data.loc[row_number] = [article_id, article_date, article_source, article_title, article_content, article_author, article_url, article_published, article_published_utc, article_collection_utc]
        	row_number += 1
'''


# now that we have the pertinent json data in our DataFrame let's look at it
# print(jsons_data)

print(len(df))
print(df.head())
'''
result = jsons_data.to_json(orient="split")
parsed = json.loads(result)
# json.dumps(parsed, indent=4) 

with open("merged_file.json", "wb") as outfile:
     json.dump(parsed, outfile)
'''

'''
read_files = glob.glob("*.json")
with open("merged_file.json", "wb") as outfile:
    outfile.write('[{}]'.format(','.join([open(f, "rb").read() for f in read_files])))
'''

'''
result = []
for f in glob.glob("*.json"):
    with open(f, "rb") as infile:
        result.append(json.load(infile))

with open("merged_file.json", "wb") as outfile:
     json.dump(result, outfile)
'''
