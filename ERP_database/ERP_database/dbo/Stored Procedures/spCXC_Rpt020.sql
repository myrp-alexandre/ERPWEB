--exec [dbo].[spCXC_Rpt020] 1,1,99999,'','2017-04-06'
CREATE PROCEDURE [dbo].[spCXC_Rpt020]
(
@IdEmpresa int,
@IdCliente_ini numeric,
@IdCliente_fin numeric,
@Estado varchar(1),
@Fecha_corte datetime
)
AS
BEGIN
SELECT ISNULL(ROW_NUMBER() OVER(ORDER BY a.IdEmpresa),0) AS IdRow, a.IdEmpresa,a.IdSucursal,a.IdBodega,a.IdCbteVta,a.vt_tipoDoc,a.vt_NumFactura,vt_Observacion,vt_fecha,a.valor_doc, a.valor,a.Debito,a.Credito, round(sum(a.valor) over(partition by a.IdEmpresa,a.IdSucursal,a.IdBodega,a.IdCbteVta,a.vt_tipoDoc order by a.IdEmpresa,a.IdSucursal,a.IdBodega,a.IdCbteVta,a.vt_tipoDoc, a.orden, a.vt_fecha, a.IdCobro),2) as saldo,
a.IdCliente,a.pe_nombreCompleto,a.Estado,
a.Tipo_cbte,a.orden,a.Tipo_cobro,a.num_documento_cobro,a.IdCobro, case when  (isnull(round(a.valor_doc,2),a.valor) - isnull(round(estado_cancelacion.saldo_doc,2),0)) = 0 then 'COBRADO' ELSE 'PENDIENTE' END AS Estado_documento,
a.cr_observacion
FROM (
SELECT fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.vt_tipoDoc, fa_factura.vt_NumFactura, fa_factura.vt_Observacion, fa_factura.vt_fecha, 
			SUM(fa_factura_det.vt_total) AS valor_doc, SUM(fa_factura_det.vt_total) AS valor,SUM(fa_factura_det.vt_total) as Debito, 0 as Credito, 
                  fa_factura.IdCliente, tb_persona.pe_nombreCompleto, fa_factura.Estado,'CBTE_CXC' AS Tipo_cbte, 1 as orden,NULL AS Tipo_cobro, null as num_documento_cobro, null as IdCobro, null as cr_observacion
FROM     fa_factura INNER JOIN
                  fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
                  fa_factura.IdCbteVta = fa_factura_det.IdCbteVta INNER JOIN
                  fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                  tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona
GROUP BY fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.vt_tipoDoc, fa_factura.vt_NumFactura, fa_factura.vt_Observacion, fa_factura.vt_fecha, fa_factura.IdCliente, 
                  tb_persona.pe_nombreCompleto,fa_factura.Estado
UNION
SELECT fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo, fa_notaCreDeb.CodNota, fa_notaCreDeb.sc_observacion, fa_notaCreDeb.no_fecha, 
                  SUM(fa_notaCreDeb_det.sc_total) as valor_doc, SUM(fa_notaCreDeb_det.sc_total) AS sc_total, SUM(fa_notaCreDeb_det.sc_total) as Debito, 0 as Credito, fa_notaCreDeb.IdCliente, tb_persona.pe_nombreCompleto, fa_notaCreDeb.Estado,'CBTE_CXC' AS Tipo_cbte,1 as orden,NULL AS Tipo_cobro, null as num_documento_cobro, null as IdCobro,
				  null as cr_observacion
FROM     fa_cliente INNER JOIN
                  tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                  fa_notaCreDeb ON fa_cliente.IdEmpresa = fa_notaCreDeb.IdEmpresa AND fa_cliente.IdCliente = fa_notaCreDeb.IdCliente INNER JOIN
                  fa_notaCreDeb_det ON fa_notaCreDeb.IdEmpresa = fa_notaCreDeb_det.IdEmpresa AND fa_notaCreDeb.IdSucursal = fa_notaCreDeb_det.IdSucursal AND fa_notaCreDeb.IdBodega = fa_notaCreDeb_det.IdBodega AND 
                  fa_notaCreDeb.IdNota = fa_notaCreDeb_det.IdNota
				  WHERE fa_notaCreDeb.CreDeb = 'D'
GROUP BY tb_persona.pe_nombreCompleto, fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo, fa_notaCreDeb.sc_observacion, 
                  fa_notaCreDeb.no_fecha, fa_notaCreDeb.IdCliente, fa_notaCreDeb.Estado, fa_notaCreDeb.CodNota
UNION
		SELECT fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.IdCbteVta, fa_factura.vt_tipoDoc, fa_factura.vt_NumFactura, fa_factura.vt_Observacion, cxc_cobro.cr_fecha,ISNULL(FC.TOTAL,0), 
		cxc_cobro_det.dc_ValorPago*-1, 0 as Debito, cxc_cobro_det.dc_ValorPago as Credito, 
                  fa_factura.IdCliente, tb_persona.pe_nombreCompleto, fa_factura.Estado, 'CBTE_COB' AS Expr1, 2 AS orden, cxc_cobro_tipo.IdCobro_tipo, cxc_cobro.cr_NumDocumento, cxc_cobro.IdCobro,
				  cxc_cobro.cr_observacion
FROM     fa_factura INNER JOIN
                  fa_cliente INNER JOIN
                  tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                  cxc_cobro_det INNER JOIN
                  cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_det.IdCobro = cxc_cobro.IdCobro ON fa_factura.IdEmpresa = cxc_cobro_det.IdEmpresa AND 
                  fa_factura.IdSucursal = cxc_cobro_det.IdSucursal AND fa_factura.IdBodega = cxc_cobro_det.IdBodega_Cbte AND fa_factura.IdCbteVta = cxc_cobro_det.IdCbte_vta_nota AND 
                  fa_factura.vt_tipoDoc = cxc_cobro_det.dc_TipoDocumento INNER JOIN
                  cxc_cobro_tipo ON cxc_cobro.IdCobro_tipo = cxc_cobro_tipo.IdCobro_tipo			  

				  left join(
						SELECT fa_c.IdEmpresa, fa_c.IdSucursal, fa_c.IdBodega, fa_c.IdCbteVta, fa_c.vt_tipoDoc, SUM(fa_d.vt_total) AS total
						FROM     fa_factura AS fa_c INNER JOIN
						fa_factura_det AS fa_d ON fa_c.IdEmpresa = fa_d.IdEmpresa AND fa_c.IdSucursal = fa_d.IdSucursal AND fa_c.IdBodega = fa_d.IdBodega AND fa_c.IdCbteVta = fa_d.IdCbteVta
						GROUP BY fa_c.IdEmpresa, fa_c.IdSucursal, fa_c.IdBodega, fa_c.IdCbteVta, fa_c.vt_tipoDoc
				  ) FC ON cxc_cobro_det.IdEmpresa = FC.IdEmpresa AND cxc_cobro_det.IdSucursal = FC.IdSucursal AND cxc_cobro_det.IdBodega_Cbte = FC.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = FC.IdCbteVta
				  AND cxc_cobro_det.dc_TipoDocumento = FC.vt_tipoDoc

UNION
SELECT fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo, fa_notaCreDeb.CodNota, fa_notaCreDeb.sc_observacion, cxc_cobro.cr_fecha,ISNULL(nd.total,0), 
		cxc_cobro_det.dc_ValorPago*-1, 0 as Debito, cxc_cobro_det.dc_ValorPago as Credito, 
                  fa_notaCreDeb.IdCliente, tb_persona.pe_nombreCompleto, fa_notaCreDeb.Estado, 'CBTE_COB' AS Expr1, 2 AS orden, cxc_cobro_tipo.IdCobro_tipo, cxc_cobro.cr_NumDocumento, cxc_cobro.IdCobro,
				  cxc_cobro.cr_observacion
FROM     fa_notaCreDeb INNER JOIN
                  fa_cliente INNER JOIN
                  tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente INNER JOIN
                  cxc_cobro_tipo INNER JOIN
                  cxc_cobro_det INNER JOIN
                  cxc_cobro ON cxc_cobro_det.IdEmpresa = cxc_cobro.IdEmpresa AND cxc_cobro_det.IdSucursal = cxc_cobro.IdSucursal AND cxc_cobro_det.IdCobro = cxc_cobro.IdCobro ON cxc_cobro_tipo.IdCobro_tipo = cxc_cobro.IdCobro_tipo ON 
                  fa_notaCreDeb.IdEmpresa = cxc_cobro_det.IdEmpresa AND fa_notaCreDeb.IdSucursal = cxc_cobro_det.IdSucursal AND fa_notaCreDeb.IdBodega = cxc_cobro_det.IdBodega_Cbte AND 
                  fa_notaCreDeb.IdNota = cxc_cobro_det.IdCbte_vta_nota AND fa_notaCreDeb.CodDocumentoTipo = cxc_cobro_det.dc_TipoDocumento
				  left join(
						SELECT nd_c.IdEmpresa, nd_c.IdSucursal, nd_c.IdBodega, nd_c.IdNota, nd_c.CodDocumentoTipo, SUM(nd_d.sc_total) AS total
						FROM     fa_notaCreDeb AS nd_c INNER JOIN
						fa_notaCreDeb_det AS nd_d ON nd_c.IdEmpresa = nd_d.IdEmpresa AND nd_c.IdSucursal = nd_d.IdSucursal AND nd_c.IdBodega = nd_d.IdBodega AND nd_c.IdNota = nd_d.IdNota
						GROUP BY nd_c.IdEmpresa, nd_c.IdSucursal, nd_c.IdBodega, nd_c.IdNota, nd_c.CodDocumentoTipo
				  ) ND ON cxc_cobro_det.IdEmpresa = ND.IdEmpresa AND cxc_cobro_det.IdSucursal = ND.IdSucursal AND cxc_cobro_det.IdBodega_Cbte = ND.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = ND.IdNota
				  AND cxc_cobro_det.dc_TipoDocumento = ND.CodDocumentoTipo
				  ) A left join(
				  select cob_det.IdEmpresa,cob_det.IdSucursal,cob_det.IdBodega_Cbte,cob_det.IdCbte_vta_nota,cob_det.dc_TipoDocumento,sum(cob_det.dc_ValorPago) saldo_doc
				  from cxc_cobro_det cob_det inner join cxc_cobro cob
				  on cob.IdEmpresa = cob_det.IdEmpresa
				  and cob.IdSucursal = cob_det.IdSucursal
				  and cob.IdCobro = cob_det.IdCobro
				  where cob.cr_fecha <= @Fecha_corte
				  group by cob_det.IdEmpresa,cob_det.IdSucursal,cob_det.IdBodega_Cbte,cob_det.IdCbte_vta_nota,cob_det.dc_TipoDocumento
				  ) estado_cancelacion on estado_cancelacion.IdEmpresa = a.IdEmpresa
				  and estado_cancelacion.IdSucursal = a.IdSucursal
				  and estado_cancelacion.IdBodega_Cbte = a.IdBodega
				  and estado_cancelacion.IdCbte_vta_nota = a.IdCbteVta
				  and estado_cancelacion.dc_TipoDocumento = a.vt_tipoDoc
				  where a.Estado like '%'+@Estado+'%' and a.IdCliente between @IdCliente_ini and @IdCliente_fin and vt_fecha <= @Fecha_corte and a.IdEmpresa = @IdEmpresa
				  ORDER BY a.IdEmpresa,a.IdSucursal,a.IdBodega,a.IdCbteVta,a.vt_tipoDoc, a.orden, a.vt_fecha,a.IdCobro
END