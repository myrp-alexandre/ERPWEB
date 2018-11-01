CREATE VIEW web.VWCXP_005
AS
SELECT cp_conciliacion.IdEmpresa, cp_conciliacion.IdConciliacion, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble_det.dc_Valor, 
                  CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS dc_Valor_Debe, CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Haber, 
                  cp_conciliacion.Fecha, cp_conciliacion.Observacion, tb_persona.pe_nombreCompleto
FROM     cp_conciliacion INNER JOIN
                  cp_orden_pago_cancelaciones ON cp_conciliacion.IdCancelacion = cp_orden_pago_cancelaciones.Idcancelacion AND cp_conciliacion.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa INNER JOIN
                  cp_orden_pago_det ON cp_orden_pago_cancelaciones.IdOrdenPago_op = cp_orden_pago_det.IdOrdenPago AND cp_orden_pago_cancelaciones.Secuencia_op = cp_orden_pago_det.Secuencia AND 
                  cp_orden_pago_cancelaciones.IdEmpresa_op = cp_orden_pago_det.IdEmpresa INNER JOIN
                  cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                  tb_persona ON cp_orden_pago.IdPersona = tb_persona.IdPersona INNER JOIN
                  ct_plancta INNER JOIN
                  ct_cbtecble_det ON ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_det.IdEmpresa AND 
                  cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_det.IdTipoCbte AND cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble_det.IdCbteCble
GROUP BY cp_conciliacion.IdEmpresa, cp_conciliacion.IdConciliacion, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble_det.dc_Valor, 
                  cp_conciliacion.Fecha, cp_conciliacion.Observacion, tb_persona.pe_nombreCompleto
