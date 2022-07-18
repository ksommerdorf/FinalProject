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
    * model type
    * training setup
    * what is accuracy and evaluation protocol: To be addressed in later stage
    * how does it work?
    * the type and why: to be selected after testing different models for fit.

- connected to database (SQL)
    *  ERD of the database: Entity Relationship (ER) Diagram that 
            illustrates how datasets are relate to each other within a system. 
            Current primary key is postal code of housing lists.
        ![ERD](https://github.com/ksommerdorf/FinalProject/blob/Lindsey/ERD.png)


## Technology to be Used

- Database: PostgresSQL and connect with SQLAlchemy
- data cleaning and ML model: pandas and pandas ML-environment
- Dashboard: Tableau