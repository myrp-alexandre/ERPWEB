
CREATE VIEW [dbo].[vwcom_dev_compra]
AS
SELECT     com_dc.IdEmpresa, com_dc.IdSucursal, com_dc.IdBodega, com_dc.IdDevCompra, com_dc.IdProveedor, com_dc.Tipo, com_dc.dv_fecha, com_dc.dv_flete, 
                      com_dc.dv_observacion, com_dc.Estado, prov.pr_codigo AS cod_proveedor, per.pe_nombreCompleto AS nom_proveedor, sucu.Su_Descripcion AS nom_sucursal, 
                      bod.bo_Descripcion AS nom_bodega
FROM         dbo.cp_proveedor AS prov INNER JOIN
                      dbo.com_dev_compra AS com_dc ON prov.IdEmpresa = com_dc.IdEmpresa AND prov.IdProveedor = com_dc.IdProveedor INNER JOIN
                      dbo.tb_bodega AS bod INNER JOIN
                      dbo.tb_sucursal AS sucu ON bod.IdEmpresa = sucu.IdEmpresa AND bod.IdSucursal = sucu.IdSucursal ON com_dc.IdEmpresa = bod.IdEmpresa AND 
                      com_dc.IdSucursal = bod.IdSucursal AND com_dc.IdBodega = bod.IdBodega
					  inner join tb_persona as per on prov.IdPersona = per.IdPersona