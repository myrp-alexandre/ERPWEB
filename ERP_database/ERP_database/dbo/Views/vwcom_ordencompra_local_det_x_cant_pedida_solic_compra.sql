
CREATE VIEW [dbo].[vwcom_ordencompra_local_det_x_cant_pedida_solic_compra]
AS
SELECT     OC_det.IdProducto, SUM(OC_det.do_Cantidad) AS do_CantidadPedida_Oc, oc_det_sl_com_det.scd_IdEmpresa, oc_det_sl_com_det.scd_IdSucursal, 
                      oc_det_sl_com_det.scd_IdSolicitudCompra, oc_det_sl_com_det.scd_Secuencia, OC.IdProveedor, OC.IdMotivo
FROM         dbo.com_ordencompra_local AS OC INNER JOIN
                      dbo.com_ordencompra_local_det AS OC_det ON OC.IdEmpresa = OC_det.IdEmpresa AND OC.IdSucursal = OC_det.IdSucursal AND 
                      OC.IdOrdenCompra = OC_det.IdOrdenCompra LEFT OUTER JOIN
                      dbo.com_ordencompra_local_det_x_com_solicitud_compra_det AS oc_det_sl_com_det ON OC_det.IdEmpresa = oc_det_sl_com_det.ocd_IdEmpresa AND 
                      OC_det.IdSucursal = oc_det_sl_com_det.ocd_IdSucursal AND OC_det.IdOrdenCompra = oc_det_sl_com_det.ocd_IdOrdenCompra AND 
                      OC_det.Secuencia = oc_det_sl_com_det.ocd_Secuencia
GROUP BY OC_det.IdProducto, oc_det_sl_com_det.scd_IdEmpresa, oc_det_sl_com_det.scd_IdSucursal, oc_det_sl_com_det.scd_IdSolicitudCompra, 
                      oc_det_sl_com_det.scd_Secuencia, OC.IdProveedor, OC.IdMotivo