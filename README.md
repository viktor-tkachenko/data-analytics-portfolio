# SQL для A/B-тесту: підготовка даних для аналізу

## Задача
Зібрати в BigQuery єдину таблицю для аналізу A/B-тесту: порівняти поведінку
груп ('test_group') у розрізі дати, країни, континенту, пристрою та каналу трафіку.

## Що рахує запит
Для кожної комбінації 'date × country × continent × device × channel × test × test_group':

| event_name | Що означає |
| 'session' | кількість унікальних сесій |
| 'session with orders' | кількість унікальних сесій із замовленням |
| 'new_account' | кількість унікальних сесій, у яких створено акаунт |
| назви подій з 'event_params' | кількість подій кожного типу |

З цих показників можна рахувати конверсії (сесія → замовлення, сесія → акаунт)
і порівнювати групи A та B.

## Як це працює
1. CTE 'session_info' об'єднує учасників тесту ('ab_test') із даними сесій і їхніми параметрами.
    По суті це словник для подальших CTE.
3. Окремі CTE ('session', 'session_with_orders', 'events', 'account') рахують показники
   за однаковими вимірами.
4. 'UNION ALL' складає їх в одну загальну таблицю
   ('event_name' + 'value'), зручну для візуалізації.

## Інструменти й прийоми
- Google BigQuery (GoogleSQL)
- CTE, 'JOIN', 'GROUP BY', 'COUNT(DISTINCT ...)', 'UNION ALL'

## Використані таблиці
'ab_test', 'session', 'session_params', 'order', 'event_params', 'account_session' (схема 'DA').

## Результат
Таблиця зі 800996 рядками стала джерелом для інтерактивного дашборда в Tableau (https://public.tableau.com/app/profile/viktor.tkachenko/viz/ABtesting_17907708825220/Dashboard1)

## Файли
- 'sql_for_ab.sql': основний запит
