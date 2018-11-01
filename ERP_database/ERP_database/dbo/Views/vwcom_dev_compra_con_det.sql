
CREATE VIEW [dbo].[vwcom_dev_compra_con_det]
AS
SELECT     com_dc.IdEmpresa, com_dc.IdSucursal, com_dc.IdBodega, com_dc.IdDevCompra, com_dc.IdProveedor, com_dc.Tipo, com_dc.dv_fecha, com_dc.dv_flete, 
                      com_dc.dv_observacion, com_dc.Estado, prov.pr_codigo AS cod_proveedor, per.pe_nombreCompleto AS nom_proveedor, sucu.Su_Descripcion AS nom_sucursal, 
                      bod.bo_Descripcion AS nom_bodega, com_dev_det.Secuencia, com_dev_det.IdProducto, com_dev_det.dv_Cantidad, com_dev_det.dv_precioCompra, 
                      com_dev_det.dv_porc_des, com_dev_det.dv_descuento, com_dev_det.dv_subtotal, com_dev_det.dv_iva, com_dev_det.dv_total, com_dev_det.dv_ManejaIva, 
                      com_dev_det.dv_Costeado, com_dev_det.dv_peso, com_dev_det.dv_observacion AS dvt_observacion, prod.pr_codigo AS cod_producto, 
                      prod.pr_descripcion AS nom_producto, com_dev_det.ocdet_IdEmpresa, com_dev_det.ocdet_IdSucursal, com_dev_det.ocdet_IdOrdenCompra, 
                      com_dev_det.ocdet_Secuencia
FROM         dbo.cp_proveedor AS prov INNER JOIN
                      dbo.com_dev_compra AS com_dc ON prov.IdEmpresa = com_dc.IdEmpresa AND prov.IdProveedor = com_dc.IdProveedor INNER JOIN
                      dbo.tb_bodega AS bod INNER JOIN
                      dbo.tb_sucursal AS sucu ON bod.IdEmpresa = sucu.IdEmpresa AND bod.IdSucursal = sucu.IdSucursal ON com_dc.IdEmpresa = bod.IdEmpresa AND 
                      com_dc.IdSucursal = bod.IdSucursal AND com_dc.IdBodega = bod.IdBodega INNER JOIN
                      dbo.com_dev_compra_det AS com_dev_det ON com_dc.IdEmpresa = com_dev_det.IdEmpresa AND com_dc.IdSucursal = com_dev_det.IdSucursal AND 
                      com_dc.IdBodega = com_dev_det.IdBodega AND com_dc.IdDevCompra = com_dev_det.IdDevCompra INNER JOIN
                      dbo.in_Producto AS prod ON com_dev_det.IdEmpresa = prod.IdEmpresa AND com_dev_det.IdProducto = prod.IdProducto
					  inner join tb_persona as per on per.IdPersona = prov.IdPersona