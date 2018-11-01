CREATE VIEW [web].[VWCAJ_002_ingresos]
AS
select conci.IdEmpresa, conci.IdConciliacion_Caja, caj.IdTipocbte, caj.IdCbteCble, conci.valor_disponible, conci.valor_aplicado, caj.cr_Valor, per.pe_nombreCompleto, caj_cab.cm_observacion, caj_cab.cm_fecha
from cp_conciliacion_Caja_det_Ing_Caja conci
inner join caj_Caja_Movimiento_det caj on caj.IdEmpresa = conci.IdEmpresa
and caj.IdTipocbte = conci.IdTipocbte_movcaj and caj.IdCbteCble = conci.IdCbteCble_movcaj
inner join caj_Caja_Movimiento caj_cab on caj_cab.IdEmpresa = caj.IdEmpresa
and caj_cab.IdTipocbte = caj.IdTipocbte and caj_cab.IdCbteCble = caj.IdCbteCble
inner join tb_persona per on caj_cab.IdPersona = per.IdPersona
