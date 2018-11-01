

/*select * from tb_sis_reporte*/
CREATE VIEW [dbo].[vwCOMP_NATU_Rpt004]
AS
SELECT        dbo.com_ordencompra_local.IdEmpresa, dbo.com_ordencompra_local.IdSucursal, dbo.com_ordencompra_local.IdOrdenCompra, 
                         dbo.com_ordencompra_local.IdProveedor,  dbo.com_ordencompra_local.IdTerminoPago, 
                         dbo.com_ordencompra_local.oc_plazo AS Plazo, dbo.com_ordencompra_local.oc_fecha AS Fecha_oc, 
                         dbo.com_ordencompra_local.oc_observacion AS Observacion_oc, dbo.com_ordencompra_local.Estado,  
                         dbo.com_ordencompra_local_det.do_total AS Total, '' AS nom_proveedor, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         dbo.com_ordencompra_local_det.IdProducto, dbo.com_ordencompra_local_det.do_Cantidad AS Cantidad, 
                         dbo.com_ordencompra_local_det.do_precioCompra AS Precio, dbo.com_ordencompra_local_det.do_subtotal AS Subtotal, 
                         dbo.com_ordencompra_local_det.do_iva AS Iva, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         dbo.com_ordencompra_local_det.do_observacion, dbo.com_TerminoPago.Descripcion AS Termino_pago
FROM            dbo.com_ordencompra_local INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_sucursal ON dbo.com_ordencompra_local.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Producto ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.com_TerminoPago ON dbo.com_ordencompra_local.IdTerminoPago = dbo.com_TerminoPago.IdTerminoPago