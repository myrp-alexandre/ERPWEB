CREATE PROCEDURE web.SPBAN_009
(
@IdEmpresa int,
@IdBanco int,
@FechaIni date,
@FechaFin date
)
AS
select a.IdEmpresa, a.IdBanco, a.ba_descripcion, a.IdTipoFlujo, a.NomFlujo, sum(a.ValorAbsoluto) as ValorFlujo
from (
select c.IdEmpresa,b.IdBanco, ba.ba_descripcion, t.IdTipoFlujo, tf.Descricion AS NomFlujo, t.Valor as ValorAbsoluto,
case when tc.CodTipoCbteBan  in ('CHEQ','NDBA') THEN t.Valor *-1 ELSE T.Valor END AS Valor
from ba_Cbte_Ban as b inner join ct_cbtecble as c on c.IdEmpresa= b.IdEmpresa
and c.IdTipoCbte = b.IdTipocbte and c.IdCbteCble = b.IdCbteCble
inner join ba_Cbte_Ban_x_ba_TipoFlujo as t on b.IdEmpresa = c.IdEmpresa
and b.IdTipocbte = c.IdTipoCbte and b.IdCbteCble = c.IdCbteCble
inner join ba_Banco_Cuenta as ba on ba.idempresa= b.idempresa and ba.idbanco = b.IdBanco
inner join ba_TipoFlujo as tf on t.IdEmpresa = tf.IdEmpresa
and t.IdTipoFlujo = tf.IdTipoFlujo inner join ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo as tc on tc.IdEmpresa = b.IdEmpresa and tc.IdTipoCbteCble = b.IdTipocbte 
where c.IdEmpresa = @IdEmpresa
and b.IdBanco = @IdBanco
and c.cb_Fecha between @FechaIni and @FechaFin
) a
group by a.IdEmpresa, a.IdBanco, a.ba_descripcion, a.IdTipoFlujo, a.NomFlujo