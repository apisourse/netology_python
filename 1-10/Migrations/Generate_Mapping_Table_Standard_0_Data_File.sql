/***************************************************************
					Procedure
****************************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GenMapTabSTD0' AND type = 'P')
   DROP PROCEDURE GenMapTabSTD0
GO

CREATE PROCEDURE [dbo].[GenMapTabSTD0] AS
if exists (select * from sysobjects where id = object_id(N'[dbo].[TMP_MTSTD0_ERROR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMP_MTSTD0_ERROR]
UPDATE R_FIN_CI SET SYSTEM_NAME = NULL WHERE SYSTEM_NAME = ''
UPDATE R_FIN_CI SET HOST_FIN_ID = NULL WHERE HOST_FIN_ID = ''
UPDATE R_FIN_CI SET STDA_SW_RANK = NULL WHERE STDA_SW_RANK = ''
UPDATE R_FIN_CI SET LRU_TYPE_NAME = NULL WHERE LRU_TYPE_NAME = ''
UPDATE R_FIN_CI SET LRU_POSITION = NULL WHERE LRU_POSITION = ''
UPDATE R_FIN_CI SET THW_ID_1 = NULL WHERE THW_ID_1 = ''
UPDATE R_FIN_CI SET IP_ADDRESS_1 = NULL WHERE IP_ADDRESS_1 = ''
UPDATE R_FIN_CI SET THW_ID_2 = NULL WHERE THW_ID_2 = ''
UPDATE R_FIN_CI SET IP_ADDRESS_2 = NULL WHERE IP_ADDRESS_2 = ''
UPDATE R_FIN_CI SET THW_ID_3 = NULL WHERE THW_ID_3 = ''
UPDATE R_FIN_CI SET IP_ADDRESS_3 = NULL WHERE IP_ADDRESS_3 = ''
UPDATE R_FIN_CI SET THW_ID_4 = NULL WHERE THW_ID_4 = ''
UPDATE R_FIN_CI SET IP_ADDRESS_4 = NULL WHERE IP_ADDRESS_4 = ''
UPDATE R_FIN_CI SET STDA_DESIGNATION = NULL WHERE STDA_DESIGNATION = ''
--
-- CONTROLS
--
-- FD NULL
--
SELECT
	CAST(FIN AS VARCHAR(50)) AS FIN,
	CAST('FUNCTIONAL_DESIGNATION' AS VARCHAR(8000)) AS ERROR
INTO
	[dbo].[TMP_MTSTD0_ERROR]
FROM
	R_FIN_CI 
	JOIN R_ATA ON id_ata = idr_ata
	LEFT JOIN
	(
		SELECT
			MAX(FIN) AS HARD,
			idr_fin_link AS id_soft
		FROM
			R_FIN_LINK
			JOIN R_FIN_CI ON id_fin = id_fin_link
		WHERE
			link_type = 'HOST'
		GROUP BY
			idr_fin_link
	) TMP ON id_soft = id_fin
WHERE
	BITEConfReport = 'Yes'
	AND STDA_DESIGNATION IS NULL
	AND FunctionnalDesignation IS NULL
--
-- FD DOUBLE
--
INSERT INTO TMP_MTSTD0_ERROR
(
	FIN,
	ERROR
)
SELECT
	FIN,
	'DOUBLE FUNCTIONAL DESIGNATION'
FROM
	R_FIN_CI
	JOIN
	(
		SELECT
			FUNCTIONAL_DESIGNATION
		FROM
			(			
				SELECT
					id_fin,
					idr_ata,
					BITEConfReport,
					FIN,
					CASE
						WHEN STDA_DESIGNATION IS NOT NULL THEN STDA_DESIGNATION
						ELSE FunctionnalDesignation
					END FUNCTIONAL_DESIGNATION
				FROM
					R_FIN_CI
			) FIN_CI			
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN
			(
				SELECT
					MAX(FIN) AS HARD,
					idr_fin_link AS id_soft
				FROM
					R_FIN_LINK
					JOIN R_FIN_CI ON id_fin = id_fin_link
				WHERE
					link_type = 'HOST'
				GROUP BY
					idr_fin_link
			) TMP ON id_soft = id_fin
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
		GROUP BY
			FUNCTIONAL_DESIGNATION
		HAVING COUNT(*) > 1
	) TMP ON FUNCTIONAL_DESIGNATION = CASE WHEN STDA_DESIGNATION IS NOT NULL THEN STDA_DESIGNATION ELSE FunctionnalDesignation END
--
-- LRU TYPE ID & LRU POS DOUBLE
--
INSERT INTO TMP_MTSTD0_ERROR
(
	FIN,
	ERROR
)
SELECT
	FIN,
	'DOUBLE LRU_TYPE_ID LRU_POSITION'
FROM
	R_FIN_CI
	JOIN
	(
		SELECT
			THW_ID_1,
			LRU_POSITION
		FROM
			R_FIN_CI			
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN
			(
				SELECT
					MAX(FIN) AS HARD,
					idr_fin_link AS id_soft
				FROM
					R_FIN_LINK
					JOIN R_FIN_CI ON id_fin = id_fin_link
				WHERE
					link_type = 'HOST'
				GROUP BY
					idr_fin_link
			) TMP ON id_soft = id_fin
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
		GROUP BY
			THW_ID_1,
			LRU_POSITION
		HAVING
			COUNT(*) > 1
			AND THW_ID_1 IS NOT NULL
			AND LRU_POSITION IS NOT NULL
	) TMP ON TMP.THW_ID_1 = R_FIN_CI.THW_ID_1 AND TMP.LRU_POSITION = R_FIN_CI.LRU_POSITION
--
-- LRU TYPE NAME & LRU POS DOUBLE
--
INSERT INTO TMP_MTSTD0_ERROR
(
	FIN,
	ERROR
)
SELECT
	FIN,
	'DOUBLE LRU_TYPE_NAME LRU_POSITION'
FROM
	R_FIN_CI
	JOIN
	(
		SELECT
			LRU_TYPE_NAME,
			LRU_POSITION
		FROM
			R_FIN_CI			
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN
			(
				SELECT
					MAX(FIN) AS HARD,
					idr_fin_link AS id_soft
				FROM
					R_FIN_LINK
					JOIN R_FIN_CI ON id_fin = id_fin_link
				WHERE
					link_type = 'HOST'
				GROUP BY
					idr_fin_link
			) TMP ON id_soft = id_fin
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
		GROUP BY
			LRU_TYPE_NAME,
			LRU_POSITION
		HAVING
			COUNT(*) > 1
			AND LRU_TYPE_NAME IS NOT NULL
			AND LRU_POSITION IS NOT NULL
	) TMP ON TMP.LRU_TYPE_NAME = R_FIN_CI.LRU_TYPE_NAME AND TMP.LRU_POSITION = R_FIN_CI.LRU_POSITION
--
-- Unexisting HOST FIN ID
--
INSERT INTO TMP_MTSTD0_ERROR
(
	FIN,
	ERROR
)
SELECT
	R_FIN_CI.FIN,
	'Unexisting HOST FIN ID'
FROM
	R_FIN_CI			
	JOIN R_ATA ON id_ata = idr_ata
	LEFT JOIN
	(
		SELECT
			MAX(FIN) AS HARD,
			idr_fin_link AS id_soft
		FROM
			R_FIN_LINK
			JOIN R_FIN_CI ON id_fin = id_fin_link
		WHERE
			link_type = 'HOST'
		GROUP BY
			idr_fin_link
	) TMP ON id_soft = id_fin
	LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
	LEFT JOIN
	(
		SELECT
			R_FIN_CI.FIN
		FROM
			R_FIN_CI			
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN
			(
				SELECT
					MAX(FIN) AS HARD,
					idr_fin_link AS id_soft
				FROM
					R_FIN_LINK
					JOIN R_FIN_CI ON id_fin = id_fin_link
				WHERE
					link_type = 'HOST'
				GROUP BY
					idr_fin_link
			) TMP ON id_soft = id_fin
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
	) HOST ON HOST.FIN = HARD
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD0_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN LIKE '%SW%'
	AND HOST.FIN IS NULL
--
-- SW with HARD data
--
INSERT INTO TMP_MTSTD0_ERROR
(
	FIN,
	ERROR
)
SELECT
	R_FIN_CI.FIN,
	'SW with HARD data'
FROM
	R_FIN_CI			
	JOIN R_ATA ON id_ata = idr_ata
	LEFT JOIN
	(
		SELECT
			MAX(FIN) AS HARD,
			idr_fin_link AS id_soft
		FROM
			R_FIN_LINK
			JOIN R_FIN_CI ON id_fin = id_fin_link
		WHERE
			link_type = 'HOST'
		GROUP BY
			idr_fin_link
	) TMP ON id_soft = id_fin
	LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD0_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN LIKE '%SW%'
	AND
	(
		IP_ADDRESS_1 IS NOT NULL
		OR LRU_TYPE_NAME IS NOT NULL
		OR THW_ID_1 IS NOT NULL
		OR LRU_POSITION IS NOT NULL
	)
--
-- HARD with SW data
--
INSERT INTO TMP_MTSTD0_ERROR
(
	FIN,
	ERROR
)
SELECT
	R_FIN_CI.FIN,
	'HARD with SW data'
FROM
	R_FIN_CI			
	JOIN R_ATA ON id_ata = idr_ata
	LEFT JOIN
	(
		SELECT
			MAX(FIN) AS HARD,
			idr_fin_link AS id_soft
		FROM
			R_FIN_LINK
			JOIN R_FIN_CI ON id_fin = id_fin_link
		WHERE
			link_type = 'HOST'
		GROUP BY
			idr_fin_link
	) TMP ON id_soft = id_fin
	LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD0_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN NOT LIKE '%SW%'
	AND HARD IS NOT NULL
--
-- Generate MT
--
SELECT
	*,
	';'
FROM
	(
		SELECT
			LEFT(R_FIN_CI.FIN, 20) AS FIN,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					STDA_DESIGNATION
				ELSE FunctionnalDesignation
			END + ISNULL(HARD_SUF, ''), 100) AS ACRONYM,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN 'S'
				ELSE 'H'
			END FIN_TYPE,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					STDA_DESIGNATION
				ELSE FunctionnalDesignation
			END + ISNULL(HARD_SUF, ''), 100) AS FUNCTIONAL_DESCRIPTION,
			ATACODE,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN IP_ADDRESS_1 IS NOT NULL THEN LEFT(dbo.FormatIP(IP_ADDRESS_1), 15)
						ELSE '254.254.254.254'
					END
			END IP_ADDRESS,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN LRU_TYPE_NAME IS NOT NULL THEN LEFT(LRU_TYPE_NAME, 15)
						ELSE R_FIN_CI.FIN
					END
			END LRU_TYPE_NAME,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN THW_ID_1 IS NOT NULL THEN LEFT(THW_ID_1, 15)
						ELSE R_FIN_CI.FIN
					END
			END LRU_TYPE_ID,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN LRU_POSITION IS NOT NULL THEN LEFT(LRU_POSITION, 10)
						ELSE
							CASE
								WHEN RIGHT(R_FIN_CI.FIN, 1) >= '0' AND RIGHT(R_FIN_CI.FIN, 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) >= '0' AND LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) <= '9' THEN RIGHT(R_FIN_CI.FIN, 2)
										ELSE RIGHT(R_FIN_CI.FIN, 1)
									END
								ELSE '0'
							END
					END
			END LRU_POSITION,
			LEFT(SYSTEM_NAME, 25) AS SYSTEM_NAME,
			LEFT(HARD, 20) AS [HOST_FIN_ID]
		FROM
			R_FIN_CI 
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN
			(
				SELECT
					CASE
						WHEN MAX(STDA_DESIGNATION) IS NOT NULL THEN
							CASE
								WHEN RIGHT(MAX(STDA_DESIGNATION), 1) >= '0' AND RIGHT(MAX(STDA_DESIGNATION), 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(MAX(STDA_DESIGNATION), 2), 1) >= '0' AND LEFT(RIGHT(MAX(STDA_DESIGNATION), 2), 1) <= '9' THEN RIGHT(MAX(STDA_DESIGNATION), 2)
										ELSE RIGHT(MAX(STDA_DESIGNATION), 1)
									END
								ELSE ''
							END
						ELSE
							CASE
								WHEN RIGHT(MAX(FunctionnalDesignation), 1) >= '0' AND RIGHT(MAX(FunctionnalDesignation), 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(MAX(FunctionnalDesignation), 2), 1) >= '0' AND LEFT(RIGHT(MAX(FunctionnalDesignation), 2), 1) <= '9' THEN RIGHT(MAX(FunctionnalDesignation), 2)
										ELSE RIGHT(MAX(FunctionnalDesignation), 1)
									END
								ELSE ''
							END
					END HARD_SUF,
					MAX(FIN) AS HARD,
					idr_fin_link AS id_soft
				FROM
					R_FIN_LINK
					JOIN R_FIN_CI ON id_fin = id_fin_link
				WHERE
					link_type = 'HOST'
				GROUP BY
					idr_fin_link
			) TMP ON id_soft = id_fin
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
		
		UNION
		
		SELECT
			R_FIN_CI.FIN + '_A' AS FIN,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END + '_A', 100) AS ACRONYM,
			'H' FIN_TYPE,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END, 100) AS FUNCTIONAL_DESCRIPTION,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_1),
			LEFT(LRU_TYPE_NAME, 13) + '_A',
			THW_ID_1 AS LRU_TYPE_ID,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN LRU_POSITION IS NOT NULL THEN LEFT(LRU_POSITION, 10)
						ELSE
							CASE
								WHEN RIGHT(R_FIN_CI.FIN, 1) >= '0' AND RIGHT(R_FIN_CI.FIN, 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) >= '0' AND LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) <= '9' THEN RIGHT(R_FIN_CI.FIN, 2)
										ELSE RIGHT(R_FIN_CI.FIN, 1)
									END
								ELSE '0'
							END
					END
			END LRU_POSITION,
			SYSTEM_NAME,
			'' AS [HOST_FIN_ID]
		FROM
			R_FIN_CI 
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
			AND IP_ADDRESS_2 IS NOT NULL
			AND THW_ID_2 IS NOT NULL
			AND
			(
				IP_ADDRESS_2 <> IP_ADDRESS_1
				OR THW_ID_2 <> THW_ID_1
			)
		
		UNION
		SELECT
			R_FIN_CI.FIN + '_B' AS FIN,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END + '_B', 100) AS ACRONYM,
			'H' FIN_TYPE,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END, 100) AS FUNCTIONAL_DESCRIPTION,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_2),
			LEFT(LRU_TYPE_NAME, 13) + '_B',
			THW_ID_2 AS LRU_TYPE_ID,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN LRU_POSITION IS NOT NULL THEN LEFT(LRU_POSITION, 10)
						ELSE
							CASE
								WHEN RIGHT(R_FIN_CI.FIN, 1) >= '0' AND RIGHT(R_FIN_CI.FIN, 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) >= '0' AND LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) <= '9' THEN RIGHT(R_FIN_CI.FIN, 2)
										ELSE RIGHT(R_FIN_CI.FIN, 1)
									END
								ELSE '0'
							END
					END
			END LRU_POSITION,
			SYSTEM_NAME,
			'' AS [HOST_FIN_ID]
		FROM
			R_FIN_CI 
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
			AND IP_ADDRESS_2 IS NOT NULL
			AND THW_ID_2 IS NOT NULL
			AND
			(
				IP_ADDRESS_2 <> IP_ADDRESS_1
				OR THW_ID_2 <> THW_ID_1
			)
		
		UNION
		SELECT
			R_FIN_CI.FIN + '_C' AS FIN,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END + '_C', 100) AS ACRONYM,
			'H' FIN_TYPE,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END, 100) AS FUNCTIONAL_DESCRIPTION,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_3),
			LEFT(LRU_TYPE_NAME, 13) + '_C',
			THW_ID_3 AS LRU_TYPE_ID,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN LRU_POSITION IS NOT NULL THEN LEFT(LRU_POSITION, 10)
						ELSE
							CASE
								WHEN RIGHT(R_FIN_CI.FIN, 1) >= '0' AND RIGHT(R_FIN_CI.FIN, 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) >= '0' AND LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) <= '9' THEN RIGHT(R_FIN_CI.FIN, 2)
										ELSE RIGHT(R_FIN_CI.FIN, 1)
									END
								ELSE '0'
							END
					END
			END LRU_POSITION,
			SYSTEM_NAME,
			'' AS [HOST_FIN_ID]
		FROM
			R_FIN_CI 
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
			AND IP_ADDRESS_3 IS NOT NULL
			AND THW_ID_3 IS NOT NULL
			AND
			(
				IP_ADDRESS_3 <> IP_ADDRESS_1
				OR THW_ID_3 <> THW_ID_1
			)
		
		UNION
		SELECT
			R_FIN_CI.FIN + '_D' AS FIN,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END + '_D', 100) AS ACRONYM,
			'H' FIN_TYPE,
			LEFT(CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN LEFT(STDA_DESIGNATION, 11)
				ELSE FunctionnalDesignation
			END, 100) AS FUNCTIONAL_DESCRIPTION,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_4),
			LEFT(LRU_TYPE_NAME, 13) + '_D',
			THW_ID_4 AS LRU_TYPE_ID,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN ''
				ELSE
					CASE
						WHEN LRU_POSITION IS NOT NULL THEN LEFT(LRU_POSITION, 10)
						ELSE
							CASE
								WHEN RIGHT(R_FIN_CI.FIN, 1) >= '0' AND RIGHT(R_FIN_CI.FIN, 1) <= '9' THEN
									CASE
										WHEN LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) >= '0' AND LEFT(RIGHT(R_FIN_CI.FIN, 2), 1) <= '9' THEN RIGHT(R_FIN_CI.FIN, 2)
										ELSE RIGHT(R_FIN_CI.FIN, 1)
									END
								ELSE '0'
							END
					END
			END LRU_POSITION,
			SYSTEM_NAME,
			'' AS [HOST_FIN_ID]
		FROM
			R_FIN_CI 
			JOIN R_ATA ON id_ata = idr_ata
			LEFT JOIN TMP_MTSTD0_ERROR ON TMP_MTSTD0_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD0_ERROR.FIN IS NULL
			AND IP_ADDRESS_4 IS NOT NULL
			AND THW_ID_4 IS NOT NULL
			AND
			(
				IP_ADDRESS_4 <> IP_ADDRESS_1
				OR THW_ID_4 <> THW_ID_1
			)
	) TMP
ORDER BY
	FIN_TYPE,
	CASE WHEN ISNUMERIC(LRU_POSITION) = 1 THEN CONVERT(INTEGER, LRU_POSITION) ELSE 0 END,
	FIN

/***************************************************************
					Group report
****************************************************************/
if not exists(SELECT * FROM T_REPORT_GROUP WHERE report_group_label='Others')
begin
	INSERT INTO
		T_REPORT_GROUP (
			report_group_label
		)
	VALUES (
		'Others'
	)
end

/***************************************************************
					Line in T_DBActions
****************************************************************/

DELETE FROM T_DBActions WHERE label='Generate Mapping Table Standard 0 Data File'

INSERT INTO 
	T_dbactions (
		label,
		command,
		comments,
		template_page,
		parameters,
		report_commentary,
		mandatory_fields,
		report_group_idr
	) 
SELECT 
	'Generate Mapping Table Standard 0 Data File',
	'EXECUTE [GenMapTabSTD0]',
	'- Export Mapping Table data file Standard 0',
	NULL,
	NULL,
	NULL,
	NULL,
	report_group_id 
FROM 
	T_REPORT_GROUP 
WHERE 
	report_group_label='Others'
