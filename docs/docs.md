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

Customer segments are based on the recency of their last order and frequency of orders placed:

| segment           | description                          |
|-------------------|--------------------------------------|
| Loyal Leader      | 3+ orders, last purchase <= 90 days. |
| Growing Patron    | 2 orders, last purchase <= 90 days.  |
| New Enthusiast    | 1 order, last purchase <= 90 days.   |
| Casual Shopper    | 3+ orders, purchase 91-180 days ago. |
| Waning Loyalty    | 2 orders, purchase 91-180 days ago.  |
| Slipping Newcomer | 1 order, purchase 91-180 days ago.   |
| At-Risk Regular   | 3+ orders, purchase 181-365 days ago.|
| Vanished Buyer    | 2 orders, purchase 181-365 days ago. |
| One-Time Buyer    | 1 order, purchase 181-365 days ago.  |
| Dormant Customer  | No orders in the last 365+ days.     |

{% enddocs %}