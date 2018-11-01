-- =============================================
-- Create date: <09/06/2015>
-- Description:	<>
-- =============================================
CREATE PROCEDURE [dbo].[spINV_Rpt011] 	
	 @IdEmpresa int,
	 @IdSucursalIni int,
	 @IdSucursalFin int,
	 @IdBodegaIni int,
	 @IdBodegaFin int,
	 @IdProductoIni decimal,
	 @IdProductoFin decimal,
	 @FechaCorteIni datetime
AS
BEGIN

	SET NOCOUNT ON;


	select a.IdSucursal, a.IdBodega, a.IdProducto, max(a.mv_costo) AS Costo_Inicial, max(a.mv_costo) AS Costo_Inicial_Acum
	from in_movi_inve_detalle a INNER JOIN in_movi_inve B ON 
		a.IdEmpresa = b.IdEmpresa
	and a.IdSucursal = b.IdSucursal
	and a.IdBodega = b.IdBodega
	and a.IdMovi_inven_tipo = b.IdMovi_inven_tipo
	and a.IdNumMovi = b.IdNumMovi
	where 
	a.IdEmpresa = @IdEmpresa
	and a.IdSucursal >= @IdSucursalIni and a.IdSucursal <= @IdSucursalFin
	and a.IdBodega >= @IdBodegaIni and a.IdBodega <= @IdBodegaFin
	and a.IdProducto >= @IdProductoIni and a.IdProducto <= @IdProductoFin
	and b.cm_fecha = (select  max(movDet.cm_fecha)
						from in_movi_inve_detalle mov INNER JOIN in_movi_inve movDet ON 
						mov.IdEmpresa = movDet.IdEmpresa
						and mov.IdSucursal = movDet.IdSucursal
						and mov.IdBodega = movDet.IdBodega
						and mov.IdMovi_inven_tipo = movDet.IdMovi_inven_tipo
						and mov.IdNumMovi = movDet.IdNumMovi and movDet.cm_tipo='+'
						where 
						 mov.IdEmpresa = a.IdEmpresa
						and mov.IdSucursal = a.IdSucursal
						and mov.IdBodega = a.IdBodega
						and mov.IdProducto = a.IdProducto
						and movDet.cm_fecha < @FechaCorteIni)
	and b.cm_tipo='+'
	group by a.IdSucursal, a.IdBodega, a.IdProducto

END