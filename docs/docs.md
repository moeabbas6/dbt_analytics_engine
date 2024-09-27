{% docs orders_status %}

Orders can be one of the following statuses:

| status         | description                                                               |
|----------------|---------------------------------------------------------------------------|
| completed      | The order has been placed and all payments were successful                |
| failed         | The order has been placed and at least one payment failed                 |

{% enddocs %}



{% docs return_reason %}

The reason codes provided by customers when returning a product. 
The available options include:

| return reason          | description                                                                |
|------------------------|----------------------------------------------------------------------------|
| Not as Described       | The product did not match the description or expectations.                 |
| Compatibility Issues   | The product was incompatible with other required items or systems.         |
| Quality Concerns       | The customer was dissatisfied with the product's quality or performance.   |
| Technical Difficulties | The customer experienced issues with the product's functionality or usage. |

{% enddocs %}

{% docs segment %}

Customer segments are based on both the recency of their last order and the frequency of orders placed. 
This segmentation helps categorize customers based on their purchasing behavior.

The available segments are:

| segment                         | description                                                                                          |
|---------------------------------|------------------------------------------------------------------------------------------------------|
| Champion                        | Customers who have placed more than 2 orders and made their last purchase within the last 90 days.   |
| Rising Star                     | Customers who have placed 2 orders and made their last purchase within the last 90 days.             |
| Active Newbie                   | Customers who have placed 1 order and made their last purchase within the last 90 days.              |
| Occasional                      | Customers who have placed more than 2 orders, with their last purchase between 90 and 180 days ago.  |
| Need Attention                  | Customers who have placed 2 orders, with their last purchase between 90 and 180 days ago.            |
| Newbies About to Sleep / Asleep | Customers who have placed 1 order, with their last purchase between 90 and 180 days ago.             |
| Cannot / Almost Lose Them       | Customers who have placed more than 2 orders, with their last purchase between 180 and 365 days ago. |
| At Risk / Lost 2nd Buyer        | Customers who have placed 2 orders, with their last purchase between 180 and 365 days ago.           |
| Unhappy / Lost 1st Buyer        | Customers who have placed 1 order, with their last purchase between 180 and 365 days ago.            |
| Hibernating Customers           | Customers who have not placed any orders in the past 365 days.                                       |

{% enddocs %}