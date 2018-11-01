CREATE view [dbo].[vwct_cbtecble_x_cp_Conciliacion_caja]
as
SELECT        cp_conciliacion_Caja_det.IdEmpresa, cp_conciliacion_Caja_det.IdConciliacion_Caja, ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble_det.IdEmpresa AS IdEmpresa_cbte, 
                         ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta AS nom_Cuenta, 
                         ct_cbtecble_det.IdCentroCosto, ct_centro_costo.Centro_costo AS nom_Centro_costo, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, 
                         ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS Debe, 
                         CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ct_cbtecble_det.dc_Valor * - 1 ELSE 0 END AS Haber, ct_cbtecble_det.dc_Observacion, 
                         ct_cbtecble_det.IdPunto_cargo, ct_cbtecble_det.IdPunto_cargo_grupo, ct_punto_cargo_grupo.nom_punto_cargo_grupo, ct_punto_cargo.nom_punto_cargo
FROM            ct_centro_costo_sub_centro_costo RIGHT OUTER JOIN
                         ct_cbtecble_tipo INNER JOIN
                         cp_conciliacion_Caja_det INNER JOIN
                         cp_orden_giro ON cp_conciliacion_Caja_det.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND 
                         cp_conciliacion_Caja_det.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND 
                         cp_conciliacion_Caja_det.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                         ct_cbtecble_det ON cp_orden_giro.IdEmpresa = ct_cbtecble_det.IdEmpresa AND cp_orden_giro.IdCbteCble_Ogiro = ct_cbtecble_det.IdCbteCble AND 
                         cp_orden_giro.IdTipoCbte_Ogiro = ct_cbtecble_det.IdTipoCbte INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble ON 
                         ct_cbtecble_tipo.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble_tipo.IdTipoCbte = ct_cbtecble_det.IdTipoCbte LEFT OUTER JOIN
                         ct_centro_costo ON ct_cbtecble_det.IdEmpresa = ct_centro_costo.IdEmpresa AND ct_cbtecble_det.IdCentroCosto = ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         ct_punto_cargo_grupo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo ON 
                         ct_centro_costo_sub_centro_costo.IdEmpresa = ct_cbtecble_det.IdEmpresa AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto = ct_cbtecble_det.IdCentroCosto AND 
                         ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = ct_cbtecble_det.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         ct_punto_cargo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo.IdEmpresa AND ct_cbtecble_det.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = ct_punto_cargo.IdPunto_cargo_grupo
UNION
SELECT        cp_conciliacion_Caja_det.IdEmpresa, cp_conciliacion_Caja_det.IdConciliacion_Caja, ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble_det.IdEmpresa AS IdEmpresa_cbte, 
                         ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta AS nom_Cuenta, 
                         ct_cbtecble_det.IdCentroCosto, ct_centro_costo.Centro_costo AS nom_Centro_costo, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, 
                         ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS Debe, 
                         CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ct_cbtecble_det.dc_Valor * - 1 ELSE 0 END AS Haber, ct_cbtecble_det.dc_Observacion, 
                         ct_cbtecble_det.IdPunto_cargo, ct_cbtecble_det.IdPunto_cargo_grupo, ct_punto_cargo_grupo.nom_punto_cargo_grupo, ct_punto_cargo.nom_punto_cargo
FROM            ct_punto_cargo RIGHT OUTER JOIN
                         ct_centro_costo RIGHT OUTER JOIN
                         cp_conciliacion_Caja_det INNER JOIN
                         cp_orden_pago_det INNER JOIN
                         cp_orden_pago_cancelaciones ON cp_orden_pago_det.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_op AND 
                         cp_orden_pago_det.IdOrdenPago = cp_orden_pago_cancelaciones.IdOrdenPago_op AND 
                         cp_orden_pago_det.Secuencia = cp_orden_pago_cancelaciones.Secuencia_op ON cp_conciliacion_Caja_det.IdEmpresa_OP = cp_orden_pago_det.IdEmpresa AND 
                         cp_conciliacion_Caja_det.IdOrdenPago_OP = cp_orden_pago_det.IdOrdenPago INNER JOIN
                         ct_plancta INNER JOIN
                         ct_cbtecble_det ON ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble INNER JOIN
                         ct_cbtecble_tipo ON ct_cbtecble_det.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte ON 
                         cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble_det.IdEmpresa AND cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble_det.IdTipoCbte AND
                          cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble_det.IdCbteCble ON ct_centro_costo.IdEmpresa = ct_cbtecble_det.IdEmpresa AND 
                         ct_centro_costo.IdCentroCosto = ct_cbtecble_det.IdCentroCosto LEFT OUTER JOIN
                         ct_punto_cargo_grupo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo LEFT OUTER JOIN
                         ct_centro_costo_sub_centro_costo ON ct_cbtecble_det.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         ct_cbtecble_det.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         ct_cbtecble_det.IdCentroCosto_sub_centro_costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo ON 
                         ct_punto_cargo.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_punto_cargo.IdPunto_cargo = ct_cbtecble_det.IdPunto_cargo AND 
                         ct_punto_cargo.IdPunto_cargo_grupo = ct_cbtecble_det.IdPunto_cargo_grupo
UNION
SELECT        cp_conciliacion_Caja_det.IdEmpresa, cp_conciliacion_Caja_det.IdConciliacion_Caja, ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble_det.IdEmpresa AS IdEmpresa_cbte, 
                         ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta AS nom_Cuenta, 
                         ct_cbtecble_det.IdCentroCosto, ct_centro_costo.Centro_costo AS nom_Centro_costo, ct_cbtecble_det.IdCentroCosto_sub_centro_costo, 
                         ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS Debe, 
                         CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ct_cbtecble_det.dc_Valor * - 1 ELSE 0 END AS Haber, ct_cbtecble_det.dc_Observacion, 
                         ct_cbtecble_det.IdPunto_cargo, ct_cbtecble_det.IdPunto_cargo_grupo, ct_punto_cargo_grupo.nom_punto_cargo_grupo, ct_punto_cargo.nom_punto_cargo
FROM            ct_punto_cargo RIGHT OUTER JOIN
                         ct_centro_costo RIGHT OUTER JOIN
                         cp_nota_DebCre INNER JOIN
                         cp_conciliacion_Caja_det ON cp_nota_DebCre.IdEmpresa = cp_conciliacion_Caja_det.IdEmpresa_OGiro AND 
                         cp_nota_DebCre.IdCbteCble_Nota = cp_conciliacion_Caja_det.IdCbteCble_Ogiro AND 
                         cp_nota_DebCre.IdTipoCbte_Nota = cp_conciliacion_Caja_det.IdTipoCbte_Ogiro INNER JOIN
                         ct_plancta INNER JOIN
                         ct_cbtecble_det ON ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble INNER JOIN
                         ct_cbtecble_tipo ON ct_cbtecble_det.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte ON 
                         cp_nota_DebCre.IdEmpresa = ct_cbtecble_det.IdEmpresa AND cp_nota_DebCre.IdTipoCbte_Nota = ct_cbtecble_det.IdTipoCbte AND 
                         cp_nota_DebCre.IdCbteCble_Nota = ct_cbtecble_det.IdCbteCble ON ct_centro_costo.IdEmpresa = ct_cbtecble_det.IdEmpresa AND 
                         ct_centro_costo.IdCentroCosto = ct_cbtecble_det.IdCentroCosto LEFT OUTER JOIN
                         ct_punto_cargo_grupo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo LEFT OUTER JOIN
                         ct_centro_costo_sub_centro_costo ON ct_cbtecble_det.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         ct_cbtecble_det.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         ct_cbtecble_det.IdCentroCosto_sub_centro_costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo ON 
                         ct_punto_cargo.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_punto_cargo.IdPunto_cargo = ct_cbtecble_det.IdPunto_cargo AND 
                         ct_punto_cargo.IdPunto_cargo_grupo = ct_cbtecble_det.IdPunto_cargo_grupo
UNION
SELECT        dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.ct_cbtecble_det.IdEmpresa AS IdEmpresa_cbte, dbo.ct_cbtecble_det.IdTipoCbte, dbo.ct_cbtecble_det.IdCbteCble, dbo.ct_cbtecble_det.secuencia, 
                         dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta AS nom_Cuenta, dbo.ct_cbtecble_det.IdCentroCosto, 
                         dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS Debe, 
                         CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ct_cbtecble_det.dc_Valor * - 1 ELSE 0 END AS Haber, dbo.ct_cbtecble_det.dc_Observacion, 
                         dbo.ct_cbtecble_det.IdPunto_cargo, dbo.ct_cbtecble_det.IdPunto_cargo_grupo, dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, 
                         dbo.ct_punto_cargo.nom_punto_cargo
FROM            dbo.ct_centro_costo RIGHT OUTER JOIN
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja INNER JOIN
                         dbo.ct_plancta INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_plancta.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_plancta.IdCtaCble = dbo.ct_cbtecble_det.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ct_cbtecble_det.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte ON 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = dbo.ct_cbtecble_det.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = dbo.ct_cbtecble_det.IdCbteCble LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo ON 
                         dbo.ct_centro_costo.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_centro_costo.IdCentroCosto = dbo.ct_cbtecble_det.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_punto_cargo_grupo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo.IdPunto_cargo_grupo
UNION
SELECT        dbo.cp_conciliacion_Caja.IdEmpresa, dbo.cp_conciliacion_Caja.IdConciliacion_Caja, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.ct_cbtecble_det.IdEmpresa AS IdEmpresa_cbte, dbo.ct_cbtecble_det.IdTipoCbte, dbo.ct_cbtecble_det.IdCbteCble, dbo.ct_cbtecble_det.secuencia, 
                         dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta AS nom_Cuenta, dbo.ct_cbtecble_det.IdCentroCosto, 
                         dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS Debe, 
                         CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ct_cbtecble_det.dc_Valor * - 1 ELSE 0 END AS Haber, dbo.ct_cbtecble_det.dc_Observacion, 
                         dbo.ct_cbtecble_det.IdPunto_cargo, dbo.ct_cbtecble_det.IdPunto_cargo_grupo, dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, 
                         dbo.ct_punto_cargo.nom_punto_cargo
FROM            dbo.ct_centro_costo_sub_centro_costo RIGHT OUTER JOIN
                         dbo.ct_plancta INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_plancta.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_plancta.IdCtaCble = dbo.ct_cbtecble_det.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.cp_orden_pago_cancelaciones INNER JOIN
                         dbo.cp_orden_pago INNER JOIN
                         dbo.cp_conciliacion_Caja ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_conciliacion_Caja.IdEmpresa_op AND 
                         dbo.cp_orden_pago.IdOrdenPago = dbo.cp_conciliacion_Caja.IdOrdenPago_op ON 
                         dbo.cp_orden_pago_cancelaciones.IdEmpresa_op = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdOrdenPago_op = dbo.cp_orden_pago.IdOrdenPago ON 
                         dbo.ct_cbtecble_det.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago AND 
                         dbo.ct_cbtecble_det.IdTipoCbte = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago AND 
                         dbo.ct_cbtecble_det.IdCbteCble = dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo.IdPunto_cargo_grupo LEFT OUTER JOIN
                         dbo.ct_punto_cargo_grupo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.ct_cbtecble_det.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo