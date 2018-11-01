CREATE view [dbo].[vwBAN_Rpt014]

as
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.tb_empresa.em_nombre AS nom_empresa, dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.ba_Cbte_Ban.IdCbteCble, 
                         dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, dbo.ba_Banco_Cuenta.ba_Num_Cuenta, 
                         dbo.ba_Banco_Cuenta.IdCtaCble AS IdCtaCble_ban, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.IdPeriodo, dbo.ba_Cbte_Ban.cb_Observacion, 
                         dbo.ba_Cbte_Ban.cb_Valor, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.ValorEnLetras, dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta AS nom_cuenta, dbo.ct_cbtecble_det.dc_Observacion 
						 ,debito=case 
						 when dbo.ct_cbtecble_det.dc_Valor>0 then dbo.ct_cbtecble_det.dc_Valor
						 else
						 0
						 end 
						 ,credito=case 
						 when dbo.ct_cbtecble_det.dc_Valor<0 then dbo.ct_cbtecble_det.dc_Valor*-1
						 else
						 0
						 end 
FROM            dbo.ba_Cbte_Ban INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.tb_empresa ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble