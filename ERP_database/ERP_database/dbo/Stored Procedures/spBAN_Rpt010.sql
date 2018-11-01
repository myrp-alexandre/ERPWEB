

--EXEC [dbo].[spBAN_Rpt010] 1,1,'01/01/2016','01/01/2018'
CREATE  PROCEDURE [dbo].[spBAN_Rpt010]
	@IdEmpresa as int,	
	@IdBanco as int,
	@Fecha_ini as datetime,
	@Fecha_fin as datetime		 
AS
BEGIN
/*
SET @IdEmpresa = 1
SET @IdBanco = 2
SET @Fecha_ini = '01/01/2017'
SET @Fecha_fin = '31/01/2017'
*/
DECLARE @IdCtaCble varchar(20)

select @IdCtaCble = IdCtaCble  
from ba_Banco_Cuenta 
where IdEmpresa = @IdEmpresa and IdBanco = @IdBanco

DECLARE @Saldo_inicial float

select @Saldo_inicial = sum(dc_Valor)
from ct_cbtecble_det det 
inner join ct_cbtecble cab
on cab.IdEmpresa = det.IdEmpresa
and cab.IdTipoCbte = det.IdTipoCbte
and cab.IdCbteCble = det.IdCbteCble
where det.IdEmpresa = @IdEmpresa and IdCtaCble = @IdCtaCble
and cab.cb_Fecha < @Fecha_ini 

DECLARE @Total_registros numeric

select @Total_registros = count(cab.IdEmpresa)
from ct_cbtecble_det det 
inner join ct_cbtecble cab
on cab.IdEmpresa = det.IdEmpresa
and cab.IdTipoCbte = det.IdTipoCbte
and cab.IdCbteCble = det.IdCbteCble
where det.IdEmpresa = @IdEmpresa and IdCtaCble = @IdCtaCble
and cab.cb_Fecha between @Fecha_ini and @Fecha_fin
set @Saldo_inicial = isnull(@Saldo_inicial,0)
SET @Total_registros = ISNULL(@Total_registros,0)
IF(@Total_registros > 0)
BEGIN
			SELECT A.IdEmpresa,A.IdTipoCbte,A.IdCbteCble,a.secuencia, cb_Fecha,cb_Observacion, dc_Observacion,
						
						CASE WHEN cb_Cheque IS NOT NULL and a.cb_Estado = 'I' 
							THEN '**ANULADO** ' + a.cb_giradoA
						WHEN cb_Cheque IS NOT NULL and a.cb_Estado = 'A' 
							THEN a.cb_giradoA
						ELSE cb_Observacion
						END AS Observacion_girado_a,

						CASE WHEN cb_Cheque IS NOT NULL
						THEN ltrim(rtrim(A.CodTipoCbte))+' # '+cb_Cheque 
							ELSE ltrim(rtrim(A.CodTipoCbte)) +' # '+cast(a.IdCbteCble as varchar(20))
						END AS Referencia,

						cb_giradoA, A.CodTipoCbte,A.tc_TipoCbte, A.IdCtaCble, A.pc_Cuenta, 
						a.Saldo_inicial, 
						ISNULL(a.Debe,0) Debe, ISNULL(a.Haber,0) Haber,
									 
						ISNULL(@Saldo_inicial + sum(a.dc_Valor)
						over(partition by a.IdEmpresa
						order by a.cb_fecha,a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.secuencia
						rows unbounded preceding),0) as Saldo, A.Origen
			FROM(
			SELECT        det.IdEmpresa, det.IdTipocbte, det.IdCbteCble, det.secuencia, ba_Cbte_Ban.cb_Fecha, ba_Cbte_Ban.cb_Observacion, ba_Cbte_Ban.cb_Cheque, 
									 ba_Cbte_Ban.cb_giradoA, ct_cbtecble_tipo.CodTipoCbte, ct_cbtecble_tipo.tc_TipoCbte, det.IdCtaCble, ct_plancta.pc_Cuenta,
									 isnull(@Saldo_inicial,0) Saldo_inicial, 
									 CASE WHEN det.dc_Valor > 0 THEN abs(det.dc_Valor) ELSE 0 END AS Debe, 
									 CASE WHEN det.dc_Valor < 0 THEN abs(det.dc_Valor) ELSE 0 END AS Haber,
									 DET.dc_Valor,det.dc_Observacion, cab.cb_Estado, 'BAN' Origen
			FROM            ba_Cbte_Ban INNER JOIN
									 ct_cbtecble AS cab ON ba_Cbte_Ban.IdEmpresa = cab.IdEmpresa AND ba_Cbte_Ban.IdEmpresa = cab.IdEmpresa AND ba_Cbte_Ban.IdTipocbte = cab.IdTipoCbte AND 
									 ba_Cbte_Ban.IdCbteCble = cab.IdCbteCble INNER JOIN
									 ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble INNER JOIN
									 ct_cbtecble_tipo ON cab.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND cab.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
									 ct_plancta ON det.IdEmpresa = ct_plancta.IdEmpresa AND det.IdCtaCble = ct_plancta.IdCtaCble
			where det.IdEmpresa = @IdEmpresa and det.IdCtaCble = @IdCtaCble
			and ba_Cbte_Ban.cb_Fecha between @Fecha_ini and @Fecha_fin --and cab.cb_Estado = 'A'
			UNION
			select   det.IdEmpresa, det.IdTipocbte, det.IdCbteCble, DET.secuencia, cab.cb_Fecha, cab.cb_Observacion, NULL cb_Cheque, 
									 NULL cb_giradoA, ct_cbtecble_tipo.CodTipoCbte, ct_cbtecble_tipo.tc_TipoCbte, det.IdCtaCble, ct_plancta.pc_Cuenta, 
									 isnull(@Saldo_inicial,0) Saldo_inicial,
									 CASE WHEN det.dc_Valor > 0 THEN abs(det.dc_Valor) ELSE 0 END AS Debe, 
									 CASE WHEN det.dc_Valor < 0 THEN abs(det.dc_Valor) ELSE 0 END AS Haber,
									 DET.dc_Valor, det.dc_Observacion, cab.cb_Estado, 'CON' Origen
			FROM            ct_cbtecble AS cab INNER JOIN
									 ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble INNER JOIN
									 ct_cbtecble_tipo ON cab.IdEmpresa = ct_cbtecble_tipo.IdEmpresa AND cab.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
									 ct_plancta ON det.IdEmpresa = ct_plancta.IdEmpresa AND det.IdCtaCble = ct_plancta.IdCtaCble
			WHERE        (det.IdEmpresa = @IdEmpresa) AND (det.IdCtaCble = @IdCtaCble) AND (cab.cb_Fecha BETWEEN @Fecha_ini AND @Fecha_fin)
						AND NOT EXISTS(
						SELECT IdEmpresa 
						FROM ba_Cbte_Ban ban
						WHERE ban.IdEmpresa = cab.IdEmpresa
						and ban.IdTipocbte = cab.IdTipoCbte
						and ban.IdCbteCble = cab.IdCbteCble
						)/*
						AND NOT EXISTS(
						select IdEmpresa from ct_cbtecble_Reversado rev
						where rev.IdEmpresa = cab.IdEmpresa
						and rev.IdTipocbte = cab.IdTipoCbte
						and rev.IdCbteCble = cab.IdCbteCble
						)
						AND NOT EXISTS(
						select IdEmpresa from ct_cbtecble_Reversado rev
						where rev.IdEmpresa_Anu = cab.IdEmpresa
						and rev.IdTipoCbte_Anu = cab.IdTipoCbte
						and rev.IdCbteCble_Anu = cab.IdCbteCble
						)*/
			) A ORDER BY a.cb_fecha,a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.secuencia
END
ELSE
	BEGIN
				SELECT @IdEmpresa AS IdEmpresa, 0 as IdTipoCbte, cast(0 as numeric) as IdCbteCble, 0 as secuencia, @Fecha_fin as cb_Fecha, NULL AS cb_Observacion, NULL as dc_Observacion, 'No hay registros' as Observacion_girado_a,
				NULL AS Referencia, NULL AS cb_giradoA, NULL AS CodTipoCbte, NULL AS tc_TipoCbte, @IdCtaCble as IdCtaCble, pc_Cuenta, 
				cast(ISNULL(@Saldo_inicial, 0) as float) AS Saldo_inicial, cast(0 as float)AS Debe, cast(0 as float) AS Haber, cast(ISNULL(@Saldo_inicial,0) as float )as Saldo, NULL AS Origen
				FROM ct_plancta
				where ct_plancta.IdEmpresa = @IdEmpresa and ct_plancta.IdCtaCble = @IdCtaCble
	END
END