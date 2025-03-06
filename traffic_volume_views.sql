SELECT
    interval_no_5m,
    SUM(IF(approach IN (58, 59),volume,0)) AS EBLT,
    SUM(IF(approach IN (60, 61, 62),volume,0)) AS EBT,
    SUM(IF(approach IN (64),volume,0)) AS EBRT,
    SUM(IF(approach IN (58,59,60,61,62,64),volume,0)) AS EB_Total,
    SUM(IF(approach IN (42,43),volume,0)) AS WBLT,
    SUM(IF(approach IN (44,45,46),volume,0)) AS WBT,
    SUM(IF(approach IN (48),volume,0)) AS WBRT,
    SUM(IF(approach IN (42,43,44,45,46,48),volume,0)) AS WB_Total,
    SUM(IF(approach IN (50,51),volume,0)) AS NBLT,
    SUM(IF(approach IN (52,53,54),volume,0)) AS NBT,
    SUM(IF(approach IN (56),volume,0)) AS NBRT,
    SUM(IF(approach IN (50,51,52,53,54,56),volume,0)) AS NB_Total,
    SUM(IF(approach IN (34,35),volume,0)) AS SBLT,
    SUM(IF(approach IN (36,37,38),volume,0)) AS SBT,
    SUM(IF(approach IN (40),volume,0)) AS SBRT,
    SUM(IF(approach IN (34,35,36,37,38,40),volume,0)) AS SB_Total,
    SUM(IF(approach IN (58, 59, 60, 61, 62, 64, 40, 38, 37, 36, 35, 34, 48, 46, 45, 44, 43, 42, 56, 54, 53, 52, 51, 50), volume,0)) AS Total_Traffic
FROM may15_signal665_5min
GROUP BY 
    interval_no_5m
ORDER BY interval_no_5m
LIMIT 5;
