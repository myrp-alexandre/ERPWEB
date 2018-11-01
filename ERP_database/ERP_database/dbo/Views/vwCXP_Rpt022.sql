CREATE view vwCXP_Rpt022 as
SELECT        dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp, dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp, dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
                         dbo.cp_nota_DebCre.IdEmpresa, dbo.cp_nota_DebCre.IdCbteCble_Nota, dbo.cp_nota_DebCre.IdTipoCbte_Nota, dbo.cp_nota_DebCre.DebCre, 
                         dbo.cp_nota_DebCre.IdProveedor, dbo.cp_nota_DebCre.IdSucursal, dbo.cp_nota_DebCre.cn_fecha, dbo.cp_nota_DebCre.cn_serie1, dbo.cp_nota_DebCre.cn_serie2, 
                         dbo.cp_nota_DebCre.cn_Nota, dbo.cp_nota_DebCre.cn_observacion, dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.IdCtaCble, 
                         ISNULL(dbo.ct_cbtecble_det.IdCentroCosto, '') AS IdCentroCosto, ISNULL(dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, '') 
                         AS IdCentroCosto_sub_centro_costo, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_cbtecble_det.dc_Observacion, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_sucCentro_costo, dbo.cp_nota_DebCre.IdTipoNota, dbo.ct_plancta.pc_Cuenta AS nom_cuenta, 
                         dbo.cp_nota_DebCre.cn_subtotal_iva, dbo.cp_nota_DebCre.cn_subtotal_siniva, dbo.cp_nota_DebCre.cn_baseImponible, dbo.cp_nota_DebCre.cn_total
FROM            dbo.cp_nota_DebCre INNER JOIN
                         dbo.cp_orden_pago_cancelaciones ON dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago AND 
                         dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago AND 
                         dbo.cp_nota_DebCre.IdCbteCble_Nota = dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.cp_nota_DebCre.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdCbteCble_Nota = dbo.ct_cbtecble_det.IdCbteCble AND dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto