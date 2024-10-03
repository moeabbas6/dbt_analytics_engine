
# dbt_analytics_engine

## Introduction  

The **dbt_analytics_engine** project is an end-to-end demonstration of my capabilities in analytics engineering using dbt (data build tool). This project replicates a complete data pipeline, from data extraction/generation, loading, and transformation, all the way to the end users' Business Intelligence (BI) tools, specifically Looker Studio.

Designed to showcase a comprehensive range of dbt features, the project includes data transformation, testing, and documentation. Additionally, I have created a dashboard in Looker Studio to visualize the output, demonstrating the full lifecycle of data from raw extraction/generation to actionable insights.

This project not only highlights my technical skills but also reflects my ability to design and execute complex data workflows.

## Project Overview

The **dbt_analytics_engine** project is designed to simulate a comprehensive data pipeline, covering the entire process from data extraction/generation and loading to transformation and final visualization in a BI tool (Looker Studio). This project demonstrates my proficiency in managing and transforming data, as well as implementing dbt features to build robust and efficient data models.

## Documentation

The detailed documentation for the **dbt_analytics_engine** project, including data lineage and descriptions, is publicly hosted on [Surge](https://dbt_analytics_engine.surge.sh/#!/overview?g_v=1). This documentation provides a comprehensive view of the data pipeline, including the structure and relationships of the datasets, as well as the transformations applied throughout the project.

### Key Features:
- **End-to-End Data Pipeline**: This project covers all stages of the data lifecycle, from initial extraction/generation and loading of raw data to the final transformation and presentation of insights in a dashboard.
- **Extensive Use of dbt**: The project leverages a wide array of dbt features, including but not limited to data transformation, testing, and documentation. Each feature is utilized to its full potential, showcasing a deep understanding of the dbt ecosystem.
- **Custom SQL-Based Tables**: To allow for a variety of use cases, I created [custom SQL](https://github.com/moeabbas6/dbt_analytics_engine/tree/main/analyses/sources) tables that reflect real-world scenarios. These tables serve as the foundation for multiple models, enabling complex data transformations and testing.
- **Comprehensive Testing Suite**: Robust testing is integrated into the project, ensuring data accuracy and consistency across all transformations. 
- **Documentation**: The project includes thorough documentation, detailing each step of the pipeline, the rationale behind key decisions, and the expected outcomes. This documentation ensures that the project is easily understandable and maintainable.
- **Visualization in Looker Studio**: The final step of the pipeline is a dashboard created in Looker Studio, where the transformed data is presented in a clear and actionable format. This visualization highlights the practical applications of the data pipeline and demonstrates how insights can be derived from raw data.

## Tech Stack

The **dbt_analytics_engine** project leverages a robust and modern technology stack to manage and transform data effectively. The key components of the stack include:

- **Google BigQuery**: Serves as the data warehouse, enabling efficient storage and querying of large datasets using SQL. It also allows the use of BigQuery ML models, such as the ARIMA model, to generate sales forecasts, making it a powerful tool for both data management and predictive analytics.
- **dbt (data build tool)**: Used for data transformation, testing, lineage tracking, and documentation. dbt enables the creation of complex data models and ensures data quality throughout the pipeline.
- **Looker Studio**: Utilized for data visualization, providing clear and actionable insights through interactive dashboards that reflect the transformed data.
- **Surge**: dbt documentation is hosted on Surge, allowing external viewers without a dbt Cloud account to access the data documentation and lineage. Special thanks to Brock, Co-founder at Surge, for creating this amazing service.

## Architecture

The **dbt_analytics_engine** project is built on a well-structured architecture that integrates multiple tools and technologies to create a seamless end-to-end data pipeline. Below is a high-level overview of the architecture:

1. **Data Extraction/Generation and Loading**:
   - - **Custom SQL-Based Tables**: To allow for a variety of use cases, I created custom SQL views that reflect real-world scenarios. These views serve as the foundation for multiple models, enabling complex data transformations and testing. Using `CREATE OR REPLACE` statements, I create tables from those views and store them in a raw schema within Google BigQuery. The data is populated for the entire previous and current year, providing a robust dataset. To ensure the data remains relevant and up-to-date, the dataset is limited to the current date through transformations applied in the staging layers. 

2. **Data Transformation with dbt**:
   - **Model Layers**:
     - **Staging Models**: The first layer handles raw data with minor transformations. These models are built as views and serve as the foundation for further transformations.
     - **Intermediate Models**: The second layer joins and further transforms the staging models. These models are also built as views and prepare the data for final processing.
     - **Marts Models**: The final layer materializes the intermediate models as tables, partitioned and clustered for optimal performance. This layer is designed for consumption by BI tools like Looker Studio and includes important calculations and business logic.
   - **Testing**: Each layer of models includes rigorous testing to ensure data accuracy, consistency, and reliability. These tests are critical for maintaining the integrity of the data pipeline.
   - **dbt Exposures**: dbt exposures are used to track the downstream use of data models, ensuring that the data pipeline is fully documented and traceable.
   - **Environments**:
     - **Development (Dev)**: This environment is used for ad-hoc work and iterative development. The outputs are directed to a dedicated dev dataset in BigQuery, isolating development work from production data.
     - **Continuous Integreation (CI)**: The CI environment runs the slim CI job, triggered whenever a pull request is made. This job performs a series of tests to validate the updated models, ensuring that only models passing these checks can be pushed to the master branch. If the slim CI job fails, the merge to the master branch is blocked, preventing untested or broken code from being integrated.
     - **Production (Prod)**: The production environment is where the final, stable versions of the models are deployed. The outputs are directed to a dedicated prod dataset in BigQuery, ensuring that production data is reliable and consistent. The production environment is also where the Slim Continuous Deployment (CD) job operates. This job is triggered automatically whenever a pull request is merged, ensuring that the production database is always updated with the latest changes in the codebase. This process eliminates the need to manually trigger a rebuild or wait for the next scheduled production job, ensuring that the production environment is always current.

3. **Data Visualization**:
   - **Looker Studio**: Once the data has been transformed and tested, it is visualized using Looker Studio. The data is presented in interactive dashboards that provide insights and support decision-making.

4. **Automation and Workflow**:
   - The entire pipeline is fully automated using dbt Cloud. The combination of environments and jobs ensures that the data is always up to date. A daily build job runs to build the entire DAG, leveraging incremental models so that only updated and new records are inserted. This ensures that the pipeline remains efficient and scalable. The CI/CD workflow is triggered during pull requests and merges. This workflow ensures that any changes are validated before being deployed, guaranteeing that the data in production is always accurate and up to date.

### dbt Packages

To enhance the functionality and efficiency of the **dbt_analytics_engine** project, I integrated several dbt packages that provided additional capabilities and streamlined various aspects of the development process.

#### Packages Used:
- **dbt_expectations**: This package includes more advanced tests. One of the tests extensively used in the project is `expect_table_aggregation_to_equal_other_table`, which ensures that the metrics aggregation in a model matches the aggregation from an upstream model. This test plays a crucial role in verifying that no transformations have inadvertently corrupted the values in any metric.
- **dbt-utils**: This package includes the `expression_is_true` test, which is used to validate the business logic in any calculation. For example, it can be applied to check that the net revenue before tax is calculated correctly by ensuring that the gross revenue minus the shipping amount results in the expected value. This ensures that any transformation or calculation logic remains accurate and reliable.
- **dbt_meta_testing**: This package was crucial in ensuring that required tests and documentation were included in the project. The `required_tests` feature allowed me to check for models where tests were missing, ensuring comprehensive coverage.
- **codegen**: I leveraged this package to generate YAML foundations for sources and models, significantly saving time and reducing manual work during the setup phase.
- **dbt_ml**: This package provides a framework to train, audit and use BigQuery ML (Machine Learning) models. It implements a `model` materialization that trains a BigQuery ML (Machine Learning) model from a select statement and a set of parameters.

## Results

You can explore the full live demo of the **dbt_analytics_engine** project on [Looker Studio](https://lookerstudio.google.com/s/lLJKHojOQ_M). 

## Let's Connect

If you're interested in discussing this project or my skills further, please feel free to reach out to me on [LinkedIn](https://www.linkedin.com/in/moe-abbas/).
