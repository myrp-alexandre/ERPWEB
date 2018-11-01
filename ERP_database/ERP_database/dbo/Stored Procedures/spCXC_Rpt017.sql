--exec [spCXC_Rpt017] 1,'01/06/2016','30/06/2016'
CREATE procedure [dbo].[spCXC_Rpt017]
(
@IdEmpresa int,
@FechaIni datetime,
@FechaFin datetime
)
AS
BEGIN
DELETE [dbo].[cxc_CXC_Rpt017]
INSERT INTO [dbo].[cxc_CXC_Rpt017]
           ([IdEmpresa]				     ,[IdSucursal]           ,[IdBodega]		       ,[IdCbte_vta_nota]
           ,[dc_TipoDocumento]           ,[vt_total]             ,[dc_ValorPago]           ,[Saldo]
           ,[IdCliente]		             ,[IdPersona]            ,[nom_Cliente]            ,[pe_cedulaRuc]
           ,[IdProvincia]	             ,[IdCiudad]             ,[IdParroquia]            ,[pe_Naturaleza]
           ,[vt_NumFactura]              ,[vt_fecha]             ,[vt_fech_venc]           ,[ValorPago_mes])
SELECT        cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, 
                         ROUND(vwfa_factura_SubTotal_Iva_total.vt_total, 2) AS vt_total, ROUND(SUM(cxc_cobro_det.dc_ValorPago), 2) AS valor_pago, 
                         ROUND(ISNULL(vwfa_factura_SubTotal_Iva_total.vt_total, 0), 2) - ROUND(SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2) AS Saldo, fa_cliente.IdCliente, 
                         tb_persona.IdPersona, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, tb_provincia.IdProvincia, tb_ciudad.IdCiudad, tb_parroquia.IdParroquia, 
                         CASE WHEN tb_persona.pe_Naturaleza = 'NATU' THEN 'N' ELSE 'J' END AS pe_Naturaleza, CASE WHEN fa_factura.vt_serie1 IS NOT NULL 
                         THEN fa_factura.vt_serie1 + '-' + fa_factura.vt_serie2 + '-' + fa_factura.vt_NumFactura ELSE fa_factura.CodCbteVta END AS vt_NumFactura, fa_factura.vt_fecha, 
                         fa_factura.vt_fech_venc,0
FROM            fa_factura INNER JOIN
                         vwfa_factura_SubTotal_Iva_total ON fa_factura.IdEmpresa = vwfa_factura_SubTotal_Iva_total.IdEmpresa AND 
                         fa_factura.IdSucursal = vwfa_factura_SubTotal_Iva_total.IdSucursal AND fa_factura.IdBodega = vwfa_factura_SubTotal_Iva_total.IdBodega AND 
                         fa_factura.IdCbteVta = vwfa_factura_SubTotal_Iva_total.IdCbteVta INNER JOIN
                         fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
						 fa_cliente_contactos con on con.IdEmpresa = fa_cliente.IdEmpresa and con.IdCliente = fa_cliente.IdCliente and fa_factura.IdContacto = con.IdContacto INNER JOIN
						 tb_ciudad on tb_ciudad.IdCiudad = con.IdCiudad INNER JOIN
						 tb_parroquia on tb_parroquia.IdParroquia = con.IdParroquia INNER JOIN
						 tb_provincia ON tb_ciudad.IdProvincia = tb_provincia.IdProvincia LEFT OUTER JOIN
                         cxc_cobro_det ON vwfa_factura_SubTotal_Iva_total.IdEmpresa = cxc_cobro_det.IdEmpresa AND 
                         vwfa_factura_SubTotal_Iva_total.IdSucursal = cxc_cobro_det.IdSucursal AND vwfa_factura_SubTotal_Iva_total.IdBodega = cxc_cobro_det.IdBodega_Cbte AND 
                         vwfa_factura_SubTotal_Iva_total.IdCbteVta = cxc_cobro_det.IdCbte_vta_nota INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro
WHERE NOT EXISTS (
			SELECT        *
			FROM            fa_notaCreDeb_x_fa_factura_NotaDeb 
			WHERE fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_fac_nd_doc_mod = fa_factura.IdEmpresa AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_fac_nd_doc_mod = fa_factura.IdSucursal AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_fac_nd_doc_mod = fa_factura.IdBodega AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.IdCbteVta_fac_nd_doc_mod = fa_factura.IdCbteVta AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.vt_tipoDoc = fa_factura.vt_tipoDoc
) AND (cxc_cobro.cr_fechaCobro <= @FechaFin)
GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, 
                         vwfa_factura_SubTotal_Iva_total.vt_total, fa_cliente.IdCliente, tb_persona.IdPersona, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, 
                         tb_provincia.IdProvincia, tb_ciudad.IdCiudad, tb_parroquia.IdParroquia, tb_persona.pe_Naturaleza, fa_factura.vt_serie1, fa_factura.vt_serie2, 
                         fa_factura.vt_NumFactura, fa_factura.CodCbteVta, fa_factura.vt_fecha, fa_factura.vt_fech_venc, fa_factura.Estado
HAVING        (cxc_cobro_det.dc_TipoDocumento = 'FACT') AND (fa_factura.Estado = 'A')
/*UNION
SELECT        cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, 
                         ROUND(vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total, 2) AS vt_total, ROUND(SUM(cxc_cobro_det.dc_ValorPago), 2) AS valor_pago, 
                         ROUND(ISNULL(vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total, 0), 2) - ROUND(SUM(ISNULL(cxc_cobro_det.dc_ValorPago, 0)), 2) AS Saldo, fa_cliente.IdCliente, 
                         tb_persona.IdPersona, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, tb_provincia.IdProvincia, tb_ciudad.IdCiudad, tb_parroquia.IdParroquia, 
                         CASE WHEN tb_persona.pe_Naturaleza = 'NATU' THEN 'N' ELSE 'J' END AS pe_Naturaleza, CASE WHEN fa_notaCreDeb.Serie1 IS NOT NULL 
                         THEN fa_notaCreDeb.Serie1 + '-' + fa_notaCreDeb.Serie2 + '-' + fa_notaCreDeb.NumNota_Impresa ELSE fa_notaCreDeb.CodNota END AS vt_NumFactura, 
                         fa_notaCreDeb.no_fecha, fa_notaCreDeb.no_fecha_venc,0
FROM            fa_notaCreDeb INNER JOIN
                         vwfa_notaCreDeb_det_Subtotal_Iva_total ON fa_notaCreDeb.IdEmpresa = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdEmpresa AND 
                         fa_notaCreDeb.IdSucursal = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdSucursal AND 
                         fa_notaCreDeb.IdBodega = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdBodega AND 
                         fa_notaCreDeb.IdNota = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdNota INNER JOIN
                         fa_cliente ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         tb_ciudad ON fa_cliente.IdCiudad = tb_ciudad.IdCiudad INNER JOIN
                         tb_parroquia ON fa_cliente.IdParroquia = tb_parroquia.IdParroquia INNER JOIN
                         tb_provincia ON tb_ciudad.IdProvincia = tb_provincia.IdProvincia LEFT OUTER JOIN
                         cxc_cobro_det ON vwfa_notaCreDeb_det_Subtotal_Iva_total.IdEmpresa = cxc_cobro_det.IdEmpresa AND 
                         vwfa_notaCreDeb_det_Subtotal_Iva_total.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         vwfa_notaCreDeb_det_Subtotal_Iva_total.IdBodega = cxc_cobro_det.IdBodega_Cbte AND 
                         vwfa_notaCreDeb_det_Subtotal_Iva_total.IdNota = cxc_cobro_det.IdCbte_vta_nota INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro
WHERE NOT EXISTS (
			SELECT        *
			FROM            fa_notaCreDeb_x_fa_factura_NotaDeb 
			where fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_fac_nd_doc_mod = fa_notaCreDeb.IdEmpresa AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_fac_nd_doc_mod = fa_notaCreDeb.IdSucursal AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_fac_nd_doc_mod = fa_notaCreDeb.IdBodega AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.IdCbteVta_fac_nd_doc_mod = fa_notaCreDeb.IdNota AND 
					fa_notaCreDeb_x_fa_factura_NotaDeb.vt_tipoDoc = fa_notaCreDeb.CodDocumentoTipo
) AND (cxc_cobro.cr_fechaCobro <= @FechaFin)
GROUP BY cxc_cobro_det.IdEmpresa, cxc_cobro_det.IdSucursal, cxc_cobro_det.IdBodega_Cbte, cxc_cobro_det.IdCbte_vta_nota, cxc_cobro_det.dc_TipoDocumento, 
                         vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total, fa_cliente.IdCliente, tb_persona.IdPersona, tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, 
                         tb_provincia.IdProvincia, tb_ciudad.IdCiudad, tb_parroquia.IdParroquia, tb_persona.pe_Naturaleza, fa_notaCreDeb.Serie1, fa_notaCreDeb.Serie2, 
                         fa_notaCreDeb.NumNota_Impresa, fa_notaCreDeb.CodNota, fa_notaCreDeb.CreDeb, fa_notaCreDeb.no_fecha, fa_notaCreDeb.no_fecha_venc, 
                         fa_notaCreDeb.Estado
HAVING        (cxc_cobro_det.dc_TipoDocumento = 'NTDB') AND (fa_notaCreDeb.CreDeb = 'D') AND (fa_notaCreDeb.Estado = 'A')
*/
update dbo.cxc_CXC_Rpt017
set ValorPago_mes = ROUND(ISNULL(A.dc_ValorPago,0),2)
FROM(
SELECT        cxc_CXC_Rpt017.IdEmpresa, cxc_CXC_Rpt017.IdSucursal, cxc_CXC_Rpt017.IdBodega, cxc_CXC_Rpt017.IdCbte_vta_nota, cxc_CXC_Rpt017.dc_TipoDocumento, 
                         SUM(cxc_cobro_det.dc_ValorPago) AS dc_ValorPago
FROM            cxc_CXC_Rpt017 INNER JOIN
                         cxc_cobro_det ON cxc_CXC_Rpt017.IdEmpresa = cxc_cobro_det.IdEmpresa AND cxc_CXC_Rpt017.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         cxc_CXC_Rpt017.IdBodega = cxc_cobro_det.IdBodega_Cbte AND cxc_CXC_Rpt017.IdCbte_vta_nota = cxc_cobro_det.IdCbte_vta_nota AND 
                         cxc_CXC_Rpt017.dc_TipoDocumento = cxc_cobro_det.dc_TipoDocumento INNER JOIN
                         cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND 
                         cxc_cobro_det.IdCobro = cxc_cobro.IdCobro
WHERE cxc_cobro.cr_fechaCobro between @FechaIni and @FechaFin
GROUP BY cxc_CXC_Rpt017.IdEmpresa, cxc_CXC_Rpt017.IdSucursal, cxc_CXC_Rpt017.IdBodega, cxc_CXC_Rpt017.IdCbte_vta_nota, cxc_CXC_Rpt017.dc_TipoDocumento
)A
WHERE A.IdEmpresa = cxc_CXC_Rpt017.IdEmpresa
AND A.IdSucursal = cxc_CXC_Rpt017.IdSucursal
AND A.IdBodega = cxc_CXC_Rpt017.IdBodega
AND A.IdCbte_vta_nota = cxc_CXC_Rpt017.IdCbte_vta_nota
AND A.dc_TipoDocumento = cxc_CXC_Rpt017.dc_TipoDocumento

SELECT [IdEmpresa]      ,[IdSucursal]      ,[IdBodega]      ,[IdCbte_vta_nota]      ,[dc_TipoDocumento]
      ,[vt_total]      ,[dc_ValorPago]      ,[Saldo]      ,[IdCliente]      ,[IdPersona]      ,[nom_Cliente]
      ,[pe_cedulaRuc]      ,[IdProvincia]      ,[IdCiudad]      ,[IdParroquia]      ,[pe_Naturaleza]
      ,[vt_NumFactura]      ,[vt_fecha]      ,[vt_fech_venc]      ,[ValorPago_mes]
  FROM [dbo].[cxc_CXC_Rpt017]

END