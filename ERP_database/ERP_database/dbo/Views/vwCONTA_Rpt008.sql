CREATE VIEW [dbo].[vwCONTA_Rpt008]
AS
SELECT        dbo.cp_orden_pago_det.IdEmpresa, dbo.cp_orden_pago_det.IdOrdenPago, dbo.cp_orden_pago_det.Secuencia AS Secuencia_op, 
                         dbo.cp_orden_pago_det.IdEmpresa_cxp, dbo.cp_orden_pago_det.IdCbteCble_cxp, dbo.cp_orden_pago_det.IdTipoCbte_cxp, 
                         dbo.ct_cbtecble_det.secuencia AS secuencia_cxp, dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_plancta.pc_clave_corta, 
                         dbo.ct_cbtecble_det.dc_Observacion, dbo.ct_cbtecble.cb_Fecha, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_cbtecble_tipo.CodTipoCbte, 
                         dbo.ct_cbtecble_tipo.tc_TipoCbte
FROM            dbo.cp_orden_pago_det INNER JOIN
                         dbo.ct_cbtecble ON dbo.cp_orden_pago_det.IdEmpresa_cxp = dbo.ct_cbtecble.IdEmpresa AND 
                         dbo.cp_orden_pago_det.IdTipoCbte_cxp = dbo.ct_cbtecble.IdTipoCbte AND dbo.cp_orden_pago_det.IdCbteCble_cxp = dbo.ct_cbtecble.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte