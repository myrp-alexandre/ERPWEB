CREATE view [web].[vwfa_factura]
as
SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_cliente_contactos.Nombres, 
                         dbo.fa_Vendedor.Ve_Vendedor, det.vt_Subtotal0, det.vt_SubtotalIVA, det.vt_iva, det.vt_total, dbo.fa_factura.Estado, dbo.fa_factura.esta_impresa, 
                         dbo.fa_factura_x_in_Ing_Egr_Inven.IdEmpresa_in_eg_x_inv, dbo.fa_factura_x_in_Ing_Egr_Inven.IdSucursal_in_eg_x_inv, dbo.fa_factura_x_in_Ing_Egr_Inven.IdMovi_inven_tipo_in_eg_x_inv, 
                         dbo.fa_factura_x_in_Ing_Egr_Inven.IdNumMovi_in_eg_x_inv
FROM            dbo.fa_factura INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_Subtotal0) AS vt_Subtotal0, SUM(vt_SubtotalIVA) AS vt_SubtotalIVA, SUM(vt_iva) AS vt_iva, SUM(vt_total) AS vt_total
                               FROM            (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, CASE WHEN vt_por_iva = 0 THEN vt_Subtotal ELSE 0 END AS vt_Subtotal0, CASE WHEN vt_por_iva > 0 THEN vt_Subtotal ELSE 0 END AS vt_SubtotalIVA, 
                                                                                   vt_iva, vt_total
                                                         FROM            dbo.fa_factura_det) AS A
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS det ON dbo.fa_factura.IdCbteVta = det.IdCbteVta AND dbo.fa_factura.IdBodega = det.IdBodega AND dbo.fa_factura.IdSucursal = det.IdSucursal AND 
                         dbo.fa_factura.IdEmpresa = det.IdEmpresa LEFT OUTER JOIN
                         dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                         dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto LEFT OUTER JOIN
                         dbo.fa_factura_x_in_Ing_Egr_Inven ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_x_in_Ing_Egr_Inven.IdEmpresa_fa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_x_in_Ing_Egr_Inven.IdSucursal_fa AND 
                         dbo.fa_factura.IdBodega = dbo.fa_factura_x_in_Ing_Egr_Inven.IdBodega_fa AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_x_in_Ing_Egr_Inven.IdCbteVta_fa