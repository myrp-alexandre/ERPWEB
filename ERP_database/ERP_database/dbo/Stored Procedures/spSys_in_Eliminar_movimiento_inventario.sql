--EXEC [dbo].[spSys_in_Eliminar_movimiento_inventario] 1,11,2,33,0
CREATE PROCEDURE [dbo].[spSys_in_Eliminar_movimiento_inventario]
(
@IdEmpresa int,
@IdSucursal int,
@IdMoviInven_tipo int,
@IdNumMovi numeric,
@Borrar bit
)
AS
BEGIN
/*
set @IdEmpresa = 1
set @IdSucursal = 2
set @IdMoviInven_tipo = 5
set @IdNumMovi = 1
set @Borrar = 1
*/
--Variables para movimiento de inventario	
DECLARE @IdEmpresa_inv int
DECLARE @IdSucursal_inv int
DECLARE @IdBodega_inv int
DECLARE @IdMoviInven_tipo_inv int
DECLARE @IdNumMovi_inv numeric


--Variables para comprobante contable
DECLARE @IdEmpresa_cbte int
DECLARE @IdTipoCbte_cbte int
DECLARE @IdCbteCble_cbte numeric

DECLARE @Contador int

select @Contador = count(*) from in_Ing_Egr_Inven_det where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi
IF(@Contador > 0)
	BEGIN
		--Obtengo ID del movimiento de inventario
		select @IdEmpresa_inv = IdEmpresa_inv, @IdSucursal_inv = IdSucursal_inv,@IdBodega_inv = IdBodega_inv, @IdMoviInven_tipo_inv = IdMovi_inven_tipo_inv, @IdNumMovi_inv = IdNumMovi_inv from in_Ing_Egr_Inven_det where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi		
		IF(@IdEmpresa_inv is not null)
			BEGIN
				--Obtengo ID del comprobante contable
				select @IdEmpresa_cbte = IdEmpresa_ct, @IdTipoCbte_cbte = IdTipoCbte, @IdCbteCble_cbte = IdCbteCble from in_movi_inve_x_ct_cbteCble where IdEmpresa = @IdEmpresa_inv and IdBodega = @IdBodega_inv and IdSucursal = @IdSucursal_inv and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv				
			END	
		
		IF(@Borrar = 0)
			BEGIN
				select * from cp_Aprobacion_Ing_Bod_x_OC_det WHERE IdEmpresa_Ing_Egr_Inv = @IdEmpresa and IdSucursal_Ing_Egr_Inv = @IdSucursal and IdMovi_inven_tipo_Ing_Egr_Inv = @IdMoviInven_tipo and IdNumMovi_Ing_Egr_Inv = @IdNumMovi
				select * from in_Ing_Egr_Inven_det where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi
				select * from in_Ing_Egr_Inven where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi
				select * from in_movi_inve_x_ct_cbteCble where IdEmpresa = @IdEmpresa_inv and IdSucursal = @IdSucursal_inv and IdBodega = @IdBodega_inv and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv
				select * from in_movi_inve_detalle_x_ct_cbtecble_det where IdEmpresa_inv = @IdEmpresa_inv and IdSucursal_inv = @IdSucursal_inv and IdBodega_inv = @IdBodega_inv and IdMovi_inven_tipo_inv = @IdMoviInven_tipo_inv and IdNumMovi_inv = @IdNumMovi_inv
				select * from ct_cbtecble_det where @IdEmpresa_cbte = IdEmpresa and IdTipoCbte = @IdTipoCbte_cbte and IdCbteCble = @IdCbteCble_cbte
				select * from ct_cbtecble where @IdEmpresa_cbte = IdEmpresa and IdTipoCbte = @IdTipoCbte_cbte and IdCbteCble = @IdCbteCble_cbte
				select * from in_movi_inve_detalle where IdEmpresa = @IdEmpresa_inv and IdSucursal = @IdSucursal_inv and @IdBodega_inv = IdBodega and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv
				select * from in_movi_inve where IdEmpresa = @IdEmpresa_inv and IdSucursal = @IdSucursal_inv and @IdBodega_inv = IdBodega and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv								
			END		
		IF(@Borrar = 1)
			BEGIN
				
				DELETE cp_Aprobacion_Ing_Bod_x_OC_det WHERE IdEmpresa_Ing_Egr_Inv = @IdEmpresa and IdSucursal_Ing_Egr_Inv = @IdSucursal and IdMovi_inven_tipo_Ing_Egr_Inv = @IdMoviInven_tipo and IdNumMovi_Ing_Egr_Inv = @IdNumMovi
				UPDATE in_Ing_Egr_Inven_det set IdEmpresa_inv = null, IdSucursal_inv = null, IdMovi_inven_tipo_inv = null, IdNumMovi_inv = null where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi
				DELETE in_Ing_Egr_Inven_det where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi
				DELETE in_Ing_Egr_Inven where IdEmpresa = @IdEmpresa and IdSucursal = @IdSucursal and IdMovi_inven_tipo = @IdMoviInven_tipo and IdNumMovi = @IdNumMovi
								
				DELETE in_movi_inve_x_ct_cbteCble where IdEmpresa = @IdEmpresa_inv and IdSucursal = @IdSucursal_inv and @IdBodega_inv = IdBodega and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv
				DELETE in_movi_inve_detalle_x_ct_cbtecble_det where IdEmpresa_inv = @IdEmpresa_inv and IdSucursal_inv = @IdSucursal_inv and IdBodega_inv = @IdBodega_inv and IdMovi_inven_tipo_inv = @IdMoviInven_tipo_inv and IdNumMovi_inv = @IdNumMovi_inv

				DELETE ct_cbtecble_det where @IdEmpresa_cbte = IdEmpresa and IdTipoCbte = @IdTipoCbte_cbte and IdCbteCble = @IdCbteCble_cbte
				DELETE ct_cbtecble where @IdEmpresa_cbte = IdEmpresa and IdTipoCbte = @IdTipoCbte_cbte and IdCbteCble = @IdCbteCble_cbte

				DELETE in_movi_inve_detalle where IdEmpresa = @IdEmpresa_inv and IdSucursal = @IdSucursal_inv and IdBodega = @IdBodega_inv and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv
				DELETE in_movi_inve where IdEmpresa = @IdEmpresa_inv and IdSucursal = @IdSucursal_inv and IdBodega = @IdBodega_inv and IdMovi_inven_tipo = @IdMoviInven_tipo_inv and IdNumMovi = @IdNumMovi_inv								
			END			
	END
	ELSE
		BEGIN
		SELECT 'NO EXISTE EL MOVIMIENTO DE INVENTARIO SELECCIONADO'
		END

END