CREATE VIEW [Fj_servindustrias].[vwfa_pre_facturacion_det_Fact_x_Gastos_data]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM     (SELECT dbo.ct_cbtecble.IdEmpresa, dbo.ct_cbtecble.IdTipoCbte, dbo.ct_cbtecble.IdCbteCble,dbo.ct_cbtecble_det.secuencia,0 as IdCuota, 0 as secuencia_cuota, dbo.cp_orden_giro.co_factura, dbo.cp_orden_giro.co_observacion, dbo.cp_orden_giro.co_total, dbo.ct_cbtecble_det.IdCentroCosto, 
                                    dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.IdPunto_cargo, dbo.ct_cbtecble_det.dc_Valor AS subtotal_sin_iva, dbo.cp_orden_giro.co_Por_iva, 
                                    CASE WHEN cp_orden_giro.co_valoriva > 0 THEN ct_cbtecble_det.dc_Valor * (cp_orden_giro.co_Por_iva / 100) ELSE 0 END AS valor_iva, dbo.cp_orden_giro.co_FechaFactura, 
                                    dbo.ct_cbtecble_det.dc_Valor + CASE WHEN cp_orden_giro.co_valoriva > 0 THEN ct_cbtecble_det.dc_Valor * (cp_orden_giro.co_Por_iva / 100) ELSE 0 END AS Total, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, 
                                    dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.tb_persona.pe_nombreCompleto, 'FACTURA' AS Tipo, 1 AS Cantidad, 
                                    dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo, dbo.caj_Caja_Movimiento_Tipo_grupo.tg_descripcion
                  FROM      dbo.caj_Caja_Movimiento_Tipo_grupo RIGHT OUTER JOIN
                                    dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi_grupo RIGHT OUTER JOIN
                                    dbo.cp_orden_giro INNER JOIN
                                    dbo.ct_cbtecble ON dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.ct_cbtecble.IdTipoCbte AND dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.ct_cbtecble.IdCbteCble AND 
                                    dbo.cp_orden_giro.IdEmpresa = dbo.ct_cbtecble.IdEmpresa INNER JOIN
                                    dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                                    dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                                    dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                                    dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona ON dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi = dbo.cp_orden_giro.IdTipoMovi LEFT OUTER JOIN
                                    dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                                    dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                                    dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                                    dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                                    dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                                    dbo.vwcp_Retencion_valor_total_x_cbte_cxp ON dbo.cp_orden_giro.IdEmpresa = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdEmpresa_Ogiro AND 
                                    dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdTipoCbte_Ogiro AND dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdCbteCble_Ogiro
                  WHERE   (dbo.cp_orden_giro.Estado = 'A') AND (dbo.ct_cbtecble_det.IdCentroCosto IS NOT NULL) AND (dbo.ct_cbtecble_det.dc_Valor > 0) AND (NOT EXISTS
                                        (SELECT IdEmpresa, IdCuota, IdEmpresa_ct, IdTipoCbte, IdCbteCble, Total_a_pagar, Num_cuotas, Dias_plazo, Fecha_inicio, Estado, Observacion
                                         FROM      dbo.cp_cuotas_x_doc
                                         WHERE   (dbo.cp_orden_giro.IdEmpresa = IdEmpresa) AND (dbo.cp_orden_giro.IdTipoCbte_Ogiro = IdTipoCbte) AND (dbo.cp_orden_giro.IdCbteCble_Ogiro = IdCbteCble)))
                  UNION
SELECT dbo.cp_cuotas_x_doc.IdEmpresa, dbo.cp_cuotas_x_doc.IdTipoCbte, dbo.cp_cuotas_x_doc.IdCbteCble, dbo.ct_cbtecble_det.secuencia,dbo.cp_cuotas_x_doc_det.IdCuota, dbo.cp_cuotas_x_doc_det.Secuencia AS secuencia_cuota, dbo.cp_orden_giro.co_factura, dbo.cp_orden_giro.co_observacion, dbo.cp_orden_giro.co_total, 
                  dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.IdPunto_cargo, dbo.ct_cbtecble_det.dc_Valor / cuota.numero_cuotas AS subtotal_sin_iva, dbo.cp_orden_giro.co_Por_iva, 
                  CASE WHEN cp_orden_giro.co_valoriva > 0 THEN (ct_cbtecble_det.dc_Valor / cuota.numero_cuotas) * (cp_orden_giro.co_Por_iva / 100) ELSE 0 END AS valor_iva, dbo.cp_cuotas_x_doc_det.Fecha_vcto_cuota, 
                  dbo.ct_cbtecble_det.dc_Valor / cuota.numero_cuotas + CASE WHEN cp_orden_giro.co_valoriva > 0 THEN (ct_cbtecble_det.dc_Valor / cuota.numero_cuotas) * (cp_orden_giro.co_Por_iva / 100) ELSE 0 END AS Total, 
                  dbo.ct_centro_costo.Centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Expr1, dbo.ct_punto_cargo.nom_punto_cargo, dbo.tb_persona.pe_nombreCompleto, 'FACTURA' AS Tipo, 1 AS Cantidad, 
                  dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo, dbo.caj_Caja_Movimiento_Tipo_grupo.tg_descripcion
FROM     dbo.caj_Caja_Movimiento_Tipo_grupo RIGHT OUTER JOIN
                  dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi_grupo RIGHT OUTER JOIN
                  dbo.cp_cuotas_x_doc_det INNER JOIN
                  dbo.cp_cuotas_x_doc ON dbo.cp_cuotas_x_doc_det.IdEmpresa = dbo.cp_cuotas_x_doc.IdEmpresa AND dbo.cp_cuotas_x_doc_det.IdCuota = dbo.cp_cuotas_x_doc.IdCuota INNER JOIN
                  dbo.cp_orden_giro ON dbo.cp_cuotas_x_doc.IdEmpresa_ct = dbo.cp_orden_giro.IdEmpresa AND dbo.cp_cuotas_x_doc.IdTipoCbte = dbo.cp_orden_giro.IdTipoCbte_Ogiro AND 
                  dbo.cp_cuotas_x_doc.IdCbteCble = dbo.cp_orden_giro.IdCbteCble_Ogiro INNER JOIN
                  dbo.ct_cbtecble_det ON dbo.cp_orden_giro.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.ct_cbtecble_det.IdTipoCbte AND 
                  dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                  dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                  dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona ON dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi = dbo.cp_orden_giro.IdTipoMovi LEFT OUTER JOIN
                  dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto AND dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                      (SELECT cp_cuotas_x_doc_1.IdEmpresa, cp_cuotas_x_doc_1.IdTipoCbte, cp_cuotas_x_doc_1.IdCbteCble, COUNT(cp_cuotas_x_doc_det_1.IdCuota) AS numero_cuotas
                       FROM      dbo.cp_cuotas_x_doc_det AS cp_cuotas_x_doc_det_1 INNER JOIN
                                         dbo.cp_cuotas_x_doc AS cp_cuotas_x_doc_1 ON cp_cuotas_x_doc_det_1.IdEmpresa = cp_cuotas_x_doc_1.IdEmpresa AND cp_cuotas_x_doc_det_1.IdCuota = cp_cuotas_x_doc_1.IdCuota
                       GROUP BY cp_cuotas_x_doc_1.IdEmpresa, cp_cuotas_x_doc_1.IdTipoCbte, cp_cuotas_x_doc_1.IdCbteCble) AS cuota ON dbo.cp_orden_giro.IdEmpresa = cuota.IdEmpresa AND 
                  dbo.cp_orden_giro.IdTipoCbte_Ogiro = cuota.IdTipoCbte AND dbo.cp_orden_giro.IdCbteCble_Ogiro = cuota.IdCbteCble
WHERE  (dbo.cp_orden_giro.Estado = 'A') AND (dbo.ct_cbtecble_det.IdCentroCosto IS NOT NULL) AND (dbo.ct_cbtecble_det.dc_Valor > 0)
                  UNION
                  SELECT dbo.caj_Caja_Movimiento.IdEmpresa, dbo.caj_Caja_Movimiento.IdTipocbte, dbo.caj_Caja_Movimiento.IdCbteCble,ct_cbtecble_det.secuencia,0 as IdCuota,0 as secuencia_cuota, 'VAL ' + CAST(dbo.caj_Caja_Movimiento.IdCbteCble AS VARCHAR(20)) AS Expr1, 
                                    dbo.caj_Caja_Movimiento.cm_observacion, dbo.caj_Caja_Movimiento.cm_valor, dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.IdPunto_cargo, 
                                    dbo.caj_Caja_Movimiento.cm_valor AS Expr2, 0 AS por_iva, 0 AS valor_iva, dbo.caj_Caja_Movimiento.cm_fecha, dbo.caj_Caja_Movimiento.cm_valor AS Expr3, dbo.ct_centro_costo.Centro_costo, 
                                    dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Expr4, dbo.ct_punto_cargo.nom_punto_cargo, dbo.tb_persona.pe_nombreCompleto, 'VALE' AS Tipo, 1 AS Cantidad, 
                                    dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo, dbo.caj_Caja_Movimiento_Tipo_grupo.tg_descripcion
                  FROM     dbo.caj_Caja_Movimiento_Tipo_grupo RIGHT OUTER JOIN
                                    dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi_grupo RIGHT OUTER JOIN
                                    dbo.cp_conciliacion_Caja_det_x_ValeCaja INNER JOIN
                                    dbo.caj_Caja_Movimiento ON dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = dbo.caj_Caja_Movimiento.IdEmpresa AND 
                                    dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = dbo.caj_Caja_Movimiento.IdCbteCble AND dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = dbo.caj_Caja_Movimiento.IdTipocbte INNER JOIN
                                    dbo.ct_cbtecble_det ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.caj_Caja_Movimiento.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble AND 
                                    dbo.caj_Caja_Movimiento.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                                    dbo.tb_persona ON dbo.caj_Caja_Movimiento.IdPersona = dbo.tb_persona.IdPersona ON dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi = dbo.caj_Caja_Movimiento.IdTipoMovi LEFT OUTER JOIN
                                    dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                                    dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                                    dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                                    dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                                    dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto
                  WHERE  (dbo.ct_cbtecble_det.IdCentroCosto IS NOT NULL) AND (dbo.ct_cbtecble_det.dc_Valor > 0) AND (dbo.caj_Caja_Movimiento.Estado = 'A')
                  UNION
                  SELECT dbo.ct_cbtecble_det.IdEmpresa, dbo.ct_cbtecble_det.IdTipoCbte, dbo.ct_cbtecble_det.IdCbteCble,dbo.ct_cbtecble_det.secuencia, 0 as IdCuota, 0 as secuencia_cuota, 'OP ' + CAST(dbo.cp_orden_pago.IdOrdenPago AS VARCHAR(20)) AS Expr1, dbo.cp_orden_pago.Observacion, 
                                    dbo.cp_orden_pago_det.Valor_a_pagar, dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.IdPunto_cargo, dbo.ct_cbtecble_det.dc_Valor, 0 AS por_iva, 
                                    0 AS valor_iva, dbo.cp_orden_pago.Fecha, dbo.cp_orden_pago_det.Valor_a_pagar AS Expr2, dbo.ct_centro_costo.Centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Expr3, 
                                    dbo.ct_punto_cargo.nom_punto_cargo, dbo.tb_persona.pe_nombreCompleto, 'OP' AS Tipo, 1 AS Cantidad, dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo, dbo.caj_Caja_Movimiento_Tipo_grupo.tg_descripcion
                  FROM     dbo.caj_Caja_Movimiento_Tipo_grupo RIGHT OUTER JOIN
                                    dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi_grupo RIGHT OUTER JOIN
                                    dbo.cp_orden_pago INNER JOIN
                                    dbo.cp_orden_pago_det ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa AND dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_det.IdOrdenPago INNER JOIN
                                    dbo.ct_cbtecble_det ON dbo.cp_orden_pago_det.IdEmpresa_cxp = dbo.ct_cbtecble_det.IdEmpresa AND dbo.cp_orden_pago_det.IdTipoCbte_cxp = dbo.ct_cbtecble_det.IdTipoCbte AND 
                                    dbo.cp_orden_pago_det.IdCbteCble_cxp = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                                    dbo.tb_persona ON dbo.cp_orden_pago.IdPersona = dbo.tb_persona.IdPersona ON dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi = dbo.cp_orden_pago.IdTipoMovi LEFT OUTER JOIN
                                    dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                                    dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                                    dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                                    dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                                    dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
                  WHERE  (dbo.ct_cbtecble_det.IdCentroCosto IS NOT NULL) AND (dbo.ct_cbtecble_det.dc_Valor > 0) AND (dbo.cp_orden_pago.Estado = 'A') AND (NOT EXISTS
                                        (SELECT IdEmpresa
                                         FROM      dbo.cp_orden_giro AS og
                                         WHERE   (dbo.cp_orden_pago_det.IdEmpresa_cxp = IdEmpresa) AND (dbo.cp_orden_pago_det.IdTipoCbte_cxp = IdTipoCbte_Ogiro) AND (dbo.cp_orden_pago_det.IdCbteCble_cxp = IdCbteCble_Ogiro))) AND 
                                    (NOT EXISTS
                                        (SELECT IdEmpresa
                                         FROM      dbo.cp_nota_DebCre AS nd
                                         WHERE   (dbo.cp_orden_pago_det.IdEmpresa_cxp = IdEmpresa) AND (dbo.cp_orden_pago_det.IdTipoCbte_cxp = IdTipoCbte_Nota) AND (dbo.cp_orden_pago_det.IdCbteCble_cxp = IdCbteCble_Nota)))) A