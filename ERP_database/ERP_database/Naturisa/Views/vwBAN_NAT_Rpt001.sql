CREATE view [Naturisa].[vwBAN_NAT_Rpt001]
as
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.tb_empresa.em_nombre AS nom_empresa, dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.ba_Cbte_Ban.IdCbteCble, 
                         dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, dbo.ba_Banco_Cuenta.ba_Num_Cuenta, 
                         dbo.ba_Banco_Cuenta.IdCtaCble AS IdCtaCble_ban, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.IdPeriodo, dbo.ba_Cbte_Ban.cb_Observacion, 
                         SUM(dbo.ba_Cbte_Ban.cb_Valor) AS cb_Valor, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.ValorEnLetras, dbo.ct_cbtecble_det.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta AS nom_cuenta, '' dc_Observacion, SUM(iif(dbo.ct_cbtecble_det.dc_Valor > 0, dbo.ct_cbtecble_det.dc_Valor, 0)) 
                         AS debito, SUM(iif(dbo.ct_cbtecble_det.dc_Valor < 0, dbo.ct_cbtecble_det.dc_Valor * - 1, 0)) AS credito, dbo.ct_punto_cargo.nom_punto_cargo, 
                         dbo.ba_Cbte_Ban.cb_Cheque, '' nom_punto_cargo_grupo, dbo.ct_plancta.pc_clave_corta AS clave_cta, dbo.ba_Cbte_Ban.cb_giradoA
FROM            dbo.ct_punto_cargo_grupo INNER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_punto_cargo_grupo.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo = dbo.ct_punto_cargo.IdPunto_cargo_grupo RIGHT OUTER JOIN
                         dbo.ba_Cbte_Ban INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.tb_empresa ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble ON 
                         dbo.ct_punto_cargo.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_punto_cargo.IdPunto_cargo = dbo.ct_cbtecble_det.IdPunto_cargo AND 
                         dbo.ct_punto_cargo.IdPunto_cargo_grupo = dbo.ct_cbtecble_det.IdPunto_cargo_grupo
GROUP BY dbo.ba_Cbte_Ban.IdEmpresa, dbo.tb_empresa.em_nombre, dbo.tb_empresa.em_ruc, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.IdTipocbte, 
                         dbo.ba_Cbte_Ban.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion, dbo.ba_Banco_Cuenta.ba_Num_Cuenta, dbo.ba_Banco_Cuenta.IdCtaCble, 
                         dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.IdPeriodo, dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.ValorEnLetras, 
                         dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_punto_cargo.nom_punto_cargo, 
                         dbo.ba_Cbte_Ban.cb_Cheque,  dbo.ct_plancta.pc_clave_corta, dbo.ba_Cbte_Ban.cb_giradoA