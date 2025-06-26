# Agriculture Data Warehouse & ETL Pipeline (Snowflake)

## Overview

This repository demonstrates the design, implementation, and orchestration of an end-to-end data pipeline for agricultural analytics using **Snowflake** as a cloud data warehouse. It showcases capabilities in data ingestion, robust ETL/ELT processes, dimensional modeling, and interactive dashboarding to deliver actionable insights from diverse agricultural datasets. This project highlights key skills relevant to **Data Analyst** and **Data Engineering** roles, focusing on building scalable and efficient data solutions.

## Pipeline Name Suggestion:
**AgriFlow DWH** (A combination of Agriculture and Data Flow/Airflow, leading to Data Warehouse)

## Key Features & Highlights

* **Comprehensive Data Ingestion:** Processed various agricultural datasets (Farms, Crops, Livestock, Soil Quality, Weather, etc.).
* **Robust ETL/ELT Pipeline Development:** Engineered SQL-based ETL/ELT scripts for data cleaning, transformation, and loading into Snowflake, ensuring data integrity and readiness for analysis.
    * Examples include `CLEAN_HARVEST` for data validation and `FACT_HARVEST` for creating a comprehensive fact table by joining various dimensions.
    * Creation of a `DIM_DATE` table for time-based analysis.
* **Dimensional Modeling (Star Schema):** Designed and implemented a star schema within Snowflake, optimizing the data structure for analytical queries and reporting efficiency.
    * Key tables like `FACT_HARVEST` and various `DIM_` tables (e.g., `DIM_FARMS`, `DIM_CROPS`, `DIM_DATE`) were created to support analytical needs.
* **Interactive Dashboarding:** Developed SQL views for deriving key agricultural KPIs and trends, which were then visualized in interactive dashboards using **Snowsight**.
    * Examples of KPIs include `Total_Yield`, `Avg_Yield_Per_Acre`, `Avg_Soil_pH`, `Monthly_Yield`, and `Monthly_Subsidy`.
* **Cloud Data Warehousing:** Leveraged **Snowflake's** capabilities for scalable, high-performance data storage and querying in a cloud environment.

## Technologies Used

* **Cloud Data Warehouse:** Snowflake
* **Database Language:** SQL
* **Business Intelligence & Visualization:** Snowsight, Power BI, Looker Studio
* **Data Concepts:** ETL/ELT, Dimensional Modeling (Star Schema), Data Cleaning, Data Transformation, Data Quality, KPI Development.

## Project Structure & Workflow

This repository contains the essential components for the **AgriFlow DWH** pipeline:

1.  **Data Source:** Raw agricultural data provided in `.csv` format.
2.  **ETL/ELT Scripts (`ETL Pipeline.sql`):** SQL scripts defining the steps to load, clean, transform, and model the raw data into a star schema within Snowflake. This includes creating fact and dimension tables and aggregating key metrics.
3.  **Dashboarding Queries (`Dashboarding.sql`):** SQL views designed to extract and aggregate data from the data warehouse for direct consumption by BI tools, enabling the creation of dashboards.
4.  **Visualizations:** Screenshots of the **Snowsight Dashboard** demonstrating key insights and analytical capabilities.
5.  **Documentation:** `Agriculture.pdf` provides the Entity-Relationship Diagram (ERD) of the agricultural dataset, outlining entities and their relationships, which guided the data modeling process.

## Screenshots

Below are some screenshots illustrating the Snowflake directory structure and the Snowsight Dashboard.

### 📁 Snowflake Directory

![Snowflake Directory](./Snowflake%20Directory.png)

### 📊 Snowsight Dashboard

![Snowsight Dashboard](./Snowsight%20Dashboard.png)

---

## Getting Started (for review)

To review this project:

1.  **Understand the Data Model:** Refer to `Agriculture.pdf` for the ERD and table definitions.
2.  **Review ETL/ELT:** Examine `ETL Pipeline.sql` to see how raw data is transformed and loaded into Snowflake.
3.  **Explore Dashboarding Logic:** Check `Dashboarding.sql` for the SQL views that power the analytics.
4.  **View Results:** Observe the `Snowsight Dashboard.png` to see the final visualized insights.

*Note: Access to a Snowflake account would be required to fully execute these scripts and interact with the live dashboard.*

---

## Future Enhancements (Optional - but good for demonstrating forward-thinking)

* Integrate Airflow DAGs for automated scheduling of the Snowflake ETL/ELT processes.
* Implement data quality checks and logging within the ETL pipeline.
* Expand dashboard capabilities with more advanced visualizations and predictive analytics.
* Explore stream processing for real-time data ingestion.

---

## Connect with Me

Feel free to connect or reach out with any questions!

* **LinkedIn:** [Your LinkedIn Profile URL]
* **GitHub:** [Link to your GitHub profile/other relevant repos]
* **Email:** [Your Email Address]
