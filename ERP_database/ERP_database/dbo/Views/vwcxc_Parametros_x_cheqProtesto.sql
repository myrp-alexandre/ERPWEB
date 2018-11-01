
CREATE VIEW [dbo].[vwcxc_Parametros_x_cheqProtesto]
as
SELECT     A.IdEmpresa, A.secuencia, A.pa_IdSucursal_x_default_x_cheqProtes, A.pa_IdBodega_x_default_x_cheqProtes, A.pa_IdProducto_x_ND_x_CheqProtes, 
                      A.pa_IdProducto_x_NC_x_Cobro, S.Su_Descripcion, B.bo_Descripcion, PND.IdProducto, PND.pr_descripcion AS ProductoND, PNC.pr_descripcion AS ProductoNC
FROM         dbo.cxc_Parametros_x_cheqProtesto AS A 
INNER JOIN dbo.tb_sucursal AS S ON A.IdEmpresa = S.IdEmpresa AND a.pa_IdSucursal_x_default_x_cheqProtes=S.IdSucursal 
INNER JOIN dbo.tb_bodega AS B ON  A.pa_IdSucursal_x_default_x_cheqProtes = B.IdSucursal AND 
                      A.pa_IdBodega_x_default_x_cheqProtes = B.IdBodega AND S.IdEmpresa = B.IdEmpresa AND S.IdSucursal = B.IdSucursal 
INNER JOIN dbo.vwin_producto_x_tb_bodega AS PND ON A.IdEmpresa = PND.IdEmpresa AND A.pa_IdBodega_x_default_x_cheqProtes = PND.IdBodega AND 
                      A.pa_IdProducto_x_ND_x_CheqProtes = PND.IdProducto 
INNER JOIN dbo.vwin_producto_x_tb_bodega AS PNC ON A.IdEmpresa = PNC.IdEmpresa AND A.pa_IdBodega_x_default_x_cheqProtes = PNC.IdBodega AND 
                      A.pa_IdProducto_x_NC_x_Cobro = PNC.IdProducto
                      GROUP BY  A.IdEmpresa, A.secuencia, A.pa_IdSucursal_x_default_x_cheqProtes, A.pa_IdBodega_x_default_x_cheqProtes, A.pa_IdProducto_x_ND_x_CheqProtes, 
                      A.pa_IdProducto_x_NC_x_Cobro, S.Su_Descripcion, B.bo_Descripcion, PND.IdProducto, PND.pr_descripcion, PNC.pr_descripcion
