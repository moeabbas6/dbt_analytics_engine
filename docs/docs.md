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

| segment                | description                            |
|------------------------|----------------------------------------|
| Champion               | 3+ orders, last purchase <= 90 days.   |
| Rising Star            | 2 orders, last purchase <= 90 days.    |
| Active Newbie          | 1 order, last purchase <= 90 days.     |
| Occasional             | 3+ orders, last purchase 91-180 days.  |
| Need Attention         | 2 orders, last purchase 91-180 days.   |
| Newbies About to Sleep | 1 order, last purchase 91-180 days.    |
| Cannot Lose Them       | 3+ orders, last purchase 181-365 days. |
| At Risk                | 2 orders, last purchase 181-365 days.  |
| Unhappy                | 1 order, last purchase 181-365 days.   |
| Hibernating            | No orders in the last 365+ days.       |

{% enddocs %}