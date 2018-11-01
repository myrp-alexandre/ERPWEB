
CREATE  PROCEDURE [dbo].[spIn_Inventario_Obtener_Stock_A_Fecha]
@Fecha date,
@IdEmpresa int,
@IdSucursal int,
@IdBodega int


AS
BEGIN
			SELECT  a.IdEmpresa,a.IdSucursal, a.IdBodega , b.IdProducto, SUM(b.dm_cantidad) AS Cantidad  
			FROM         dbo.in_movi_inve AS a INNER JOIN
								  dbo.in_movi_inve_detalle AS b ON a.IdEmpresa = b.IdEmpresa
								   AND a.IdSucursal = b.IdSucursal AND a.IdBodega = b.IdBodega
								    AND 
								  a.IdMovi_inven_tipo = b.IdMovi_inven_tipo 
								  AND a.IdNumMovi = b.IdNumMovi
								  where (cm_fecha <= @Fecha)and a.IdEmpresa = @IdEmpresa 
								  and a.IdSucursal = @IdSucursal and a.IdBodega = @IdBodega
			GROUP BY a.IdEmpresa,a.IdSucursal, a.IdBodega ,b.IdProducto

END