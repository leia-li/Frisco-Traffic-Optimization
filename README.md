# Frisco-Traffic-Optimization

Environment Set Up:
Download MySQL Workbench, JupyterNotebook, Power BI

Validation test (665 May 15):
1. Download test data parquet file (665 May 15)
2. Download test validation file (Excel sheet for 665 May 15)
3. Create database and table in MySQL
4. Load parquet file into MySQL using Python script
5. Validate loading (17XXXX rows for 665 May 15 signal 82)
6. Do calculated view for 5 min intervals

Create database and table in MySQL

Measures in PowerBI:


Edits to make to MySQL queries:
- change lane to "lane grouping"
- import normalized data to Power BI
- add fields for street, intersection (i.e. what will become filters on the overview page)


Issues:
- setting up mysql connection (uninstall mysql-connector-python -y was needed)
- checked configuration in mysql (ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';
FLUSH PRIVILEGES;)
