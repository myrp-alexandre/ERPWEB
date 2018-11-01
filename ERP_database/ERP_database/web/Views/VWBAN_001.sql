CREATE VIEW [web].[VWBAN_001]
AS
SELECT        ba_Cbte_Ban_tipo.CodTipoCbteBan, ba_Cbte_Ban.IdEmpresa, ba_Cbte_Ban.IdCbteCble, ba_Cbte_Ban.IdTipocbte, ba_Cbte_Ban.IdBanco, ba_Banco_Cuenta.ba_descripcion, ba_Cbte_Ban.cb_Fecha, 
                         ba_Cbte_Ban.cb_Observacion, ba_Cbte_Ban.Estado, ba_Cbte_Ban.IdTipoNota, ba_tipo_nota.Descripcion AS Descripcion_TipoNota, 'Ninguno' AS NomBeneficiario, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta, 
                         ct_cbtecble_det.dc_Valor, CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS dc_Valor_Debe, CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) 
                         ELSE 0 END AS dc_Valor_Haber
FROM            ct_cbtecble_det INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         ba_Cbte_Ban_tipo INNER JOIN
                         ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo ON ba_Cbte_Ban_tipo.CodTipoCbteBan = ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan INNER JOIN
                         ba_Cbte_Ban ON ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble = ba_Cbte_Ban.IdTipocbte INNER JOIN
                         ba_Banco_Cuenta ON ba_Cbte_Ban.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ba_Cbte_Ban.IdBanco = ba_Banco_Cuenta.IdBanco INNER JOIN
                         ba_tipo_nota ON ba_Cbte_Ban.IdEmpresa = ba_tipo_nota.IdEmpresa AND ba_Cbte_Ban.IdTipoNota = ba_tipo_nota.IdTipoNota ON ct_cbtecble_det.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND 
                         ct_cbtecble_det.IdTipoCbte = ba_Cbte_Ban.IdTipocbte AND ct_cbtecble_det.IdCbteCble = ba_Cbte_Ban.IdCbteCble
WHERE        (NOT EXISTS
                             (SELECT        IdEmpresa, Idcancelacion, Secuencia, IdEmpresa_op, IdOrdenPago_op, Secuencia_op, IdEmpresa_op_padre, IdOrdenPago_op_padre, Secuencia_op_padre, IdEmpresa_cxp, IdTipoCbte_cxp, IdCbteCble_cxp, 
                                                         IdEmpresa_pago, IdTipoCbte_pago, IdCbteCble_pago, MontoAplicado, SaldoAnterior, SaldoActual, Observacion, fechaTransaccion
                               FROM            cp_orden_pago_cancelaciones AS f
                               WHERE        (IdEmpresa_pago = ba_Cbte_Ban.IdEmpresa) AND (IdTipoCbte_pago = ba_Cbte_Ban.IdTipocbte) AND (IdCbteCble_pago = ba_Cbte_Ban.IdCbteCble)))
UNION ALL
SELECT        dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan, dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion, 
                         dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.IdTipoNota, dbo.ba_tipo_nota.Descripcion AS Descripcion_TipoNota, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble_det.dc_Valor, CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS dc_Valor_Debe, 
                         CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Haber
FROM            dbo.ba_Banco_Cuenta INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.ba_Banco_Cuenta.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND dbo.ba_Banco_Cuenta.IdBanco = dbo.ba_Cbte_Ban.IdBanco INNER JOIN
                         dbo.ba_tipo_nota ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_tipo_nota.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipoNota = dbo.ba_tipo_nota.IdTipoNota INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble AND dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa INNER JOIN
                         dbo.tb_persona INNER JOIN
                         dbo.cp_orden_pago ON dbo.tb_persona.IdPersona = dbo.cp_orden_pago.IdPersona INNER JOIN
                         dbo.cp_orden_pago_cancelaciones ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_op AND dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_cancelaciones.IdOrdenPago_op ON 
                         dbo.ba_Cbte_Ban.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago AND dbo.ba_Cbte_Ban.IdCbteCble = dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago INNER JOIN
                         dbo.ba_Cbte_Ban_tipo INNER JOIN
                         dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo ON dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan = dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan ON 
                         dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble
GROUP BY dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan, dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion, 
                         dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.IdTipoNota, dbo.ba_tipo_nota.Descripcion, dbo.tb_persona.pe_nombreCompleto, dbo.ct_cbtecble_det.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_cbtecble_det.secuencia