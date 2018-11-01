
/*select * from tb_sis_reporte where Modulo='CONTA'*/
CREATE VIEW [dbo].[vwCONTA_Rpt005]
AS
SELECT        dbo.ct_cbtecble.IdEmpresa, dbo.ct_cbtecble.IdTipoCbte, dbo.ct_cbtecble.IdCbteCble, dbo.ct_cbtecble.IdPeriodo, dbo.ct_cbtecble.cb_Fecha AS Fecha, 
                         dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_cbtecble_det.IdCentroCosto, dbo.ct_cbtecble_det.dc_Valor AS Valor, dbo.ct_centro_costo.Centro_costo, 
                         dbo.ct_cbtecble_tipo.tc_TipoCbte AS TipoCbte, dbo.ct_plancta.pc_Cuenta AS nom_Cuenta, dbo.ct_plancta.pc_Naturaleza AS Naturaleza_cta, 
                         dbo.ct_plancta.IdCtaCblePadre, dbo.tb_Calendario.AnioFiscal, dbo.tb_Calendario.Mes_x_anio AS IdMes, dbo.tb_Calendario.NombreMes AS Mes
FROM            dbo.ct_cbtecble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte AND dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble INNER JOIN
                         dbo.tb_Calendario ON dbo.ct_cbtecble.cb_Fecha = dbo.tb_Calendario.fecha LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto