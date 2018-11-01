
CREATE proc [dbo].[spCON_Saldo_Inicial_x_cta_cble]
(
 @i_IdEmpresa int
,@i_FechaCorte datetime
,@i_IdCentroCosto varchar(30)
)
as
/*
declare @i_IdEmpresa int
declare @i_FechaCorte datetime
declare @i_IdCentroCosto varchar(30)


set @i_IdEmpresa =1
set @i_FechaCorte ='31/01/2014'
set @i_IdCentroCosto =''

*/


--//preguntando si la tabla 
If(OBJECT_ID('tempdb..#tmp_Saldo_x_Cuenta_a_fecha_corte') Is Not Null)
	Begin
		Drop Table #tmp_Saldo_x_Cuenta_a_fecha_corte
	End



select 
B.IdEmpresa	,B.IdCtaCble	,B.IdCtaCblePadre
,ROUND(sum(B.valor),2) as Saldo	
into #tmp_Saldo_x_Cuenta_a_fecha_corte
from 		(
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- DEBITOS
		select A.idempresa,A.idctaCble
		,valor = A.Valor
		,A.IdCtaCblePadre
		,A.Valor as valor_Deudor 
		,0 Valor_Acreedor
		,A.IdCentroCosto
		from (
					SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre
								, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor
					FROM            ct_cbtecble AS A INNER JOIN
							ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
							ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble INNER JOIN
							ct_rpt_SaldoxCta ON B.IdEmpresa = ct_rpt_SaldoxCta.IdEmpresa AND B.IdCtaCble = ct_rpt_SaldoxCta.IdCtaCble LEFT OUTER JOIN
							ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE        (A.IdEmpresa = @i_IdEmpresa) AND (A.cb_Fecha <= @i_FechaCorte) AND (B.dc_Valor > 0) AND (ISNULL(B.IdCentroCosto, '') LIKE '%' + @i_IdCentroCosto + '%')
					GROUP BY A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza
				) as  A

		union
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- Creditos
			select A.idempresa,A.idctaCble
			,valor = A.Valor
			,A.IdCtaCblePadre			
			,0 Valor_Deudor
			,A.Valor as valor_Acreedor 
			,A.IdCentroCosto
			from (
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre
									, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor
						FROM            ct_cbtecble AS A INNER JOIN
								ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
								ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble INNER JOIN
								ct_rpt_SaldoxCta ON B.IdEmpresa = ct_rpt_SaldoxCta.IdEmpresa AND B.IdCtaCble = ct_rpt_SaldoxCta.IdCtaCble LEFT OUTER JOIN
								ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE        
						(A.IdEmpresa = @i_IdEmpresa) 
						AND (A.cb_Fecha <= @i_FechaCorte) 
						AND (B.dc_Valor < 0) 
						AND (ISNULL(B.IdCentroCosto, '') LIKE '%' + @i_IdCentroCosto + '%')
						GROUP BY A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza
					) A

		) B
group by B.idempresa,B.idctaCble,B.IdCtaCblePadre --,B.IdCentroCosto;


select IdEmpresa,IdCtaCble,IdCtaCblePadre,Saldo
from #tmp_Saldo_x_Cuenta_a_fecha_corte