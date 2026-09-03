# Amazon Sales SQL Analysis

SQL analysis of a 100,000-row Amazon sales dataset (sourced from Kaggle), answering
seven business questions around revenue, geography, seller performance, seasonality,
payment behavior, and discounting.

## Dataset

`Amazon.csv` — 100,000 orders, 20 columns:

`OrderID, OrderDate, CustomerID, CustomerName, ProductID, ProductName, Category, Brand, Quantity, UnitPrice, Discount, Tax, ShippingCost, TotalAmount, PaymentMethod, OrderStatus, City, State, Country, SellerID`

## Tools

PostgreSQL for querying and analysis.

## Business Questions & Findings

### 1. Which products and categories generate the highest revenue?

**Top 5 products by revenue**

| Product | Revenue |
|---|---|
| Memory Card 128GB | 1,935,138.40 |
| LED Desk Lamp | 1,921,948.41 |
| Mechanical Keyboard | 1,906,963.54 |
| Electric Kettle | 1,905,751.79 |
| Smartwatch | 1,901,275.59 |

**Top 5 categories by revenue**

| Category | Total Revenue |
|---|---|
| Electronics | 15,584,217.18 |
| Sports & Outdoors | 15,345,571.88 |
| Books | 15,261,837.01 |
| Clothing | 15,253,397.50 |
| Toys & Games | 15,216,684.99 |

Revenue is fairly evenly spread across the top categories — Electronics leads, but no
single category dominates.

### 2. Which cities and regions contribute the most sales?

**Top 5 cities**

| City | Revenue |
|---|---|
| Charlotte | 4,747,701.73 |
| Dallas | 4,730,108.67 |
| San Jose | 4,669,614.33 |
| Seattle | 4,660,962.17 |
| Philadelphia | 4,650,673.88 |

**Revenue by country**

| Country | Revenue |
|---|---|
| United States | 64,310,048.50 |
| India | 13,875,839.12 |
| Canada | 5,323,757.00 |
| United Kingdom | 4,526,896.86 |
| Australia | 3,789,106.44 |

The US drives roughly two-thirds of total revenue, making it the core market.

### 3. Who are the best performing sellers?

Sellers are ranked by **% of orders successfully delivered**.

| Seller ID | Delivered % |
|---|---|
| SELL00670 | 95% |
| SELL01917 | 92% |
| SELL01847 | 91% |
| SELL00587 | 91% |
| SELL00527 | 90% |

### 4. How do sales trend by year?

| Year | Total Sales |
|---|---|
| 2024 | 18,166,048.49 |
| 2023 | 18,513,912.19 |
| 2022 | 18,367,248.41 |
| 2021 | 18,248,574.81 |
| 2020 | 18,529,864.02 |

Year-over-year sales are remarkably stable (within ~1.5% of each other), showing no
strong growth or decline trend across the dataset's time span.

### 5. What are the most preferred payment methods?

| Payment Method | Times Used |
|---|---|
| Credit Card | 35,038 |
| Debit Card | 20,024 |
| UPI | 15,066 |
| Amazon Pay | 15,017 |
| Net Banking | 9,927 |
| Cash on Delivery | 4,928 |

Credit Card is the dominant payment method, used almost twice as often as the next
option (Debit Card).

### 6. Which products carry the highest average discount amount?

| Product | Avg. Discount Amount |
|---|---|
| USB-C Charger | 24.66 |
| Memory Card 128GB | 24.46 |
| Noise Cancelling Headphones | 24.29 |
| Power Bank 20000mAh | 23.75 |
| Graphic Tablet | 23.65 |

### 7. Are there seasonal trends in customer purchasing behavior?

Monthly **order volume**, **revenue**, and **Average Order Value (AOV)** were all
compared across the year.

- **No strong seasonal purchasing trend was observed.** Monthly revenue, order volume,
  and AOV remained relatively stable throughout the year.
- **February recorded the lowest revenue (₹6.73M)**, driven by a lower number of orders
  (7,402) — not by a drop in AOV, which stayed consistent with other months (~₹909).
- This indicates any dips in revenue are driven by **order volume**, not by customers
  spending less per order.

*(See `queries.sql` Q7a–Q7c for the month-by-month order count, revenue, and AOV breakdown.)*

## Key Business Insight

**Seller performance and cancellation rate are the operational metrics that most need
active monitoring.** Poor-performing sellers and high cancellation rates directly hurt
revenue, customer satisfaction, and operational efficiency — these should be reviewed
regularly so corrective action can be taken early.

## Repo Structure

```
├── Amazon.csv       # raw dataset
├── queries.sql       # all analysis queries, in order
└── README.md         # this file
```

## How to Reproduce

1. Load `Amazon.csv` into a PostgreSQL table named `amazon_sales`.
2. Run the queries in `queries.sql` in order — each is commented with the business
   question it answers.
