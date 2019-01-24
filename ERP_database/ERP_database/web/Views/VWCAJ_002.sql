CREATE VIEW [web].[VWCAJ_002]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM     (SELECT dbo.cp_conciliacion_Caja_det.IdEmpresa, dbo.cp_conciliacion_Caja_det.IdConciliacion_Caja, dbo.cp_conciliacion_Caja_det.Secuencia, dbo.cp_conciliacion_Caja_det.IdEmpresa_OGiro, 
                                    dbo.cp_conciliacion_Caja_det.IdTipoCbte_Ogiro, dbo.cp_conciliacion_Caja_det.IdCbteCble_Ogiro, dbo.cp_orden_giro.co_factura, dbo.tb_persona.pe_nombreCompleto, dbo.cp_orden_giro.co_FechaFactura, 
                                    dbo.cp_orden_giro.co_total, ISNULL(ret.valor_retencion, 0) AS valor_retencion, dbo.cp_orden_giro.co_total - ISNULL(ret.valor_retencion, 0) AS valor_a_pagar, dbo.cp_conciliacion_Caja_det.Valor_a_aplicar, 
                                    dbo.cp_orden_giro.co_observacion, dbo.cp_conciliacion_Caja.Saldo_cont_al_periodo, dbo.cp_conciliacion_Caja.Ingresos, ABS(dbo.cp_conciliacion_Caja.Total_fact_vale) AS Total_fact_vale, 
                                    dbo.cp_conciliacion_Caja.Dif_x_pagar_o_cobrar, 'FACTURA' AS TIPO, dbo.cp_conciliacion_Caja.Fecha_ini, dbo.cp_conciliacion_Caja.Fecha_fin, op.Valor_a_pagar AS valor_a_reponer, 
                                    dbo.caj_Caja.ca_Descripcion AS NombreCaja, '' AS tm_descripcion, dbo.cp_conciliacion_Caja.IdUsuarioCreacion, U.Nombre AS NombreUsuario, tb_sucursal.Su_Descripcion
                  FROM      dbo.cp_conciliacion_Caja INNER JOIN
                                    dbo.cp_conciliacion_Caja_det ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.cp_conciliacion_Caja_det.IdEmpresa AND 
                                    dbo.cp_conciliacion_Caja.IdConciliacion_Caja = dbo.cp_conciliacion_Caja_det.IdConciliacion_Caja INNER JOIN
                                    dbo.cp_orden_giro ON dbo.cp_conciliacion_Caja_det.IdEmpresa_OGiro = dbo.cp_orden_giro.IdEmpresa AND dbo.cp_conciliacion_Caja_det.IdCbteCble_Ogiro = dbo.cp_orden_giro.IdCbteCble_Ogiro AND 
                                    dbo.cp_conciliacion_Caja_det.IdTipoCbte_Ogiro = dbo.cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                                    dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                                    dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                                        (SELECT cp_orden_giro_1.IdEmpresa, cp_orden_giro_1.IdTipoCbte_Ogiro, cp_orden_giro_1.IdCbteCble_Ogiro, SUM(dbo.cp_retencion_det.re_valor_retencion) AS valor_retencion
                                         FROM      dbo.cp_orden_giro AS cp_orden_giro_1 INNER JOIN
                                                           dbo.cp_retencion ON cp_orden_giro_1.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro AND cp_orden_giro_1.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND 
                                                           cp_orden_giro_1.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                                                           dbo.cp_retencion_det ON dbo.cp_retencion.IdEmpresa = dbo.cp_retencion_det.IdEmpresa AND dbo.cp_retencion.IdRetencion = dbo.cp_retencion_det.IdRetencion
                                         GROUP BY cp_orden_giro_1.IdEmpresa, cp_orden_giro_1.IdTipoCbte_Ogiro, cp_orden_giro_1.IdCbteCble_Ogiro) AS ret ON dbo.cp_orden_giro.IdEmpresa = ret.IdEmpresa AND 
                                    dbo.cp_orden_giro.IdTipoCbte_Ogiro = ret.IdTipoCbte_Ogiro AND dbo.cp_orden_giro.IdCbteCble_Ogiro = ret.IdCbteCble_Ogiro LEFT OUTER JOIN
                                        (SELECT IdEmpresa, IdOrdenPago, Valor_a_pagar
                                         FROM      dbo.cp_orden_pago_det) AS op ON op.IdEmpresa = dbo.cp_conciliacion_Caja.IdEmpresa AND op.IdOrdenPago = dbo.cp_conciliacion_Caja.IdOrdenPago_op INNER JOIN
                                    dbo.caj_Caja ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.caj_Caja.IdEmpresa AND dbo.cp_conciliacion_Caja.IdCaja = dbo.caj_Caja.IdCaja INNER JOIN
                                    dbo.tb_sucursal ON dbo.caj_Caja.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.caj_Caja.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT JOIN
                                    dbo.caj_Caja_Movimiento_Tipo ON dbo.cp_orden_giro.IdEmpresa = dbo.caj_Caja_Movimiento_Tipo.IdEmpresa AND dbo.cp_orden_giro.IdTipoMovi = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi LEFT OUTER JOIN
                                    dbo.seg_usuario AS U ON U.IdUsuario = dbo.cp_conciliacion_Caja.IdUsuarioCreacion
                  UNION ALL
                  SELECT dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja, dbo.cp_conciliacion_Caja_det_x_ValeCaja.Secuencia, 
                                    dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, NULL AS co_factura, 
                                    dbo.tb_persona.pe_nombreCompleto, dbo.caj_Caja_Movimiento.cm_fecha, dbo.caj_Caja_Movimiento.cm_valor, 0 AS valor_retencion, dbo.caj_Caja_Movimiento.cm_valor AS valor_a_pagar, 
                                    dbo.caj_Caja_Movimiento.cm_valor AS valor_a_aplicar, dbo.caj_Caja_Movimiento.cm_observacion, dbo.cp_conciliacion_Caja.Saldo_cont_al_periodo, dbo.cp_conciliacion_Caja.Ingresos, 
                                    ABS(dbo.cp_conciliacion_Caja.Total_fact_vale) AS Total_fact_vale, dbo.cp_conciliacion_Caja.Dif_x_pagar_o_cobrar, 'VALE' AS TIPO, dbo.cp_conciliacion_Caja.Fecha_ini, dbo.cp_conciliacion_Caja.Fecha_fin, 
                                    op.Valor_a_pagar AS valor_a_reponer, dbo.caj_Caja.ca_Descripcion AS NombreCaja, dbo.caj_Caja_Movimiento_Tipo.tm_descripcion, dbo.cp_conciliacion_Caja.IdUsuarioCreacion, U.Nombre AS NombreUsuario, 
                                    tb_sucursal.Su_Descripcion
                  FROM     dbo.cp_conciliacion_Caja INNER JOIN
                                    dbo.cp_conciliacion_Caja_det_x_ValeCaja ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa AND 
                                    dbo.cp_conciliacion_Caja.IdConciliacion_Caja = dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja INNER JOIN
                                    dbo.caj_Caja_Movimiento ON dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = dbo.caj_Caja_Movimiento.IdEmpresa AND 
                                    dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = dbo.caj_Caja_Movimiento.IdCbteCble AND dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = dbo.caj_Caja_Movimiento.IdTipocbte INNER JOIN
                                    dbo.ct_cbtecble ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.ct_cbtecble.IdEmpresa AND dbo.caj_Caja_Movimiento.IdTipocbte = dbo.ct_cbtecble.IdTipoCbte AND 
                                    dbo.caj_Caja_Movimiento.IdCbteCble = dbo.ct_cbtecble.IdCbteCble LEFT OUTER JOIN
                                    dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento_Tipo.IdEmpresa = dbo.caj_Caja_Movimiento.IdEmpresa AND dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi = dbo.caj_Caja_Movimiento.IdTipoMovi INNER JOIN
                                    dbo.tb_persona ON dbo.caj_Caja_Movimiento.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                                        (SELECT IdEmpresa, IdOrdenPago, Valor_a_pagar
                                         FROM      dbo.cp_orden_pago_det) AS op ON op.IdEmpresa = dbo.cp_conciliacion_Caja.IdEmpresa AND op.IdOrdenPago = dbo.cp_conciliacion_Caja.IdOrdenPago_op INNER JOIN
                                    dbo.caj_Caja ON dbo.cp_conciliacion_Caja.IdEmpresa = dbo.caj_Caja.IdEmpresa AND dbo.cp_conciliacion_Caja.IdCaja = dbo.caj_Caja.IdCaja INNER JOIN
                                    dbo.tb_sucursal ON dbo.caj_Caja.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.caj_Caja.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                                    dbo.seg_usuario AS U ON U.IdUsuario = dbo.cp_conciliacion_Caja.IdUsuarioCreacion) A
