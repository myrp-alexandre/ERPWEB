-- exec [dbo].[spCONTA_Rpt007] 1,'01/06/2016','30/06/2016','',0,0,1

CREATE procedure [dbo].[spCONTA_Rpt007]
(
 @i_IdEmpresa int
,@i_Fecha_Ini datetime
,@i_Fecha_Fin datetime
,@i_IdCentroCosto varchar(20)
,@i_IdPunto_cargo_grupo int
,@i_IdPunto_cargo int
,@i_mostrar_cero bit

)
as
------==========================  DESHABILITADO POR Q SE LLAMA CON OTRO SP :spCON_Mayorizar_x_fecha_corte 

/*

declare @i_IdEmpresa int
declare @i_Fecha_Ini datetime
declare @i_Fecha_Fin datetime
declare @i_IdCentroCosto varchar(20)
declare @i_IdPunto_cargo_grupo int
declare @i_IdPunto_cargo int
DECLARE @i_mostrar_cero bit

SET @i_IdEmpresa =1
SET @i_Fecha_Ini ='01/06/2016'
SET @i_Fecha_Fin ='30/06/2016'
SET @i_mostrar_cero =1

set @i_IdCentroCosto =''
set @i_IdPunto_cargo_grupo =0
set @i_IdPunto_cargo =0

*/

/*
declare @w_IdPunto_cargo_grupo_ini int
declare @w_IdPunto_cargo_grupo_fin int
declare @w_IdPunto_cargo_ini int
declare @w_IdPunto_cargo_fin int



if (isnull(@i_IdPunto_cargo_grupo,0)=0)
begin
	set @w_IdPunto_cargo_grupo_ini =0 -- incluir cero q son los null
	set @w_IdPunto_cargo_grupo_fin =99999
end
else
begin
	set @w_IdPunto_cargo_grupo_ini =@i_IdPunto_cargo_grupo
	set @w_IdPunto_cargo_grupo_fin =@i_IdPunto_cargo_grupo
end 



if (isnull(@i_IdPunto_cargo,0)=0)
begin
	set @w_IdPunto_cargo_ini =0  -- incluir cero q son los null
	set @w_IdPunto_cargo_fin =99999
end
else
begin
	set @w_IdPunto_cargo_ini =@i_IdPunto_cargo
	set @w_IdPunto_cargo_fin =@i_IdPunto_cargo
end 




delete ct_Sumatoria_x_Cuenta
delete ct_Balance_x_General

declare @W_IdCtaCble_x_Utilidad varchar(20)
declare @W_IdCtaCble_Padre_x_Utilidad varchar(20)

select @W_IdCtaCble_x_Utilidad= A.IdCtaCble from ct_anio_fiscal_x_cuenta_utilidad A
WHERE A.IdEmpresa=@i_IdEmpresa and A.IdanioFiscal=year(@i_Fecha_Ini)


if (@W_IdCtaCble_x_Utilidad is null)
begin
	select @W_IdCtaCble_x_Utilidad= A.IdCtaCble from ct_anio_fiscal_x_cuenta_utilidad A
	WHERE A.IdEmpresa=@i_IdEmpresa 
end 



select @W_IdCtaCble_Padre_x_Utilidad =IdCtaCblePadre  from ct_plancta where IdEmpresa=@i_IdEmpresa and IdCtaCble=@W_IdCtaCble_x_Utilidad



delete ct_Sumatoria_x_Cuenta
delete ct_Balance_x_General


--==================================================================================
---------- resto el asiento de cierre del mes de fecha fin ------------------
------------  por que no debo considerarlo  -------------------------------

--========================== Fin Insert credito sumados ==============================================



insert into [dbo].[ct_Sumatoria_x_Cuenta]
(
[IdEmpresa] ,[IdCtaCble]	,Saldo_Inicial 				,IdCtaCblePadre
,dc_Saldo_deudor
,dc_Saldo_Acreedor		,dc_Saldo
)

select 
B.idempresa	,B.idctaCble	,ROUND(sum(B.Saldo_Inicial),2) as Saldo_Inicial	,B.IdCtaCblePadre
,round(sum(B.valor_Deudor),2) as valor_Deudor
,round(sum(B.Valor_Acreedor),2) as Valor_Acreedor
,0
from 		(

		-- SALDO INICIAL	
		select A.idempresa,A.idctaCble
		,Saldo_Inicial = A.Valor
		,A.IdCtaCblePadre
		,0 as valor_Deudor 
		,0 as Valor_Acreedor
		,A.IdCentroCosto
		from (
		
					SELECT     
					A.IdEmpresa			
					, D.IdCtaCble	, D.IdCtaCblePadre
					, B.IdCentroCosto	, D.pc_Naturaleza		, sum(B.dc_Valor) as Valor
					FROM         ct_cbtecble AS A INNER JOIN
					ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
					ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
					ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE A.IdEmpresa=@i_IdEmpresa
					and A.cb_Fecha < @i_Fecha_Ini
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

				) as  A

		union
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- Creditos
					-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- DEBITOS DEL MES
		select A.idempresa,A.idctaCble
		,0 Saldo_Inicial 
		,A.IdCtaCblePadre
		,A.Valor as valor_Deudor 
		,0 Valor_Acreedor
		,A.IdCentroCosto
		from (
					SELECT     
					A.IdEmpresa			
					, D.IdCtaCble	, D.IdCtaCblePadre
					, B.IdCentroCosto	, D.pc_Naturaleza		, sum(B.dc_Valor) as Valor
					FROM         ct_cbtecble AS A INNER JOIN
					ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
					ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
					ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE A.IdEmpresa=@i_IdEmpresa
					and A.cb_Fecha BETWEEN @i_Fecha_Ini AND @i_Fecha_Fin
					and B.dc_Valor>0
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

				) as  A

		union
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- Creditos
			select A.idempresa,A.idctaCble
			,0 Saldo_Inicial 
			,A.IdCtaCblePadre			
			,0 Valor_Deudor
			,A.Valor as valor_Acreedor 
			,A.IdCentroCosto
			from (
						
					SELECT     
					A.IdEmpresa			
					, D.IdCtaCble	, D.IdCtaCblePadre
					, B.IdCentroCosto	, D.pc_Naturaleza		, sum(B.dc_Valor) as Valor
					FROM         ct_cbtecble AS A INNER JOIN
					ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
					ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
					ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE A.IdEmpresa=@i_IdEmpresa
					and A.cb_Fecha BETWEEN @i_Fecha_Ini AND @i_Fecha_Fin
					and B.dc_Valor<0
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

					) A



		UNION					
	    -- SUMA DEBITOS Y CREDITO PARA CUENTA DE UTILIDAD
		select A.idempresa
		,@W_IdCtaCble_x_Utilidad  IdCtaCble
		,valor = A.Valor
		,@W_IdCtaCble_Padre_x_Utilidad IdCtaCblePadre
		,A.Valor as valor_Deudor 
		,0 Valor_Acreedor
		,NULL IdCentroCosto
		from (
					SELECT        A.IdEmpresa, SUM(B.dc_Valor) AS Valor
					FROM            ct_cbtecble AS A INNER JOIN
						ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
						ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble INNER JOIN
						ct_grupocble ON D.IdGrupoCble = ct_grupocble.IdGrupoCble LEFT OUTER JOIN
						ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE        (ct_grupocble.gc_estado_financiero = 'ER')
					AND A.IdEmpresa = @i_IdEmpresa
					and CAST(A.cb_Fecha as date) <= @i_Fecha_Ini
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor>0 --- suma de debitos
					group by A.IdEmpresa
				) as  A
		union

			select A.idempresa
			,@W_IdCtaCble_x_Utilidad IdCtaCble
			,valor = A.Valor
			,@W_IdCtaCble_Padre_x_Utilidad IdCtaCblePadre			
			,0 Valor_Deudor
			,A.Valor as valor_Acreedor 
			,NULL IdCentroCosto
			from (
						
					SELECT        A.IdEmpresa, SUM(B.dc_Valor) AS Valor
					FROM            ct_cbtecble AS A INNER JOIN
						ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
						ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble INNER JOIN
						ct_grupocble ON D.IdGrupoCble = ct_grupocble.IdGrupoCble LEFT OUTER JOIN
						ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE        (ct_grupocble.gc_estado_financiero = 'ER')
					AND A.IdEmpresa = @i_IdEmpresa
					and CAST(A.cb_Fecha as date) <= @i_Fecha_Ini
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor<0 --- suma de CREDITO
					group by A.IdEmpresa
					) A

		) B
group by B.idempresa,B.idctaCble,B.IdCtaCblePadre




--- FIN sumando por cuenta en base a la naturaleza 
--===========================================================
--===========================================================
--===========================================================
--- insertando cuentas del plan de cuenta para poder sumar recursivamente
--===========================================================


insert into [dbo].[ct_Sumatoria_x_Cuenta]
(
[IdEmpresa] ,	[IdCtaCble]		,[dc_Saldo]		,IdCtaCblePadre
,es_movimento
,dc_Saldo_deudor
,dc_Saldo_Acreedor
,Saldo_Inicial
)
SELECT 
A.IdEmpresa		, A.IdCtaCble	,0				,A.IdCtaCblePadre
,A.pc_EsMovimiento
,0
,0
,0
FROM ct_plancta A
where A.IdEmpresa=@i_IdEmpresa
and A.pc_EsMovimiento='N'
and not exists
(
	select IdEmpresa
	from [dbo].[ct_Sumatoria_x_Cuenta] B
	where B.IdEmpresa=A.IdEmpresa
	and B.IdCtaCble=A.IdCtaCble
);


--===========================================================
--- FIN insertando cuentas del plan de cuenta
--===========================================================


--===========================================================
--- Elimino las cuentas en cero para no perder tiempo al mayorizar y q mayorize solo lo necesario 
--delete  from [dbo].[ct_Sumatoria_x_Cuenta] where  es_movimento ='S' and dc_Saldo=0;
--===========================================================


---======================================================
---======================================================
------- Acumulo por cuentas padre Recursivamente 
--====================================================================================

    	WITH movi(IdPadre	,IdCta	,total	,[Nivel],total_deudor,total_Acreedor)
		AS
		(
			select 
			A.IdCtaCblePadre		,A.IdCtaCble	,A.Saldo_Inicial
			, CAST(A.IdCtaCble AS VARCHAR(1000)) + '\' AS [Nivel]
			,A.dc_Saldo_deudor
			,A.dc_Saldo_Acreedor
			from [dbo].[ct_Sumatoria_x_Cuenta] A
			where A.IdCtaCblePadre is null
			and A.idempresa	=@i_IdEmpresa 
    		union all
			select  
				t.IdCtaCblePadre		,t.IdCtaCble	,t.Saldo_Inicial
			,CAST(p.[Nivel] AS VARCHAR(500))  + CAST(t.IdCtaCble AS VARCHAR(500)) + '\' AS [Nivel]
			,t.dc_Saldo_deudor
			,t.dc_Saldo_Acreedor
			from [dbo].[ct_Sumatoria_x_Cuenta] t INNER JOIN
				movi as p on p.IdCta=t.IdCtaCblePadre
			where 			t.idempresa	=@i_IdEmpresa 
						
		)
		insert into ct_Balance_x_General
		(IdEmpresa, [IdCtaCble] ,	[IdCtaCblePadre] ,	Saldo_Inicial,Debito_Mes,Credito_Mes
		,IdNivelCta,GrupoCble,OrderGrupoCble,gc_estado_financiero
		,Saldo
		)
		select @i_IdEmpresa,  v.IdCta  , v.IdPadre , 
					(
						SELECT round(SUM( total),2) FROM movi 
						WHERE [Nivel] LIKE v.[Nivel] + '%'
					) as total
					,(
						SELECT round(SUM( total_deudor),2) FROM movi 
						WHERE [Nivel] LIKE v.[Nivel] + '%'
					) as total_deudor
					,(
						SELECT round(SUM( total_Acreedor),2) FROM movi 
						WHERE [Nivel] LIKE v.[Nivel] + '%'
					) as total_Acredor
		,0	,'',0,00
		,0
		from movi as v ;






update ct_Balance_x_General
set Saldo=Saldo_Inicial+Debito_Mes-Credito_Mes



if(@i_mostrar_cero=0)
begin
	delete ct_Balance_x_General 
	where (Saldo_Inicial + Debito_Mes + Credito_Mes)=0
end

update ct_Balance_x_General  
set CtaUtilidad =1
where IdCtaCble=@W_IdCtaCble_x_Utilidad


update ct_Balance_x_General 
set Saldo_inicial_x_Movi=0
,Debito_Mes_x_Movi=0
,Credito_Mes_x_Movi=0
,Saldo_x_Movi=0


update ct_Balance_x_General 
set Saldo_inicial_x_Movi=Saldo_Inicial
,Debito_Mes_x_Movi=Debito_Mes
,Credito_Mes_x_Movi=Credito_Mes
FROM            ct_Balance_x_General INNER JOIN
ct_plancta ON ct_Balance_x_General.IdEmpresa = ct_plancta.IdEmpresa AND ct_Balance_x_General.IdCtaCble = ct_plancta.IdCtaCble
where ct_plancta.pc_EsMovimiento='S'


update ct_Balance_x_General 
set Saldo_x_Movi =Saldo_inicial_x_Movi+Debito_Mes_x_Movi-Credito_Mes_x_Movi

*/

		select A.IdEmpresa,A.IdCtaCble
		, B.pc_Cuenta  as nom_cuenta  
		,B.IdNivelCta,C.gc_GrupoCble as GrupoCble
		,CAST(C.gc_Orden AS INT) as OrderGrupoCble,C.gc_estado_financiero, A.IdCtaCblePadre
		,A.Saldo_Inicial,A.Debito_Mes,A.Credito_Mes,A.Saldo
		,B.pc_EsMovimiento,c.gc_signo_operacion
		,CAST(A.CtaUtilidad AS bit) CtaUtilidad
		,A.Saldo_inicial_x_Movi,A.Debito_Mes_x_Movi,A.Credito_Mes_x_Movi,A.Saldo_x_Movi
		from ct_Balance_x_General A
		,ct_plancta B,ct_grupocble C
		where A.IdEmpresa=B.IdEmpresa
		and A.IdCtaCble=B.IdCtaCble
		and B.IdGrupoCble=C.IdGrupoCble
		order by 2