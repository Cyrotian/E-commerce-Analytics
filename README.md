# E-commerce Analytics

A dbt learning project that models e-commerce order data (Olist-style orders/customers/products, plus a Walmart Trustpilot reviews seed) on Postgres. It's a sandbox for practicing core dbt patterns: staging models, ephemeral intermediate models, incremental facts, snapshots, and tests.

## Project layout

```
mini_shop/                     dbt project root
├── seeds/                     raw CSVs loaded via `dbt seed`
│   ├── customers.csv, orders.csv, order_items.csv, payments.csv,
│   │   products.csv, sellers.csv, geolocation.csv
│   └── walmart_trustpilot_reviews.csv
├── models/
│   ├── staging/                1:1 cleaned views over each seed (stg_*)
│   │   └── intermediate/       ephemeral join/dedup logic (int_*)
│   ├── mart/                   fct_orders (incremental fact table)
│   └── jinja/                  Jinja practice models (set, if, for loop)
├── marts/                      mart_product_sales (aggregated, ephemeral)
├── snapshots/                  customers_check_scd (type-2 style tracking)
├── tests/                      custom singular data tests
├── analyses/, macros/          currently empty, scaffolded by dbt init
└── dbt_project.yml
```

> Note: `marts/` lives at the project root alongside `models/`, not inside it — `mart_product_sales.sql` is the only model there.

## Data model

**Staging** (`models/staging/`) — one view per seed, light renaming/casting only:
`stg_customers`, `stg_orders`, `stg_order_items`, `stg_payments`, `stg_products`, `stg_sellers`, `stg_geolocation`, `stg_reviews`.

**Intermediate** (`models/staging/intermediate/`, ephemeral):
- `int_customer_record_latest` — dedupes customers down to their most recent order (`row_number()` per `customer_unique_id`).
- `int_order_items_enriched` — order items joined to product category.

**Marts**:
- `fct_orders` (`models/mart/`) — incremental fact table of orders; on incremental runs, re-scans the last 7 days based on `order_purchase_timestamp`.
- `mart_product_sales` (`marts/`) — items sold and total revenue per product category, built on `int_order_items_enriched`.

**Jinja practice** (`models/jinja/`) — small models for learning Jinja in dbt:
- `include_cancelled` — `{% set %}` flag + `{% if %}` to conditionally filter out cancelled orders.
- `max_values` — `{% for %}` loop over a list of payment columns to generate `MAX(...)` aggregates, using `loop.last` to handle commas.
- `min_order_value` — variable-driven threshold (50) filtering payments joined to orders.
- `tax_rate` — variable-driven tax rate (0.20) to compute `order_value_with_tax`.

**Snapshots** (`snapshots/`):
- `customers_check_scd` — check-strategy snapshot over `int_customer_record_latest`, tracking changes to `customer_zip_code_prefix`, `customer_city`, `customer_state`.

**Tests**:
- Schema tests in `models/staging/schema.yml` — `not_null`/`unique` on `stg_customers`/`stg_orders` keys, `relationships` from orders to customers, `accepted_values` on `order_status`.
- `tests/assert_non_negative_prices.sql` — singular test asserting `stg_order_items.price >= 0`.

## Setup

1. Target database is Postgres (`dbt-postgres` adapter). Create a `~/.dbt/profiles.yml` with a `mini_shop` profile (this file is intentionally not tracked in the repo).
2. Use the included virtualenv or create your own:
   ```bash
   source .venv/bin/activate   # or: python -m venv .venv && pip install dbt-postgres
   ```

## Usage

All dbt commands run from `mini_shop/`:

```bash
cd mini_shop

dbt seed              # load the CSVs into raw tables
dbt run               # build staging, intermediate, and mart models
dbt snapshot          # capture customer changes into customers_check_scd
dbt test              # run schema + singular tests

dbt docs generate && dbt docs serve   # browse the generated docs/lineage
```

## Resources

- [dbt docs](https://docs.getdbt.com/docs/introduction)
- [dbt Discourse](https://discourse.getdbt.com/)
- [dbt community Slack](https://community.getdbt.com/)
