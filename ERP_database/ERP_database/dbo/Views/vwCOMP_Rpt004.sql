
CREATE VIEW [dbo].[vwCOMP_Rpt004]
AS
SELECT        dbo.com_ordencompra_local.IdEmpresa, dbo.com_ordencompra_local.IdSucursal, dbo.com_ordencompra_local.IdOrdenCompra, 
                         dbo.com_ordencompra_local.oc_NumDocumento AS documento, dbo.com_ordencompra_local.oc_fecha, dbo.com_ordencompra_local.oc_observacion, 
                         dbo.com_comprador.IdComprador, dbo.com_comprador.Descripcion AS nom_comprador, dbo.cp_proveedor.IdProveedor, 
                         pe_nombreCompleto AS nom_proveedor, dbo.com_ordencompra_local.IdEstadoAprobacion_cat, dbo.com_Motivo_Orden_Compra.IdMotivo, 
                         dbo.com_Motivo_Orden_Compra.Descripcion AS Nom_motivo_oc, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         dbo.com_ordencompra_local_det.do_Cantidad, dbo.com_ordencompra_local_det.do_precioCompra AS precio, dbo.com_ordencompra_local_det.do_subtotal, 
                         dbo.com_ordencompra_local_det.do_iva, dbo.com_ordencompra_local_det.do_total, dbo.ct_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, 
                         dbo.ct_centro_costo.IdCentroCosto, dbo.ct_centro_costo.Centro_costo, dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS sub_centro_costo
FROM            dbo.ct_punto_cargo RIGHT OUTER JOIN
                         dbo.in_Producto INNER JOIN
                         dbo.com_ordencompra_local INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra ON 
                         dbo.in_Producto.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Producto.IdProducto = dbo.com_ordencompra_local_det.IdProducto INNER JOIN
                         dbo.tb_sucursal INNER JOIN
                         dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa ON dbo.com_ordencompra_local.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.com_comprador ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_comprador.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_Motivo_Orden_Compra ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdMotivo = dbo.com_Motivo_Orden_Compra.IdMotivo ON 
                         dbo.ct_punto_cargo.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.ct_punto_cargo.IdPunto_cargo = dbo.com_ordencompra_local_det.IdPunto_cargo LEFT OUTER JOIN
                         dbo.ct_centro_costo RIGHT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_centro_costo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto ON 
                         dbo.com_ordencompra_local_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.com_ordencompra_local_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
						 inner join tb_persona as per on  cp_proveedor.IdPersona = per.IdPersona