/***************************************************************
					Procedure
****************************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'GenMapTabSTD2.0' AND type = 'P')
   DROP PROCEDURE [GenMapTabSTD2.0]
GO

CREATE PROCEDURE [dbo].[GenMapTabSTD2.0] AS
if exists (select * from sysobjects where id = object_id(N'[dbo].[TMP_MTSTD2_ERROR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMP_MTSTD2_ERROR]
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
	[dbo].[TMP_MTSTD2_ERROR]
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
INSERT INTO TMP_MTSTD2_ERROR
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD2_ERROR.FIN IS NULL
		GROUP BY
			FUNCTIONAL_DESIGNATION
		HAVING COUNT(*) > 1
	) TMP ON FUNCTIONAL_DESIGNATION = CASE WHEN STDA_DESIGNATION IS NOT NULL THEN STDA_DESIGNATION ELSE FunctionnalDesignation END
--
-- LRU TYPE ID & LRU POS DOUBLE
--
INSERT INTO TMP_MTSTD2_ERROR
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD2_ERROR.FIN IS NULL
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
INSERT INTO TMP_MTSTD2_ERROR
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND TMP_MTSTD2_ERROR.FIN IS NULL
		GROUP BY
			LRU_TYPE_NAME,
			LRU_POSITION
		HAVING
			COUNT(*) > 1
			AND LRU_TYPE_NAME IS NOT NULL
			AND LRU_POSITION IS NOT NULL
	) TMP ON TMP.LRU_TYPE_NAME = R_FIN_CI.LRU_TYPE_NAME AND TMP.LRU_POSITION = R_FIN_CI.LRU_POSITION
--
-- SW with HARD data
--
INSERT INTO TMP_MTSTD2_ERROR
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
	LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD2_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN LIKE '%SW%'
	AND
	(
		IP_ADDRESS_1 IS NOT NULL
		OR LRU_TYPE_NAME IS NOT NULL
		OR THW_ID_1 IS NOT NULL
		OR LRU_POSITION IS NOT NULL
		OR DL_PROTOCOL IS NOT NULL
		OR FIRST_FMC IS NOT NULL
	)
--
-- HARD with SW data
--
INSERT INTO TMP_MTSTD2_ERROR
(
	FIN,
	ERROR
)
SELECT
	R_FIN_CI.FIN,
	'Bad way HARD/SOFT link in SV'
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
	LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD2_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN NOT LIKE '%SW%'
	AND HARD IS NOT NULL
--
-- HARD with incomplete FMC LRUCode
--
INSERT INTO TMP_MTSTD2_ERROR
(
	FIN,
	ERROR
)
SELECT
	R_FIN_CI.FIN,
	'HARD with incomplete FMC LRUCode'
FROM
	R_FIN_CI			
	JOIN R_ATA ON id_ata = idr_ata
	LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD2_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN NOT LIKE '%SW%'
	AND NOT(
			(FIRST_FMC IS NULL AND LEFT(bite_lru_code, 1) IS NULL AND RIGHT(bite_lru_code, 4) IS NULL )
			OR(FIRST_FMC IS NOT NULL AND LEFT(bite_lru_code, 1) IS NOT NULL AND RIGHT(bite_lru_code, 4) IS NOT NULL )
		)
--
-- HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL
--
INSERT INTO TMP_MTSTD2_ERROR
(
	FIN,
	ERROR
)
SELECT
	R_FIN_CI.FIN,
	'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
FROM
	R_FIN_CI			
	JOIN R_ATA ON id_ata = idr_ata
	LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD2_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN NOT LIKE '%SW%'
	AND NOT (
		(IP_ADDRESS_1 IS NULL AND LRU_TYPE_NAME IS NULL AND THW_ID_1 IS NULL AND LRU_POSITION IS NULL AND DL_PROTOCOL IS NULL)
		OR (IP_ADDRESS_1 IS NOT NULL AND LRU_TYPE_NAME IS NOT NULL AND THW_ID_1 IS NOT NULL AND LRU_POSITION IS NOT NULL AND DL_PROTOCOL IS NULL)
	)
--
-- Unexisting HOST FIN ID
--
INSERT INTO TMP_MTSTD2_ERROR
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
	LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND ( --<<<<<<<
				TMP_MTSTD2_ERROR.FIN IS NULL
				OR  ERROR = 'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
				OR  ERROR = 'HARD with incomplete FMC LRUCode'
			)--<<<<<<<
	) HOST ON HOST.FIN = HARD
WHERE
	BITEConfReport = 'Yes'
	AND TMP_MTSTD2_ERROR.FIN IS NULL
	AND R_FIN_CI.FIN LIKE '%SW%'
	AND HOST.FIN IS NULL
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
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN 'S'
				ELSE 'H'
			END FIN_TYPE,
			CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					STDA_DESIGNATION
				ELSE FunctionnalDesignation
			END FUNCTIONAL_DESIGNATION,
			LEFT(STDA_SW_RANK, 2) AS STDA_SW_RANK,
			ATACODE,
			CASE
				WHEN IP_ADDRESS_1 IS NOT NULL AND LRU_TYPE_NAME IS NOT NULL AND THW_ID_1 IS NOT NULL AND LRU_POSITION IS NOT NULL AND DL_PROTOCOL IS NOT NULL
					AND NOT
					(
						IP_ADDRESS_2 IS NOT NULL
						AND THW_ID_2 IS NOT NULL
						AND
						(
							IP_ADDRESS_2 <> IP_ADDRESS_1
							OR THW_ID_2 <> THW_ID_1
						)
					)
				THEN dbo.FormatIP(IP_ADDRESS_1)
				ELSE NULL
			END IP_ADDRESS,
			CASE
				WHEN IP_ADDRESS_1 IS NOT NULL AND LRU_TYPE_NAME IS NOT NULL AND THW_ID_1 IS NOT NULL AND LRU_POSITION IS NOT NULL AND DL_PROTOCOL IS NOT NULL THEN LEFT(LRU_TYPE_NAME, 15)
				ELSE NULL
			END LRU_TYPE_NAME,
			CASE
				WHEN IP_ADDRESS_1 IS NOT NULL AND LRU_TYPE_NAME IS NOT NULL AND THW_ID_1 IS NOT NULL AND LRU_POSITION IS NOT NULL AND DL_PROTOCOL IS NOT NULL
					AND NOT
					(
						IP_ADDRESS_2 IS NOT NULL
						AND THW_ID_2 IS NOT NULL
						AND
						(
							IP_ADDRESS_2 <> IP_ADDRESS_1
							OR THW_ID_2 <> THW_ID_1
						)
					)
				THEN LEFT(THW_ID_1, 15)
				ELSE NULL
			END LRU_TYPE_ID,
			CASE
				WHEN IP_ADDRESS_1 IS NOT NULL AND LRU_TYPE_NAME IS NOT NULL AND THW_ID_1 IS NOT NULL AND LRU_POSITION IS NOT NULL AND DL_PROTOCOL IS NOT NULL THEN LEFT(LRU_POSITION, 10)
				ELSE NULL
			END LRU_POSITION,
			LEFT(SYSTEM_NAME, 25) AS SYSTEM_NAME,
			LEFT(HARD, 20) AS [HOST_FIN_ID],
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN
					CASE
						WHEN FunctionnalDesignation LIKE '%SPP%' AND FunctionnalDesignation LIKE '%SCI%' THEN 1
						ELSE 0
					END
				ELSE NULL
			END SPP,
			CASE
				WHEN IP_ADDRESS_1 IS NOT NULL AND LRU_TYPE_NAME IS NOT NULL AND THW_ID_1 IS NOT NULL AND LRU_POSITION IS NOT NULL AND DL_PROTOCOL IS NOT NULL THEN DL_PROTOCOL
				ELSE ''
			END DL_PROTOCOL,
			CASE
				WHEN ISNULL(ERROR, '') <> 'HARD with incomplete FMC LRUCode' AND R_FIN_CI.FIN NOT LIKE '%SW%' THEN LEFT(bite_lru_code, 1)
				ELSE ''
			END LRU_DECOD_KEY,
			CASE
				WHEN ISNULL(ERROR, '') <> 'HARD with incomplete FMC LRUCode' AND R_FIN_CI.FIN NOT LIKE '%SW%' THEN RIGHT(bite_lru_code, 4)
				ELSE ''
			END LRU_CODE,
			CASE
				WHEN ISNULL(ERROR, '') <> 'HARD with incomplete FMC LRUCode' AND R_FIN_CI.FIN NOT LIKE '%SW%' THEN CONVERT(VARCHAR, FIRST_FMC)
				ELSE ''
			END FIRST_FMC			
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND
			(
				TMP_MTSTD2_ERROR.FIN IS NULL
				OR  ERROR = 'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
				OR  ERROR = 'HARD with incomplete FMC LRUCode'
			)
		UNION
		
		SELECT
			R_FIN_CI.FIN + '_A' AS FIN,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN 'S'
				ELSE 'H'
			END FIN_TYPE,
			CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					CASE
						WHEN R_FIN_CI.FIN LIKE '%SW%' THEN LEFT(STDA_DESIGNATION, 13)
						ELSE LEFT(STDA_DESIGNATION, 19)
					END
				ELSE FunctionnalDesignation
			END + '_A' FUNCTIONAL_DESIGNATION,
			STDA_SW_RANK,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_1),
			LEFT(LRU_TYPE_NAME, 13) + '_A',
			THW_ID_1 AS LRU_TYPE_ID,
			LRU_POSITION,
			SYSTEM_NAME,
			R_FIN_CI.FIN AS [HOST_FIN_ID],
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN
					CASE
						WHEN FunctionnalDesignation LIKE '%SPP%' AND FunctionnalDesignation LIKE '%SCI%' THEN 1
						ELSE 0
					END
				ELSE NULL
			END SPP,
			DL_PROTOCOL,
			'' AS LRU_DECOD_KEY,
			'' AS LRU_CODE,
			'' AS FIRST_FMC
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND
			(
				TMP_MTSTD2_ERROR.FIN IS NULL
				OR  ERROR = 'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
				OR  ERROR = 'HARD with incomplete FMC LRUCode'
			)
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
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN 'S'
				ELSE 'H'
			END FIN_TYPE,
			CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					CASE
						WHEN R_FIN_CI.FIN LIKE '%SW%' THEN LEFT(STDA_DESIGNATION, 13)
						ELSE LEFT(STDA_DESIGNATION, 19)
					END
				ELSE FunctionnalDesignation
			END + '_B' FUNCTIONAL_DESIGNATION,
			STDA_SW_RANK,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_2),
			LEFT(LRU_TYPE_NAME, 13) + '_B',
			THW_ID_2 AS LRU_TYPE_ID,
			LRU_POSITION,
			SYSTEM_NAME,
			R_FIN_CI.FIN AS [HOST_FIN_ID],
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN
					CASE
						WHEN FunctionnalDesignation LIKE '%SPP%' AND FunctionnalDesignation LIKE '%SCI%' THEN 1
						ELSE 0
					END
				ELSE NULL
			END SPP,
			DL_PROTOCOL,
			'' AS LRU_DECOD_KEY,
			'' AS LRU_CODE,
			'' AS FIRST_FMC
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND
			(
				TMP_MTSTD2_ERROR.FIN IS NULL
				OR  ERROR = 'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
				OR  ERROR = 'HARD with incomplete FMC LRUCode'
			)
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
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN 'S'
				ELSE 'H'
			END FIN_TYPE,
			CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					CASE
						WHEN R_FIN_CI.FIN LIKE '%SW%' THEN LEFT(STDA_DESIGNATION, 13)
						ELSE LEFT(STDA_DESIGNATION, 19)
					END
				ELSE FunctionnalDesignation
			END + '_C' FUNCTIONAL_DESIGNATION,
			STDA_SW_RANK,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_3),
			LEFT(LRU_TYPE_NAME, 13) + '_C',
			THW_ID_3 AS LRU_TYPE_ID,
			LRU_POSITION,
			SYSTEM_NAME,
			R_FIN_CI.FIN AS [HOST_FIN_ID],
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN
					CASE
						WHEN FunctionnalDesignation LIKE '%SPP%' AND FunctionnalDesignation LIKE '%SCI%' THEN 1
						ELSE 0
					END
				ELSE NULL
			END SPP,
			DL_PROTOCOL,
			'' AS LRU_DECOD_KEY,
			'' AS LRU_CODE,
			'' AS FIRST_FMC
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND
			(
				TMP_MTSTD2_ERROR.FIN IS NULL
				OR  ERROR = 'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
				OR  ERROR = 'HARD with incomplete FMC LRUCode'
			)
			AND IP_ADDRESS_2 IS NOT NULL
			AND THW_ID_2 IS NOT NULL
			AND IP_ADDRESS_3 IS NOT NULL
			AND THW_ID_3 IS NOT NULL
		
		UNION
		
		SELECT
			R_FIN_CI.FIN + '_D' AS FIN,
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN 'S'
				ELSE 'H'
			END FIN_TYPE,
			CASE
				WHEN STDA_DESIGNATION IS NOT NULL THEN
					CASE
						WHEN R_FIN_CI.FIN LIKE '%SW%' THEN LEFT(STDA_DESIGNATION, 13)
						ELSE LEFT(STDA_DESIGNATION, 19)
					END
				ELSE FunctionnalDesignation
			END + '_D' FUNCTIONAL_DESIGNATION,
			STDA_SW_RANK,
			ATACODE,
			dbo.FormatIP(IP_ADDRESS_4),
			LEFT(LRU_TYPE_NAME, 13) + '_D',
			THW_ID_4 AS LRU_TYPE_ID,
			LRU_POSITION,
			SYSTEM_NAME,
			R_FIN_CI.FIN AS [HOST_FIN_ID],
			CASE
				WHEN R_FIN_CI.FIN LIKE '%SW%' THEN
					CASE
						WHEN FunctionnalDesignation LIKE '%SPP%' AND FunctionnalDesignation LIKE '%SCI%' THEN 1
						ELSE 0
					END
				ELSE NULL
			END SPP,
			DL_PROTOCOL,
			'' AS LRU_DECOD_KEY,
			'' AS LRU_CODE,
			'' AS FIRST_FMC
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
			LEFT JOIN TMP_MTSTD2_ERROR ON TMP_MTSTD2_ERROR.FIN = R_FIN_CI.FIN
		WHERE
			BITEConfReport = 'Yes'
			AND
			(
				TMP_MTSTD2_ERROR.FIN IS NULL
				OR  ERROR = 'HARD with incomplete IP_ADDRESS_1 LRU_TYPE_NAME THW_ID_1 LRU_POSITION DL_PROTOCOL'
				OR  ERROR = 'HARD with incomplete FMC LRUCode'
			)
			AND IP_ADDRESS_2 IS NOT NULL
			AND THW_ID_2 IS NOT NULL
			AND IP_ADDRESS_3 IS NOT NULL
			AND THW_ID_3 IS NOT NULL
			AND IP_ADDRESS_4 IS NOT NULL
			AND THW_ID_4 IS NOT NULL
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

DELETE FROM T_DBActions WHERE label='Generate Mapping Table Standard 2 Data File'

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
	'Generate Mapping Table Standard 2 Data File',
	'EXECUTE [GenMapTabSTD2.0]',
	'- Export Mapping Table data file Standard 2',
	NULL,
	NULL,
	NULL,
	NULL,
	report_group_id 
FROM 
	T_REPORT_GROUP 
WHERE 
	report_group_label='Others'
