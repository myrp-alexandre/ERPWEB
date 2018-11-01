CREATE VIEW  vwin_transferencia_det_x_in_Guia_x_traspaso_bodega_det
AS
SELECT        in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdEmpresa_trans, in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdSucursalOrigen_trans, 
                         tb_sucursal.codigo, tb_sucursal.Su_Descripcion, in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdBodegaOrigen_trans, tb_bodega.cod_bodega, 
                         tb_bodega.bo_Descripcion, in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdTransferencia_trans, 
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.Secuencia_trans, in_Producto.IdProducto, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdEmpresa_guia, in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdGuia_guia, 
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.Secuencia_guia
FROM            in_transferencia_det INNER JOIN
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det ON 
                         in_transferencia_det.IdEmpresa = in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdEmpresa_trans AND 
                         in_transferencia_det.IdSucursalOrigen = in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdSucursalOrigen_trans AND 
                         in_transferencia_det.IdBodegaOrigen = in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdBodegaOrigen_trans AND 
                         in_transferencia_det.IdTransferencia = in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdTransferencia_trans AND 
                         in_transferencia_det.dt_secuencia = in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.Secuencia_trans INNER JOIN
                         in_Producto ON in_transferencia_det.IdEmpresa = in_Producto.IdEmpresa AND in_transferencia_det.IdProducto = in_Producto.IdProducto INNER JOIN
                         tb_bodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal ON 
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdEmpresa_trans = tb_bodega.IdEmpresa AND 
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdSucursalOrigen_trans = tb_bodega.IdSucursal AND 
                         in_transferencia_det_x_in_Guia_x_traspaso_bodega_det.IdBodegaOrigen_trans = tb_bodega.IdBodega