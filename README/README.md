# Customer Churn Analysis

## Objective
To identify key drivers of customer churn using SQL and visualize insights using Power BI.

## Tools Used
- MySQL
- SQL
- Power BI
- Excel / CSV

## Dataset
Telco Customer Churn dataset containing customer demographics, services, contracts, and billing information.

## Key Analyses
- Churn by Contract Type
- Churn by Monthly Charges
- Identification of high-risk customer segments

### Contract Type vs Customer Churn

Analysis shows a strong inverse relationship between contract duration and churn rate. Month-to-month customers exhibit the highest churn rate (42.7%), while customers on two-year contracts have significantly lower churn (2.8%). This suggests that longer-term contracts improve customer retention and should be a key focus for churn reduction strategies.

### Churn vs Monthly Charges

Customer churn increases significantly with higher monthly charges. Customers in the high-charge segment show a churn rate of 35.36%, compared to 10.86% for low-charge customers. This indicates strong price sensitivity and suggests that retention efforts should focus on high-value customers through pricing incentives or value-based offers.

## Key Insights
- Month-to-month contracts show the highest churn rate (~43%)
- Customers with high monthly charges churn significantly more (~35%)
- Long-term contracts drastically reduce churn

## Business Recommendations
- Incentivize customers to move to long-term contracts
- Offer targeted discounts for high-charge customers
- Focus retention efforts on high-risk segments

## Power BI Dashboard
![Churn Dashboard](powerbi/churn_dashboard.png)
