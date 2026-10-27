SELECT
  s.date AS date,
  s.ga_session_id AS session_id,
  sp.continent AS continent,
  sp.country AS country,
  sp.device AS device,
  sp.browser AS browser,
  sp.mobile_model_name AS mobile_model_name,
  sp.operating_system AS operating_system,
  sp.language AS language,
  sp.medium AS traffic_source,
  sp.channel AS traffic_channel,
  ac.id AS account_id,
  CASE
    WHEN ac.is_verified = 1 THEN 'verified'
    WHEN ac.is_verified = 0 THEN 'unverified'
  END AS verification_status,
  CASE
    WHEN ac.is_unsubscribed = 0 THEN 'subscribed'
    WHEN ac.is_unsubscribed = 1 THEN 'unsubscribed'
  END AS subscription_status,
  p.category AS category,
  p.name AS name,
  p.price AS price,
  p.short_description AS short_description
FROM `data-analytics-mate.DA.session` s
LEFT JOIN `data-analytics-mate.DA.session_params` sp
  ON s.ga_session_id = sp.ga_session_id
LEFT JOIN `data-analytics-mate.DA.account_session` acs
  ON s.ga_session_id = acs.ga_session_id
LEFT JOIN `data-analytics-mate.DA.account` ac
  ON acs.account_id = ac.id
LEFT JOIN `data-analytics-mate.DA.order` o
  ON s.ga_session_id = o.ga_session_id
LEFT JOIN `data-analytics-mate.DA.product` p
  ON o.item_id = p.item_id;
