# E-commerce Analytics Engineering with dbt

A self-directed data engineering project exploring how **dbt** is used to transform raw e-commerce data into reliable, analytics-ready datasets.

The project follows a layered modelling approach, moving data from raw sources through staging and transformation models before producing datasets suitable for reporting and analysis.

## Tech Stack

* dbt Core
* DuckDB
* SQL
* Jinja
* Git

## Key Features

* Modular dbt models and dependency management using `ref()`
* Staging and analytical transformations
* Data quality testing with `unique`, `not_null`, `relationships`, and `accepted_values`
* Incremental models for efficient data processing
* SCD Type 2 customer history using dbt snapshots
* Reusable SQL using Jinja and macros
* Documentation and model lineage

## Project Goal

The goal is to build a small but production-style analytics warehouse while learning the engineering principles behind dbt, including data modelling, testing, historical tracking, incremental processing, and maintainable SQL.
