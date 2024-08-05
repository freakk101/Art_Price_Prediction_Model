# Cloudera_Hackathon

## Competition
This project was a submission for the Cloudera Applied Machine Learning Prototype Hackathon: https://www.hackerearth.com/challenges/hackathon/cloudera-applied-machine-learning-prototype-hackathon/. Our project won 2nd place at the Cloudera and AMD Applied ML 2023 Hackathon

## Summary:
This project uses machine learning methods to predict the selling price of an art piece at an auction, by taking in an image of the art and art attributes from the user. The application is split into two models, a numerical model that is trained on the selling prices of pieces based on their attribute values and a computer vision model uses a Convolutional Neural Network (CNN) that is trained on images of art pieces and their respective selling prices. The final price prediction is generated using a weighted average of the outputs of the two models. The user journey includes inputing an image of the art and various attributes associated with it including (Year of the painting, the time period, How famous the artist is, descriptions of the image, etc..), and the app will output the predicted selling price of that piece at an auction. 

## Data Aggregation

The data for the numerical model was taken from a premade dataset on Kaggle. The link to that data can be found here: https://www.kaggle.com/datasets/flkuhm/art-price-dataset. The data includes the following attributes: price, artist, Title, yearCreation, signed, condition, period, and movement.

The fame data was generated by taking the artist's name in artDataset.csv and using the Selenium web scraping library to querying the website Artsy (https://www.artsy.net/) to access the artist's biography. A script was written to create a numerical fame metric for each artist based on the length of the artist's biography, as an artist with a longer biopgraphy is likely to be more famous. The modified numerical dataset with the fame metric can be found in artist_fame.csv.

The image data used to train the computer vision model is derived from the Sotheby's website, which has an online database of many art auction images of various movements and genres and the selling price for those movements. The website link can be found here: https://www.sothebys.com/en/buy/private-sales/contemporary-art?locale=en. An example of an image and the associated price can be seen below:


<img src="/docs/Sotheby's Image.png"/>

After using web scraping techniques to generate a CSV file with the links to download all the images, we wrote a downloader script to download those images into a folder and split these folders by the movement of art. The downloader scripts can be found in the ImageDownloader folder (https://github.com/Idanlau/Art_Price_Prediction_Model/tree/main/scripts/ImageDownloader). 

## Numerical Model
After experimenting with 3 different models, Random forest regressor, Multiple linear regression and KNN regressor, Random Forest Regressor yeilded the best results and the metric used to evaluate the models were Mean Average Error. Preprocessing techniques to deal with categorical data was one hot encoding and for text based data, bag of words was used.

### Fame Calculator
For every artist name the user provides, the artist will be queried on the Artsy using the Selenium web scraping library to find their biography, and a numerical fame metric will be calulcated based on the length of their biography. This fame value is then inputted into the numerical model to provide greater data about the artist. 

## Computer Vision
The computer vision model takes in an image of the art piece and uses a Convolutional Neural Network which contains multiple layers to filter various attributes of the art piece that demonstrate a correlation with the art selling price using the TensorFlow Keras API.

It uses the pandas and numpy libraries to load the data and perform data manipulations. All of the image data inputs are resized so the image inputs are consistent. The script loads the image data and trains a convolutional neural network (CNN) to predict the price of an artwork given its image. The model is compiled using mean squared error loss and the Adam optimizer. We leveraged the Cloudera Data Science Workbench to process large quantities of images and train the model for 30 epochs with a batch size of 32, and the best weights are saved during training using a ModelCheckpoint callback. Finally, the mean absolute error (MAE) of the model is calculated on the test set and printed.
