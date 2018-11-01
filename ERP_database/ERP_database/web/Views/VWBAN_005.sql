CREATE VIEW web.VWBAN_005
AS
SELECT        ba_Cbte_Ban.IdEmpresa, ba_Cbte_Ban.IdTipocbte, ba_Cbte_Ban.IdCbteCble, ba_Cbte_Ban.cb_giradoA, ba_Cbte_Ban.ValorEnLetras, tb_ciudad.Descripcion_Ciudad, ba_Cbte_Ban.cb_Valor, ba_Cbte_Ban.cb_Fecha
FROM            ba_Cbte_Ban INNER JOIN
                         tb_ciudad ON ba_Cbte_Ban.cb_ciudadChq = tb_ciudad.IdCiudad