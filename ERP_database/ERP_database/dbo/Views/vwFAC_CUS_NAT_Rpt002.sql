CREATE VIEW [dbo].[vwFAC_CUS_NAT_Rpt002] AS
SELECT fac_det.IdEmpresa, fac_det.IdSucursal, fac_det.IdBodega, fac_det.IdCbteVta, fac_det.Secuencia, 
                         fac_det.IdProducto, fac_det.vt_cantidad, fac_det.vt_Precio, fac_det.vt_PorDescUnitario, 
                         fac_det.vt_DescUnitario, fac_det.vt_PrecioFinal, fac_det.vt_Subtotal, fac_det.vt_iva, fac_det.vt_total, 
                         fac_det.vt_estado, fac_det.vt_detallexItems, dbo.in_Producto.pr_codigo, 
                         dbo.in_Producto.pr_descripcion,
						 fac.vt_tipoDoc, fac.vt_serie1, fac.vt_serie2, fac.vt_NumFactura, fac.IdCliente, fac.IdVendedor, 
                         fac.vt_fecha, fac.vt_plazo, fac.vt_fech_venc, fac.vt_tipo_venta, fac.vt_Observacion, fac.IdPeriodo,
						  dbo.tb_sucursal.Su_Descripcion, 
                         dbo.tb_bodega.bo_Descripcion, dbo.fa_Vendedor.Ve_Vendedor, 
                         dbo.tb_persona.pe_nombreCompleto, fac.vt_autorizacion, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, fac.IdCaja, 
						  dbo.fa_motivo_venta.IdMotivo_Vta,  dbo.fa_motivo_venta.descripcion_motivo_vta
 
FROM fa_factura fac INNER JOIN 
	 fa_factura_det fac_det ON fac.IdEmpresa = fac_det.IdEmpresa AND fac.IdSucursal = fac_det.IdSucursal AND 
	 fac.IdBodega = fac_det.IdBodega AND fac.IdCbteVta = fac_det.IdCbteVta INNER JOIN 
	 fa_cliente cli ON fac.IdEmpresa = CLI.IdEmpresa AND fac.IdCliente = CLI.IdCliente INNER JOIN
     dbo.in_Producto ON fac_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND fac_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
     dbo.tb_sucursal ON fac.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND fac.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
     dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal AND 
     fac.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
     dbo.fa_Vendedor ON fac.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND fac.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
     dbo.tb_persona ON cli.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN 
	 dbo.fa_motivo_venta ON dbo.fa_motivo_venta.IdEmpresa = dbo.in_Producto.IdEmpresa