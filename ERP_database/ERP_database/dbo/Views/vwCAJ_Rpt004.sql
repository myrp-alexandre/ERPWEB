CREATE VIEW [dbo].[vwCAJ_Rpt004]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM     (SELECT cp_conciliacion_Caja_det.IdEmpresa, cp_conciliacion_Caja_det.IdConciliacion_Caja, cp_conciliacion_Caja_det.Secuencia, cp_conciliacion_Caja_det.IdEmpresa_OGiro, cp_conciliacion_Caja_det.IdTipoCbte_Ogiro, 
                                    cp_conciliacion_Caja_det.IdCbteCble_Ogiro, cp_orden_giro.co_factura, tb_persona.pe_nombreCompleto, cp_orden_giro.co_FechaFactura, cp_orden_giro.co_total, isnull(ret.valor_retencion, 0) valor_retencion, 
                                    cp_orden_giro.co_total - isnull(ret.valor_retencion, 0) AS valor_a_pagar, cp_conciliacion_Caja_det.Valor_a_aplicar, cp_orden_giro.co_observacion, cp_conciliacion_Caja.Saldo_cont_al_periodo, cp_conciliacion_Caja.Ingresos, 
                                    abs(cp_conciliacion_Caja.Total_fact_vale) Total_fact_vale, cp_conciliacion_Caja.Dif_x_pagar_o_cobrar, 'FACTURA' AS TIPO, cp_conciliacion_Caja.Fecha_ini, cp_conciliacion_Caja.Fecha_fin, op.Valor_a_pagar valor_a_reponer
                  FROM      cp_conciliacion_Caja INNER JOIN
                                    cp_conciliacion_Caja_det ON cp_conciliacion_Caja.IdEmpresa = cp_conciliacion_Caja_det.IdEmpresa AND cp_conciliacion_Caja.IdConciliacion_Caja = cp_conciliacion_Caja_det.IdConciliacion_Caja INNER JOIN
                                    cp_orden_giro ON cp_conciliacion_Caja_det.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND cp_conciliacion_Caja_det.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND 
                                    cp_conciliacion_Caja_det.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                                    cp_proveedor ON cp_orden_giro.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_giro.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                                    tb_persona ON cp_proveedor.IdPersona = tb_persona.IdPersona LEFT JOIN
                                        (SELECT cp_orden_giro.IdEmpresa, cp_orden_giro.IdTipoCbte_Ogiro, cp_orden_giro.IdCbteCble_Ogiro, SUM(cp_retencion_det.re_valor_retencion) AS valor_retencion
                                         FROM      cp_orden_giro INNER JOIN
                                                           cp_retencion ON cp_orden_giro.IdEmpresa = cp_retencion.IdEmpresa_Ogiro AND cp_orden_giro.IdCbteCble_Ogiro = cp_retencion.IdCbteCble_Ogiro AND 
                                                           cp_orden_giro.IdTipoCbte_Ogiro = cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                                                           cp_retencion_det ON cp_retencion.IdEmpresa = cp_retencion_det.IdEmpresa AND cp_retencion.IdRetencion = cp_retencion_det.IdRetencion
                                         GROUP BY cp_orden_giro.IdEmpresa, cp_orden_giro.IdTipoCbte_Ogiro, cp_orden_giro.IdCbteCble_Ogiro) AS ret ON cp_orden_giro.IdEmpresa = ret.IdEmpresa AND 
                                    cp_orden_giro.IdTipoCbte_Ogiro = ret.IdTipoCbte_Ogiro AND cp_orden_giro.IdCbteCble_Ogiro = ret.IdCbteCble_Ogiro
									LEFT JOIN (
									SELECT IdEmpresa,IdOrdenPago,Valor_a_pagar FROM cp_orden_pago_det									
									) op on op.IdEmpresa = cp_conciliacion_Caja.IdEmpresa and op.IdOrdenPago = cp_conciliacion_Caja.IdOrdenPago_op
                  UNION ALL
                  SELECT cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa, cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja, cp_conciliacion_Caja_det_x_ValeCaja.Secuencia, cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja, 
                                    cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, NULL AS co_factura, tb_persona.pe_nombreCompleto, caj_Caja_Movimiento.cm_fecha, 
                                    caj_Caja_Movimiento.cm_valor, 0 AS valor_retencion, caj_Caja_Movimiento.cm_valor AS valor_a_pagar, caj_Caja_Movimiento.cm_valor AS valor_a_aplicar, caj_Caja_Movimiento.cm_observacion, 
                                    cp_conciliacion_Caja.Saldo_cont_al_periodo, cp_conciliacion_Caja.Ingresos, abs(cp_conciliacion_Caja.Total_fact_vale) Total_fact_vale, cp_conciliacion_Caja.Dif_x_pagar_o_cobrar, 'VALE' AS TIPO, 
                                    cp_conciliacion_Caja.Fecha_ini, cp_conciliacion_Caja.Fecha_fin, op.Valor_a_pagar valor_a_reponer
                  FROM     cp_conciliacion_Caja INNER JOIN
                                    cp_conciliacion_Caja_det_x_ValeCaja ON cp_conciliacion_Caja.IdEmpresa = cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa AND 
                                    cp_conciliacion_Caja.IdConciliacion_Caja = cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja INNER JOIN
                                    caj_Caja_Movimiento ON cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = caj_Caja_Movimiento.IdEmpresa AND cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = caj_Caja_Movimiento.IdCbteCble AND 
                                    cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = caj_Caja_Movimiento.IdTipocbte INNER JOIN
                                    ct_cbtecble ON caj_Caja_Movimiento.IdEmpresa = ct_cbtecble.IdEmpresa AND caj_Caja_Movimiento.IdTipocbte = ct_cbtecble.IdTipoCbte AND caj_Caja_Movimiento.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
                                    tb_persona ON caj_Caja_Movimiento.IdPersona = tb_persona.IdPersona
									LEFT JOIN (
									SELECT IdEmpresa,IdOrdenPago,Valor_a_pagar FROM cp_orden_pago_det									
									) op on op.IdEmpresa = cp_conciliacion_Caja.IdEmpresa and op.IdOrdenPago = cp_conciliacion_Caja.IdOrdenPago_op) A