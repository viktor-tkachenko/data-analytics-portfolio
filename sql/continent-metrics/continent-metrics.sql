-- Задача: порівняти континенти за виручкою (загальною, з мобільних девайсів і з десктопів),
-- її часткою від загальної виручки, кількістю акаунтів і сесій.
WITH revenue_metrics AS (
  SELECT
    sp.continent,
    SUM(p.price) AS revenue,
    SUM(CASE WHEN sp.device = 'mobile' THEN p.price ELSE 0 END) AS revenue_from_mobile,
    SUM(CASE WHEN sp.device = 'desktop' THEN p.price ELSE 0 END) AS revenue_from_desktop
  FROM `data-analytics-mate.DA.session_params` sp
  JOIN `data-analytics-mate.DA.order` o ON sp.ga_session_id = o.ga_session_id
  JOIN `data-analytics-mate.DA.product` p ON o.item_id = p.item_id
  GROUP BY sp.continent
),

account_metrics AS (
  SELECT
    sp.continent,
    COUNT(DISTINCT a.id) AS account_count,
    COUNT(DISTINCT CASE WHEN a.is_verified = 1 THEN a.id END) AS verified_account_count
  FROM `data-analytics-mate.DA.account` a
  JOIN `data-analytics-mate.DA.account_session` acs ON a.id = acs.account_id
  JOIN `data-analytics-mate.DA.session_params` sp ON acs.ga_session_id = sp.ga_session_id
  GROUP BY sp.continent
),

session_metrics AS (
  SELECT
    continent,
    COUNT(ga_session_id) AS session_count
  FROM `data-analytics-mate.DA.session_params`
  GROUP BY continent
)

SELECT
  sm.continent,
  rm.revenue,
  rm.revenue_from_mobile,
  rm.revenue_from_desktop,
  ROUND(rm.revenue / SUM(rm.revenue) OVER () * 100, 2) AS revenue_percent_from_total,
  am.account_count,
  am.verified_account_count,
  sm.session_count
FROM session_metrics sm
LEFT JOIN account_metrics am ON sm.continent = am.continent
LEFT JOIN revenue_metrics rm ON sm.continent = rm.continent
ORDER BY rm.revenue DESC;
