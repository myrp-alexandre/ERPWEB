
CREATE VIEW [dbo].[vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega]
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.oc_fecha, OC.oc_observacion, OC.IdEstadoAprobacion_cat, OC.Estado, OC.IdProveedor, per.pe_nombreCompleto AS nom_proveedor, 
                         SUM(OC_det.do_Cantidad) AS do_Cantidad, ISNULL(SUM(GUIA.Cantidad_enviar), 0) AS Cantidad_enviar, SUM(OC_det.do_Cantidad) - ISNULL(SUM(GUIA.Cantidad_enviar), 0) AS Saldo_x_Enviar
FROM            com_ordencompra_local AS OC INNER JOIN
                         com_ordencompra_local_det AS OC_det ON OC.IdEmpresa = OC_det.IdEmpresa AND OC.IdSucursal = OC_det.IdSucursal AND OC.IdOrdenCompra = OC_det.IdOrdenCompra INNER JOIN
                         cp_proveedor ON OC.IdEmpresa = cp_proveedor.IdEmpresa AND OC.IdProveedor = cp_proveedor.IdProveedor LEFT OUTER JOIN
                         in_Guia_x_traspaso_bodega_det AS GUIA ON OC_det.IdEmpresa = GUIA.IdEmpresa_OC AND OC_det.IdSucursal = GUIA.IdSucursal_OC AND OC_det.IdOrdenCompra = GUIA.IdOrdenCompra_OC AND 
                         OC_det.Secuencia = GUIA.Secuencia_OC INNER JOIN tb_persona per on cp_proveedor.IdPersona = per.IdPersona
GROUP BY OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdEstadoAprobacion_cat, OC.oc_fecha, OC.oc_observacion, OC.Estado, OC.IdProveedor,per.pe_nombreCompleto