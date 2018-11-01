-- spSys_Ge_Comparativo_Modulo_vs_Contas  1 ,'01/06/2016','30/06/2016'

CREATE proc spSys_Ge_Comparativo_Modulo_vs_Contas 
(
 @i_IdEmpresa int
,@i_fecha_ini datetime
,@i_fecha_fin datetime
)
as
begin 

declare @w_IdCtaCble_cxc varchar(20)
declare @w_IdCtaCble_Anti varchar(20)
declare @w_IdCtaCble_cxc_Credito varchar(20)

select @w_IdCtaCble_cxc=A.IdCtaCble_cxc,@w_IdCtaCble_Anti=A.IdCtaCble_Anti,@w_IdCtaCble_cxc_Credito=A.IdCtaCble_cxc_Credito from fa_cliente A where A.IdEmpresa=@i_IdEmpresa


delete tbSys_Ge_Comparativo_Modulo_vs_Contas

insert into tbSys_Ge_Comparativo_Modulo_vs_Contas
(IdEmpresa		,IdSucursal			,cod_sucu		,IdBodega				,IdCbteVta									,vt_tipoDoc					,vt_serie1	,vt_serie2		,vt_NumFactura        
,IdCliente		,pe_nombreCompleto	,vt_fecha		,vt_Observacion			,Debito_Vta									,Credito_Vta				,cb_Fecha	,cb_Observacion ,IdCtaCble            
,Debito_Conta	,Credito_Conta		,pc_Cuenta		,IdEmpresa_ct			,IdTipoCbte_ct								,IdCbteCble_ct				,secuencia  ,TIPO			,referencia)
SELECT       
fa_factura.IdEmpresa, fa_factura.IdSucursal, tb_sucursal.codigo as cod_sucu, fa_factura.IdBodega, fa_factura.IdCbteVta,
fa_factura.vt_tipoDoc, fa_factura.vt_serie1, fa_factura.vt_serie2, fa_factura.vt_NumFactura, fa_factura.IdCliente, tb_persona.pe_nombreCompleto, fa_factura.vt_fecha, fa_factura.vt_Observacion,
                         vwfa_factura_SubTotal_Iva_total.vt_total AS Debito_Vta, 0 Credito_Vta, ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion, ct_cbtecble_det.IdCtaCble, 
                         ct_cbtecble_det.dc_Valor AS Debito_Conta,0 Credito_Conta, ct_plancta.pc_Cuenta, ct_cbtecble_det.IdEmpresa AS IdEmpresa_ct, ct_cbtecble_det.IdTipoCbte AS IdTipoCbte_ct, 
                         ct_cbtecble_det.IdCbteCble AS IdCbteCble_ct, ct_cbtecble_det.secuencia,'FACT'AS TIPO
,fa_factura.vt_tipoDoc + isnull(fa_factura.vt_serie1,'') + isnull(fa_factura.vt_serie2,'') + isnull(fa_factura.vt_NumFactura,'') + '/'+ cast(fa_factura.IdCbteVta as varchar(20)) referencia
FROM            ct_cbtecble_det INNER JOIN
                         fa_factura_x_ct_cbtecble INNER JOIN
                         ct_cbtecble ON fa_factura_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble.IdEmpresa AND fa_factura_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         fa_factura_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble.IdCbteCble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND 
                         ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble RIGHT OUTER JOIN
                         tb_persona INNER JOIN
                         fa_cliente ON tb_persona.IdPersona = fa_cliente.IdPersona INNER JOIN
                         fa_factura ON fa_cliente.IdEmpresa = fa_factura.IdEmpresa AND fa_cliente.IdCliente = fa_factura.IdCliente INNER JOIN
                         vwfa_factura_SubTotal_Iva_total ON fa_factura.IdEmpresa = vwfa_factura_SubTotal_Iva_total.IdEmpresa AND 
                         fa_factura.IdSucursal = vwfa_factura_SubTotal_Iva_total.IdSucursal AND fa_factura.IdBodega = vwfa_factura_SubTotal_Iva_total.IdBodega AND 
                         fa_factura.IdCbteVta = vwfa_factura_SubTotal_Iva_total.IdCbteVta INNER JOIN
                         tb_sucursal ON fa_factura.IdEmpresa = tb_sucursal.IdEmpresa AND fa_factura.IdSucursal = tb_sucursal.IdSucursal ON 
                         fa_factura_x_ct_cbtecble.vt_IdEmpresa = fa_factura.IdEmpresa AND fa_factura_x_ct_cbtecble.vt_IdSucursal = fa_factura.IdSucursal AND 
                         fa_factura_x_ct_cbtecble.vt_IdBodega = fa_factura.IdBodega AND fa_factura_x_ct_cbtecble.vt_IdCbteVta = fa_factura.IdCbteVta
WHERE        (ct_cbtecble_det.dc_Valor > 0)
and fa_factura.IdEmpresa=@i_IdEmpresa
and fa_factura.vt_fecha between @i_fecha_ini and @i_fecha_fin


union

SELECT        
fa_notaCreDeb.IdEmpresa,   fa_notaCreDeb.IdSucursal,tb_sucursal.codigo, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo
,fa_notaCreDeb.Serie1,fa_notaCreDeb.Serie2,fa_notaCreDeb.NumNota_Impresa,fa_notaCreDeb.IdCliente
, tb_persona.pe_nombreCompleto, ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion
,vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total as Debito_Vta,0 Credito_Vta,
ct_cbtecble.cb_Fecha,ct_cbtecble.cb_Observacion,
 ct_cbtecble_det.IdCtaCble, 
                         ct_cbtecble_det.dc_Valor AS Debito_Conta,0 Credito_Conta, ct_plancta.pc_Cuenta, ct_cbtecble_det.IdEmpresa AS IdEmpresa_ct, ct_cbtecble_det.IdTipoCbte AS IdTipoCbte_ct, 
                         ct_cbtecble_det.IdCbteCble AS IdCbteCble_ct, ct_cbtecble_det.secuencia,'N/D'AS TIPO
,fa_notaCreDeb.CodDocumentoTipo + isnull(fa_notaCreDeb.Serie1,'')+isnull(fa_notaCreDeb.Serie2,'')+isnull(fa_notaCreDeb.NumNota_Impresa,'') + '/'+ cast(fa_notaCreDeb.IdNota as varchar(20))
FROM            ct_cbtecble_det INNER JOIN
                         ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         fa_notaCreDeb_x_ct_cbtecble ON ct_cbtecble.IdEmpresa = fa_notaCreDeb_x_ct_cbtecble.ct_IdEmpresa AND 
                         ct_cbtecble.IdEmpresa = fa_notaCreDeb_x_ct_cbtecble.ct_IdEmpresa AND ct_cbtecble.IdTipoCbte = fa_notaCreDeb_x_ct_cbtecble.ct_IdTipoCbte AND 
                         ct_cbtecble.IdTipoCbte = fa_notaCreDeb_x_ct_cbtecble.ct_IdTipoCbte AND ct_cbtecble.IdCbteCble = fa_notaCreDeb_x_ct_cbtecble.ct_IdCbteCble AND 
                         ct_cbtecble.IdCbteCble = fa_notaCreDeb_x_ct_cbtecble.ct_IdCbteCble INNER JOIN
                         tb_persona INNER JOIN
                         fa_cliente ON tb_persona.IdPersona = fa_cliente.IdPersona INNER JOIN
                         fa_notaCreDeb ON fa_cliente.IdEmpresa = fa_notaCreDeb.IdEmpresa AND fa_cliente.IdCliente = fa_notaCreDeb.IdCliente ON
                         fa_notaCreDeb_x_ct_cbtecble.no_IdEmpresa = fa_notaCreDeb.IdEmpresa AND fa_notaCreDeb_x_ct_cbtecble.no_IdSucursal = fa_notaCreDeb.IdSucursal AND 
                         fa_notaCreDeb_x_ct_cbtecble.no_IdBodega = fa_notaCreDeb.IdBodega AND fa_notaCreDeb_x_ct_cbtecble.no_IdNota = fa_notaCreDeb.IdNota INNER JOIN
                         vwfa_notaCreDeb_det_Subtotal_Iva_total ON fa_notaCreDeb.IdEmpresa = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdEmpresa AND 
                         fa_notaCreDeb.IdSucursal = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdSucursal AND 
                         fa_notaCreDeb.IdBodega = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdBodega AND 
                         fa_notaCreDeb.IdNota = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdNota CROSS JOIN
                         tb_sucursal
WHERE        (ct_cbtecble_det.dc_Valor > 0)
and fa_notaCreDeb.CreDeb='D'
and fa_notaCreDeb.IdEmpresa=@i_IdEmpresa
and fa_notaCreDeb.no_fecha between @i_fecha_ini and @i_fecha_fin


union


SELECT        
fa_notaCreDeb.IdEmpresa,   fa_notaCreDeb.IdSucursal,tb_sucursal.codigo, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, fa_notaCreDeb.CodDocumentoTipo
,fa_notaCreDeb.Serie1,fa_notaCreDeb.Serie2,fa_notaCreDeb.NumNota_Impresa,fa_notaCreDeb.IdCliente
, tb_persona.pe_nombreCompleto, ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion

,0 as Debito_Vta			,vwfa_notaCreDeb_det_Subtotal_Iva_total.sc_total  Credito_Vta,

ct_cbtecble.cb_Fecha,ct_cbtecble.cb_Observacion, ct_cbtecble_det.IdCtaCble, 
 
 0 AS Debito_Conta	,ct_cbtecble_det.dc_Valor*-1  Credito_Conta
 
 , ct_plancta.pc_Cuenta, ct_cbtecble_det.IdEmpresa AS IdEmpresa_ct, ct_cbtecble_det.IdTipoCbte AS IdTipoCbte_ct, 
                         ct_cbtecble_det.IdCbteCble AS IdCbteCble_ct, ct_cbtecble_det.secuencia,'N/C'AS TIPO
,fa_notaCreDeb.CodDocumentoTipo + isnull(fa_notaCreDeb.Serie1,'')+isnull(fa_notaCreDeb.Serie2,'')+isnull(fa_notaCreDeb.NumNota_Impresa,'') + '/'+ cast(fa_notaCreDeb.IdNota as varchar(20))
FROM            ct_cbtecble_det INNER JOIN
                         ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         fa_notaCreDeb_x_ct_cbtecble ON ct_cbtecble.IdEmpresa = fa_notaCreDeb_x_ct_cbtecble.ct_IdEmpresa AND 
                         ct_cbtecble.IdEmpresa = fa_notaCreDeb_x_ct_cbtecble.ct_IdEmpresa AND ct_cbtecble.IdTipoCbte = fa_notaCreDeb_x_ct_cbtecble.ct_IdTipoCbte AND 
                         ct_cbtecble.IdTipoCbte = fa_notaCreDeb_x_ct_cbtecble.ct_IdTipoCbte AND ct_cbtecble.IdCbteCble = fa_notaCreDeb_x_ct_cbtecble.ct_IdCbteCble AND 
                         ct_cbtecble.IdCbteCble = fa_notaCreDeb_x_ct_cbtecble.ct_IdCbteCble INNER JOIN
                         tb_persona INNER JOIN
                         fa_cliente ON tb_persona.IdPersona = fa_cliente.IdPersona INNER JOIN
                         fa_notaCreDeb ON fa_cliente.IdEmpresa = fa_notaCreDeb.IdEmpresa AND fa_cliente.IdCliente = fa_notaCreDeb.IdCliente ON
                         fa_notaCreDeb_x_ct_cbtecble.no_IdEmpresa = fa_notaCreDeb.IdEmpresa AND fa_notaCreDeb_x_ct_cbtecble.no_IdSucursal = fa_notaCreDeb.IdSucursal AND 
                         fa_notaCreDeb_x_ct_cbtecble.no_IdBodega = fa_notaCreDeb.IdBodega AND fa_notaCreDeb_x_ct_cbtecble.no_IdNota = fa_notaCreDeb.IdNota INNER JOIN
                         vwfa_notaCreDeb_det_Subtotal_Iva_total ON fa_notaCreDeb.IdEmpresa = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdEmpresa AND 
                         fa_notaCreDeb.IdSucursal = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdSucursal AND 
                         fa_notaCreDeb.IdBodega = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdBodega AND 
                         fa_notaCreDeb.IdNota = vwfa_notaCreDeb_det_Subtotal_Iva_total.IdNota CROSS JOIN
                         tb_sucursal
WHERE        (ct_cbtecble_det.dc_Valor < 0)
and fa_notaCreDeb.CreDeb='C'
and fa_notaCreDeb.IdEmpresa=@i_IdEmpresa
and fa_notaCreDeb.no_fecha between @i_fecha_ini and @i_fecha_fin



union
SELECT         fa_factura.IdEmpresa, fa_factura.IdSucursal, tb_sucursal.codigo, fa_factura.IdBodega, fa_factura.IdCbteVta,fa_factura.vt_tipoDoc, fa_factura.vt_serie1, 
                         fa_factura.vt_serie2, fa_factura.vt_NumFactura, cxc_cobro.IdCliente, tb_persona.pe_nombreCompleto, cxc_cobro.cr_fecha, cxc_cobro.cr_observacion, 
                         0 Debito_Vta ,cxc_cobro_det.dc_ValorPago Credito_Vta, ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion, ct_plancta.IdCtaCble,0 Debito_Conta, ct_cbtecble_det.dc_Valor*-1 as Credito_Conta, ct_plancta.pc_Cuenta, 
                         ct_cbtecble_det.IdEmpresa AS IdEmpresa_ct, ct_cbtecble_det.IdTipoCbte AS IdTipoCbte_ct, ct_cbtecble_det.IdCbteCble AS IdCbteCble_ct, 
                         ct_cbtecble_det.secuencia AS secuencia_ct,'COBRO_X_FT'AS TIPO
,fa_factura.vt_tipoDoc + isnull(fa_factura.vt_serie1,'') + isnull(fa_factura.vt_serie2,'') + isnull(fa_factura.vt_NumFactura,'') + '/'+ cast(fa_factura.IdCbteVta as varchar(20)) referencia
FROM            cxc_cobro INNER JOIN
                         cxc_cobro_det ON cxc_cobro.IdEmpresa = cxc_cobro_det.IdEmpresa AND cxc_cobro.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         cxc_cobro.IdCobro = cxc_cobro_det.IdCobro INNER JOIN
                         cxc_cobro_x_ct_cbtecble ON cxc_cobro.IdEmpresa = cxc_cobro_x_ct_cbtecble.cbr_IdEmpresa AND 
                         cxc_cobro.IdSucursal = cxc_cobro_x_ct_cbtecble.cbr_IdSucursal AND cxc_cobro.IdCobro = cxc_cobro_x_ct_cbtecble.cbr_IdCobro INNER JOIN
                         ct_cbtecble ON cxc_cobro_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble.IdEmpresa AND cxc_cobro_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         cxc_cobro_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         fa_factura ON cxc_cobro_det.IdEmpresa = fa_factura.IdEmpresa AND cxc_cobro_det.IdSucursal = fa_factura.IdSucursal AND
                         cxc_cobro_det.IdBodega_Cbte = fa_factura.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = fa_factura.IdCbteVta AND 
                         cxc_cobro_det.dc_TipoDocumento = fa_factura.vt_tipoDoc INNER JOIN
                         tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona
WHERE        (ct_cbtecble_det.dc_Valor < 0)
and ct_cbtecble_det.IdEmpresa=@i_IdEmpresa
and fa_factura.vt_fecha between @i_fecha_ini and @i_fecha_fin


union


SELECT         fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, tb_sucursal.codigo, fa_notaCreDeb.IdBodega, fa_notaCreDeb.IdNota, 
                         fa_notaCreDeb.CodDocumentoTipo, fa_notaCreDeb.Serie1, fa_notaCreDeb.Serie2, fa_notaCreDeb.NumNota_Impresa, fa_notaCreDeb.IdCliente, 
                         tb_persona.pe_nombreCompleto, cxc_cobro.cr_fecha, cxc_cobro.cr_observacion, 0 AS debito_vta, cxc_cobro_det.dc_ValorPago AS credito_vta, 
                         ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion, ct_plancta.IdCtaCble, 0 AS debito_cont, ct_cbtecble_det.dc_Valor * - 1 AS credito_cont, ct_plancta.pc_Cuenta, 
                         ct_cbtecble_det.IdEmpresa AS Expr1, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia,'COBRO_X_ND'  TIPO
,fa_notaCreDeb.CodDocumentoTipo + isnull(fa_notaCreDeb.Serie1,'')+isnull(fa_notaCreDeb.Serie2,'')+isnull(fa_notaCreDeb.NumNota_Impresa,'') + '/'+ cast(fa_notaCreDeb.IdNota as varchar(20))
FROM            cxc_cobro INNER JOIN
                         cxc_cobro_det ON cxc_cobro.IdEmpresa = cxc_cobro_det.IdEmpresa AND cxc_cobro.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         cxc_cobro.IdCobro = cxc_cobro_det.IdCobro INNER JOIN
                         cxc_cobro_x_ct_cbtecble ON cxc_cobro.IdEmpresa = cxc_cobro_x_ct_cbtecble.cbr_IdEmpresa AND 
                         cxc_cobro.IdSucursal = cxc_cobro_x_ct_cbtecble.cbr_IdSucursal AND cxc_cobro.IdCobro = cxc_cobro_x_ct_cbtecble.cbr_IdCobro INNER JOIN
                         ct_cbtecble ON cxc_cobro_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble.IdEmpresa AND cxc_cobro_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         cxc_cobro_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         fa_notaCreDeb ON cxc_cobro_det.IdEmpresa = fa_notaCreDeb.IdEmpresa AND cxc_cobro_det.IdSucursal = fa_notaCreDeb.IdSucursal AND 
                         cxc_cobro_det.IdBodega_Cbte = fa_notaCreDeb.IdBodega AND cxc_cobro_det.IdCbte_vta_nota = fa_notaCreDeb.IdNota AND 
                         cxc_cobro_det.dc_TipoDocumento = fa_notaCreDeb.CodDocumentoTipo
WHERE        (ct_cbtecble_det.dc_Valor < 0)
and ct_cbtecble_det.IdEmpresa=@i_IdEmpresa
and fa_notaCreDeb.no_fecha between @i_fecha_ini and @i_fecha_fin


union 

SELECT       cxc_cobro.IdEmpresa, cxc_cobro.IdSucursal, tb_sucursal.codigo, NULL AS idbodega, NULL AS IdCbteVta, cxc_cobro.IdCobro_tipo, NULL AS serie1, NULL 
                         AS serie2, NULL AS num_fact, cxc_cobro.IdCliente, tb_persona.pe_nombreCompleto, cxc_cobro.cr_fecha, cxc_cobro.cr_observacion, 0 AS debito_vta, 
                         cxc_cobro.cr_TotalCobro AS credito_vta, ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion, ct_cbtecble_det.IdCtaCble, 0 AS debito_con, 
                         ct_cbtecble_det.dc_Valor*-1 AS credito_con, ct_plancta.pc_Cuenta, ct_cbtecble_det.IdEmpresa AS IdEmpresa_ct, ct_cbtecble_det.IdTipoCbte AS IdTipoCbte_ct, 
                         ct_cbtecble_det.IdCbteCble AS IdCbteCble_ct, ct_cbtecble_det.secuencia AS secuencia_ct,'COBRO_SIN' tipo
,cxc_cobro.IdCobro_tipo + '#:' + cxc_cobro.cr_NumDocumento+'\' + cast(cxc_cobro.IdCobro as varchar(20))
FROM            cxc_cobro INNER JOIN
                         cxc_cobro_x_ct_cbtecble ON cxc_cobro.IdEmpresa = cxc_cobro_x_ct_cbtecble.cbr_IdEmpresa AND 
                         cxc_cobro.IdSucursal = cxc_cobro_x_ct_cbtecble.cbr_IdSucursal AND cxc_cobro.IdCobro = cxc_cobro_x_ct_cbtecble.cbr_IdCobro INNER JOIN
                         ct_cbtecble ON cxc_cobro_x_ct_cbtecble.ct_IdEmpresa = ct_cbtecble.IdEmpresa AND cxc_cobro_x_ct_cbtecble.ct_IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                         cxc_cobro_x_ct_cbtecble.ct_IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         tb_sucursal ON cxc_cobro.IdEmpresa = tb_sucursal.IdEmpresa AND cxc_cobro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         fa_cliente ON cxc_cobro.IdEmpresa = fa_cliente.IdEmpresa AND cxc_cobro.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
                         cxc_cobro_det ON cxc_cobro.IdEmpresa = cxc_cobro_det.IdEmpresa AND cxc_cobro.IdSucursal = cxc_cobro_det.IdSucursal AND 
                         cxc_cobro.IdCobro = cxc_cobro_det.IdCobro
WHERE        (ct_cbtecble_det.dc_Valor < 0) AND (cxc_cobro_det.IdEmpresa IS NULL)
and ct_cbtecble_det.IdEmpresa=@i_IdEmpresa
and cxc_cobro.cr_fecha between @i_fecha_ini and @i_fecha_fin

union


SELECT         ct_cbtecble.IdEmpresa, 0 IdSucursal, '' codigo, NULL AS IdBodega, ct_cbtecble.IdCbteCble, ct_cbtecble_tipo.CodTipoCbte, NULL 
                         AS serie1, NULL AS serie2, NULL AS fact, NULL AS idcliente, NULL AS nom_cliente, ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion, 

						 case when ct_cbtecble_det.dc_Valor> 0 then ct_cbtecble_det.dc_Valor else 0	 end debito_vta ,
						 case when ct_cbtecble_det.dc_Valor< 0 then ct_cbtecble_det.dc_Valor*-1 else 0	 end credito_vta ,
							 
						 ct_cbtecble.cb_Fecha AS Expr1, ct_cbtecble_det.dc_Observacion, ct_plancta.IdCtaCble, 

						 case when ct_cbtecble_det.dc_Valor> 0 then ct_cbtecble_det.dc_Valor else 0	 end debito_con ,
						 case when ct_cbtecble_det.dc_Valor< 0 then ct_cbtecble_det.dc_Valor*-1 else 0	 end credito_con ,
						 
						  ct_plancta.pc_Cuenta, ct_cbtecble_det.IdEmpresa AS IdEmpresa_ct, 
                          ct_cbtecble_det.IdTipoCbte AS IdTipoCbte_ct, ct_cbtecble_det.IdCbteCble AS IdCbteCble_ct, ct_cbtecble_det.secuencia AS secuencia_ct
						 ,'DIARIO' Tipo,ct_cbtecble_tipo.CodTipoCbte +'#'+ cast(ct_cbtecble.IdCbteCble as varchar(20)) referencia
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         
                         ct_cbtecble_tipo ON ct_cbtecble.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble
WHERE   
	ct_cbtecble_det.IdEmpresa=@i_IdEmpresa 
and ct_cbtecble_det.IdCtaCble in(@w_IdCtaCble_cxc,@w_IdCtaCble_Anti,@w_IdCtaCble_cxc_Credito)
and ct_cbtecble.cb_Fecha between @i_fecha_ini and @i_fecha_fin
and not exists
(

		select A.vt_IdEmpresa from fa_factura_x_ct_cbtecble A
		where A.ct_IdEmpresa=ct_cbtecble_det.IdEmpresa
		and A.ct_IdTipoCbte=ct_cbtecble_det.IdTipoCbte
		and A.ct_IdCbteCble=ct_cbtecble_det.IdCbteCble
)

and not exists
(

		select A.ct_IdEmpresa from fa_notaCreDeb_x_ct_cbtecble A
		where A.ct_IdEmpresa=ct_cbtecble_det.IdEmpresa
		and A.ct_IdTipoCbte=ct_cbtecble_det.IdTipoCbte
		and A.ct_IdCbteCble=ct_cbtecble_det.IdCbteCble
)
and not exists
(

		select A.ct_IdEmpresa from cxc_cobro_x_ct_cbtecble A
		where A.ct_IdEmpresa=ct_cbtecble_det.IdEmpresa
		and A.ct_IdTipoCbte=ct_cbtecble_det.IdTipoCbte
		and A.ct_IdCbteCble=ct_cbtecble_det.IdCbteCble
)



select 
IdEmpresa		,IdSucursal			,cod_sucu		,IdBodega				,IdCbteVta									,vt_tipoDoc					,vt_serie1	,vt_serie2		,vt_NumFactura        
,IdCliente		,pe_nombreCompleto	,vt_fecha		,vt_Observacion			,Debito_Vta									,Credito_Vta				,cb_Fecha	,cb_Observacion ,IdCtaCble            
,Debito_Conta	,Credito_Conta		,pc_Cuenta		,IdEmpresa_ct			,IdTipoCbte_ct								,IdCbteCble_ct				,secuencia  ,TIPO			,referencia
from tbSys_Ge_Comparativo_Modulo_vs_Contas



end