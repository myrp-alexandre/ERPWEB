--EXEC spSys_cp_Actualizar_fecha_vcto_ND_x_proveedor 3,'GISIS',90,1
CREATE PROCEDURE spSys_cp_Actualizar_fecha_vcto_ND_x_proveedor
(
@IdEmpresa INT,
@pr_nombre varchar(50),
@DIAS INT,
@Ejecutar bit
)
AS
BEGIN
DECLARE @IdProveedor numeric
DECLARE @Contador int
/*
IF(@Ejecutar = 0)
	BEGIN
		SELECT * FROM cp_proveedor 
		WHERE pr_nombre like '%'+@pr_nombre+'%' AND IdEmpresa = @IdEmpresa

		SELECT @IdProveedor = IdProveedor FROM cp_proveedor 
		WHERE pr_nombre like '%'+@pr_nombre+'%' AND IdEmpresa = @IdEmpresa

		SELECT * FROM cp_nota_DebCre
		WHERE DebCre = 'D' AND IdEmpresa = @IdEmpresa and IdProveedor = @IdProveedor
	END
ELSE
	BEGIN
		SELECT * FROM cp_proveedor 
		WHERE pr_nombre like '%'+@pr_nombre+'%' AND IdEmpresa = @IdEmpresa

		SELECT @Contador = COUNT(IdEmpresa) FROM cp_proveedor 
		WHERE pr_nombre like '%'+@pr_nombre+'%' AND IdEmpresa = @IdEmpresa		

		SET @Contador = ISNULL(@Contador,0)
		
		IF(@Contador = 1)
			BEGIN
				SELECT @IdProveedor = IdProveedor FROM cp_proveedor 
				WHERE pr_nombre like '%'+@pr_nombre+'%' AND IdEmpresa = @IdEmpresa

				SELECT * FROM cp_nota_DebCre
				WHERE DebCre = 'D' AND IdEmpresa = @IdEmpresa and IdProveedor = @IdProveedor

				update cp_nota_DebCre set cn_Fecha_vcto = DATEADD(DAY,@DIAS,cn_fecha)
				WHERE DebCre = 'D' AND IdEmpresa = @IdEmpresa and IdProveedor = @IdProveedor

				UPDATE cp_proveedor set pr_plazo = @DIAS where IdEmpresa = @IdEmpresa and IdProveedor = @IdProveedor 

				SELECT * FROM cp_nota_DebCre
				WHERE DebCre = 'D' AND IdEmpresa = @IdEmpresa and IdProveedor = @IdProveedor
			END
		ELSE
		IF(@Contador = 0)
			SELECT 'NO EXISTEN COINCIDENCIAS DE PROVEEDORES'
		ELSE
		IF(@Contador > 1)
			SELECT 'EXISTE MAS DE 1 COINCIDENCIA PARA EL PROVEEDOR'
	END
	*/
END