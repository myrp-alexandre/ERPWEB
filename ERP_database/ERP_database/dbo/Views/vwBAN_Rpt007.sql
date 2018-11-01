CREATE view [dbo].[vwBAN_Rpt007]
as
SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.ct_cbtecble_tipo.tc_TipoCbte AS Tipo_cbte_cxp, 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago, 
                         ct_cbtecble_tipo_1.CodTipoCbte AS Tipo_cbte_pago, dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago, dbo.cp_orden_giro.co_observacion, 
                         dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_TipoFlujo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_tipo_flujo, dbo.ba_TipoFlujo.cod_flujo, dbo.ba_TipoFlujo.Tipo, 
                         dbo.cp_orden_pago_cancelaciones.MontoAplicado AS dc_Valor, dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 'INGRESOS' ELSE 'EGRESOS' END AS Tipo_movi, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 1 ELSE 2 END AS orden, dbo.tb_persona.pe_nombreCompleto, case when conci.checked is null then cast(0 as bit) else cast(1 as bit) end as en_conci
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.ba_TipoFlujo ON dbo.cp_orden_giro.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND dbo.cp_orden_giro.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo INNER JOIN
                         dbo.cp_orden_pago_cancelaciones INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCtaCble = dbo.ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ct_cbtecble_tipo AS ct_cbtecble_tipo_1 ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_tipo_1.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_tipo_1.IdTipoCbte ON 
                         dbo.cp_orden_giro.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona left join 
						(
						select IdEmpresa,IdTipocbte,IdCbteCble, checked from ba_Conciliacion_det_IngEgr
						where checked = 1
						)conci on conci.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND conci.IdTipocbte = ba_Cbte_Ban.IdTipocbte
						and ba_Cbte_Ban.IdCbteCble = conci.IdCbteCble
UNION
SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.ct_cbtecble_tipo.tc_TipoCbte AS Tipo_cbte_cxp, 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago, 
                         ct_cbtecble_tipo_1.CodTipoCbte AS Tipo_cbte_pago, dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago, dbo.cp_nota_DebCre.cn_observacion, 
                         dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_TipoFlujo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_tipo_flujo, dbo.ba_TipoFlujo.cod_flujo, dbo.ba_TipoFlujo.Tipo, 
                         dbo.cp_orden_pago_cancelaciones.MontoAplicado AS dc_Valor, dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 'INGRESOS' ELSE 'EGRESOS' END AS Tipo_movi, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 1 ELSE 2 END AS orden, tb_persona.pe_nombreCompleto, case when conci.checked is null then cast(0 as bit) else cast(1 as bit) end as en_conci
FROM            dbo.ba_TipoFlujo INNER JOIN
                         dbo.cp_nota_DebCre ON dbo.ba_TipoFlujo.IdEmpresa = dbo.cp_nota_DebCre.IdEmpresa AND 
                         dbo.ba_TipoFlujo.IdTipoFlujo = dbo.cp_nota_DebCre.IdTipoFlujo INNER JOIN
                         dbo.cp_orden_pago_cancelaciones INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCtaCble = dbo.ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ct_cbtecble_tipo AS ct_cbtecble_tipo_1 ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_tipo_1.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_tipo_1.IdTipoCbte ON 
                         dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
                         dbo.cp_nota_DebCre.IdCbteCble_Nota = dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp AND 
                         dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona
						 left join 
						(
						select IdEmpresa,IdTipocbte,IdCbteCble, checked from ba_Conciliacion_det_IngEgr
						where checked = 1
						)conci on conci.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND conci.IdTipocbte = ba_Cbte_Ban.IdTipocbte
						and ba_Cbte_Ban.IdCbteCble = conci.IdCbteCble
UNION
SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.ct_cbtecble_tipo.tc_TipoCbte AS Tipo_cbte_cxp, 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago, 
                         ct_cbtecble_tipo_1.CodTipoCbte AS Tipo_cbte_pago, dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago, dbo.cp_orden_pago.Observacion, 
                         dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_TipoFlujo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_tipo_flujo, dbo.ba_TipoFlujo.cod_flujo, dbo.ba_TipoFlujo.Tipo, 
                         dbo.cp_orden_pago_cancelaciones.MontoAplicado AS dc_Valor, dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 'INGRESOS' ELSE 'EGRESOS' END AS Tipo_movi, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 1 ELSE 2 END AS orden, dbo.tb_persona.pe_nombreCompleto, case when conci.checked is null then cast(0 as bit) else cast(1 as bit) end as en_conci
FROM            dbo.ba_TipoFlujo INNER JOIN
                         dbo.cp_orden_pago ON dbo.ba_TipoFlujo.IdEmpresa = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.ba_TipoFlujo.IdTipoFlujo = dbo.cp_orden_pago.IdTipoFlujo INNER JOIN
                         dbo.cp_orden_pago_det ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa AND 
                         dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_det.IdOrdenPago INNER JOIN
                         dbo.cp_orden_pago_cancelaciones INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte AND 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCtaCble = dbo.ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ct_cbtecble_tipo AS ct_cbtecble_tipo_1 ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_tipo_1.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_tipo_1.IdTipoCbte ON 
                         dbo.cp_orden_pago_det.IdEmpresa_cxp = dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
                         dbo.cp_orden_pago_det.IdTipoCbte_cxp = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp AND 
                         dbo.cp_orden_pago_det.IdCbteCble_cxp = dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp INNER JOIN
                         dbo.tb_persona ON dbo.cp_orden_pago.IdPersona = dbo.tb_persona.IdPersona
						  left join 
						(
						select IdEmpresa,IdTipocbte,IdCbteCble, checked from ba_Conciliacion_det_IngEgr
						where checked = 1
						)conci on conci.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND conci.IdTipocbte = ba_Cbte_Ban.IdTipocbte
						and ba_Cbte_Ban.IdCbteCble = conci.IdCbteCble
WHERE        (dbo.cp_orden_pago.IdTipo_op <> 'FACT_PROVEE') AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.cp_nota_DebCre AS deb
                               WHERE        (IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa_cxp) AND (IdTipoCbte_Nota = dbo.cp_orden_pago_det.IdTipoCbte_cxp) AND 
                                                         (IdCbteCble_Nota = dbo.cp_orden_pago_det.IdCbteCble_cxp))) AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.cp_orden_giro AS giro
                               WHERE        (IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa_cxp) AND (IdTipoCbte_Ogiro = dbo.cp_orden_pago_det.IdTipoCbte_cxp) AND 
                                                         (IdCbteCble_Ogiro = dbo.cp_orden_pago_det.IdCbteCble_cxp)))
UNION
SELECT        dbo.caj_Caja_Movimiento.IdEmpresa, dbo.caj_Caja_Movimiento.IdTipocbte, ct_cbtecble_tipo_1.tc_TipoCbte AS Tipo_cbte_cxp, dbo.ba_Cbte_Ban.IdCbteCble, 
                         dbo.ba_Cbte_Ban.IdEmpresa AS Expr1, dbo.ba_Cbte_Ban.IdTipocbte AS Expr2, dbo.ct_cbtecble_tipo.CodTipoCbte AS Tipo_cbte_pago, 
                         dbo.ba_Cbte_Ban.IdCbteCble AS Expr3, CASE WHEN dbo.cxc_cobro.IdEmpresa IS NOT NULL 
                         THEN dbo.cxc_cobro.cr_observacion ELSE caj_Caja_Movimiento.cm_observacion END AS cr_observacion, dbo.ba_Cbte_Ban.cb_Fecha, 
                         dbo.ba_TipoFlujo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_tipo_flujo, dbo.ba_TipoFlujo.cod_flujo, dbo.ba_TipoFlujo.Tipo, dbo.ct_cbtecble_det.dc_Valor, 
                         dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, 
                         CASE WHEN ct_cbtecble_det_1.dc_Valor > 0 THEN 'INGRESOS' ELSE 'EGRESOS' END AS Tipo_movi, 
                         CASE WHEN ct_cbtecble_det_1.dc_Valor > 0 THEN 1 ELSE 2 END AS orden, dbo.tb_persona.pe_nombreCompleto, case when conci.checked is null then cast(0 as bit) else cast(1 as bit) end as en_conci
FROM            dbo.ct_cbtecble_det INNER JOIN
                         dbo.ba_TipoFlujo INNER JOIN
                         dbo.ct_cbtecble_det AS ct_cbtecble_det_1 INNER JOIN
                         dbo.ct_cbtecble ON ct_cbtecble_det_1.IdEmpresa = dbo.ct_cbtecble.IdEmpresa AND ct_cbtecble_det_1.IdTipoCbte = dbo.ct_cbtecble.IdTipoCbte AND 
                         ct_cbtecble_det_1.IdCbteCble = dbo.ct_cbtecble.IdCbteCble INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.ct_cbtecble.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND dbo.ct_cbtecble.IdCbteCble = dbo.ba_Cbte_Ban.IdCbteCble AND 
                         dbo.ct_cbtecble.IdTipoCbte = dbo.ba_Cbte_Ban.IdTipocbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON ct_cbtecble_det_1.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         ct_cbtecble_det_1.IdCtaCble = dbo.ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         dbo.caj_Caja_Movimiento INNER JOIN
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito ON 
                         dbo.caj_Caja_Movimiento.IdEmpresa = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdEmpresa AND 
                         dbo.caj_Caja_Movimiento.IdCbteCble = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdCbteCble AND 
                         dbo.caj_Caja_Movimiento.IdTipocbte = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdTipocbte ON 
                         dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdCbteCble AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdTipocbte ON 
                         dbo.ba_TipoFlujo.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND dbo.ba_TipoFlujo.IdTipoFlujo = dbo.ba_Cbte_Ban.IdTipoFlujo INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ct_cbtecble_tipo AS ct_cbtecble_tipo_1 ON dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdEmpresa = ct_cbtecble_tipo_1.IdEmpresa AND 
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdTipocbte = ct_cbtecble_tipo_1.IdTipoCbte ON 
                         dbo.ct_cbtecble_det.IdEmpresa = dbo.caj_Caja_Movimiento.IdEmpresa AND dbo.ct_cbtecble_det.IdTipoCbte = dbo.caj_Caja_Movimiento.IdTipocbte AND 
                         dbo.ct_cbtecble_det.IdCbteCble = dbo.caj_Caja_Movimiento.IdCbteCble LEFT OUTER JOIN
                         dbo.tb_persona ON dbo.caj_Caja_Movimiento.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         dbo.cxc_cobro INNER JOIN
                         dbo.cxc_cobro_x_caj_Caja_Movimiento ON dbo.cxc_cobro.IdEmpresa = dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdEmpresa AND 
                         dbo.cxc_cobro.IdSucursal = dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdSucursal AND 
                         dbo.cxc_cobro.IdCobro = dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdCobro ON 
                         dbo.caj_Caja_Movimiento.IdEmpresa = dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdEmpresa AND 
                         dbo.caj_Caja_Movimiento.IdCbteCble = dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdCbteCble AND 
                         dbo.caj_Caja_Movimiento.IdTipocbte = dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdTipocbte
						   left join 
						(
						select IdEmpresa,IdTipocbte,IdCbteCble, checked from ba_Conciliacion_det_IngEgr
						where checked = 1
						)conci on conci.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND conci.IdTipocbte = ba_Cbte_Ban.IdTipocbte
						and ba_Cbte_Ban.IdCbteCble = conci.IdCbteCble
WHERE        (dbo.ct_cbtecble_det.dc_Valor > 0)
UNION ALL
SELECT        ban.IdEmpresa AS IdEmpresa_cxp, ban.IdTipocbte AS IdTipoCbte_cxp, dbo.ct_cbtecble_tipo.tc_TipoCbte AS Tipo_cbte_cxp, ban.IdCbteCble AS IdCbteCble_cxp, 
                         ban.IdEmpresa AS IdEmpresa_pago, ban.IdTipocbte AS IdTipocbte_pago, dbo.ct_cbtecble_tipo.CodTipoCbte AS Tipo_cbte_pago, ban.IdCbteCble AS IdCbteCble_pago, 
                         ban.cb_Observacion, ban.cb_Fecha, dbo.ba_TipoFlujo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_tipo_flujo, dbo.ba_TipoFlujo.cod_flujo, 
                         dbo.ba_TipoFlujo.Tipo, ABS(dbo.ct_cbtecble_det.dc_Valor) dc_Valor, dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 'INGRESOS' ELSE 'EGRESOS' END AS Tipo_movi, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN 1 ELSE 2 END AS orden, null, case when conci.checked is null then cast(0 as bit) else cast(1 as bit) end as en_conci
FROM            dbo.ba_Cbte_Ban AS ban INNER JOIN
                         dbo.ba_TipoFlujo ON ban.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND ban.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo INNER JOIN
                         dbo.ct_cbtecble_det ON ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble AND 
                         ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCtaCble = dbo.ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON ban.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND ban.IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte
						   left join 
						(
						select IdEmpresa,IdTipocbte,IdCbteCble, checked from ba_Conciliacion_det_IngEgr
						where checked = 1
						)conci on conci.IdEmpresa = ban.IdEmpresa AND conci.IdTipocbte = ban.IdTipocbte
						and ban.IdCbteCble = conci.IdCbteCble
WHERE        NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.cp_orden_pago_cancelaciones can
                               WHERE        ban.IdEmpresa = can.IdEmpresa_pago AND ban.IdTipocbte = can.IdTipoCbte_pago AND ban.IdCbteCble = can.IdCbteCble_pago) AND 
                         NOT EXISTS
                             (SELECT        mba_IdEmpresa
                               FROM            ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito caj
                               WHERE        ban.IdEmpresa = caj.mba_IdEmpresa AND ban.IdTipocbte = caj.mba_IdTipocbte AND ban.IdCbteCble = caj.mba_IdCbteCble) AND ban.Estado = 'A'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[69] 4[4] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 51
               Left = 1114
               Bottom = 180
               Right = 1377
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 210
               Left = 0
               Bottom = 338
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Cbte_Ban"
            Begin Extent = 
               Top = 0
               Left = 528
               Bottom = 129
               Right = 750
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 165
               Left = 705
               Bottom = 294
               Right = 933
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo_1"
            Begin Extent = 
               Top = 206
               Left = 0
               Bottom = 335
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_TipoFlujo"
            Begin Extent = 
               Top = 178
               Left = 0
               Bottom = 307
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 279
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt007';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_cancelaciones"
            Begin Extent = 
               Top = 6
               Left = 788
               Bottom = 135
               Right = 1001
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 10095
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt007';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt007';

