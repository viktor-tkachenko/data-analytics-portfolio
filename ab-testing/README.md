# A/B Testing: Statistical Significance

Statistical significance of four conversion metrics across four A/B tests: data extraction with **SQL (BigQuery)**, calculation in **Python (Google Colab)** and an interactive dashboard in **Tableau Public**.

**Links**
- Dashboard: [A/B Testing: Statistical Significance](https://public.tableau.com/shared/H93M4WXHK)
- Notebook: [Google Colab](https://colab.research.google.com/drive/1R71mIJOPUBt21JWFsX7h79plDLIx1Km-?usp=sharing)
- Results: [ab_test_significance_results.csv](https://drive.google.com/file/d/134Wo0Y5T1a9q1LfsSQHgb6okWPqH7iqC/view?usp=sharing)

## Metrics
Each metric is the share of sessions with the event:
`add_payment_info / session`, `add_shipping_info / session`, `begin_checkout / session`, `new_accounts / session`.

## Method
Group 2 (test) is compared with group 1 (control) using a two-sided two-proportion z-test.
- H0: the true conversion rates are equal; significance level α = 0.05
- Pooled rate p = (x1 + x2) / (n1 + n2); SE = √( p(1 − p)(1/n1 + 1/n2) ); z = (p2 − p1) / SE
- Metric change = (test − control) / control

The calculation does not depend on the number of metrics: they are defined in a single configuration list (name, numerator event, denominator event), and loops run over tests, metrics and slices. Adding a metric means adding one entry.

## Slices
Total, and separately by country, device, channel and continent (1,968 result rows). Rows where the statistic cannot be calculated are flagged `valid_test = False` instead of being dropped.

## Results (total, group 2 vs group 1)

| Test | add_payment_info | add_shipping_info | begin_checkout | new_accounts |
|---|---|---|---|---|
| 1 | +12.54% (p = 0.0001) | +6.56% (p = 0.0092) | +6.66% (p = 0.0029) | −3.35% (p = 0.123) |
| 2 | +3.58% (p = 0.215) | +1.65% (p = 0.478) | +1.99% (p = 0.341) | +1.24% (p = 0.556) |
| 3 | +1.48% (p = 0.520) | −2.62% (p = 0.157) | −3.35% (p = 0.012) | −1.13% (p = 0.520) |
| 4 | −3.54% (p = 0.116) | −3.41% (p = 0.074) | −2.35% (p = 0.046) | −3.36% (p = 0.018) |

## Limitations
- No multiple-comparison correction: among hundreds of slices some significant results may appear by chance.
- The numerator counts events, not unique sessions with the event, so conversion in small slices can be overstated.
- Small groups (mostly countries) give unstable statistics even for valid rows.
- Significance does not explain causes; the changes tested are unknown.

## Repository structure
- `python/`: notebook with the full calculation
- `sql/`: query used to extract the data
- `tableau/`: dashboard link and screenshots
