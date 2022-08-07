
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
   

## Machine Learnining Model
- Takes in joined data from datasets 

Kayla tested decision trees and clustering with varying degrees of success. Krishna created histograms of the various features to allow us to better understand the data.
![Feature Histogram](https://github.com/ksommerdorf/FinalProject/blob/main/images/Histogram_features.png)

* Training setup - We will split data into training and testing components.  We will drop median house price for prediction analysis.  Courtney has also created a new binary column "price increase or decrease" that will be an output of the trained model.
    * what is accuracy and evaluation protocol?
    * clustering with kmeans tested at 2 and 3 to find distinct groups within the data set. The kmeans tested at 3 separates the larger class.

- Connected to database (SQL)
    *  ERD of the database: Entity Relationship (ER) Diagram that 
            illustrates how datasets are related to each other within a system. 
            Current primary key is postal code of housing lists. Lindsey created the ERD and Kayla created joins in postgress.
            ![ERD](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/ERD.png)

- Tried both the Supervised and Unsupervised Machine learning models. Model evaluation and accuracy score were calculated for each to better predict the features that are driving the target.
![Accurarcy_score_MLmodels.png](https://github.com/ksommerdorf/FinalProject/blob/main/images/Accurarcy_score_MLmodels.png)

### Tools And Libraries Used:

- Database: PostgresSQL and connect with SQLAlchemy
- Data cleaning and ML model: pandas and pandas ML-environment
- Dashboard: [Tableau](https://public.tableau.com/views/RealEstateProject_16586455498320/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)
   * Interactions: able to click on each county and see the individual value for that county; this will develop into being able to select a certain County and have all the statistics for that county show on the dashboard
   * Tools: interactive map; line chart showing housing prices over time; correlations maps to show the important feature's impact on the overall median housing price
   

### Communication Protocols:

Utilizing group programming for collaboration, meetings are conducted during class and scheduled outside class using Slack app to communicate amongst team members. A group chat is used to keep everyone in the loop as ideas and work progresses. 

### Future Directions:

-In future we can acquire the crime data for the missing years and also try to further investigate on the many different features of importance that help in prediction of the target and include them to the original data set.

-With more time given we can work on tweaking the zillow API to get in the real estate features to increase the volume of the data for the ML models.

-In future we can hypertune the classifier and regression model parameters to calculate the confusion matrix and to increase the accuracy score.
