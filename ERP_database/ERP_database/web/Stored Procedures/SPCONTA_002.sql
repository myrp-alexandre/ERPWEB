
--exec web.SPCONTA_002 1,410101,'2018/06/01','2018/12/31'
CREATE PROC [web].[SPCONTA_002]
(
@IdEmpresa int,
@IdCtaCble varchar(20),
@FechaIni datetime,
@FechaFin datetime
)
AS
DECLARE @SaldoInicial float
DECLARE @SignoOperacion int

select @SignoOperacion = g.gc_signo_operacion from ct_grupocble as g inner join ct_plancta as p
on g.IdGrupoCble = p.IdGrupoCble
where IdEmpresa = @IdEmpresa AND p.IdCtaCble = @IdCtaCble



select @SaldoInicial = sum(d.dc_Valor) from ct_cbtecble_det d
inner join ct_cbtecble c
on c.IdEmpresa = d.IdEmpresa and c.IdTipoCbte = d.IdTipoCbte and c.IdCbteCble = d.IdCbteCble
where c.IdEmpresa = @IdEmpresa and d.IdCtaCble = @IdCtaCble and c.cb_Fecha < @FechaIni

SET @SaldoInicial = CASE WHEN @SignoOperacion < 0 THEN @SaldoInicial *-1 ELSE @SaldoInicial END	

SELECT        ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta, ct_cbtecble_det.dc_Valor, 
ISNULL(@SaldoInicial,0) AS SaldoInicial,
CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor ELSE 0 END AS dc_Valor_Debe,
CASE WHEN ct_cbtecble_det.dc_Valor < 0 THEN ABS(ct_cbtecble_det.dc_Valor) ELSE 0 END AS dc_Valor_Haber,
isnull(@SaldoInicial,0) + SUM(

CASE WHEN @SignoOperacion < 0 THEN 
				  dbo.ct_cbtecble_det.dc_Valor*-1
				  ELSE dbo.ct_cbtecble_det.dc_Valor
				  END 

) OVER(partition by ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdCtaCble ORDER BY ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdCtaCble,ct_cbtecble.cb_Fecha, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia) as Saldo,
ct_cbtecble.cb_Fecha, ct_cbtecble.cb_Observacion, ct_cbtecble.cb_Estado, ct_cbtecble_tipo.tc_TipoCbte
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         ct_cbtecble_tipo ON ct_cbtecble.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte
where ct_cbtecble_det.IdEmpresa = @IdEmpresa and ct_cbtecble.cb_Fecha between @FechaIni and @FechaFin and ct_cbtecble_det.IdCtaCble = @IdCtaCble
ORDER BY ct_cbtecble_det.IdEmpresa, ct_cbtecble_det.IdCtaCble, ct_cbtecble.cb_Fecha, ct_cbtecble_det.IdTipoCbte, ct_cbtecble_det.IdCbteCble, ct_cbtecble_det.secuencia