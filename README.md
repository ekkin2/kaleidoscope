# Kleidoscope
Kaleidoscope is an accessibility focused news feed app that shows users the facts quickly and efficiently while making sure users are cognizant of the political biases in the articles they read.

## Inspiration
2020 showed us how important reliable access to trustworthy information is in our modern society. From misinformation about COVID-19, masks, and vaccines causing great danger to public health and misinformation about election results culminating in rioters storming the Capitol, the damage caused by partisan politics and lack of access to trustworthy news is extremely apparent. 

After such drastic effects, we decided to take a step towards solving this problem by creating an app that turns the traditional news feed concept on its head.

## What it does
Kaleidoscope is a news feed app that shows you the political leaning and objectivity of every article that you read. As you read articles, we keep track of the political leanings of the articles that you’ve read recently. Instead of trying to recommend similar articles, as most recommender systems do, we encourage you to read articles that differentiate from your own personal reading patterns. In this way, you’re able to diversify your reading and gain a more holistic view of current events. 

News nowadays is increasingly jargonized and filled with potentially misleading information. Kaleidoscope provides a rating for how objective every article is so that you can have a clear understanding of how informative it is compared to other articles about similar topics. A short summary is attached to every article so that information becomes understandable and accessible to anyone. 

Finally, Kaleidoscope has several sort and topic filters. You can choose to sort the articles in your feed by time or objectivity and filter the feed by topic (e.g. business, science, health). In this way, you can get the most up-to-date and the most reliable news in any field very quickly. 

## How we built it
Kaleidoscope has two main parts: the frontend mobile application and the backend server, which itself has three machine learning models running inside it. 

The frontend app is made using the Flutter SDK, which we decided on both due to familiarity with the framework and its cross platform compatibility. 

The backend server contains the polarity classifier, objectivity ranker, and summarizing engine. 

We generate polarity rankings using Snorkel, a tool developed by Stanford AI that allows ML engineers to create labeled datasets out of unlabeled data. We used Snorkel to generate a new dataset consisting of unlabeled articles and their corresponding polarities. After embedding each article into a 300-vector using the Word2Vec algorithm, we train a dense neural network to provide probability scores for LEFT, RIGHT, and CENTER, which we use to compute a weighted sum as a polarity score. 

We developed a novel objectivity scoring model, trained on over 300,000 articles. Based on a model that classifies single sentences as facts or opinions, our model takes into account all the facts and opinions in an article to generate a holistic score. We built and trained a machine learning model that highlights the facts and rates articles by objectivity so the public can get the most objective news. 

Our summarization process utilizes the davinci engine of OpenAI’s GPT-3 model to generate human-readable summaries of articles. 

## Challenges we ran into
One of the most challenging issues we ran into was the lack of data for our polarity classifier. There are very few datasets online which take text and assign a distinct political leaning to it, and those that do often are very limited in their scope (e.g. focusing on a specific news event or person). To get around this, we had to use Snorkel as a labeling tool to create our own dataset and combined this with the [NELA-GT-2019](https://github.com/mgruppi/nela-gt-2019) dataset to create the data that we used to train our polarity classifier.

Another issue that we had was that designing a model to determine how objective an article is was not as simple as we thought. While there were a few published models that differentiate between fake news and real news, this doesn’t really capture the same information. On the other hand, there also existed a few models to determine if a single sentence was a fact or an opinion, but this doesn’t capture information about the whole article. In the end, we settled for an aggregation of fact/opinion information about every sentence of the article which we then converted into a score. 

## Accomplishments that we're proud of
We strongly believe in the social impact of our project and are proud that we were able to solve the news problem through an extremely accessible platform like a mobile app. We’re especially proud that this is an app that we would all actually use to get our news on a daily basis.

## What we learned
The biggest lesson we learned in creating Kaleidoscope was how to create effective pipelines for machine learning based applications. Designing a REST API that interacts with the models in the backend and can effectively and efficiently communicate that data to the frontend was a new experience for us, and we learned a lot about the whole process. 

We had our first experience with designing a machine learning model based on the workings of another model. In creating the objectivity scoring model, we had to use another public model that classified sentences and incorporated those results into the overall model.

## What's next for Kaleidoscope
We have several ideas for Kaleidoscope moving forward. Most significantly we intend to release our app on the App Store and the Google Play Store, as well as publish the dataset we created for news polarity.  We also have thought about incorporating some sort of discussion board to let people discuss articles. 
