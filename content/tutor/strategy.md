---
title: "Exploring Dollar-Cost Averaging with Python"
thumbnailImagePosition: left
thumbnailImage: //d1u9biwaxjngwg.cloudfront.net/cover-image-showcase/city-750.jpg
# coverImage: //d1u9biwaxjngwg.cloudfront.net/cover-image-showcase/city.jpg
metaAlignment: center
coverMeta: out
date: 2021-10-29
lastmod: 2026-09-11
---
*Archive note: This tutorial was written in October 2021. Its dataset, examples, external data-download instructions, and reported results reflect that period.*

# Introduction

Dollar-cost averaging (DCA) means investing a fixed amount at regular intervals, regardless of the asset’s price. This is the definition used by [Investor.gov](https://www.investor.gov/introduction-investing/investing-basics/glossary/dollar-cost-averaging). In this tutorial, we use Python to explore how this approach performed over a historical Bitcoin price sample.

{{< alert warning >}} 
This is a historical coding exercise, not an investment recommendation. The results describe one sample period, not expected future returns.
{{< /alert >}} 

You’ll need basic Python knowledge. We’ll explore the following question:

> What would have happened if I had started buying Bitcoin near its April 2021 peak and continued investing a fixed amount at regular intervals?


<br />

# Download Historical Data

The original exercise used daily Bitcoin prices from [Yahoo Finance](https://finance.yahoo.com/quote/BTC-USD?p=BTC-USD), saved as `BTC-USD.csv`. Prepare a CSV with the columns below. The code assumes one row per calendar day, sorted from oldest to newest, with no missing dates or opening prices.

These are example rows, not the complete dataset:

|Date	| Open	| High	| Low |	Close |	Volume |
|-|-|-|-|-|-|
|2021-04-10	| 58253 |	61276 |	58038 |	59793 |	58238470525 |
|2021-04-11	| 59846 |	60790 |	59289 |	60204 |	46280252580 |


<br />

# Read Data in Python 
Import the libraries:
```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
```

Read the `Date` and `Open` columns into NumPy arrays. We’ll use the opening price as the assumed purchase price throughout this simplified example.

```python
price_keyword = "Open"
date_keyword = "Date"
record_dir = "BTC-USD.csv"
record = pd.read_csv(record_dir)

date = record[date_keyword]
coin_price = record[price_keyword]
dates = date.to_numpy()
coin_prices = coin_price.to_numpy()
```

Plot the prices before calculating results. Keep the dates visible: the sample’s start and end points matter when interpreting a historical result.

The original article included this chart:

![Bitcoin price chart from the original 2021 exercise](https://res.cloudinary.com/eric-kaiyue/image/upload/v1635600944/website/tutor/btc_gl5hme.png)

The code snippet looks like this:
```python
fig = plt.figure(dpi=200, figsize=(10,6))
plt.subplots_adjust(left=0.092, bottom=0.15, right=0.99, top=0.97, wspace=0.1, hspace=0.1)
ax = fig.gca()
plot_step = 1
ax.plot(dates[::plot_step], coin_prices[::plot_step])
ax.tick_params(axis='x', labelrotation=45)
ax.grid()
```

# Simulate Dollar-Cost Averaging

Suppose we invest $100 every 30 days. Each purchase buys more Bitcoin when its price is lower and less when its price is higher. At the end of the sample, we value the accumulated holdings at the final opening price and subtract our total contributions.

This code advances by 30 rows, which represents 30 days only under the daily-data assumptions above. It is not a calendar-month schedule. The example assumes fractional purchases and excludes fees, spreads, and taxes.

```python
invest_period = 30      # period
investment = 100        # periodic investment in dollars
capital = 0
shares = 0

for i in range(0, date.shape[0], invest_period):
    shares += investment/coin_prices[i]
    capital += investment

profit = shares*coin_prices[-1] - capital

print("-"*50)
print("Invest ${:d} every {:.1f} months".format(investment, invest_period/30))
print("Captial: ${:.5f}\t Profit: ${:.5f} Interest Rate {:.3f}".format(capital, profit, profit/capital))
```

The original code and its reported output are preserved below. The output calls the gain-to-contributions ratio an “Interest Rate”; that label is inaccurate. The figures have not been recalculated for this edit, and reproducing them requires the same complete historical dataset.
```
Invest $100 every 1.0 months
Captial: $700.00000	 Profit: $259.25737 Interest Rate 0.370
```

The reported gain was approximately 37% of total contributions. This is not an interest rate or an annualized return, and it does not account for how long each contribution was invested.

# Explore the Assumptions

Try a seven-day interval and inspect what changes. Keeping each purchase at $100 also increases total contributions, so this is not simply a comparison of timing with the same budget.

To make the exercise more informative:

- Compare several start and end dates rather than relying on one favorable period.
- Specify the same total budget and when that money becomes available before comparing purchase schedules.
- Include transaction costs and examine periods when the holdings lose value.
- If you choose a schedule based on one sample, evaluate it on a separate period before drawing conclusions.

The point is to make the assumptions visible through code. A favorable result in one historical window does not establish that a schedule is consistently better.
