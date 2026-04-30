# Frisco ATSPM Dashboard

Dashboard [link](https://app.powerbi.com/view?r=eyJrIjoiYjQ3MDg2NDYtZmViYS00OWIyLWJhMzItNDllNmRiMTY5MzI1IiwidCI6IjhkMjgxZDFkLTljNGQtNGJmNy1iMTZlLTAzMmQxNWRlOWY2YyIsImMiOjN9) and screenshots:

<img width="1007" alt="Screen Shot 2025-05-01 at 6 32 37 PM" src="https://github.com/user-attachments/assets/456bd6f7-2617-422b-b2c8-4814f3d8bc49" />

<img width="988" alt="Screen Shot 2025-05-01 at 6 32 55 PM" src="https://github.com/user-attachments/assets/3909e4cb-4c90-4c2b-945a-a6daadff6eb6" />

<img width="988" alt="Screen Shot 2025-05-01 at 6 33 04 PM" src="https://github.com/user-attachments/assets/eaf28ccd-8f01-49a0-9aa3-f9cd1a821d2c" />

<img width="988" alt="Screen Shot 2025-05-01 at 6 33 11 PM" src="https://github.com/user-attachments/assets/a7d0abb0-d09a-47cb-b2f0-6881de3560ad" />

# Frisco Traffic Analysis: Interactive Dashboard for Traffic Volume & Metrics

**Hi there! Here is my project contribution in a nutshell:**

In this project completed for The City of Frisco, one of the fastest-growing cities in the nation, I processed and analyzed historical traffic count data to build an interactive Power BI dashboard enabling time series analysis across intersections citywide. My analysis provided value to the city by giving traffic engineers the ability to contextualize traffic trends over time, identify anomalies, and evaluate lane-level performance metrics, which were capabilities the city did not previously have access to. The dashboard was validated by the lead traffic engineer as immediately actionable for city traffic operations.

**If you'd like to dig deeper into my work on this project, feel free to navigate by section:**

- [Executive Summary](#executive-summary)
- [Project Background](#project-background)
- [Approach](#approach)
- [Gathering & Processing Data](#gathering--processing-data)
- [Dashboard Features](#dashboard-features)
- [Findings](#findings)
- [Challenges](#challenges)
- [Learnings](#learnings)

---

## Executive Summary

**Results:**
- Seasonal differences in traffic patterns were confirmed: traffic levels during the school year (April) were found to be lower than summer months (June), with directional and movement-level breakdowns confirming where and when volume shifts occur.
- Lane-level metrics revealed actionable signals, including intersections where lane utilization factors suggest unequal lane usage. For example, one southbound left turn lane being used disproportionately more than the other.
- A top locations view allowed engineers to rank and prioritize intersections by volume, movement type, or approach direction for resource planning.

**Recommendations:**
- Deploy the dashboard for active use by city traffic engineers to monitor intersection performance and inform signal timing or lane configuration decisions.
- Expand the dataset beyond the two-month sample to support more comprehensive trend analysis and seasonal benchmarking across the full year.

---

## Project Background

Within the last decade, Frisco has become one of the fastest-growing cities in the nation. With traffic rising, the city has looked for methods to better understand and manage congestion. However, the city's existing process for reviewing traffic counts relied on static snapshots, where engineers could see point-in-time data but had no way to track how an intersection behaved over time or compare performance across locations.

The goal of this project was to integrate and process historical traffic count data and visualize it in an interactive dashboard that would enable time series analysis, support data-driven traffic management decisions, and give city staff a reliable, self-service tool they could trust.

---

## Approach

I wanted to offer the City of Frisco three core capabilities with this dashboard:

1. **Data Integrity** — Engineers needed to trust that numbers from the dashboard were consistent with numbers elsewhere. To achieve this, I performed validation tests on traffic counts and refined data inputs based on inconsistencies identified during that process.

2. **Time Series Analysis** — The ability to see traffic trends over time, or a Time Series Analysis, to be able to properly contextualize traffic trends and identify anomalies and opportunities for improvement.

3. **Traffic Metrics** — Beyond raw counts, I surfaced lane-level metrics that give engineers a richer picture of how traffic flows:
   - **Lane Utilization Factor (fLU):** How uniformly lanes within a grouping are being used
   - **Peak Hour Factor (PHF):** How uniformly traffic flows within the peak hour
   - **Average Daily Traffic per Approach (ADT):** Total traffic counts for cars flowing into each direction at an intersection

## Gathering & Processing Data
Raw traffic count data was provided in the parquet format. The dataset covered more than 150 intersections across Frisco, with data collected at 1-minute intervals. Here's a diagram of the data transformation and loading process I developed:

<img width="792" alt="image" src="https://github.com/user-attachments/assets/6120c49e-1859-4238-a626-2102686c3d92" />

1. Create a table in MySQL to store raw data loaded from the parquet file.
2. Perform 3 layers of transformation on top of the raw data:
   1. A derived layer that introduces columns for directions, lane groupings, and intervals for later aggregation layers (named derived_atspm)
   2. An aggregation layer that counts traffic volume in 5-minute, 15-minutes, and 60-minute intervals. Created on top of the derived layer (named aggr-5min/aggr-15min/aggr-60min)
   3. Another aggregation layer to calculate traffic metrics within peak periods (named aggr_lane_metrics)
4. Download each resulting table from the transformation as .csv files and upload to OneDrive.
   1. aggr-5min.csv
   2. aggr-15min.csv
   3. aggr-60min.csv
   4. aggr_lane_metrics.csv
6. Connect Power BI dashboard data source to 4 .csv files.

## Data Transformation:
1. Local environment set up
- Download MySQL Workbench, JupyterNotebook, Power BI
- Download MySQL connector
2. Create table in MySQL to store event parameter filter rules (using SQL [here](External_signal_param_rules.ipynb))
3. Download test data for signalid 665, May 15 (using this Python [script](External_ParquetMySQLInsertion.ipynb)) and run steps #3-#6 with the data, checking count consistency with other ATSPM source.
4. Create derived_atspm, aggr-5min, aggr-15min, aggr-60min, and aggr_lane_metrics tables in MySQL (using file [here](External_MySQL_manual_batching.ipynb))
5. Create and run stored procedures to populate 4 tables (using file [here](External_MySQL_manual_batching.ipynb))
6. Validate final csv row counts with MySQL table counts. 
7. Download rest of data (using this Python [script](External_ParquetMySQLInsertion.ipynb) and run steps #3-#6 with rest of data.


## Dashboard Features

The dashboard is organized across multiple views, each designed to answer a different analytical question:

**Day View** allows the user to select a street, intersection, date, and optional peak period to view turning movement volumes, lane metrics, and directional breakdowns for a single day. For example, selecting Preston & Stonebrook/Rolater on June 3 shows that northbound and southbound traffic dominates, with a southbound AM peak at 7am (commuters heading to work) and a northbound PM peak (commuters heading home). The PHF hovers around 0.8 across lanes, and the fLU for southbound left turns suggests unequal lane usage worth investigating.

**Day-of-Week View** allows the user to select a street, intersection, month, and day of week to view the average volume profile for that combination. This view surfaces how a given intersection behaves on a recurring basis and how overall volume, movement type, and direction vary across weeks.

**Month Comparison View** allows the user to compare two months side by side for a selected day type, for example Sundays in April vs. June. This view confirmed that traffic levels during the school year are lower than summer months, with directional and movement-type breakdowns showing where those differences are concentrated.

**Top Locations View** allows the user to compare intersections against each other, ranked by overall volume, movement type (left, right, thru), or approach direction, which enabled engineers to identify the highest-demand locations across the city.

## Findings

- The dashboard surfaced that northbound and southbound through movements account for the dominant share (~80% by approach percentage) of traffic at the analyzed intersections, consistent with Frisco's north-south commuter patterns.
- Seasonal analysis confirmed lower traffic volumes during the school year (April) compared to summer (June), with differences visible across direction, approach, movement type, and traffic metrics.
- PHF values hovering around 0.8 indicate moderately uniform peak hour flow across lanes, a baseline the city can now track over time.
- The fLU metric identified at least one intersection where southbound left turn lanes showed unequal utilization, suggesting potential need for signal timing or lane configuration review.

## Challenges

- **Validating data:** Traffic count data came with domain-specific conventions around movement types, lane groupings, and peak period definitions required alignment with city staff before processing. I learned to ask clarifying questions early and validate outputs against known benchmarks before building visualizations.
- **Ensuring data consistency across sources:** Inconsistencies in raw traffic count inputs required validation testing to identify and resolve before the dashboard could be trusted.
- **Data modeling to enable enriched analysis:** Frisco needed several dimensions to slice the data (date, intersection, direction, movement, lane, peak period), which required several stages of transformations including calculations for lane metrics and aggregations for interval ranges. For data processing speed, I learn about techniques such as indexing and the importance of applying the right filters early on to enable efficient transformations.
- **Designing the dashboard to be user-friendly:** After eliciting requirements from city traffic engineers and IT stakeholders and developing an understanding of how they would need to use the dashboard, I organized views around their analytical questions. As for the visual design itself, I considered how spacing, color, and negative space can come together to let trends shown in graphics pop out to the user. 

## Learnings

- **Data integrity is the foundation of stakeholder trust.** One of the early challenges and important facets of the dashboard was making sure the numbers could be trusted. Running validation tests parallel to data processing saved significant rework and built confidence with the city early.
- **Establishing domain context early is key.** Understanding what PHF, fLU, and ADT per approach mean for a traffic engineer shaped which metrics I surfaced and how I visualized them. Investing time upfront to understand what matters to the users and what domain-"language" they speak allowed the dashboard to resonate. In the final presentation, the lead traffic engineer commented that this dashboard was exactly what he imagined, and that his traffic engineers could immediately start using it. 
- **Design for the question, not the data.** Rather than building one large dashboard, organizing views around specific questions (what happened at this intersection today? how does this intersection behave on a recurring basis? how do months compare?) made the tool more intuitive and actionable for city staff.


## Troubleshooted Issues:
- setting up mysql connection (uninstall mysql-connector-python -y was needed)
- checking configuration in mysql (ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';
FLUSH PRIVILEGES;)
- original dashboard was using normalized data (from derived layer) which was not scalable for 220M+ rows (developed 3 layers of data transformation)
- original lane metrics were not calculated based on peak period (introduced redundancy)
- original python scripts timing out (added progress logging and updated mysql settings)
- MySQL stored procedures timing out (adopted manual batching approach)
