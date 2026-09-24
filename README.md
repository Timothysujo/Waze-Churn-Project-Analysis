# Waze User Churn Analysis

## Overview

This project analyzes user behavior and engagement patterns to identify factors associated with user churn on the Waze platform.

The project follows an end-to-end data analytics workflow, combining Python, SQL, Power BI, statistical analysis, and machine learning to move from raw data exploration to business-focused insights.

The overall goal was to understand how user engagement, driving behavior, onboarding age, device type, and other behavioral characteristics relate to churn, while developing a foundation for future churn prediction and retention strategies.

#### End-to-End Workflow

Data → Python EDA → SQL Analysis → Feature Engineering → Statistical Testing → Machine Learning → Power BI Dashboard → Business Insights

---

## Dataset

The dataset contains information about Waze users and their app activity, including behavioral and engagement metrics.

Key variables analyzed included:

* Driving activity
* Activity days
* Number of drives
* Number of sessions
* Kilometers driven
* Driving duration
* Device type (iPhone vs. Android)
* User churn status

The initial data review identified **700 rows without a churn label**, which required consideration during the data preparation process.

---

## Tools & Technologies

* **Python**
* **Pandas** – Data manipulation and analysis
* **NumPy** – Numerical analysis
* **Matplotlib / Seaborn** – Data visualization
* **Scikit-learn** – Statistical analysis and machine learning
* **Jupyter Notebook** – Analysis and documentation
* **PowerPoint** – Executive presentation and communication

---

## Project Steps

### 1. Data Loading & Understanding

* Loaded the dataset into Python.
* Reviewed the structure and data types.
* Examined descriptive statistics.
* Identified missing values and potential data-quality issues.
* Compared users who churned with users who were retained.

### 2. Data Cleaning

* Investigated missing values.
* Addressed rows without churn labels.
* Reviewed distributions and potential outliers.
* Prepared the dataset for exploratory analysis and modeling.

### 3. SQL Analysis

A dedicated MySQL analysis was performed to answer business questions about user churn and engagement.

The SQL analysis focused on using queries to segment users, calculate churn rates, compare retained vs. churned users, and identify behavioral patterns.

Key SQL Analyses
Overall Churn Rate

Calculated the number and percentage of retained and churned users.

This provided a baseline understanding of the overall churn distribution.

Sessions & User Engagement

Compared average total sessions between retained and churned users.

The analysis found that churned users had a slightly higher average number of total sessions than retained users, demonstrating that higher overall session volume does not necessarily correspond to lower churn.

Activity-Day Segmentation

Users were grouped according to the number of active days:

0–5
6–10
11–15
16–20
21–26
Greater than 26

Observed churn rates decreased as activity days increased:

Activity Days	Churn Rate
0–5	36.23%
6–10	25.21%
11–15	16.80%
16–20	10.53%
21–26	7.10%
>26	4.53%

This analysis suggested a strong relationship between consistent app usage and lower churn.

### 4. Exploratory Data Analysis

Analyzed relationships between user engagement and churn using:

* Histograms
* Distribution plots
* Comparative visualizations
* Churn-rate analysis
* Behavioral metrics

The analysis found that the number of sessions and drives had a **right-skewed distribution**, with most users having relatively low activity and a smaller number of highly active users.

### 5. Feature Engineering

Created additional behavioral features to better understand user engagement and improve predictive modeling.

Examples included:

* Kilometers per hour
* Kilometers per driving day
* Total sessions per day
* Percentage of sessions in the last month
* Professional driver indicator
* Other user engagement ratios

These engineered features were later evaluated for their importance in predicting churn.

### 6. Statistical Analysis

A two-sample t-test was performed to investigate whether iPhone and Android users differed significantly in their average number of drives.

**Result:**

* t-statistic: **1.46**
* p-value: **0.143**
* Significance level: **0.05**

Since the p-value was greater than 0.05, the analysis did not find statistically significant evidence that device type was associated with differences in the average number of drives.

### 7. Predictive Modeling

Multiple classification approaches were explored to predict user churn.

#### Logistic Regression

A logistic regression model was developed to estimate the probability of user churn.

Performance:

* **Precision:** 54.9%
* **Recall:** 9.86%

Activity days was identified as one of the most important variables, with greater activity generally associated with lower churn. The low recall indicated that the model was not effective enough to identify most users who actually churned.

#### Random Forest & XGBoost

Random Forest and XGBoost models were subsequently developed and evaluated using train, validation, and test datasets.

XGBoost performed better than Random Forest across the reported evaluation metrics. However, the model achieved approximately:

* **Accuracy:** 80%
* **Recall:** 18%
* **F1 Score:** 24%

The results suggested that additional training data and features would be needed before using the model for important business decisions.

### 8. Power BI Dashboard

The analysis was also translated into an interactive Power BI dashboard to communicate churn patterns visually.

The dashboard was designed to make the analysis more accessible to non-technical stakeholders and provide an interactive way to explore relationships between user behavior and churn.

* Dashboard Analysis Included
* Retained vs. churned user percentages
* Churn by activity-day groups
* Churn by onboarding-age groups
* User engagement metrics
* Sessions and driving behavior
* Device distribution
* Behavioral segmentation
* Churn-rate comparisons

Power BI was used to transform the analytical results into business-facing visualizations and allow users to interact with different segments of the dataset.

---

### 9. Key Results & Insights

Several important patterns emerged from the analysis:

* **Activity days were strongly associated with churn**, with higher activity generally corresponding to lower churn.
* **Churn rates tended to increase as mean daily driving distance increased.**
* The number of drives and sessions was **right-skewed**, with most users having relatively low activity and a small number of highly active users.
* Churned users showed higher median kilometers per driving day than retained users.
* The iPhone/Android split was approximately **64% iPhone and 36% Android**, and the analysis did not find statistically significant evidence that device type affected average driving activity.
* XGBoost outperformed Random Forest in the reported model evaluation.
* The predictive models were useful for identifying patterns and potential churn drivers, but additional features and training data would be needed for stronger predictive performance.

---

## Business Impact

The analysis provides a foundation for understanding user engagement and identifying potential churn-risk factors.

The findings can help inform:

* User retention strategies
* Product and feature improvements
* Customer engagement initiatives
* Future churn prediction models
* Additional analysis of user activity trends

The project also demonstrates the ability to translate technical analysis into **business-focused insights and recommendations**.

---

## Deliverables

#### The project includes:

* Python/Jupyter notebooks
* Data cleaning and preparation
* Exploratory data analysis
* SQL analysis and business questions
* SQL feature engineering
* Statistical hypothesis testing
* Machine learning models
* Power BI dashboard
* Data visualizations
* Executive analysis/report
* PowerPoint presentation
* Future Improvements

#### Potential next steps include:

* Data & Feature Engineering
* Add additional behavioral features
* Analyze drives per activity day
* Analyze sessions per day
* Measure navigation and activity ratios
* Examine weekday vs. weekend behavior
* Analyze changes in user activity over time
* Create engagement trend features
* SQL & BI
* Expand the Power BI dashboard with additional interactive filters
* Create user-engagement segments
* Develop more detailed churn cohorts
* Build KPI cards for executive reporting
* Add drill-through functionality for user segments
* Create time-based behavioral analysis
* Machine Learning
* Increase the amount of training data
* Address class imbalance
* Test additional classification algorithms
* Perform hyperparameter tuning
* Improve feature selection
* Optimize recall for identifying users at risk of churn
* Evaluate additional metrics such as ROC-AUC and PR-AUC

#### Skills Demonstrated

Data Analytics | Python | SQL | MySQL | Pandas | NumPy | Data Cleaning | Exploratory Data Analysis | Data Visualization | Power BI | Feature Engineering | Statistical Testing | Hypothesis Testing | Machine Learning | Logistic Regression | Random Forest | XGBoost | Business Intelligence | Business Insights | Data Storytelling | Executive Reporting | PowerPoint


