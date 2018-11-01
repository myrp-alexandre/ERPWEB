CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt003]
AS
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY fa_factura.IdEmpresa), 0) AS IdRow, dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, CAST(dbo.fa_factura.vt_NumFactura AS numeric) AS vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.IdCliente, 
                         LTRIM(RTRIM(dbo.tb_persona.pe_nombreCompleto)) AS pe_nombreCompleto, Fj_servindustrias.fa_factura_fj.descripcion_fact vt_Observacion, 						 
						 ISNULL(det.vt_Subtotal, 0) AS vt_Subtotal, ISNULL(det.vt_iva, 0) AS vt_iva, ISNULL(det.vt_total, 0) AS vt_total, 
                         ISNULL(cobr.dc_ValorPago, 0) AS dc_ValorPago, ROUND(ISNULL(det.vt_total, 0) - ISNULL(cobr.dc_ValorPago, 0), 2) AS saldo
FROM            dbo.fa_cliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.fa_factura ON dbo.fa_cliente.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_cliente.IdCliente = dbo.fa_factura.IdCliente LEFT OUTER JOIN
                         Fj_servindustrias.fa_factura_fj ON dbo.fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND dbo.fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND 
                         dbo.fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND dbo.fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta AND dbo.fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND 
                         dbo.fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND dbo.fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, SUM(vt_Subtotal) AS vt_Subtotal, SUM(vt_iva) AS vt_iva, SUM(vt_total) AS vt_total
                               FROM            dbo.fa_factura_det
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS det ON dbo.fa_factura.IdEmpresa = det.IdEmpresa AND det.IdSucursal = dbo.fa_factura.IdSucursal AND dbo.fa_factura.IdBodega = det.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = det.IdCbteVta LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento, SUM(dc_ValorPago) AS dc_ValorPago
                               FROM            dbo.cxc_cobro_det
                               GROUP BY IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento) AS cobr ON dbo.fa_factura.IdEmpresa = cobr.IdEmpresa AND cobr.IdSucursal = dbo.fa_factura.IdSucursal AND 
                         dbo.fa_factura.IdBodega = cobr.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = cobr.IdCbte_vta_nota AND cobr.dc_TipoDocumento = dbo.fa_factura.vt_tipoDoc
WHERE        (dbo.fa_factura.Estado = 'A') AND (ROUND(ISNULL(det.vt_total, 0) - ISNULL(cobr.dc_ValorPago, 0), 2) > 0)