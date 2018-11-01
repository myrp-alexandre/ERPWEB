CREATE VIEW web.VWBAN_006
AS
SELECT        ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ba_Cbte_Ban.cb_giradoA, ba_Cbte_Ban.ValorEnLetras, tb_ciudad.Descripcion_Ciudad, ba_Cbte_Ban.cb_Valor, 
                         ba_Cbte_Ban.cb_Fecha, ba_Cbte_Ban.cb_Observacion, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble_det.dc_Valor, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS dc_Valor_Debe, CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Haber, 
                         ba_Cbte_Ban.cb_Cheque
FROM            ct_plancta INNER JOIN
                         ct_cbtecble_det ON ct_plancta.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_plancta.IdCtaCble = ct_cbtecble_det.IdCtaCble INNER JOIN
                         ba_Cbte_Ban INNER JOIN
                         tb_ciudad ON ba_Cbte_Ban.cb_ciudadChq = tb_ciudad.IdCiudad ON ct_cbtecble_det.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ba_Cbte_Ban.IdTipocbte AND 
                         ct_cbtecble_det.IdCbteCble = ba_Cbte_Ban.IdCbteCble