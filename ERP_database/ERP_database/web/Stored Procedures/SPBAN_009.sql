--EXEC [web].[SPBAN_009] 2,1,'01/01/2019','31/01/2019'
CREATE PROCEDURE [web].[SPBAN_009]
(
@IdEmpresa int,
@IdBanco int,
@FechaFin date
)
AS
select a.IdEmpresa, a.IdBanco, a.ba_descripcion, a.IdTipoFlujo, a.NomFlujo, sum(a.ValorAbsoluto) as ValorFlujo
from (
SELECT c.IdEmpresa, b.IdBanco, ba.ba_descripcion, t.IdTipoFlujo, tf.Descricion AS NomFlujo, t.Valor AS ValorAbsoluto, CASE WHEN tc.CodTipoCbteBan IN ('CHEQ', 'NDBA') THEN t .Valor * - 1 ELSE T .Valor END AS Valor
FROM     ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo AS tc INNER JOIN
                  ba_Cbte_Ban AS b INNER JOIN
                  ct_cbtecble AS c ON c.IdEmpresa = b.IdEmpresa AND c.IdTipoCbte = b.IdTipocbte AND c.IdCbteCble = b.IdCbteCble INNER JOIN
                  ba_Banco_Cuenta AS ba ON ba.IdEmpresa = b.IdEmpresa AND ba.IdBanco = b.IdBanco ON tc.IdEmpresa = b.IdEmpresa AND tc.IdTipoCbteCble = b.IdTipocbte INNER JOIN
                  ba_TipoFlujo AS tf INNER JOIN
                  ba_Cbte_Ban_x_ba_TipoFlujo AS t ON tf.IdEmpresa = t.IdEmpresa AND tf.IdTipoFlujo = t.IdTipoFlujo ON c.IdEmpresa = t.IdEmpresa AND c.IdTipoCbte = t.IdTipocbte AND c.IdCbteCble = t.IdCbteCble
where c.IdEmpresa = @IdEmpresa
and b.IdBanco = @IdBanco
and c.cb_Fecha <= @FechaFin
UNION ALL
SELECT ba_TipoFlujo_Movimiento.IdEmpresa, ba_TipoFlujo_Movimiento.IdBanco, ba_Banco_Cuenta.ba_descripcion, ba_TipoFlujo_Movimiento.IdTipoFlujo, ba_TipoFlujo.Descricion, ba_TipoFlujo_Movimiento.Valor, 
                  ba_TipoFlujo_Movimiento.Estado
FROM     ba_TipoFlujo_Movimiento INNER JOIN
                  ba_TipoFlujo ON ba_TipoFlujo_Movimiento.IdEmpresa = ba_TipoFlujo.IdEmpresa AND ba_TipoFlujo_Movimiento.IdTipoFlujo = ba_TipoFlujo.IdTipoFlujo INNER JOIN
                  ba_Banco_Cuenta ON ba_TipoFlujo_Movimiento.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ba_TipoFlujo_Movimiento.IdBanco = ba_Banco_Cuenta.IdBanco
WHERE  (ba_TipoFlujo_Movimiento.Estado = 1) AND ba_TipoFlujo_Movimiento.Fecha <= @FechaFin AND ba_TipoFlujo_Movimiento.IdEmpresa = @IdEmpresa AND ba_TipoFlujo_Movimiento.IdBanco = @IdBanco
) a
group by a.IdEmpresa, a.IdBanco, a.ba_descripcion, a.IdTipoFlujo, a.NomFlujo