# A/B Testing – Website Conversion Analysis

An end-to-end A/B testing project analyzing website conversion performance between a control page and a treatment page.

The project covers data cleaning, exploratory analysis, statistical hypothesis testing, PostgreSQL analysis, and interactive dashboard development.

---

## Project Overview

The objective of this project is to determine whether the treatment landing page produced a statistically significant difference in website conversion compared with the control landing page.

### Experiment

- Control group → `old_page`
- Treatment group → `new_page`
- Final cleaned observations → `290,584`
- Experiment period → January 2–24, 2017
- Statistical test → Two-Proportion Z-Test
- Significance level → α = 0.05

---

## Key Results

| Metric | Control | Treatment |
|---|---:|---:|
| Users | 145,274 | 145,310 |
| Conversions | 17,489 | 17,264 |
| Conversion Rate | 12.04% | 11.88% |

### Observed Difference

**Treatment − Control = -0.16 percentage points**

### Statistical Test

- Z-statistic: **1.311**
- P-value: **0.1899**
- Significance level: **0.05**
- 95% Confidence Interval: **-0.394 pp to +0.078 pp**

The treatment page showed a slightly lower observed conversion rate than the control page, but the difference was not statistically significant at the 5% significance level.

---

## Project Workflow

```text
Raw Dataset
     ↓
Data Cleaning
     ↓
User-Level Deduplication
     ↓
Exploratory Analysis
     ↓
Statistical Hypothesis Testing
     ↓
PostgreSQL Analysis
     ↓
Interactive Dashboard
     ↓
Business Insights
