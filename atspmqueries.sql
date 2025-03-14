ATSPM queries

-- This has detection types and phase numbers.
WITH MostRecentSignals AS (

    SELECT *

    FROM (

        SELECT 

            s.*,

            ROW_NUMBER() OVER (PARTITION BY s.SignalID ORDER BY s.Start DESC) AS rn

        FROM [MOE].[dbo].[Signals] s

        WHERE s.VersionActionId != 10

        AND s.Start < '2023-10-01'

    ) AS Ranked

    WHERE rn = 1

)

SELECT 

    mrs.*,

    a.ApproachID,

	a.ProtectedPhaseNumber,

	a.PermissivePhaseNumber,

    d.DetectorID,

	m.Abbreviation,

	dir.Abbreviation,

	dt.Description

FROM MostRecentSignals mrs

JOIN Approaches a ON mrs.VersionID = a.VersionID

JOIN DirectionTypes dir on a.DirectionTypeID = dir.DirectionTypeID

JOIN Detectors d ON a.ApproachID = d.ApproachID

JOIN DetectionTypeDetector dtd ON d.ID = dtd.ID

JOIN DetectionTypes dt ON dtd.DetectionTypeID = dt.DetectionTypeID

JOIN MovementTypes m on d.MovementTypeID = m.MovementTypeID

ORDER BY mrs.Start DESC;

 

WITH MostRecentSignals AS (
    SELECT *
    FROM (
        SELECT 
            s.*,
            ROW_NUMBER() OVER (PARTITION BY s.SignalID ORDER BY s.Start DESC) AS rn
        FROM [MOE].[dbo].[Signals] s
        WHERE s.VersionActionId != 10
        AND s.Start < '2023-10-01'
    ) AS Ranked
    WHERE rn = 1
)
SELECT 
    mrs.*,
    a.ApproachID,
    d.DetectorID
FROM MostRecentSignals mrs
JOIN Approaches a ON mrs.VersionID = a.VersionID
JOIN Detectors d ON a.ApproachID = d.ApproachID
ORDER BY mrs.Start DESC;


WITH MostRecentSignals AS (
    SELECT *
    FROM (
        SELECT 
            s.*,
            ROW_NUMBER() OVER (PARTITION BY s.SignalID ORDER BY s.Start DESC) AS rn
        FROM [MOE].[dbo].[Signals] s
        WHERE s.VersionActionId != 10
        AND s.Start < '2023-10-01'
    ) AS Ranked
    WHERE rn = 1
)
SELECT 
    mrs.*,
    a.ApproachID,
    d.DetectorID,
	m.Abbreviation
FROM MostRecentSignals mrs
JOIN Approaches a ON mrs.VersionID = a.VersionID
JOIN Detectors d ON a.ApproachID = d.ApproachID
JOIN MovementTypes m on d.MovementTypeID = m.MovementTypeID
ORDER BY mrs.Start DESC;

WITH MostRecentSignals AS (
    SELECT *
    FROM (
        SELECT 
            s.*,
            ROW_NUMBER() OVER (PARTITION BY s.SignalID ORDER BY s.Start DESC) AS rn
        FROM [MOE].[dbo].[Signals] s
        WHERE s.VersionActionId != 10
        AND s.Start < '2023-10-01'
    ) AS Ranked
    WHERE rn = 1
)
SELECT 
    mrs.*,
    a.ApproachID,
    d.DetectorID,
	m.Abbreviation,
	dir.Abbreviation
FROM MostRecentSignals mrs
JOIN Approaches a ON mrs.VersionID = a.VersionID
JOIN DirectionTypes dir on a.DirectionTypeID = dir.DirectionTypeID
JOIN Detectors d ON a.ApproachID = d.ApproachID
JOIN MovementTypes m on d.MovementTypeID = m.MovementTypeID
ORDER BY mrs.Start DESC;
