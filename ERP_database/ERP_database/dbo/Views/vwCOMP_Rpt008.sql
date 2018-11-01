CREATE view  vwCOMP_Rpt008
as
SELECT        dbo.com_ordencompra_local_det.IdEmpresa, dbo.com_ordencompra_local_det.IdSucursal, dbo.com_ordencompra_local_det.IdOrdenCompra, dbo.com_ordencompra_local_det.Secuencia, 
                         dbo.com_ordencompra_local_det.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.ct_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, 
                         dbo.com_ordencompra_local.oc_fecha, dbo.com_ordencompra_local_det.do_Cantidad, dbo.com_ordencompra_local_det.do_precioCompra, ISNULL(dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.costo, 0) 
                         AS ult_costo, ROUND(dbo.com_ordencompra_local_det.do_precioCompra - ISNULL(dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.costo, 0), 2) AS diferencia
FROM            dbo.com_ordencompra_local INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra INNER JOIN
                         dbo.in_Producto ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto LEFT OUTER JOIN
                         dbo.vwin_producto_Ult_Costo_Hist_x_Sucu ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdSucursal = dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.IdSucursal AND 
                         dbo.com_ordencompra_local_det.IdProducto = dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.IdProducto LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.com_ordencompra_local_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo