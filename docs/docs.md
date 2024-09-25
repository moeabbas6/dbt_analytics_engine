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