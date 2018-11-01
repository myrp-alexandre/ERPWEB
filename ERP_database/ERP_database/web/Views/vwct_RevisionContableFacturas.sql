CREATE VIEW [web].[vwct_RevisionContableFacturas]
AS
SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, ISNULL(dbo.fa_factura_x_ct_cbtecble.ct_IdEmpresa, 0) AS ct_IdEmpresa, 
                         ISNULL(dbo.fa_factura_x_ct_cbtecble.ct_IdTipoCbte, 0) AS ct_IdTipoCbte, ISNULL(dbo.fa_factura_x_ct_cbtecble.ct_IdCbteCble, 0) AS ct_IdCbteCble, dbo.fa_cliente_contactos.Nombres, 
                         dbo.fa_factura.vt_tipoDoc + '-' + dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + dbo.fa_factura.vt_NumFactura AS Referencia, dbo.fa_factura.vt_fecha, ROUND(d.Total, 2) AS TotalModulo, 
                         ISNULL(ROUND(SUM(dbo.ct_cbtecble_det.dc_Valor), 2), 0) AS TotalContabilidad, ROUND(d.Total, 2) - ISNULL(ROUND(SUM(dbo.ct_cbtecble_det.dc_Valor), 2), 0) AS Diferencia
FROM            dbo.fa_factura INNER JOIN
                         dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                         dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto LEFT OUTER JOIN
                         dbo.fa_factura_x_ct_cbtecble ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_x_ct_cbtecble.vt_IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_x_ct_cbtecble.vt_IdSucursal AND 
                         dbo.fa_factura.IdBodega = dbo.fa_factura_x_ct_cbtecble.vt_IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_x_ct_cbtecble.vt_IdCbteVta LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_total) AS Total
                               FROM            dbo.fa_factura_det
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS d ON dbo.fa_factura.IdCbteVta = d.IdCbteVta AND dbo.fa_factura.IdBodega = d.IdBodega AND dbo.fa_factura.IdSucursal = d.IdSucursal AND 
                         dbo.fa_factura.IdEmpresa = d.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_cbtecble_det ON dbo.fa_factura_x_ct_cbtecble.ct_IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.fa_factura_x_ct_cbtecble.ct_IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.fa_factura_x_ct_cbtecble.ct_IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble AND dbo.fa_cliente.IdCtaCble_cxc_Credito = ISNULL(dbo.ct_cbtecble_det.IdCtaCble, dbo.fa_cliente.IdCtaCble_cxc_Credito)
						 where fa_factura.Estado = 'A'
GROUP BY dbo.fa_factura_x_ct_cbtecble.ct_IdEmpresa, dbo.fa_factura_x_ct_cbtecble.ct_IdTipoCbte, dbo.fa_factura_x_ct_cbtecble.ct_IdCbteCble, d.Total, dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, 
                         dbo.fa_factura.IdCbteVta, dbo.fa_cliente_contactos.Nombres, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_fecha