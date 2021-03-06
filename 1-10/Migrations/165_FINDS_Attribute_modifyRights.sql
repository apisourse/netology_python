------------------------------------------------------------------------
-- Grant access to all attributes 
------------------------------------------------------------------------
DECLARE @id_role_admin INT
SELECT @id_role_admin = id_role FROM T_USER_ROLE WHERE name_role = 'Administrator'

DECLARE @id_role_common INT
SELECT @id_role_common = id_role FROM T_USER_ROLE WHERE name_role = 'Common User'

DECLARE @id_attr INT

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- FINDS_PsFinDsNameForMassLoading  
------------------------------------------------------------------------------------------------------------------

SELECT @id_attr = id_infobase FROM InfoBase WHERE object_value = 'FINDS_PsFinDsNameForMassLoading' AND table_name = 'R_FIN_DS'

-- Administrator				
IF EXISTS (SELECT * FROM T_PERMISSION_ACCESS_ATTRIBUTE WHERE idr_user_role =  @id_role_admin and idr_infobase = @id_attr  )
	DELETE FROM  T_PERMISSION_ACCESS_ATTRIBUTE WHERE idr_user_role = @id_role_admin  and idr_infobase = @id_attr


INSERT INTO T_PERMISSION_ACCESS_ATTRIBUTE SELECT @id_role_admin, @id_attr, '1', '0', '0'

-- Common User				
IF EXISTS (SELECT * FROM T_PERMISSION_ACCESS_ATTRIBUTE WHERE idr_user_role = @id_role_common  and idr_infobase = @id_attr  )
	DELETE FROM  T_PERMISSION_ACCESS_ATTRIBUTE WHERE idr_user_role =  @id_role_common and idr_infobase = @id_attr


INSERT INTO T_PERMISSION_ACCESS_ATTRIBUTE SELECT @id_role_common, @id_attr, '1', '0', '0'



