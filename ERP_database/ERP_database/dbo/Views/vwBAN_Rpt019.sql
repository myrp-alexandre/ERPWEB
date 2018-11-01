CREATE view [dbo].[vwBAN_Rpt019]
as
SELECT        ba_Cbte_Ban.IdEmpresa, ba_Cbte_Ban.IdTipocbte, ba_Cbte_Ban.IdCbteCble, cp_orden_giro.IdCbteCble_Ogiro, 
                         cp_TipoDocumento.Codigo + '-' + cp_orden_giro.co_serie + '-' + cp_orden_giro.co_factura AS Referencia, cp_orden_pago_cancelaciones.MontoAplicado, 
                         cp_orden_giro.co_observacion, cp_orden_giro.co_FechaFactura AS co_fecha
FROM            ct_cbtecble INNER JOIN
                         cp_orden_pago_cancelaciones ON ct_cbtecble.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
                         ct_cbtecble.IdTipoCbte = cp_orden_pago_cancelaciones.IdTipoCbte_cxp AND ct_cbtecble.IdCbteCble = cp_orden_pago_cancelaciones.IdCbteCble_cxp INNER JOIN
                         ba_Cbte_Ban ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ba_Cbte_Ban.IdEmpresa AND 
                         cp_orden_pago_cancelaciones.IdCbteCble_pago = ba_Cbte_Ban.IdCbteCble AND 
                         cp_orden_pago_cancelaciones.IdTipoCbte_pago = ba_Cbte_Ban.IdTipocbte INNER JOIN
                         cp_orden_giro ON ct_cbtecble.IdEmpresa = cp_orden_giro.IdEmpresa AND ct_cbtecble.IdEmpresa = cp_orden_giro.IdEmpresa AND 
                         ct_cbtecble.IdTipoCbte = cp_orden_giro.IdTipoCbte_Ogiro AND ct_cbtecble.IdCbteCble = cp_orden_giro.IdCbteCble_Ogiro INNER JOIN
                         cp_TipoDocumento ON cp_orden_giro.IdOrden_giro_Tipo = cp_TipoDocumento.CodTipoDocumento
UNION
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdCbteCble, dbo.cp_nota_DebCre.IdCbteCble_Nota, 
                         Refencia = CASE WHEN dbo.cp_nota_DebCre.cn_Nota IS NULL OR
                         dbo.cp_nota_DebCre.cn_Nota = '' THEN 'ND#' + cast(cp_nota_DebCre.IdCbteCble_Nota AS varchar(20)) 
                         ELSE 'ND-' + dbo.cp_nota_DebCre.cn_serie1 + dbo.cp_nota_DebCre.cn_serie2 + '-' + dbo.cp_nota_DebCre.cn_Nota END, 
                         dbo.cp_orden_pago_cancelaciones.MontoAplicado, dbo.cp_nota_DebCre.cn_observacion, cp_nota_DebCre.cn_fecha AS co_fecha
FROM            dbo.ct_cbtecble INNER JOIN
                         dbo.cp_orden_pago_cancelaciones ON dbo.ct_cbtecble.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
                         dbo.ct_cbtecble.IdTipoCbte = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte INNER JOIN
                         dbo.cp_nota_DebCre ON dbo.ct_cbtecble.IdEmpresa = dbo.cp_nota_DebCre.IdEmpresa AND dbo.ct_cbtecble.IdEmpresa = dbo.cp_nota_DebCre.IdEmpresa AND 
                         dbo.ct_cbtecble.IdTipoCbte = dbo.cp_nota_DebCre.IdTipoCbte_Nota AND dbo.ct_cbtecble.IdCbteCble = dbo.cp_nota_DebCre.IdCbteCble_Nota
UNION
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ct_cbtecble.IdCbteCble, 
                         'CD#' + cast(dbo.ct_cbtecble.IdCbteCble AS varchar(20)), dbo.cp_orden_pago_cancelaciones.MontoAplicado, dbo.ct_cbtecble.cb_Observacion, 
                         ct_cbtecble.cb_Fecha AS co_fecha
FROM            dbo.ct_cbtecble INNER JOIN
                         dbo.cp_orden_pago_cancelaciones ON dbo.ct_cbtecble.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_cxp AND 
                         dbo.ct_cbtecble.IdTipoCbte = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_cxp AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.cp_orden_pago_cancelaciones.IdCbteCble_cxp INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago = dbo.ba_Cbte_Ban.IdCbteCble AND 
                         dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago = dbo.ba_Cbte_Ban.IdTipocbte
WHERE        NOT EXISTS
                             (SELECT        OG.IdEmpresa
                               FROM            cp_orden_giro OG
                               WHERE        OG.IdEmpresa = ct_cbtecble.IdEmpresa AND OG.IdTipoCbte_Ogiro = ct_cbtecble.IdTipoCbte AND OG.IdCbteCble_Ogiro = ct_cbtecble.IdCbteCble) AND 
                         NOT EXISTS
                             (SELECT        ND.IdEmpresa
                               FROM            cp_nota_DebCre ND
                               WHERE        ND.IdEmpresa = ct_cbtecble.IdEmpresa AND ND.IdTipoCbte_Nota = ct_cbtecble.IdTipoCbte AND ND.IdCbteCble_Nota = ct_cbtecble.IdCbteCble)