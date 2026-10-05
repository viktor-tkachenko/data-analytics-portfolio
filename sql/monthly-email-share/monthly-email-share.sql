-- Задача: для кожного акаунта показати частку листів за місяць від усіх
-- листів цього місяця, а також дати першого й останнього листа.
WITH emails AS (
  SELECT
    acs.account_id AS id_account,
    es.id_message,
    DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS sent_date
  FROM `data-analytics-mate.DA.email_sent` es
  JOIN `data-analytics-mate.DA.account_session` acs ON es.id_account = acs.account_id
  JOIN `data-analytics-mate.DA.session` s ON s.ga_session_id = acs.ga_session_id
),

monthly AS (
  SELECT
    DATE_TRUNC(sent_date, MONTH) AS sent_month,
    id_account,
    COUNT(id_message) AS sent_msg_cnt_indiv,
    MIN(sent_date) AS first_sent_date,
    MAX(sent_date) AS last_sent_date
  FROM emails
  GROUP BY sent_month, id_account
)

SELECT
  sent_month,
  id_account,
  ROUND(sent_msg_cnt_indiv / SUM(sent_msg_cnt_indiv) OVER (PARTITION BY sent_month) * 100, 6)
    AS sent_msg_percent_from_this_month,
  first_sent_date,
  last_sent_date
FROM monthly
ORDER BY sent_month, id_account;
