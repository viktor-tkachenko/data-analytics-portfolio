# A/B testing: дашборд у Tableau

🔗 **[Відкрити на Tableau Public](https://public.tableau.com/app/profile/viktor.tkachenko/viz/ABtesting_17907708825220/Dashboard1)**

![A/B testing](https://github.com/user-attachments/assets/b86625e9-af40-4ace-818b-b7065b7b6c04)

## Задача
Порівняти дві групи A/B-тесту (`test_group` 1 і 2) і відповісти на два питання:
1. **Чи групи порівнянні?** Чи однаковий розподіл за каналами, пристроями, країнами та континентами.
2. **Чи відрізняється поведінка груп** на кожному кроці воронки: від першого візиту до замовлення.

## Дані
Таблиця з показниками в розрізі `date × country × continent × device × channel × test × test_group × event_name`,
підготовлена SQL-запитом у BigQuery (див. [sql/ab-test-analysis](../sql/ab-test-analysis)).

## Що є на дашборді

| Елемент | Що показує |
|---|---|
| **Groups** | частка користувачів у кожній групі (контроль балансу вибірки) |
| **Channels / Devices / Countries / Continents** | структура кожної групи за каналом, пристроєм, країною, континентом (100% stacked bar) |
| **Values** | кількість подій по групах: `session`, `session_start`, `first_visit`, `page_view`, `scroll`, `add_to_cart`, `begin_checkout`, `add_shipping_info`, `add_payment_info`, `new_account`, `session with orders` та ін. |
| **Values (%)** | відносна різниця групи 2 відносно групи 1 по кожній події |
| **Фільтри** | дата, тест, канал, пристрій, країна, континент |

## Основні спостереження
За цими даними було проведено 3 A/B-тести, які можна розглядати в розрізі різних задач.
Карти проведених тестів (гіпотеза, метрики, висновки):

- [Карта тесту: Зміна кнопки на головній сторінці](https://docs.google.com/document/d/1SW0TkSWkATffaeq_ghdZGE5hejz_G_SD5U-6k-R4igs/edit?usp=sharing)
- [Карта тесту: Оформлення замовлення в один клік (мобільний інтерфейс)](https://docs.google.com/document/d/1_4FVccC6uL-Wl2mz99K-Svdbd3Oo01orXHl7uzVonzs/edit?usp=sharing)
- [Карта тесту: Оплата через Google Pay / Apple Pay](https://docs.google.com/document/d/1nXvQfURjbixUUT5tuxOXJF2WQyzTqNnwqAH6z8XbHuc/edit?usp=sharing)
