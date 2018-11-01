create view [Naturisa].[vwCONTA_NATU_Rpt003]
as

SELECT        a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.CodCbteCble, a.IdPeriodo, a.cb_Fecha, a.cb_Valor, a.cb_Observacion, a.cb_Estado, a.cb_Anio, a.cb_mes,  
                         b.IdCtaCble, SUM(b.dc_Valor) AS dc_Valor, c.pc_Cuenta, dbo.ct_cbtecble_tipo.tc_TipoCbte, c.pc_clave_corta, 
                         (CASE WHEN SUM(b.dc_Valor) >= 0 THEN SUM(b.dc_Valor) ELSE 0 END) AS debe, (CASE WHEN SUM(b.dc_Valor) <= 0 THEN SUM(b.dc_Valor) * - 1 ELSE 0 END) AS Cred
FROM            dbo.ct_cbtecble AS a INNER JOIN
                         dbo.ct_cbtecble_det AS b ON a.IdEmpresa = b.IdEmpresa AND a.IdTipoCbte = b.IdTipoCbte AND a.IdCbteCble = b.IdCbteCble INNER JOIN
                         dbo.ct_plancta AS c ON b.IdCtaCble = c.IdCtaCble AND b.IdEmpresa = c.IdEmpresa INNER JOIN
                         dbo.ct_cbtecble_tipo ON a.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte AND a.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa
GROUP BY a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.CodCbteCble, a.IdPeriodo, a.cb_Fecha, a.cb_Valor, a.cb_Observacion, a.cb_Estado, a.cb_Anio, a.cb_mes, 
                         b.IdCtaCble, c.pc_Cuenta, dbo.ct_cbtecble_tipo.tc_TipoCbte, c.pc_clave_corta