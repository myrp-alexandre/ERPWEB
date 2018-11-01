--EXEC [dbo].[spSys_inv_correccion_producto_oc_ing_apro] 1,1,307,'LLA-121','LLA-067',1
CREATE PROCEDURE [dbo].[spSys_inv_correccion_producto_oc_ing_apro]
(
@i_IdEmpresa int,
@i_IdSucursal int,
@i_IdOrdenCompra numeric,
@i_cod_producto varchar(20),
@i_cod_producto_reemplazo varchar(20),
@i_ejecutar bit
)
AS
BEGIN

delete in_spSys_inv_correccion_producto_oc_ing_apro_det_ing_egr
delete in_spSys_inv_correccion_producto_oc_ing_apro_det_movi
delete in_spSys_inv_correccion_producto_oc_ing_apro_det_oc

DECLARE @IdProducto numeric
DECLARE @IdProducto_reemplazo numeric

DECLARE @Contador int
SELECT @Contador = count(IdEmpresa) 
FROM in_producto WHERE IdEmpresa = @i_IdEmpresa and pr_codigo = @i_cod_producto_reemplazo
SET @Contador = ISNULL(@Contador,0)
IF(@Contador = 0) 
BEGIN
	PRINT 'EL PRODUCTO DE REEMPLAZO NO EXISTE'
	RETURN
END
SELECT @Contador = count(IdEmpresa) 
FROM in_producto WHERE IdEmpresa = @i_IdEmpresa and pr_codigo = @i_cod_producto
SET @Contador = ISNULL(@Contador,0)
IF(@Contador = 0) 
BEGIN
	PRINT 'EL PRODUCTO NO EXISTE'
	RETURN
END

SELECT @IdProducto_reemplazo = IdProducto
FROM in_producto WHERE IdEmpresa = @i_IdEmpresa and pr_codigo = @i_cod_producto_reemplazo

SELECT @IdProducto = IdProducto
FROM in_producto WHERE IdEmpresa = @i_IdEmpresa and pr_codigo = @i_cod_producto

INSERT INTO [dbo].[in_spSys_inv_correccion_producto_oc_ing_apro_det_oc]
			([IdEmpresa]           ,[IdSucursal]           ,[IdOrdenCompra]           ,[Secuencia])
		SELECT IdEmpresa,			IdSucursal,				IdOrdenCompra,				Secuencia 
		FROM com_ordencompra_local_det where IdEmpresa = @i_IdEmpresa and IdSucursal = @i_IdSucursal and IdOrdenCompra = @i_IdOrdenCompra and IdProducto = @IdProducto

		INSERT INTO [dbo].[in_spSys_inv_correccion_producto_oc_ing_apro_det_ing_egr]
           ([IdEmpresa]           ,[IdSucursal]           ,[IdMovi_inven_tipo]           ,[IdNumMovi]           ,[Secuencia])
		 SELECT IdEmpresa,		IdSucursal,				IdMovi_inven_tipo,				IdNumMovi,				Secuencia 
		 FROM in_Ing_Egr_Inven_det WHERE exists(
		 select * from [in_spSys_inv_correccion_producto_oc_ing_apro_det_oc] ap
		 where in_Ing_Egr_Inven_det.IdEmpresa_oc = ap.IdEmpresa and in_Ing_Egr_Inven_det.IdSucursal_oc = ap.IdSucursal and in_Ing_Egr_Inven_det.IdOrdenCompra = ap.IdOrdenCompra
		 and in_Ing_Egr_Inven_det.Secuencia_oc = ap.Secuencia
		 )

		 INSERT INTO [dbo].[in_spSys_inv_correccion_producto_oc_ing_apro_det_movi]
           ([IdEmpresa]           ,[IdSucursal]         ,[IdBodega]		  ,[IdMovi_inven_tipo]           ,[IdNumMovi]           ,[Secuencia])
		 SELECT IdEmpresa_inv,		IdSucursal_inv,		IdBodega_inv,		IdMovi_inven_tipo_inv,				IdNumMovi_inv,				secuencia_inv 
		 FROM in_Ing_Egr_Inven_det WHERE exists(
		 select * from [in_spSys_inv_correccion_producto_oc_ing_apro_det_oc] ap
		 where in_Ing_Egr_Inven_det.IdEmpresa_oc = ap.IdEmpresa and in_Ing_Egr_Inven_det.IdSucursal_oc = ap.IdSucursal and in_Ing_Egr_Inven_det.IdOrdenCompra = ap.IdOrdenCompra
		 and in_Ing_Egr_Inven_det.Secuencia_oc = ap.Secuencia
		 ) and in_Ing_Egr_Inven_det.IdEmpresa_inv is not null

IF(@i_ejecutar = 1)
	BEGIN
		

		 UPDATE com_ordencompra_local_det set IdProducto = @IdProducto_reemplazo
		 WHERE EXISTS(
		 SELECT * FROM in_spSys_inv_correccion_producto_oc_ing_apro_det_oc ap
		 where com_ordencompra_local_det.IdEmpresa = ap.IdEmpresa
		 and com_ordencompra_local_det.IdSucursal = ap.IdSucursal
		 and com_ordencompra_local_det.IdOrdenCompra = ap.IdOrdenCompra
		 and com_ordencompra_local_det.Secuencia = ap.Secuencia
		 )

		 UPDATE in_Ing_Egr_Inven_det set IdProducto = @IdProducto_reemplazo
		 WHERE EXISTS(
		 SELECT * FROM in_spSys_inv_correccion_producto_oc_ing_apro_det_ing_egr ap
		 where in_Ing_Egr_Inven_det.IdEmpresa = ap.IdEmpresa
		 and in_Ing_Egr_Inven_det.IdSucursal = ap.IdSucursal
		 and in_Ing_Egr_Inven_det.IdMovi_inven_tipo = ap.IdMovi_inven_tipo
		 and in_Ing_Egr_Inven_det.IdNumMovi = ap.IdNumMovi
		 and in_Ing_Egr_Inven_det.Secuencia = ap.Secuencia
		 )

		 UPDATE in_movi_inve_detalle set IdProducto = @IdProducto_reemplazo
		 WHERE EXISTS(
		 SELECT * FROM in_spSys_inv_correccion_producto_oc_ing_apro_det_movi ap
		 where in_movi_inve_detalle.IdEmpresa = ap.IdEmpresa
		 and in_movi_inve_detalle.IdSucursal = ap.IdSucursal
		 and in_movi_inve_detalle.IdBodega = ap.IdBodega
		 and in_movi_inve_detalle.IdMovi_inven_tipo = ap.IdMovi_inven_tipo
		 and in_movi_inve_detalle.IdNumMovi = ap.IdNumMovi
		 and in_movi_inve_detalle.Secuencia = ap.Secuencia
		 )
		 
	END
ELSE
begin
	select * from in_spSys_inv_correccion_producto_oc_ing_apro_det_ing_egr
	select * from in_spSys_inv_correccion_producto_oc_ing_apro_det_movi
	select * from in_spSys_inv_correccion_producto_oc_ing_apro_det_oc
	SELECT * FROM in_Producto where IdEmpresa = @i_IdEmpresa and IdProducto = @IdProducto
	SELECT * FROM in_Producto where IdEmpresa = @i_IdEmpresa and IdProducto = @IdProducto_reemplazo
end
END