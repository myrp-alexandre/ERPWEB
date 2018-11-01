CREATE view [Naturisa].[vwCOMP_NATU_Rpt003]
as
SELECT        dbo.com_ordencompra_local_det.IdEmpresa, dbo.com_ordencompra_local_det.IdSucursal, dbo.com_ordencompra_local_det.IdOrdenCompra, 
                         dbo.com_ordencompra_local_det.Secuencia, dbo.in_Ing_Egr_Inven_det.IdEmpresa AS IdEmpresa_ing, dbo.in_Ing_Egr_Inven_det.IdSucursal AS IdSucursal_ing, 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AS IdMovi_inven_tipo_ing, dbo.in_Ing_Egr_Inven_det.IdNumMovi AS IdNumMovi_ing, 
                         dbo.in_Ing_Egr_Inven_det.Secuencia AS Secuencia_ing, dbo.com_ordencompra_local_det.IdProducto, dbo.com_ordencompra_local_det.do_Cantidad AS cant_oc, 
                         dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion AS cant_ing, CASE WHEN dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion IS NULL 
                         THEN dbo.com_ordencompra_local_det.do_Cantidad ELSE dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion END AS cant, 
                         dbo.com_ordencompra_local_det.do_precioFinal, CASE WHEN dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion IS NULL 
                         THEN dbo.com_ordencompra_local_det.do_Cantidad * dbo.com_ordencompra_local_det.do_precioFinal ELSE dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion
                          * dbo.com_ordencompra_local_det.do_precioFinal END AS total, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.cp_orden_giro.co_factura, 
                         dbo.com_ordencompra_local.oc_fecha, dbo.com_ordencompra_local.Estado, dbo.cp_proveedor.IdProveedor, dbo.cp_proveedor.pr_codigo AS cod_proveedor, 
                         '' AS nom_proveedor, dbo.in_Ing_Egr_Inven.cm_fecha AS fecha_ing, dbo.tb_sucursal.Su_Descripcion
FROM            dbo.in_Ing_Egr_Inven INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi INNER JOIN
                         dbo.tb_sucursal ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                         dbo.cp_Aprobacion_Ing_Bod_x_OC INNER JOIN
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det ON dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdAprobacion = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion INNER JOIN
                         dbo.cp_orden_giro ON dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa_Ogiro = dbo.cp_orden_giro.IdEmpresa AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdCbteCble_Ogiro = dbo.cp_orden_giro.IdCbteCble_Ogiro AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdTipoCbte_Ogiro = dbo.cp_orden_giro.IdTipoCbte_Ogiro ON 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdMovi_inven_tipo_Ing_Egr_Inv AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv RIGHT OUTER JOIN
                         dbo.cp_proveedor INNER JOIN
                         dbo.com_ordencompra_local INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra ON 
                         dbo.cp_proveedor.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND dbo.cp_proveedor.IdProveedor = dbo.com_ordencompra_local.IdProveedor INNER JOIN
                         dbo.in_Producto ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto ON 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia
UNION
SELECT        OC_con_saldo.IdEmpresa, OC_con_saldo.IdSucursal, OC_con_saldo.IdOrdenCompra, OC_con_saldo.Secuencia, NULL AS IdEmpresa_ing, NULL 
                         AS IdSucursal_ing, NULL AS IdMovi_inven_tipo_ing, NULL AS IdNumMovi_ing, NULL AS Secuencia_ing, com_ordencompra_local_det.IdProducto, 
                         com_ordencompra_local_det.do_Cantidad AS cant_oc, NULL AS cant_ing, OC_con_saldo.saldo AS cant, com_ordencompra_local_det.do_precioFinal, 
                         com_ordencompra_local_det.do_precioFinal * OC_con_saldo.saldo AS total, in_Producto.pr_codigo, in_Producto.pr_descripcion, NULL AS co_factura, 
                         com_ordencompra_local.oc_fecha, com_ordencompra_local.Estado, cp_proveedor.IdProveedor, cp_proveedor.pr_codigo AS cod_proveedor, 
                         '' AS nom_proveedor, NULL AS Fecha_ing, NULL AS Su_Descripcion
FROM            dbo.com_ordencompra_local INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = com_ordencompra_local_det.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = com_ordencompra_local_det.IdSucursal AND 
                         dbo.com_ordencompra_local.IdOrdenCompra = com_ordencompra_local_det.IdOrdenCompra INNER JOIN
                             (SELECT        dbo.com_ordencompra_local_det.IdEmpresa, dbo.com_ordencompra_local_det.IdSucursal, dbo.com_ordencompra_local_det.IdOrdenCompra, 
                                                         dbo.com_ordencompra_local_det.Secuencia, dbo.com_ordencompra_local_det.do_Cantidad AS cant_oc, 
                                                         SUM(dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion) AS cant_ing, 
                                                         dbo.com_ordencompra_local_det.do_Cantidad - SUM(dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion) AS saldo
                               FROM            dbo.in_Ing_Egr_Inven_det INNER JOIN
                                                         dbo.com_ordencompra_local_det ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                                                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                                                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                                                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia
                               GROUP BY dbo.com_ordencompra_local_det.IdEmpresa, dbo.com_ordencompra_local_det.IdSucursal, dbo.com_ordencompra_local_det.IdOrdenCompra, 
                                                         dbo.com_ordencompra_local_det.Secuencia, dbo.com_ordencompra_local_det.do_Cantidad
                               HAVING         (dbo.com_ordencompra_local_det.do_Cantidad - SUM(dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion) > 0)) AS OC_con_saldo ON 
                         com_ordencompra_local_det.IdEmpresa = OC_con_saldo.IdEmpresa AND com_ordencompra_local_det.IdSucursal = OC_con_saldo.IdSucursal AND 
                         com_ordencompra_local_det.IdOrdenCompra = OC_con_saldo.IdOrdenCompra AND com_ordencompra_local_det.Secuencia = OC_con_saldo.Secuencia INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.in_Producto ON com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto