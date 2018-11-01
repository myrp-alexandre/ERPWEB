CREATE VIEW [dbo].[vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega_det]
AS
SELECT        OC_det.IdEmpresa, OC_det.IdSucursal, OC_det.IdOrdenCompra, OC_det.Secuencia, OC_det.do_Cantidad, OC_det.do_precioFinal, LTRIM(RTRIM(isnull(OC_det.do_observacion,''))) +' - '+LTRIM(RTRIM(isnull(OC.oc_observacion,''))) 
                         AS co_observacion, OC.oc_fecha, OC.Estado, OC.IdEstadoAprobacion_cat,in_Producto.IdProducto, in_Producto.pr_descripcion as nom_producto, in_Producto.pr_codigo, SUM(ISNULL(GUIA.Cantidad_enviar, 0)) AS Cantidad_enviar, ISNULL(OC_det.do_Cantidad - SUM(ISNULL(GUIA.Cantidad_enviar, 0)),0) AS Saldo_x_Enviar,
						 cp_proveedor.IdProveedor, per.pe_nombreCompleto as nom_proveedor, OC.oc_NumDocumento
FROM            com_ordencompra_local_det AS OC_det INNER JOIN
                         com_ordencompra_local AS OC ON OC_det.IdEmpresa = OC.IdEmpresa AND OC_det.IdSucursal = OC.IdSucursal AND OC_det.IdOrdenCompra = OC.IdOrdenCompra INNER JOIN
                         cp_proveedor ON OC.IdEmpresa = cp_proveedor.IdEmpresa AND OC.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                         in_Producto ON OC_det.IdEmpresa = in_Producto.IdEmpresa AND OC_det.IdProducto = in_Producto.IdProducto LEFT OUTER JOIN
                         in_Guia_x_traspaso_bodega_det AS GUIA ON OC_det.IdEmpresa = GUIA.IdEmpresa_OC AND OC_det.IdSucursal = GUIA.IdSucursal_OC AND OC_det.IdOrdenCompra = GUIA.IdOrdenCompra_OC AND 
                         OC_det.Secuencia = GUIA.Secuencia_OC INNER JOIN tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GROUP BY OC_det.IdEmpresa, OC_det.IdSucursal, OC_det.IdOrdenCompra, OC_det.Secuencia, OC_det.do_Cantidad, OC_det.do_precioFinal, LTRIM(RTRIM(isnull(OC_det.do_observacion,''))) +' - '+LTRIM(RTRIM(isnull(OC.oc_observacion,''))) ,
                          OC.oc_fecha, OC.Estado, OC.IdEstadoAprobacion_cat, in_Producto.IdProducto,in_Producto.pr_descripcion, in_Producto.pr_codigo,cp_proveedor.IdProveedor, per.pe_nombreCompleto ,OC.oc_NumDocumento