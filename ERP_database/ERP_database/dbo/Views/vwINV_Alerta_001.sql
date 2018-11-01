CREATE VIEW [dbo].[vwINV_Alerta_001]
AS
SELECT A.IdEmpresa, A.IdSucursal, dbo.tb_sucursal.Su_Descripcion, A.IdProducto, A.pr_codigo, A.pr_descripcion, A.pr_stock_minimo, MAX(A.stock_inventario) AS stock_inventario, MAX(A.stock_pendiente_ingreso) AS stock_pendiente_ingreso, 
                  MAX(A.stock_solicitud_sin_aprobacion) AS stock_solicitud_sin_aprobacion, CASE WHEN (A.pr_stock_minimo >= (MAX(A.stock_inventario) + MAX(A.stock_pendiente_ingreso))) THEN 'ALERTA' ELSE '' END AS ESTADO_ALERTA
FROM     (

SELECT dbo.in_Producto.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto_alerta_x_sucursal.pr_stock_minimo, 
                  SUM(dbo.in_movi_inve_detalle.dm_cantidad) AS stock_inventario, 0 AS stock_pendiente_ingreso, 0 AS stock_solicitud_sin_aprobacion, 'INVENTARIO' AS Origen
FROM     dbo.in_Producto INNER JOIN
                  dbo.in_Producto_alerta_x_sucursal ON dbo.in_Producto.IdEmpresa = dbo.in_Producto_alerta_x_sucursal.IdEmpresa AND dbo.in_Producto.IdProducto = dbo.in_Producto_alerta_x_sucursal.IdProducto INNER JOIN
                  dbo.in_movi_inve_detalle ON dbo.in_Producto_alerta_x_sucursal.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_Producto_alerta_x_sucursal.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND 
                  dbo.in_Producto_alerta_x_sucursal.IdProducto = dbo.in_movi_inve_detalle.IdProducto
WHERE  (dbo.in_Producto.Estado = 'A')
GROUP BY dbo.in_Producto.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto_alerta_x_sucursal.pr_stock_minimo
                  UNION
                  SELECT dbo.in_Producto.IdEmpresa, dbo.com_ordencompra_local_det.IdSucursal, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto_alerta_x_sucursal.pr_stock_minimo, 
                  0 AS stock_inventario, SUM(dbo.com_ordencompra_local_det.do_Cantidad) AS stock_pendiente_ingreso, 0 AS stock_solicitud_sin_aprobacion, 'COMPRA' AS Expr1
FROM     dbo.in_Producto_alerta_x_sucursal INNER JOIN
                  dbo.in_Producto ON dbo.in_Producto_alerta_x_sucursal.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Producto_alerta_x_sucursal.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                  dbo.com_ordencompra_local INNER JOIN
                  dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                  dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra ON dbo.in_Producto_alerta_x_sucursal.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                  dbo.in_Producto_alerta_x_sucursal.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND dbo.in_Producto_alerta_x_sucursal.IdProducto = dbo.com_ordencompra_local_det.IdProducto
WHERE  (dbo.in_Producto.Estado = 'A') AND (dbo.com_ordencompra_local.Estado = 'A') AND (NOT EXISTS
                      (SELECT IdEmpresa
                       FROM      dbo.in_Ing_Egr_Inven_det AS det
                       WHERE   (IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa) AND (IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal) AND (dbo.com_ordencompra_local_det.IdOrdenCompra = IdOrdenCompra) AND 
                                         (dbo.com_ordencompra_local_det.Secuencia = Secuencia_oc)))
GROUP BY dbo.in_Producto.IdEmpresa, dbo.com_ordencompra_local_det.IdSucursal, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto_alerta_x_sucursal.pr_stock_minimo
                  UNION
                  SELECT dbo.in_Producto.IdEmpresa, dbo.com_solicitud_compra_det.IdSucursal, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto_alerta_x_sucursal.pr_stock_minimo, 
                  0 AS stock_inventario, 0 AS stock_pendiente_ingreso, SUM(dbo.com_solicitud_compra_det.do_Cantidad) AS stock_solicitud_sin_aprobacion, 'SOLICITUD' AS Expr1
FROM     dbo.in_Producto_alerta_x_sucursal INNER JOIN
                  dbo.in_Producto ON dbo.in_Producto_alerta_x_sucursal.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Producto_alerta_x_sucursal.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                  dbo.com_solicitud_compra_det_pre_aprobacion INNER JOIN
                  dbo.com_solicitud_compra_det ON dbo.com_solicitud_compra_det_pre_aprobacion.IdEmpresa = dbo.com_solicitud_compra_det.IdEmpresa AND 
                  dbo.com_solicitud_compra_det_pre_aprobacion.IdSucursal_SC = dbo.com_solicitud_compra_det.IdSucursal AND 
                  dbo.com_solicitud_compra_det_pre_aprobacion.IdSolicitudCompra = dbo.com_solicitud_compra_det.IdSolicitudCompra AND 
                  dbo.com_solicitud_compra_det_pre_aprobacion.Secuencia_SC = dbo.com_solicitud_compra_det.Secuencia INNER JOIN
                  dbo.com_solicitud_compra_det_aprobacion ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.com_solicitud_compra_det_aprobacion.IdEmpresa AND 
                  dbo.com_solicitud_compra_det.IdSucursal = dbo.com_solicitud_compra_det_aprobacion.IdSucursal_SC AND dbo.com_solicitud_compra_det.IdSolicitudCompra = dbo.com_solicitud_compra_det_aprobacion.IdSolicitudCompra AND 
                  dbo.com_solicitud_compra_det.Secuencia = dbo.com_solicitud_compra_det_aprobacion.Secuencia_SC ON dbo.in_Producto_alerta_x_sucursal.IdEmpresa = dbo.com_solicitud_compra_det.IdEmpresa AND 
                  dbo.in_Producto_alerta_x_sucursal.IdSucursal = dbo.com_solicitud_compra_det.IdSucursal AND dbo.in_Producto_alerta_x_sucursal.IdProducto = dbo.com_solicitud_compra_det.IdProducto
WHERE  (dbo.in_Producto.Estado = 'A') AND (dbo.com_solicitud_compra_det_aprobacion.IdEstadoAprobacion = 'PEN_SOL') AND (dbo.com_solicitud_compra_det_pre_aprobacion.IdEstadoAprobacion = 'APR_SOL') AND 
                  (dbo.in_Producto_alerta_x_sucursal.se_controla_stock_minimo = 1)
GROUP BY dbo.in_Producto.IdEmpresa, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto_alerta_x_sucursal.pr_stock_minimo, dbo.com_solicitud_compra_det.IdSucursal) AS A INNER JOIN
                  dbo.tb_sucursal ON dbo.tb_sucursal.IdEmpresa = A.IdEmpresa AND dbo.tb_sucursal.IdSucursal = A.IdSucursal
GROUP BY A.IdEmpresa, A.IdSucursal, dbo.tb_sucursal.Su_Descripcion, A.IdProducto, A.pr_codigo, A.pr_descripcion, A.pr_stock_minimo