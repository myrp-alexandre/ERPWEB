CREATE VIEW [Fj_servindustrias].[vwBAN_FJ_Rpt002]
	AS 
	SELECT        dbo.ba_Conciliacion.IdConciliacion, dbo.ba_Conciliacion.IdBanco, dbo.ba_Conciliacion.IdPeriodo, dbo.ct_cbtecble_tipo.tc_TipoCbte, dbo.ct_cbtecble.cb_Valor, 
                         dbo.ct_cbtecble.cb_Observacion, dbo.ba_Conciliacion_det_IngEgr.tipo_IngEgr, dbo.ba_Conciliacion.IdEmpresa, dbo.ba_Banco_Cuenta.ba_descripcion, 
                         dbo.ct_cbtecble.cb_Fecha
FROM            dbo.ct_cbtecble INNER JOIN
                         dbo.ba_Conciliacion_det_IngEgr INNER JOIN
                         dbo.ba_Conciliacion ON dbo.ba_Conciliacion_det_IngEgr.IdEmpresa = dbo.ba_Conciliacion.IdEmpresa AND 
                         dbo.ba_Conciliacion_det_IngEgr.IdConciliacion = dbo.ba_Conciliacion.IdConciliacion ON 
                         dbo.ct_cbtecble.IdEmpresa = dbo.ba_Conciliacion_det_IngEgr.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ba_Conciliacion_det_IngEgr.IdTipocbte AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.ba_Conciliacion_det_IngEgr.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Conciliacion.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ba_Conciliacion.IdBanco = dbo.ba_Banco_Cuenta.IdBanco
WHERE        (dbo.ba_Conciliacion_det_IngEgr.tipo_IngEgr = '-')