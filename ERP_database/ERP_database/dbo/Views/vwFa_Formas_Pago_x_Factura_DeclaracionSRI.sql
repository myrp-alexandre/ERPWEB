CREATE VIEW [dbo].[vwFa_Formas_Pago_x_Factura_DeclaracionSRI]
	AS 
	SELECT        A.IdEmpresa, p.IdTipoDocumento, p.pe_cedulaRuc, A.vt_tipoDoc, year(A.vt_fecha) Idanio,month(A.vt_fecha) IdMes, fa_cliente.FormaPago IdFormaPago
FROM            fa_factura AS A INNER JOIN
                         fa_cliente ON A.IdEmpresa = fa_cliente.IdEmpresa AND A.IdCliente = fa_cliente.IdCliente INNER JOIN
						 tb_persona AS P on fa_cliente.IdPersona = p.IdPersona
WHERE        (A.Estado = 'A') AND (LTRIM(RTRIM(A.vt_tipoDoc)) = 'FACT')
group by  A.IdEmpresa, p.IdTipoDocumento, p.pe_cedulaRuc, A.vt_tipoDoc, year(A.vt_fecha) ,month(A.vt_fecha) , fa_cliente.FormaPago