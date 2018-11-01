CREATE VIEW [dbo].[vwFa_Formas_Pago_x_Factura_DeclaracionSRI]
	AS 
	SELECT        A.IdEmpresa, A.IdTipoDocumento, A.pe_cedulaRuc, A.vt_tipoDoc, year(A.vt_fecha) Idanio,month(A.vt_fecha) IdMes, fa_factura_x_formaPago.IdFormaPago
FROM            vwfa_factura AS A INNER JOIN
                         fa_factura_x_formaPago ON A.IdEmpresa = fa_factura_x_formaPago.IdEmpresa AND A.IdSucursal = fa_factura_x_formaPago.IdSucursal AND A.IdBodega = fa_factura_x_formaPago.IdBodega AND 
                         A.IdCbteVta = fa_factura_x_formaPago.IdCbteVta
WHERE        (A.Estado = 'A') AND (LTRIM(RTRIM(A.vt_tipoDoc)) = 'FACT')
group by  A.IdEmpresa, A.IdTipoDocumento, A.pe_cedulaRuc, A.vt_tipoDoc, year(A.vt_fecha) ,month(A.vt_fecha) , fa_factura_x_formaPago.IdFormaPago