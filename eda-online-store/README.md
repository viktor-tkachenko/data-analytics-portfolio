# Exploratory Data Analysis: Sales Orders

Exploratory analysis of a company's sales orders in **Python (Google Colab)**: cleaning three related tables, merging them, building business metrics and studying sales, profit, logistics and time trends.

**Notebook:** [Exploratory_data_analysis_for_online_store.ipynb](Exploratory_data_analysis_for_online_store.ipynb)

## Dataset
Three tables: **Events** (orders: dates, priority, country, product, sales channel, units, unit price and cost), **Products** (product category) and **Countries** (ISO codes, region, sub-region).
- 1,328 orders after cleaning (1,330 raw rows; 2 rows without units sold were dropped), 45 countries, 12 product categories.
- Order dates: 2010-01-01 to 2017-07-23.
- 82 orders (6.2%) have no country code. They were kept, so their country attributes stay empty after the merge.

## Tools
Python: pandas, NumPy, matplotlib, seaborn.

## What I did
1. **Data overview and cleaning:** checked missing values, standardized column names, data types and text values, removed extra spaces, checked duplicates, reviewed descriptive statistics. Filled the missing alpha-2 code for Namibia according to the ISO standard.
2. **Merging and metrics:** joined the three tables and added business metrics (revenue, cost, profit, shipping time).
3. **Analysis and visualization:**
   - product categories: revenue, profit, popularity (units sold);
   - geography: countries, regions, sub-regions;
   - sales channels: online vs offline;
   - shipping time by category, country, region and sub-region, and its relationship with profit;
   - time trends: by year, month and day of week, by category, country, sub-region and region.

## Key findings
- Total revenue $1.70 billion, profit $501.4 million, profit margin 29.5%.
- **Office Supplies** bring the most revenue (over $400 million); **Cosmetics** are the most profitable category.
- **Europe** gives about 94% of revenue, cost and profit; Southern Europe is the leading sub-region. Asia contributes 5-6%.
- Sales channels are balanced: 3.32 million units sold offline and 3.26 million online.
- Average shipping time is 24.8 days (20.8 to 27.2 days across categories); its relationship with profit is weak.
- Weekly seasonality is limited, monthly variation is stronger: revenue peaks in March ($170.7 million) and is lowest in October ($107.8 million).

## Limitations
- The data end on 2017-07-23, so 2017 is a partial year and its lower revenue partly reflects the shorter period.
- The analysis is descriptive: no statistical tests, so differences between groups are not checked for significance.
- The source files are not included in the repository: the notebook reads them from Google Drive.
