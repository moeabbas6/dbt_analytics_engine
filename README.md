
# dbt_analytics_engine

## Introduction  

The **dbt_analytics_engine** project is an end-to-end demonstration of my capabilities in analytics engineering using dbt (data build tool). This project replicates a complete data pipeline, from data extraction, loading, and transformation, all the way to the end users' Business Intelligence (BI) tools, specifically Looker Studio.

Designed to showcase a comprehensive range of dbt features, the project includes data transformation, testing, and documentation. Additionally, I have created a dashboard in Looker Studio to visualize the output, demonstrating the full lifecycle of data from raw extraction to actionable insights.

This project not only highlights my technical skills but also reflects my ability to design and execute complex data workflows, which are essential for a successful career in analytics engineering.

## Project Overview

The **dbt_analytics_engine** project is designed to simulate a comprehensive data pipeline, covering the entire process from data extraction and loading to transformation and final visualization in a BI tool (Looker Studio). This project demonstrates my proficiency in managing and transforming data, as well as implementing dbt features to build robust and efficient data models.

## Documentation

The detailed documentation for the **dbt_analytics_engine** project, including data lineage and descriptions, is publicly hosted on [Surge](https://dbt_analytics_engine.surge.sh/). This documentation provides a comprehensive view of the data pipeline, including the structure and relationships of the datasets, as well as the transformations applied throughout the project.

### Key Features:
- **End-to-End Data Pipeline**: This project covers all stages of the data lifecycle, from initial extraction and loading of raw data to the final transformation and presentation of insights in a dashboard.
- **Extensive Use of dbt**: The project leverages a wide array of dbt features, including but not limited to data transformation, testing, and documentation. Each feature is utilized to its full potential, showcasing a deep understanding of the dbt ecosystem.
- **Custom SQL-Based Tables**: To allow for a variety of use cases, I created custom SQL tables that reflect real-world scenarios. These tables serve as the foundation for multiple views and models, enabling complex data transformations and testing.
- **Comprehensive Testing Suite**: Robust testing is integrated into the project, ensuring data accuracy and consistency across all transformations. This includes both generic and custom tests.
- **Documentation**: The project includes thorough documentation, detailing each step of the pipeline, the rationale behind key decisions, and the expected outcomes. This documentation ensures that the project is easily understandable and maintainable.
- **Visualization in Looker Studio**: The final step of the pipeline is a dashboard created in Looker Studio, where the transformed data is presented in a clear and actionable format. This visualization highlights the practical applications of the data pipeline and demonstrates how insights can be derived from raw data.

## Data Sources

The **dbt_analytics_engine** project utilizes a set of custom SQL-based tables and seeds that simulate real-world data scenarios. These data sources serve as the foundation for various transformations, testing, and visualizations throughout the project.

During the initial stages of the project, I dedicated significant time to finding suitable data sources available via public APIs. Although I implemented some of these sources, I discovered that the transformation opportunities were rather limited, and the data couldn't effectively relate to one another. To overcome these limitations and fully leverage my 7+ years of SQL experience, I decided to create the data sources myself. This approach allowed me to design tables that support a wide range of transformation opportunities and showcase my technical skills to their fullest extent.

The views in this project include the SQL code, and I created tables from these views using `CREATE OR REPLACE table` statements. To load the data into BigQuery, I ran a custom Python script, which can be found in my public repository, [bq_data_loader](https://github.com/moe-abbas-ghub/bq_data_loader).

### Views:
- **Customers View**: Captures customer-related data, including customer IDs, names, and relevant demographic information. It serves as a primary source for analyzing customer behaviors and trends.
- **NPS View**: Measures customer satisfaction and loyalty by calculating the Net Promoter Score (NPS) based on survey responses. This view helps assess the overall customer experience.
- **Payments View**: Tracks payment transactions, including order IDs, payment methods, and transaction amounts. It provides insights into payment processing and customer purchasing patterns.
- **Orders View**: Contains detailed information about customer orders, including order IDs, product IDs, quantities, and order dates. It is essential for analyzing sales trends and order fulfillment.
- **Returns View**: Logs product returns, capturing data on returned items, return reasons, and refund amounts. It is used to assess product performance and customer satisfaction.
- **Shipping View**: Details shipping activities, including shipment dates, delivery statuses, and shipping costs. It supports analysis of logistics efficiency and cost management.

### Seeds:
- **Payment Fees**: Contains the costs associated with payment processing based on different payment providers. It is used to calculate the impact of payment fees on overall revenue.
- **Products**: Includes product categories, names, and respective IDs. It serves as a reference table for linking product data across various views.
- **Taxes**: Lists tax rates by country, providing the necessary data for calculating tax liabilities and ensuring compliance with regional tax regulations.

## Tech Stack

The **dbt_analytics_engine** project leverages a robust and modern technology stack to manage and transform data effectively. The key components of the stack include:

- **Google BigQuery**: Serves as the data warehouse, enabling efficient storage and querying of large datasets using SQL.
- **Python**: A custom Python script was developed to execute the `CREATE OR REPLACE` statements, ensuring that data is loaded into BigQuery accurately and efficiently.
- **Cronjob**: The Python script is scheduled to run daily via a cronjob, automating the data loading process and ensuring that the data is always up-to-date.
- **dbt (data build tool)**: Used for data transformation, testing, lineage tracking, and documentation. dbt enables the creation of complex data models and ensures data quality throughout the pipeline.
- **Looker Studio**: Utilized for data visualization, providing clear and actionable insights through interactive dashboards that reflect the transformed data.
- **Surge**: dbt documentation is hosted on Surge, allowing external viewers without a dbt Cloud account to access the data documentation and lineage. Special thanks to Brock, Co-founder at Surge, for creating this amazing service.

## Architecture

The **dbt_analytics_engine** project is built on a well-structured architecture that integrates multiple tools and technologies to create a seamless end-to-end data pipeline. Below is a high-level overview of the architecture:

1. **Data Extraction and Loading**:
   - **Python Script**: The process begins with a custom Python script that executes `CREATE OR REPLACE` statements to load data into Google BigQuery. This script ensures that the data in BigQuery is always current and accurate.
   - **Cronjob**: A cronjob is set up to run the Python script daily, automating the data loading process and ensuring regular updates to the dataset.

2. **Data Transformation with dbt**:
   - **Model Layers**:
     - **Staging Models**: The first layer handles raw data with minor transformations. These models are built as views and serve as the foundation for further transformations.
     - **Intermediate Models**: The second layer joins and further transforms the staging models. These models are also built as views and prepare the data for final processing.
     - **Marts Models**: The final layer materializes the intermediate models as tables, partitioned and clustered for optimal performance. This layer is designed for consumption by BI tools like Looker Studio and includes important calculations and business logic.
   - **Testing**: Each layer of models includes rigorous testing to ensure data accuracy, consistency, and reliability. These tests are critical for maintaining the integrity of the data pipeline and can be further detailed if necessary.
   - **dbt Exposures**: dbt exposures are used to track the downstream use of data models, ensuring that the data pipeline is fully documented and traceable.
   - **Environments**:
     - **Development (Dev)**: This environment is used for ad-hoc work and iterative development. The outputs are directed to a dedicated dev dataset in BigQuery, isolating development work from production data.
     - **Production (Prod)**: The production environment is where the final, stable versions of the models are deployed. The outputs are directed to a dedicated prod dataset in BigQuery, ensuring that production data is reliable and consistent.
     - **Test Failures**: Any failures encountered during testing are stored in a separate `test_failures` dataset. This allows for easy monitoring and troubleshooting of issues within the data pipeline.

3. **Data Visualization**:
   - **Looker Studio**: Once the data has been transformed and tested, it is visualized using Looker Studio. The data is presented in interactive dashboards that provide insights and support decision-making.

4. **Automation and Workflow**:
   - The combination of cronjob, Python scripting, and dbt ensures that the entire workflow is automated, from data extraction to visualization. This automation minimizes manual intervention and maintains the reliability and timeliness of the data pipeline.

### dbt Packages

To enhance the functionality and efficiency of the **dbt_analytics_engine** project, I integrated several dbt packages that provided additional capabilities and streamlined various aspects of the development process.

#### Packages Used:
- **dbt-utils (version 1.2.0)**: This package includes a variety of tests, such as `accepted_range` for int64 and datetimes. It was utilized extensively across YAMLs, from sources to staging, intermediary, and marts models.
- **audit_helper (version 0.12.0)**: I used this package to audit before and after results during development, ensuring that transformations were applied correctly. Specifically, it was used to audit marts with source models.
- **dbt_meta_testing (version 0.3.6)**: This package was crucial in ensuring that required tests and documentation were included in the project. The `required_tests` feature allowed me to check for models where tests were missing, ensuring comprehensive coverage.
- **codegen (version 0.12.1)**: I leveraged this package to generate YAML foundations for sources and models, significantly saving time and reducing manual work during the setup phase.

#### Benefits:
- **Efficiency**: Using these packages allowed me to automate and streamline various tasks, such as generating YAML files and checking for missing tests, which saved considerable time and effort.
- **Enhanced Data Quality**: By integrating robust testing frameworks and audit tools, I was able to maintain high data quality throughout the pipeline.
- **Simplified Code Maintenance**: These packages helped to simplify the codebase, making it easier to maintain and extend the project over time.



### Advanced Features

In the **dbt_analytics_engine** project, I utilized Jinja for a forecasting model, enabling dynamic SQL generation to handle multiple time periods in a simple moving average (SMA) calculation. This approach allows for flexible and efficient forecasting, using templating to iterate over different periods. Below is an excerpt of the code used:

```sql
{{ config(
    cluster_by = 'date'
)}}

{% set periods = [14, 30, 60, 120, 250] %}

WITH
  fct_orders_timesesries_sma AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM {{ ref('fct_orders') }}
      GROUP BY ALL)

  ,simple_moving_average AS (
    SELECT date,
           sales,
           {%- for period in periods %}
           AVG(sales) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_sma_{{ period }}
           {%- if not loop.last -%}
             ,
           {%- endif %}
           {% endfor %}
      FROM fct_orders_timesesries_sma)
```

This snippet illustrates how Jinja was used to generate dynamic SQL for calculating the moving averages across multiple periods. The full implementation, including standard deviations and Bollinger Bands, can be found in the [full code here](https://github.com/moe-abbas-ghub/dbt_analytics_engine/blob/main/models/marts/fct_orders_timeseries_sma.sql).


## Deployment

Deployment of the **dbt_analytics_engine** project is managed through dbt Cloud, where I have set up automated jobs to ensure the pipeline runs smoothly and efficiently.

   - **Scheduled Jobs in Production**: I scheduled jobs to run daily in the production environment using cron syntax. This ensures that the data pipeline is consistently updated, and any new data is processed without manual intervention.
   - **Continuous Integration with Pull Requests**: In addition to the daily production jobs, I set up jobs to run on pull requests in a separate general environment. In this environment, only the modified models are built and tested before they are merged. This approach is a key aspect of continuous integration.

The main benefits of this deployment strategy are:

   - **Pre-Merge Testing**: By testing the changed models before they are merged, I ensure that any potential issues are identified and resolved early in the process.
   - **Efficiency**: Since only the modified models are tested in the general environment, there’s no need to re-run the entire project after merging. This saves time and resources while maintaining the integrity of the data pipeline.

This deployment strategy is also ideal for teams working in either direct or indirect promotion models. It supports seamless collaboration and ensures that code quality and data integrity are maintained across the team.


## Results

You can explore the full live demo of the **dbt_analytics_engine** project on [Looker Studio](https://lookerstudio.google.com/s/lLJKHojOQ_M). 

## Let's Connect

I'm actively seeking opportunities as an Analytics Engineer. If you're interested in discussing this project or my skills further, please feel free to reach out to me on [LinkedIn](https://www.linkedin.com/in/moe-abbas/).
