CREATE PROCEDURE [dbo].[spINV_FJ_Rpt002] 	
	 @IdEmpresa int,
	 @IdSucursalIni int,
	 @IdSucursalFin int,
	 @IdBodegaIni int,
	 @IdBodegaFin int,
	 @IdProductoIni decimal,
	 @IdProductoFin decimal,
	 @FechaCorteIni datetime,
	 @IdCentro_costo varchar(20),
	 @IdSubCentro_costo varchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	select a.IdSucursal, a.IdBodega, a.IdProducto, sum(a.dm_cantidad) AS Saldo_x_Fecha, sum(a.dm_cantidad) AS Saldo_x_Fecha_Acum
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
	and isnull(a.IdCentroCosto,'') like '%'+@IdCentro_costo+'%'
	and isnull(a.IdCentroCosto_sub_centro_costo,'') like '%'+@IdSubCentro_costo+'%'
	and b.cm_fecha < @FechaCorteIni
	group by a.IdSucursal, a.IdBodega, a.IdProducto


END