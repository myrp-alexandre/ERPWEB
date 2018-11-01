
CREATE VIEW [dbo].[vwcom_ordencompra_local_con_cant_devolver]
AS
SELECT     oc.IdEmpresa, oc.IdSucursal, oc.IdOrdenCompra, oc.IdProveedor, oc.oc_fecha, oc.oc_observacion, oc.Estado, sucu.Su_Descripcion, OC_det.Secuencia, 
                      OC_det.IdProducto, OC_det.do_Cantidad, ISNULL(dev_oc.cant_devuelta, 0) AS cant_devuelta, OC_det.do_Cantidad - ISNULL(dev_oc.cant_devuelta, 0) 
                      AS SaldoxDevolver, OC_det.do_precioCompra, OC_det.do_porc_des, OC_det.do_descuento, OC_det.do_subtotal, OC_det.do_iva, OC_det.do_total, 
                       '' pr_nombre,  OC_det.do_observacion,  oc.oc_fechaVencimiento
FROM         dbo.com_ordencompra_local_det AS OC_det INNER JOIN
                      dbo.com_ordencompra_local AS oc ON OC_det.IdEmpresa = oc.IdEmpresa AND OC_det.IdSucursal = oc.IdSucursal AND 
                      OC_det.IdOrdenCompra = oc.IdOrdenCompra INNER JOIN
                      dbo.cp_proveedor AS prove ON oc.IdEmpresa = prove.IdEmpresa AND oc.IdProveedor = prove.IdProveedor INNER JOIN
                      dbo.tb_sucursal AS sucu ON oc.IdEmpresa = sucu.IdEmpresa AND oc.IdSucursal = sucu.IdSucursal LEFT OUTER JOIN
                      dbo.vwcom_dev_compra_det_cant_devuelta_x_prod AS dev_oc ON OC_det.IdEmpresa = dev_oc.ocdet_IdEmpresa AND 
                      OC_det.IdSucursal = dev_oc.ocdet_IdSucursal AND OC_det.IdOrdenCompra = dev_oc.ocdet_IdOrdenCompra AND OC_det.Secuencia = dev_oc.ocdet_Secuencia AND 
                      OC_det.IdProducto = dev_oc.IdProducto
					  inner join tb_persona as per on prove.IdPersona = per.IdPersona
WHERE     (oc.Estado = 'A')