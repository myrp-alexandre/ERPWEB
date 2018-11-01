CREATE VIEW [web].[VWCXP_004]
AS
SELECT cp_orden_pago.IdEmpresa, cp_orden_pago.IdOrdenPago, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, cp_orden_pago.Fecha, cp_orden_pago.Observacion, cp_orden_pago.Estado, ct_cbtecble_det.IdCtaCble, 
                  ct_plancta.pc_Cuenta, ct_cbtecble_det.dc_Valor, CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Debe, 
                  CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Haber, ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble_det.dc_Observacion, tb_persona.pe_nombreCompleto, 
                  cp_orden_pago.IdTipo_op, cp_orden_pago_det.Valor_a_pagar, og.co_factura, ti.Descripcion, ti.GeneraDiario, ap.IdEstadoAprobacion, ap.Descripcion as estado_apro
FROM     ct_cbtecble INNER JOIN
                  ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                  ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                  ct_cbtecble_tipo ON ct_cbtecble.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                  cp_orden_pago_det ON ct_cbtecble.IdEmpresa = cp_orden_pago_det.IdEmpresa_cxp AND ct_cbtecble.IdTipoCbte = cp_orden_pago_det.IdTipoCbte_cxp AND ct_cbtecble.IdCbteCble = cp_orden_pago_det.IdCbteCble_cxp INNER JOIN
                  cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
                  tb_persona ON cp_orden_pago.IdPersona = tb_persona.IdPersona left join cp_orden_giro as og
				  on ct_cbtecble_det.IdEmpresa = og.IdEmpresa and ct_cbtecble_det.IdTipoCbte = og.IdTipoCbte_Ogiro and ct_cbtecble_det.IdCbteCble = og.IdCbteCble_Ogiro inner join cp_orden_pago_tipo as ti
				  on ti.IdTipo_op = cp_orden_pago.IdTipo_op inner join cp_orden_pago_estado_aprob as ap on ap.IdEstadoAprobacion = cp_orden_pago.IdEstadoAprobacion
