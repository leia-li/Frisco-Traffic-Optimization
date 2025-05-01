# Frisco-Traffic-Optimization

## Approach Overview

Diagram of data transformation and loading process:

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


## Troubleshooted Issues:
- setting up mysql connection (uninstall mysql-connector-python -y was needed)
- checking configuration in mysql (ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';
FLUSH PRIVILEGES;)
- original dashboard was using normalized data (from derived layer) which was not scalable for 220M+ rows (developed 3 layers of data transformation)
- original lane metrics were not calculated based on peak period (introduced redundancy)
- original python scripts timing out (added progress logging and updated mysql settings)
- MySQL stored procedures timing out (adopted manual batching approach)
