# North Carolina Real Estate Market Prediction 
![Housing_image.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Housing_image.png)


# Project Overview
Covid had far reaches affects in all areas of our economy.  The housing market is a prime example of this disruptive force. The pandemic brought about a low supply of housing with a high demand. It also drove companies to accept work from home options, possibly changing the way many of us use and view our homes forever. This has driven drastic price increases in the real estate market.  Are these price increases sustainable?  As mortgage rates increase, will the housing market continue to see such growth?  Will prices level off? And most importantly what are the factors that ultimately affect the price we pay for our homes.  


### Source data

- the RDC Core Metrics by Zipcode Inventory of historical data and the RDC Inventory Hotness Metrics Zip History from[Realtor.com](https://www.realtor.com/research/data/)   
- Zipcode latitude and longitude data sourced from [Github repo](https://github.com/midwire/free_zipcode_data/blob/5f831e3918488751a701b583a419ca3e1d44d93f/all_us_zipcodes.csv)   
- NC school data and park data from The National Neighborhood Data Archive (NaNDA) [openICPSR](https://nanda.isr.umich.edu/data/)
- NC crime statistics from [NCSBI.gov](https://www.ncsbi.gov/)
- Mortgage rates from  [FreddieMac](https://www.freddiemac.com/pmms/)

### Questions We Hope to Answer
- Will the median listing price continue to increase, decrease, or flatten? 
- What are the traditional and non-traditional factors that affect house pricing?
    
![median listing price over time](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/images/Median%20Listing%20Price%20Over%20Time.png)

### Presentation and Dashboard
[Google Slide Presentation](https://docs.google.com/presentation/d/1wJsflZfQ9gO1fWTTSt_opnDnW5grGbB2pMslM_kqhKI/edit?usp=sharing) and 
[Dashboard](https://public.tableau.com/app/profile/kayla.sommerdorf/viz/RealEstateProject_16586455498320/Countydata)

## ETL and Database

   * Finding our different data CSV's from across the internet starting with Realtor.com. 
   * Looked for additional features to compare to median listing price. Features included violent crime rate, number of schools, parks, and 30 year fixed rate. 
   * Combining all CSV's into one main database through both SQL and Pandas joins. 
   * Dropping NA's and changing Date time format. 
   * Make sure SQL joins worked correctly and then cleaning data to fit to the models. 
   * Duplicate rows and columns were a problem at first but the data was cleaned in Python using pandas.
   * Adding conditional column up or down to capture if a median listing price had increased or decreased month over month. Converted to 1 or 0 for graphing.
   * Balanced random forest classifier to see accuracy score.
   * Did Clustering to classify the data points.
   
![Kmeans=2](https://github.com/ksommerdorf/FinalProject/blob/6731844bf8bfa161e4dd18a9d2b4fbedf2e0d05e/images/FP_clusters_k2.PNG)


   * Took key variable and creating visuals across the state of North Carolina.
   * Trying to account for NA's and outliers to fine tune data. 
   * Since the crime data and the school data not available for all the counties for years 2019-2021, the data started appearing sparse so we considered only the Data until 2018. Given more time we would have searched other sources to fill in the gaps.
   

- Connected to database (SQL)
    *  ERD of the database: Entity Relationship (ER) Diagram that 
            illustrates how datasets are related to each other within a system. 
            Current primary key is postal code of housing lists. Lindsey created the ERD and Kayla created joins in postgress.
            ![ERD](https://github.com/ksommerdorf/FinalProject/blob/main/images/newERD.png)
            
## Machine Learnining Model
- Takes in joined data from datasets 

Kayla tested decision trees and clustering with varying degrees of success. Krishna created histograms of the various features to allow us to better understand the data.
![Feature Histogram](https://github.com/ksommerdorf/FinalProject/blob/main/images/Histogram_features.png)

* Training setup 
    - We applied *train_test_split* function from sklearn.model_selection tp split data into training and testing components.  We dropped median house price for prediction analysis for the Regressor models.  Courtney has also created a new binary column "price increase or decrease" that will be an output of the trained model. 
    - To encode categorical features as a one-hot numeric array we applied the *OneHotEncoder* from sklearn preprocessing module.
    - To standardize the features by removing the mean and scaling to unit variance we applied the *StandardScaler* from sklearn preprocessing module.

   
* clustering with kmeans tested at 2 and 3 to find distinct groups within the data set. The kmeans tested at 3 separates the larger class.


- Tried both the Supervised and Unsupervised Machine learning models.
  * adaboostClassifier with hypertuning
  * RandomForest Classifier 
  * GradientBoostClassifier
  * Support Vector Model Regressor
  * Baysian ridge Regression
  * RandomForest Regressor


Model evaluation and accuracy score were calculated for each to better predict the features that are driving the target.
![Accuracy_score.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Accuracy_score_final.png)

-From among the  ensemble learning models we decided to test the Random Forest classifier  that is robust and scalable and it combines the number of weak learner algorithms (decision trees) and combine their output to make a final classification (or regression) decision. 
Both output and feature selection of random forest models are easy to interpret, and they can easily handle outliers and nonlinear data.
For our purposes, we used a random forest classifier with the n_estimators parameter set to 100, max_depth=6, criterion='log_loss', random_state=1

-Since the accuracy score didnot increase we tested the adaboost classifer with the algorithm = 'SAMME' and GradientBoostClassifier loss='deviance',criterion='squared_error', a slight increase in score observed compared to the RandomForest.

-We slightly altered our question, moving towards Regression algorithms that can be  used to determine continuous values such as price, income, age, etc.
Instead of the Price Status we changed our target variable to Median Listing Price and tested the SVM and Baysian Ridge Regression models. RandomForestRegressor with the random grid search parameters of n_estimators=200, max_features='sqrt', criterion= 'absolute_error' yielded the score of 0.96. With naive knowledge in the machine learning world and the limited dataset, we assumed the change in prediction due to some of the hypertune parameters is adequate.



### Tools And Libraries Used:

- Database: PostgresSQL and connect with SQLAlchemy
- Data cleaning and ML model: pandas and pandas ML-environment
- Dashboard: [Tableau](https://public.tableau.com/app/profile/kayla.sommerdorf/viz/RealEstateProject_16586455498320/Countydata)
   * Interactions: able to click on each county and see the individual value for that county; this will develop into being able to select a certain County and have all the statistics for that county show on the dashboard
   * Tools: interactive map; line chart showing housing prices over time; correlations maps to show the important feature's impact on the overall median housing price
   

### Future Directions:

-In future we can acquire the crime data for the missing years and also try to further investigate on the many different features of importance that help in prediction of the target and include them to the original data set. For example grocery stores count per zipcode as food deserts have an impact on housing prices. School ratings, public transportation and taxrates in each of the county.

-With more time given we can work on tweaking the zillow API to get in the real estate features to increase the volume of the data for the ML models.

-In future we can hypertune the classifier and regression model parameters to calculate the confusion matrix and to increase the accuracy score.

-With the given time we were unable to try some of the basic neural network models and Deep learning models. 

