# Final Project

# Communication Protocols
Utilizing group programming for collaboration, meetings are conducted during class and scheduled outside class using Slack app to communicate amongst team members. A group chat is used to keep everyone in the loop as ideas and work progresses. 

# Project Overview

## Selected Topic: Real estate market predictions
- reason: A pandemic, low supply with a high demand driving the prices of homes drastically up, and increasing mortgage rates. This  has skewed the housing market and made it difficult for homebuyers to purchase property. 
- source data: Datasets are taken from [Realtor.com](https://www.realtor.com/research/data/), selected CSVs of interest include:
    * the RDC Core Metrics by Zipcode Inventory of historical data
    * zipcode latitude and longitude data sourced from [Github repo](https://github.com/midwire/free_zipcode_data/blob/5f831e3918488751a701b583a419ca3e1d44d93f/all_us_zipcodes.csv)

- Questions interested in answering with data
    * Is the average listing price still rising? Current status suggest the housing market cycle as present may last for several years.


## Machine Learnining Model
- Takes in joined data from datasets 

    * model type - David and Courtney tested unsupervised and supervised learning.  They determined the dataset was too large and we will need to narrow the number of features used for analysis. 
Kayla tested decision trees and clustering with varying degrees of success. Krisha created histograms of the various features to allow us to better understand the data.
![Feature Histogram](https://github.com/ksommerdorf/FinalProject/blob/main/images/Histogram_features.png)

* training setup - We will split data into training and testing components.  We will drop median house price for prediction analysis.  Courtney has also created a new binary column "price increase or decrease" that will be an output of the trained model.
    * what is accuracy and evaluation protocol: To be addressed in later stage
    * the type and why: to be selected after testing different models for fit.

- connected to database (SQL)
    *  ERD of the database: Entity Relationship (ER) Diagram that 
            illustrates how datasets are related to each other within a system. 
            Current primary key is postal code of housing lists. Lindsey created the ERD and Kayla created joins in postgress.
            ![ERD](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/ERD.png)


## Technology to be Used

- Database: PostgresSQL and connect with SQLAlchemy
- data cleaning and ML model: pandas and pandas ML-environment
- Dashboard: Tableau
