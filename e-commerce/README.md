# E-commerce Sales Analytics

End-to-end analysis of an online furniture store's sales: data extraction with **SQL (BigQuery)**, exploratory and statistical analysis in **Python (Jupyter)**, and an interactive dashboard in **Tableau Public**.

**Links**
- Dashboard: [Ecommerce Sales Dashboard](https://public.tableau.com/views/EcommerceSalesDashboard_17930470371160/SalesOverview?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
- Notebook: [Ecommerce_Sales_Analytics (Google Colab)](https://colab.research.google.com/drive/1SBRL3HCrykFOk9UtksumJjNjZxhmHd7G?usp=sharing)

## Dataset
- Source: Google BigQuery (`data-analytics-mate.DA`), 6 tables joined with LEFT JOINs so that every session is kept, including sessions without registration or purchase.
- Period: 2020-11-01 to 2021-01-31 (92 days), 349,545 sessions, 33,538 purchases.
- Key fields: session date, geography, device, traffic channel, registration and email status, product category and price.

## Tools
SQL (BigQuery), Python (pandas, NumPy, seaborn, matplotlib, SciPy, statsmodels), Tableau Public.

## What I did
1. Built the dataset with SQL and loaded it into Python.
2. Cleaned and described the data, documented missing values.
3. Exploratory analysis: price distribution, geography, categories, devices, traffic channels, registered users, conversion.
4. Sales dynamics: daily trend, weekday cycle, breakdown by continent, channel and device.
5. Pivot tables and heatmaps.
6. Statistical analysis: correlations (Spearman), tests for group differences (paired t-test, Friedman with Wilcoxon post-hoc, two-proportion z-test, chi-square with Cramér's V).
7. Interactive two-page dashboard in Tableau Public.

## Key findings
- **Revenue is concentrated in expensive purchases:** the top 10% of purchases (price 2,500+) bring 44% of revenue; the cheapest 25% bring only 1.9%.
- **The US is the key market:** about 44% of revenue; Sofas & armchairs, Chairs and Beds lead in every top-5 country.
- **Conversion is stable:** overall session-to-purchase conversion is 9.59% and nearly identical across channels, devices and countries.
- **Traffic drives sales:** daily sales strongly correlate with the number of sessions (Spearman ρ = 0.90), while conversion does not depend on traffic volume (ρ = -0.13, p = 0.23).
- **Weekly cycle:** median weekend sales are about 29% lower than on weekdays (statistically significant).
- **Groups differ in scale, not composition:** revenue per session is the same for registered and unregistered users, the share of organic traffic is the same in the Americas and Europe (37.90% vs 37.92%), and the device mix does not depend on the channel (Cramér's V = 0.0025).

## Limitations
The data cover only three months. Each registered account appears in one session, correlations do not prove causation, and there is no data on advertising costs or margin.

## Repository structure
- `python/`: Jupyter notebook with the full analysis
- `sql/`: SQL query used to build the dataset
- `tableau/`: dashboard link and screenshots
