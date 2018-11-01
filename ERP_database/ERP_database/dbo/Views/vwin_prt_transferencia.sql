
CREATE VIEW [dbo].[vwin_prt_transferencia]
AS
SELECT        dbo.vwin_producto_x_tb_bodega.pr_descripcion, dbo.vwin_producto_x_tb_bodega.pr_codigo, dbo.in_transferencia_det.dt_cantidad, 
                         dbo.vwin_producto_x_tb_bodega.pr_stock, dbo.vwin_producto_x_tb_bodega.bo_Descripcion, dbo.vwin_producto_x_tb_bodega.Su_Descripcion, 
                         dbo.in_transferencia.IdTransferencia, dbo.in_transferencia.IdEmpresa, dbo.in_transferencia.IdSucursalOrigen, dbo.in_transferencia.IdBodegaOrigen, 
                         dbo.in_transferencia_det.IdProducto, dbo.tb_sucursal.Su_Descripcion AS SucursalDestino, dbo.tb_bodega.bo_Descripcion AS BodegaDestinno, 
                         dbo.tb_sucursal.IdEmpresa AS Expr1, dbo.tb_empresa.em_nombre, dbo.tb_empresa.em_logo, dbo.tb_empresa.em_direccion, dbo.tb_empresa.em_telefonos, 
                         dbo.vwin_producto_x_tb_bodega.IdCtaCble_Inventario, dbo.vwin_producto_x_tb_bodega.IdCentro_Costo_Inventario, 
                         dbo.vwin_producto_x_tb_bodega.IdCentro_Costo_Costo, dbo.vwin_producto_x_tb_bodega.IdCtaCble_Gasto_x_cxp, 
                         dbo.vwin_producto_x_tb_bodega.IdCentroCosto_x_Gasto_x_cxp, dbo.vwin_producto_x_tb_bodega.IdCentroCosto_sub_centro_costo_inv, 
                         dbo.vwin_producto_x_tb_bodega.IdCentroCosto_sub_centro_costo_cost, dbo.vwin_producto_x_tb_bodega.IdCentroCosto_sub_centro_costo_cxp, 
                         dbo.vwin_producto_x_tb_bodega.IdCtaCble_Inven, dbo.vwin_producto_x_tb_bodega.IdCtaCble_Costo, dbo.vwin_producto_x_tb_bodega.IdCtaCble_CosBaseIva, 
                         dbo.vwin_producto_x_tb_bodega.IdCtaCble_CosBase0, dbo.vwin_producto_x_tb_bodega.IdCtaCble_VenIva, dbo.vwin_producto_x_tb_bodega.IdCtaCble_Ven0, 
                         dbo.vwin_producto_x_tb_bodega.IdCtaCble_DesIva, dbo.vwin_producto_x_tb_bodega.IdCtaCble_Des0, dbo.vwin_producto_x_tb_bodega.IdCtaCble_DevIva, 
                         dbo.vwin_producto_x_tb_bodega.IdCtaCble_Dev0, dbo.vwin_producto_x_tb_bodega.IdCtaCble_Vta
FROM            dbo.tb_sucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal INNER JOIN
                         dbo.vwin_producto_x_tb_bodega INNER JOIN
                         dbo.in_transferencia_det ON dbo.vwin_producto_x_tb_bodega.IdEmpresa = dbo.in_transferencia_det.IdEmpresa AND 
                         dbo.vwin_producto_x_tb_bodega.IdProducto = dbo.in_transferencia_det.IdProducto AND 
                         dbo.vwin_producto_x_tb_bodega.IdBodega = dbo.in_transferencia_det.IdBodegaOrigen AND 
                         dbo.vwin_producto_x_tb_bodega.IdSucursal = dbo.in_transferencia_det.IdSucursalOrigen INNER JOIN
                         dbo.in_transferencia ON dbo.in_transferencia_det.IdEmpresa = dbo.in_transferencia.IdEmpresa AND 
                         dbo.in_transferencia_det.IdSucursalOrigen = dbo.in_transferencia.IdSucursalOrigen AND 
                         dbo.in_transferencia_det.IdBodegaOrigen = dbo.in_transferencia.IdBodegaOrigen AND 
                         dbo.in_transferencia_det.IdTransferencia = dbo.in_transferencia.IdTransferencia ON dbo.tb_bodega.IdSucursal = dbo.in_transferencia.IdSucursalDest AND 
                         dbo.tb_bodega.IdBodega = dbo.in_transferencia.IdBodegaDest AND dbo.tb_bodega.IdEmpresa = dbo.in_transferencia.IdEmpresa INNER JOIN
                         dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa
