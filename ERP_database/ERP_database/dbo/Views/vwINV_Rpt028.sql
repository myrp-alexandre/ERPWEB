CREATE view vwINV_Rpt028
as
SELECT        com_ordencompra_local_det.IdEmpresa, com_ordencompra_local_det.IdSucursal, com_ordencompra_local_det.IdOrdenCompra, 
                         com_ordencompra_local_det.Secuencia, com_ordencompra_local_det.IdProducto, in_Producto.pr_codigo AS cod_prod, in_Producto.pr_descripcion, 
                         com_ordencompra_local.oc_fecha, cp_proveedor.IdProveedor, cp_proveedor.pr_codigo AS cod_provee, pe_nombreCompleto AS nom_provee, 
                         com_ordencompra_local.IdEstadoAprobacion_cat, com_ordencompra_local_det.do_Cantidad, SUM(ISNULL(in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, 0)) 
                         AS dm_cantidad
FROM            com_ordencompra_local INNER JOIN
                         com_ordencompra_local_det ON com_ordencompra_local.IdEmpresa = com_ordencompra_local_det.IdEmpresa AND 
                         com_ordencompra_local.IdSucursal = com_ordencompra_local_det.IdSucursal AND 
                         com_ordencompra_local.IdOrdenCompra = com_ordencompra_local_det.IdOrdenCompra INNER JOIN
                         cp_proveedor ON com_ordencompra_local.IdEmpresa = cp_proveedor.IdEmpresa AND com_ordencompra_local.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                         in_Producto ON com_ordencompra_local_det.IdProducto = in_Producto.IdProducto AND 
                         com_ordencompra_local_det.IdEmpresa = in_Producto.IdEmpresa LEFT OUTER JOIN
                         in_Ing_Egr_Inven_det ON com_ordencompra_local_det.IdEmpresa = in_Ing_Egr_Inven_det.IdEmpresa_oc AND 
                         com_ordencompra_local_det.IdSucursal = in_Ing_Egr_Inven_det.IdSucursal_oc AND 
                         com_ordencompra_local_det.IdOrdenCompra = in_Ing_Egr_Inven_det.IdOrdenCompra AND 
                         com_ordencompra_local_det.Secuencia = in_Ing_Egr_Inven_det.Secuencia_oc
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GROUP BY com_ordencompra_local_det.IdEmpresa, com_ordencompra_local_det.IdSucursal, com_ordencompra_local_det.IdOrdenCompra, 
                         com_ordencompra_local_det.Secuencia, com_ordencompra_local_det.IdProducto, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
                         com_ordencompra_local.oc_fecha, cp_proveedor.IdProveedor, cp_proveedor.pr_codigo, pe_nombreCompleto, com_ordencompra_local.IdEstadoAprobacion_cat, 
                         com_ordencompra_local_det.do_Cantidad