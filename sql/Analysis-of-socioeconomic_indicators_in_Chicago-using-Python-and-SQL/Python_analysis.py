# Socioeconomic-Indicators-in-Chicago
The city of Chicago released a dataset of socioeconomic data to the Chicago City Portal.
This dataset contains a selection of six socioeconomic indicators of public health significance and a “hardship index,” for each Chicago community area, for the years 2008 – 2012.

Scores on the hardship index can range from 1 to 100, with a higher index number representing a greater level of hardship.

A detailed description of the dataset can be found on [the city of Chicago's website](https://data.cityofchicago.org/Health-Human-Services/Census-Data-Selected-socioeconomic-indicators-in-C/kn9c-c2s2?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork-20127838&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork-20127838&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ), but to summarize, the dataset has the following variables:

-   **Community Area Number** (`ca`): Used to uniquely identify each row of the dataset

-   **Community Area Name** (`community_area_name`): The name of the region in the city of Chicago 

-   **Percent of Housing Crowded** (`percent_of_housing_crowded`): Percent of occupied housing units with more than one person per room

-   **Percent Households Below Poverty** (`percent_households_below_poverty`): Percent of households living below the federal poverty line

-   **Percent Aged 16+ Unemployed** (`percent_aged_16_unemployed`): Percent of persons over the age of 16 years that are unemployed

-   **Percent Aged 25+ without High School Diploma** (`percent_aged_25_without_high_school_diploma`): Percent of persons over the age of 25 years without a high school education

-   **Percent Aged Under** 18 or Over 64:Percent of population under 18 or over 64 years of age (`percent_aged_under_18_or_over_64`): (ie. dependents)

-   **Per Capita Income** (`per_capita_income_`): Community Area per capita income is estimated as the sum of tract-level aggragate incomes divided by the total population

-   **Hardship Index** (`hardship_index`): Score that incorporates each of the six selected socioeconomic indicators

%load_ext sql

dsn_driver = "{IBM DB2 ODBC DRIVER}"
dsn_database = "BLUDB"              
dsn_hostname = "dashdb-txn-sbox-yp-dal09-04.services.dal.bluemix.net"            
dsn_port = "50000"                  
dsn_protocol = "TCPIP"            
dsn_uid = "lxw19392"               
dsn_pwd = "21bsc1hgx7t7g+1l"  
%sql ibm_db_sa://lxw19392:21bsc1hgx7t7g%2B1l@dashdb-txn-sbox-yp-dal09-04.services.dal.bluemix.net:50000/BLUDB

import pandas
chicago_socioeconomic_data = pandas.read_csv('https://data.cityofchicago.org/resource/jcxq-k9xf.csv')
%sql PERSIST chicago_socioeconomic_data

%sql SELECT * FROM chicago_socioeconomic_data limit 5;

# How many rows are in the dataset

%sql SELECT COUNT(*) FROM chicago_socioeconomic_data

# How many community areas in Chicago have a hardship index greater than 50.0?

%sql SELECT COUNT(*) FROM chicago_socioeconomic_data WHERE hardship_index > '50'

# What is the maximum value of hardship index in this dataset?

%sql SELECT MAX (hardship_index) FROM chicago_socioeconomic_data

# Which community area which has the highest hardship index?

%sql SELECT community_area_name FROM chicago_socioeconomic_data where hardship_index = (SELECT MAX (hardship_index) FROM chicago_socioeconomic_data)

# Which Chicago community areas have per-capita incomes greater than $60,000?

%sql SELECT community_area_name FROM chicago_socioeconomic_data where per_capita_income_ > 60000

# Create a scatter plot using the variables per_capita_income_ and hardship_index. Explain the correlation between the two variables.

import matplotlib.pyplot as plt
%matplotlib inline
import seaborn as sns

income_vs_hardship = %sql SELECT per_capita_income_, hardship_index FROM chicago_socioeconomic_data;
plot = sns.jointplot(x='per_capita_income_',y='hardship_index', data=income_vs_hardship.DataFrame())

