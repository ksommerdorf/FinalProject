
# Final Project
![Housing_image.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Housing_image.png)


# Project Overview

## North Carolina Real Estate Market Prediction 

Over the last couple of years, Covid pandemic and the low supply of houses with a high demand is driving the prices of homes drastically up, and increasing mortgage rates. This has skewed the housing market and made it difficult for homebuyers to purchase property. So we are interested in analyzing the real estate data which is changing over time.

### Source data: 

- Datasets:[Realtor.com](https://www.realtor.com/research/data/), selected CSVs of interest include:
    
    * RDC Core Metrics by Zipcode Inventory of historical data
    
- Zipcode latitude and longitude data sourced from [Github repo](https://github.com/midwire/free_zipcode_data/blob/5f831e3918488751a701b583a419ca3e1d44d93f/all_us_zipcodes.csv)
    
- Number of school count and park count CSVs are sourced from NaNDA (National Neighborhood Data Archive) repo hosted at [openICPSR](https://nanda.isr.umich.edu/data/)

- Crime data from [NCSBI.gov](https://www.ncsbi.gov/)

### Objectives of the study:
    * Is the median listing price still increasing or is going to flatten? 
    * Current status suggest the housing market cycle as present may last for several years.
    
![Boxplot_median_listing_price.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Boxplot_median_listing_price.png)
## Outline
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
