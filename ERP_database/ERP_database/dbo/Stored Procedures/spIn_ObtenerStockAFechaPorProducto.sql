
CREATE PROCEDURE [dbo].[spIn_ObtenerStockAFechaPorProducto]
	@IdEmpresa int, 
	@IdBodega Int,
	@IdSucursal int,
	@IdProducto numeric(18,0),
	@Fecha date
AS
BEGIN
	select a.IdEmpresa,a.IdSucursal,a.IdBodega,a.IdProducto,Sum(a.dm_cantidad) as Cantidad from in_movi_inve_detalle a
		inner join in_movi_inve b on a.IdEmpresa = b.IdEmpresa and a.IdSucursal = b.IdSucursal and a.IdBodega = b.IdBodega 
															   and a.IdNumMovi = b.IdNumMovi and a.IdMovi_inven_tipo = b.IdMovi_inven_tipo
		where a.IdEmpresa = @IdEmpresa and a.IdSucursal = @IdSucursal and a.IdBodega =@IdBodega
		and IdProducto = @IdProducto and b.cm_fecha < @Fecha 
		group by a.IdEmpresa,a.IdSucursal,a.IdBodega,a.IdProducto
END