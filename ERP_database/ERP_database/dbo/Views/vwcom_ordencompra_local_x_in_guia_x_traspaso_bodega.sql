CREATE VIEW [dbo].[vwcom_ordencompra_local_x_in_guia_x_traspaso_bodega]
as
SELECT        in_Guia_x_traspaso_bodega.IdEmpresa, in_Guia_x_traspaso_bodega.IdGuia, in_Guia_x_traspaso_bodega.IdSucursal_Partida, tb_sucursal.Su_Descripcion, 
                         in_Guia_x_traspaso_bodega.IdSucursal_Llegada, tb_sucursal_1.Su_Descripcion AS Su_Descripcion_Llegada, in_Guia_x_traspaso_bodega_det.IdEmpresa_OC, 
                         in_Guia_x_traspaso_bodega_det.IdSucursal_OC, in_Guia_x_traspaso_bodega_det.IdOrdenCompra_OC, in_Guia_x_traspaso_bodega.Fecha
FROM            in_Guia_x_traspaso_bodega_det INNER JOIN
                         in_Guia_x_traspaso_bodega ON in_Guia_x_traspaso_bodega_det.IdEmpresa = in_Guia_x_traspaso_bodega.IdEmpresa AND 
                         in_Guia_x_traspaso_bodega_det.IdGuia = in_Guia_x_traspaso_bodega.IdGuia INNER JOIN
                         tb_sucursal ON in_Guia_x_traspaso_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND 
                         in_Guia_x_traspaso_bodega.IdSucursal_Partida = tb_sucursal.IdSucursal INNER JOIN
                         tb_sucursal AS tb_sucursal_1 ON in_Guia_x_traspaso_bodega.IdEmpresa = tb_sucursal_1.IdEmpresa AND 
                         in_Guia_x_traspaso_bodega.IdSucursal_Llegada = tb_sucursal_1.IdSucursal
GROUP BY in_Guia_x_traspaso_bodega.IdEmpresa, in_Guia_x_traspaso_bodega.IdGuia, in_Guia_x_traspaso_bodega.IdSucursal_Partida, tb_sucursal.Su_Descripcion, 
                         in_Guia_x_traspaso_bodega_det.IdEmpresa_OC, in_Guia_x_traspaso_bodega_det.IdSucursal_OC, in_Guia_x_traspaso_bodega_det.IdOrdenCompra_OC, 
                         in_Guia_x_traspaso_bodega.IdSucursal_Llegada, tb_sucursal_1.Su_Descripcion, in_Guia_x_traspaso_bodega.Fecha