# North Carolina Real Estate Market Prediction 
![Housing_image.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Housing_image.png)


# Project Overview
Covid has affected all areas of our economy.  The housing market is a prime example of this disruptive force. The pandemic brought about a low supply of housing with a high demand. It also drove companies to accept work from home options, possibly changing the way many of us use and view our homes forever. This has driven drastic price increases in the real estate market.  Are these price increases sustainable?  As mortgage rates increase, will the housing market continue to see such growth?  Will prices level off? And most importantly, what are the factors that ultimately affect the price we pay for our homes?


### Data Sources 

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
[Google Slide Presentation](https://docs.google.com/presentation/d/1wJsflZfQ9gO1fWTTSt_opnDnW5grGbB2pMslM_kqhKI/edit?usp=sharing) 

![dashboard](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/images/County%20data.png)

[Dashboard](https://public.tableau.com/app/profile/kayla.sommerdorf/viz/RealEstateProject_16586455498320/Countydata)
* Interactivity: click on each county for individual values and statistics in the interactive map, line charts that show median listing price over time, feature clusters showing importance and correlations.

## ETL and Database
![ETL](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/images/ETL.png)

   * Extracted original data set from Realtor.com. It contained traditional features such as: median listing price (our target), the price change in percent over time, average days on the market, number of active and new listings by county, number of homes with a price increase or price decrease (also by county), median square feet.  This information ranged from 2016 to 2022. Our initial exploration showed the growth in the median listing price year over year, and while there were obvious outliers most of the data seemed fairly consistent. 
   * We decided our data set was too limited and we needed to introduce more variability with additional non-traditional features.
   * We sourced additional data such as crime statistics, number of parks and number of schools in a given area.
   * The various data sets had discrepancies in the time format, column names, and the geographical boundries. 
   * Utilized Pandas to drop null values and duplicate columns, rename columns to be consistent across datasets, change time formating.
   * Sourced an additional data set to convert Lat and Longs and ZCTAs (ZIP code tabulation areas - generalized areal representations derived from the USPS ZIP codes and used by the US Census Bureau) to counties and ZIP codes.  
   * Crime statistics and interest rates were created in excel based off pdf files and website tables.
   * Used both Pandas and SQL to merge and join the datasets.
   * Created a conditional column to use in classifier models based of the median_listing_price_mm column. This new column indicated if the price increased or decreased from the previous month. It was converted to 1 or 0 for graphing.
   * Crime and school data included gaps in the data begining 2019 so we narrowed the feild of interest to end at 2018.
   * Created Entity Relationship Diagram (ERD) create tables.
   * Utilized PostgreSQL to join final tables. Used bit.io connect database.  
   ![ERD](https://github.com/ksommerdorf/FinalProject/blob/main/images/newERD.png)
   
   ## Machine Learning
   
   - Explored clustering with K-means to classify the data points.
   - Cluster features were inconclusive.
  ![Kmeans=2](https://github.com/ksommerdorf/FinalProject/blob/6731844bf8bfa161e4dd18a9d2b4fbedf2e0d05e/images/FP_clusters_k2.PNG)
   - Tested various ensemble classifiers such as Random Forest Classifier, AdaBoost Classifier, and Gradient Boosting Classifier.  For these models, a predictive class was added by creating a column for the Price Status reflecting if the median listing price changed positively(increased) or negatively(decreased) based on the percent change of the median listing price month to month. Our accuracy scores were underwhelming, coming in at approximately 60% accuracy.  We utilized hypertuning on all three of the classifier models, but did not see a large increase in accuracy.
   - Our decision to try classifiers was based on the fact that ensemble classifiers are robust and scalable and utilize a number of weak learner algorithms (decision trees) and combine their output to make a final classification (or regression) decision. 
Both output and feature selection of random forest models are easy to interpret, and they can easily handle outliers and nonlinear data.
For our purposes, we used a random forest classifier with the n_estimators parameter set to 100, max_depth=6, criterion='log_loss', random_state=1.
- Because the accuracy score did not increase, we tested the adaboost classifer with the algorithm = 'SAMME' and GradientBoostClassifier loss='deviance',criterion='squared_error', a slight increase in score observed compared to the RandomForest.
    - We slightly altered our question, moving towards Regression algorithms that can be used to determine continuous values such as price, income, age, etc.
Instead of the Price Status we changed our target variable to Median Listing Price and tested the SVM and Baysian Ridge Regression models. RandomForestRegressor with the random grid search parameters of n_estimators=200, max_features='sqrt', criterion= 'absolute_error' yielded the score of 0.96. With naive knowledge in the machine learning world and the limited dataset, we assumed the change in prediction due to some of the hypertune parameters is adequate.
   - Model evaluation and accuracy score were calculated for each to better predict the features that are driving the target.
![Accuracy_score.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Accuracy_score_final.png)

   #### Pre-processing
- Change crime statistics data type
   ```
    df['violent_crime_rate']= df['violent_crime_rate'].str.replace(',','').astype(float)
    df.head()
   ```
- Drop date column
    ```
     df_new1 = df.drop(['date'], axis=1)
    ```
    
- Filter data by year 
     ```
     filter_df = df_new1[df_new1['year'] <2019]
     ```
     
- Create features and target
    ```
    # Create our features
    X = df_data.drop('median_listing_price', axis=1 )
    X = pd.get_dummies(X)
    # Create our target
    y = df_data.loc[:, target].copy()
     ```
     
#### Training setup 
- Apply train_test_split function from the Scikit-learn library to split data into training and testing components
    ```
    from sklearn.model_selection import train_test_split
    X_train, X_test, y_train, y_test = train_test_split(X, 
                                                    y, 
                                                    random_state=1)
    
    ```
- Standardized the features by applying the StandardScaler function from the Scikit-learn library.
   ```
   scaler = StandardScaler()
   scaler.fit(X_train)
   X_train_scale = scaler.transform(X_train)
   X_test_scale = scaler.transform(X_test)
   ```
   
#### Train the data and hypertune the accuracy
   ```
   from sklearn.ensemble import RandomForestRegressor
   rf_model = RandomForestRegressor(n_estimators=100, random_state=1) 
   rf_model = rf_model.fit(X_train, y_train)
   y_pred = rf_model.predict(X_test_scale)
   Counter(y_train['median_listing_price'])
   ```
   ```
   from sklearn.model_selection import RandomizedSearchCV
   # Create the random grid search to use to find the best hyperparameters
   random_grid = {'n_estimators': [100,200,300,400],
               'max_features': ['auto','sqrt', 'log2', None],
                'criterion':['squared_error','absolute_error','poisson'],}
   rf = RandomForestRegressor()
   # using 3 fold of cross validation, radom search parameters with 100 different 
   # combinations. Use all avaiable cores.
   rf_search = RandomizedSearchCV(rf, random_grid,
               n_iter = 100, cv =3, verbose = 2, random_state = 1)
   # fit to model
   rf_search.fit(X_train, y_train)
   ```
- The [RandomForestRegressor](https://github.com/ksommerdorf/FinalProject/blob/main/notebook/ML_models/RandomForestRegressor_tuning.ipynb) gave us an accuracy score of 96.9%.  The most important features included medain square feet, violent crime rate, number of schools, active listing count, total listing count, and number of parks.
   
### Tools And Libraries Used:
![Technologies](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/images/technologies.png)

### Conclusions
With naive knowledge of machine learning and a limited dataset, we concluded that the accuracy score after including hypertune parameters is adequate in predicting our target variable median listing price. We learned it is important to design an approach that is fed with data from various sources. Real estate price prediction is a higly variable topic and will require much deeper insight than presented here. The combination of traditional and nontraditional data might yield a more accurate estimation.

For Future analysis, we want to Source more robust community data using smaller geographical areas 
Source school ratings rather than number of schools
Fill in missing crime data for later years
Source other non-traditional data such as: distance to grocery stores, area tax rates, availability of public transportation,population density, proximity to the recreational areas,accessibility of the area (number of roads, condition of the roads)
Experiment with more Regressor models and multiple hypertune parameters
try basic neural networks models and Deep learning.


### Future Analysis
- Source the missing crime data and school ratings rather than counts.
- Source more robust community data using smaller geographical areas.
- Include more non-traditional features such as; proximity to grocery stores and recreation facilities, area taxrates, population density, and accessability of the area (number and condition of roads, availability of public transportation). 
- Work on a zillow API to get in the real estate features to increase the volume of the data for the ML models.
- Hypertune the classifier and regression model parameters to calculate the confusion matrix and to increase the accuracy score.
- Try additional neural network models and deep learning models. 

##### Group Members
Courtney Sims

David Pruette

Kayla Sommerdorf

Krishna Kanchi

Lindsey Asterman 
