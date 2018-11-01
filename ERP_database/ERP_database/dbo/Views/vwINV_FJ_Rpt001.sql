
CREATE VIEW [dbo].[vwINV_FJ_Rpt001]
AS
SELECT        0 AS IdOrdenSer_x_Af, '' AS Fecha, '' AS Num_Fact, '' AS Num_Documento, '' AS Observacion, dbo.tb_sucursal.IdEmpresa, dbo.tb_sucursal.IdSucursal, 
                         dbo.tb_bodega.IdBodega, dbo.tb_bodega.bo_Descripcion, dbo.tb_empresa.em_nombre, dbo.tb_sucursal.Su_Descripcion, dbo.Af_Activo_fijo.Af_Nombre, 
                         dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, 0 AS Secuencia, 0 AS IdProducto, 0 AS Cantidad, 0 AS Costo, 0 AS SubTotal, 0 AS Iva, 0 AS Total, 
                         pe_nombreCompleto pr_nombre
FROM            dbo.tb_sucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal INNER JOIN
                         dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.in_Producto ON dbo.tb_bodega.IdEmpresa = dbo.in_Producto.IdEmpresa INNER JOIN
                         dbo.Af_Activo_fijo INNER JOIN
                         dbo.cp_proveedor ON dbo.Af_Activo_fijo.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 0 = dbo.cp_proveedor.IdProveedor ON 
                         dbo.tb_sucursal.IdSucursal = dbo.Af_Activo_fijo.IdSucursal AND dbo.tb_sucursal.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona