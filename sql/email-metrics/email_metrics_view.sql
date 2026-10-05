CREATE VIEW Students.f_tkachenko_module_task AS (
 
-- для початку формуємо CTE з категоріальними значеннями в розрізі даних акаунтів, 
-- вносимо не релевантні колонки з розрахунковими метриками листів (для подальшого об'єднання)
  
WITH acc_metrics AS (
    SELECT
        s.date AS date,
        sp.country AS country,
        acc.send_interval AS send_interval,
        acc.is_verified AS is_verified,
        acc.is_unsubscribed AS is_unsubscribed,
        COUNT(DISTINCT acc.id) AS account_cnt,
        0 AS sent_msg,
        0 AS open_msg,
        0 AS visit_msg
    FROM `data-analytics-mate.DA.account` acc
    JOIN `data-analytics-mate.DA.account_session` acs ON acc.id = acs.account_id
    JOIN `data-analytics-mate.DA.session` s ON s.ga_session_id = acs.ga_session_id
    JOIN `data-analytics-mate.DA.session_params` sp ON s.ga_session_id = sp.ga_session_id
    GROUP BY s.date, sp.country, acc.send_interval, acc.is_verified, acc.is_unsubscribed
),

-- також формуємо CTE з самими розрахунковими метриками листів
  
msg_metrics AS (
    SELECT
        DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS date,
        sp.country AS country,
        acc.send_interval AS send_interval,
        acc.is_verified AS is_verified,
        acc.is_unsubscribed AS is_unsubscribed,
        0 AS account_cnt,
        COUNT(DISTINCT es.id_message) AS sent_msg,
        COUNT(DISTINCT eo.id_message) AS open_msg,
        COUNT(DISTINCT ev.id_message) AS visit_msg
    FROM `data-analytics-mate.DA.account` acc
    JOIN `data-analytics-mate.DA.email_sent` es ON acc.id = es.id_account
    JOIN `data-analytics-mate.DA.account_session` acs ON acc.id = acs.account_id
    JOIN `data-analytics-mate.DA.session` s ON s.ga_session_id = acs.ga_session_id
    JOIN `data-analytics-mate.DA.session_params` sp ON s.ga_session_id = sp.ga_session_id
    LEFT JOIN `data-analytics-mate.DA.email_open` eo ON es.id_message = eo.id_message
    LEFT JOIN `data-analytics-mate.DA.email_visit` ev ON es.id_message = ev.id_message
    GROUP BY date, sp.country, acc.send_interval, acc.is_verified, acc.is_unsubscribed
),
  
-- об'єднуємо попередні розрахунки, агрегуємо значення
  
final AS (
SELECT
    date,
    country,
    send_interval,
    is_verified,
    is_unsubscribed,
    SUM(account_cnt) AS account_cnt,
    SUM(sent_msg) AS sent_msg,
    SUM(open_msg) AS open_msg,
    SUM(visit_msg) AS visit_msg
FROM (
    SELECT * FROM acc_metrics
    UNION ALL
    SELECT * FROM msg_metrics
) AS union_data
GROUP BY date, country, send_interval, is_verified, is_unsubscribed),

-- Окремо проводимо метрики в розрізі країни (застосовуємо віконні функції)
  
country_totals AS (
    SELECT
        *,
        SUM(account_cnt) OVER (PARTITION BY country) AS total_country_account_cnt,
        SUM(sent_msg) OVER (PARTITION BY country) AS total_country_sent_cnt
    FROM final
),

-- Ранжуємо країни за загальними метриками
  
ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (ORDER BY total_country_account_cnt DESC) AS rank_total_country_account_cnt,
        DENSE_RANK() OVER (ORDER BY total_country_sent_cnt DESC) AS rank_total_country_sent_cnt
    FROM country_totals
)

-- Фінальний селект, збираємо всі значення, виводимо фільтр за рангом
  
SELECT *
FROM ranked
WHERE rank_total_country_account_cnt <= 10
   OR rank_total_country_sent_cnt <= 10
ORDER BY date
)
