CREATE view web.VWCXP_003
as
SELECT dbo.ct_cbtecble_det.IdEmpresa, dbo.ct_cbtecble_det.IdTipoCbte, dbo.ct_cbtecble_det.IdCbteCble, dbo.ct_cbtecble_det.secuencia, ncnd.cn_fecha, ncnd.cn_Fecha_vcto, dbo.ct_cbtecble.cb_Observacion, ncnd.Estado, ncnd.cn_subtotal_iva, 
                  ncnd.cn_subtotal_siniva, ncnd.cn_valoriva, ncnd.cn_total, dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble_det.dc_Valor, CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ABS(ct_cbtecble_det.dc_Valor) 
                  ELSE 0 END AS dc_Valor_Debe, CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Haber, dbo.ct_cbtecble_tipo.tc_TipoCbte, dbo.ct_cbtecble_det.dc_Observacion, ncnd.IdProveedor, 
                  per.pe_nombreCompleto, ncnd.DebCre, CASE WHEN ncnd.DebCre = 'C' THEN 'Crédito' ELSE 'Débito' END AS Tipo_doc, ncnd.cn_Nota AS num_documento, dbo.tb_sucursal.Su_Descripcion
FROM     dbo.ct_cbtecble INNER JOIN
                  dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                  dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble INNER JOIN
                  dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                  dbo.cp_nota_DebCre AS ncnd ON dbo.ct_cbtecble.IdEmpresa = ncnd.IdEmpresa AND dbo.ct_cbtecble.IdEmpresa = ncnd.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = ncnd.IdTipoCbte_Nota AND 
                  dbo.ct_cbtecble.IdCbteCble = ncnd.IdCbteCble_Nota INNER JOIN
                  dbo.cp_proveedor AS pro ON ncnd.IdEmpresa = pro.IdEmpresa AND pro.IdProveedor = ncnd.IdProveedor INNER JOIN
                  dbo.tb_persona AS per ON pro.IdPersona = per.IdPersona INNER JOIN
                  dbo.tb_sucursal ON ncnd.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND ncnd.IdSucursal = dbo.tb_sucursal.IdSucursal
