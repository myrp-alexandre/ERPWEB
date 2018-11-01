
-- exec [dbo].[spCONTA_Rpt006] 1,'11503','','01/12/2016','31/12/2017',0,0,0
-- para reporte de movimiento de cuentas
CREATE PROCEDURE [dbo].[spCONTA_Rpt006]
 @i_IdEmpresa as int
,@i_IdCtaCble as varchar(20)
,@i_IdCentro_Costo as varchar(20)
,@i_FechaIni as datetime
,@i_FechaFin as datetime
,@i_IdGrupo_Punto_cargo int
,@i_IdPunto_cargo int
,@i_Mostrar_Asiento_Cierre bit
AS
BEGIN

/*
DECLARE @i_IdEmpresa as int
DECLARE @i_IdCtaCble as varchar(20)
DECLARE @i_FechaIni as datetime
DECLARE @i_FechaFin as datetime
declare @i_IdGrupo_Punto_cargo int
declare @i_IdPunto_cargo int


SET @i_IdEmpresa =1
SET @i_IdCtaCble ='2110102'
SET @i_FechaIni ='01-06-2016'
SET @i_FechaFin ='31-12-2016'
set @i_IdGrupo_Punto_cargo =0
set @i_IdPunto_cargo =0
*/



declare @SaldoInicial as float
declare @SaldoFinal as float
declare @TotalRegistros as numeric
declare @nom_cuenta as varchar(150)
declare @nom_centro_costo as varchar(350)
declare @nom_banco as varchar(150)
declare @nom_punto_cargo as varchar(150)
declare @nom_grupo_punto_cargo as varchar(150)
declare @w_Punto_cargo_Ini int
declare @w_Punto_cargo_Fin int
declare @w_Punto_Grupo_cargo_Ini int
declare @w_Punto_Grupo_cargo_Fin int

DECLARE @w_gc_estado_financiero varchar(20)

BEGIN --IDENTIFICO EL ESTADO FINANCIERO AL QUE PERTENECE
SELECT   @w_gc_estado_financiero = ct_grupocble.gc_estado_financiero
FROM            ct_grupocble INNER JOIN
                         ct_plancta ON ct_grupocble.IdGrupoCble = ct_plancta.IdGrupoCble
WHERE ct_plancta.IdEmpresa = @i_IdEmpresa
AND ct_plancta.IdCtaCble = @i_IdCtaCble 
END

set @nom_centro_costo=''


if (@i_IdCentro_Costo is null) begin set @i_IdCentro_Costo ='' end


if (@i_IdCentro_Costo <>'')
begin
	select @nom_centro_costo=Centro_costo from ct_centro_costo where IdEmpresa=@i_IdEmpresa and @i_IdCentro_Costo=@i_IdCentro_Costo
end


if (@i_IdPunto_cargo=0)
begin
	set @w_Punto_cargo_Ini =0
	set @w_Punto_cargo_Fin =999999
	set @nom_punto_cargo=''
end
else
begin
	set @w_Punto_cargo_Ini =@i_IdPunto_cargo
	set @w_Punto_cargo_Fin =@i_IdPunto_cargo
	select @nom_punto_cargo= '['+ cast(IdPunto_cargo as varchar(20)) +']-' +  nom_punto_cargo from ct_punto_cargo where IdEmpresa=@i_IdEmpresa and IdPunto_cargo=@i_IdPunto_cargo
end


if (@i_IdGrupo_Punto_cargo =0)
begin
	set @w_Punto_Grupo_cargo_Ini =0
	set @w_Punto_Grupo_cargo_Fin =999999
	set @nom_grupo_punto_cargo=''
end
else
begin
	set @w_Punto_Grupo_cargo_Ini =@i_IdGrupo_Punto_cargo
	set @w_Punto_Grupo_cargo_Fin =@i_IdGrupo_Punto_cargo
	select @nom_grupo_punto_cargo= '['+ cast( IdPunto_cargo_grupo as varchar(20)) +']-' +   nom_punto_cargo_grupo from ct_punto_cargo_grupo where IdEmpresa=@i_IdEmpresa and IdPunto_cargo_grupo =@i_IdGrupo_Punto_cargo
end

declare @w_IdTipoCbte_AsientoCierre_Anual int
--declare @i_Mostrar_Asiento_Cierre bit


set @w_IdTipoCbte_AsientoCierre_Anual  =-9999
--
if (@i_Mostrar_Asiento_Cierre = 0)
begin
	select @w_IdTipoCbte_AsientoCierre_Anual  = A.IdTipoCbte_AsientoCierre_Anual from ct_parametro A where A.IdEmpresa=@i_IdEmpresa
end 

----==============================================================================================================
----------========================== SALDO INICIAL ==========================
--=========================================================================
IF(@w_gc_estado_financiero = 'BG')
BEGIN -- SALDO INICIAL BG
		select @SaldoInicial = ROUND(sum(B.valor),2) 
		from 		(
				-- DEBITOS
		
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha < @i_FechaIni
							and B.dc_Valor>0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'					
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual

				union
				-- CREDITOS
						
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha < @i_FechaIni
							and B.dc_Valor<0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual
				) B
		group by B.idempresa,B.idctaCble,B.IdCtaCblePadre 
END
ELSE
BEGIN -- SALDO INICIAL ER
		select @SaldoInicial = ROUND(sum(B.valor),2) 
		from 		(
				-- DEBITOS		
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha < @i_FechaIni
							and B.dc_Valor>0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'					
							AND YEAR(A.cb_Fecha) = YEAR(@i_FechaIni)
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual
				union
				-- CREDITOS						
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha < @i_FechaIni
							and B.dc_Valor<0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'
							AND YEAR(A.cb_Fecha) = YEAR(@i_FechaIni)
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual
				) B
		group by B.idempresa,B.idctaCble,B.IdCtaCblePadre 
END


set @SaldoInicial =isnull(@SaldoInicial ,0)



----==============================================================================================================
----------========================== SALDO FINAL ==========================
--=========================================================================

IF(@w_gc_estado_financiero = 'BG')
BEGIN -- SALDO INICIAL BG
		select @SaldoFinal = ROUND(sum(B.valor),2) 
		from 		(
				-- DEBITOS
		
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha <= @i_FechaFin
							and B.dc_Valor>0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'					
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual

				union
				-- CREDITOS
						
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha <= @i_FechaFin
							and B.dc_Valor<0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual
				) B
		group by B.idempresa,B.idctaCble,B.IdCtaCblePadre 
END
ELSE
BEGIN -- SALDO INICIAL ER
		select @SaldoFinal = ROUND(sum(B.valor),2) 
		from 		(
				-- DEBITOS		
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha <= @i_FechaFin
							and B.dc_Valor>0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'					
							AND YEAR(A.cb_Fecha) = YEAR(@i_FechaIni)
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual
				union
				-- CREDITOS						
						SELECT        A.IdEmpresa, D.IdCtaCble, D.IdCtaCblePadre, B.IdCentroCosto, D.pc_Naturaleza, SUM(B.dc_Valor) AS Valor, case when ct_parametro.IdTipoCbte_AsientoCierre_Anual is null then cast(0 as bit) else cast(1 as bit) end as Es_asiento_cierre
						FROM            ct_cbtecble AS A INNER JOIN
									ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
									ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
									ct_parametro ON A.IdEmpresa = ct_parametro.IdEmpresa AND A.IdTipoCbte = ct_parametro.IdTipoCbte_AsientoCierre_Anual LEFT OUTER JOIN
									ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
						WHERE A.IdEmpresa=@i_IdEmpresa
							and A.cb_Fecha <= @i_FechaFin
							and B.dc_Valor<0
							and B.IdCtaCble=@i_IdCtaCble
							and isnull(IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
							and isnull(IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
							and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'
							AND YEAR(A.cb_Fecha) = YEAR(@i_FechaIni)
						group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza, ct_parametro.IdTipoCbte_AsientoCierre_Anual
				) B
		group by B.idempresa,B.idctaCble,B.IdCtaCblePadre 
END


set @SaldoFinal =isnull(@SaldoFinal ,0)




select @nom_cuenta=B.pc_Cuenta 
from ct_plancta B
where B.IdEmpresa=@i_IdEmpresa
and B.IdCtaCble=@i_IdCtaCble



SELECT        @TotalRegistros=count(*)
FROM            ct_cbtecble AS A,ct_cbtecble_det B
where 
    A.IdEmpresa=B.IdEmpresa
and A.IdCbteCble=B.IdCbteCble
and A.IdTipoCbte=B.IdTipoCbte
and A.IdEmpresa=@i_IdEmpresa
and A.cb_Fecha between @i_FechaIni and @i_FechaFin
and B.IdCtaCble =@i_IdCtaCble
and isnull(B.IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
and isnull(B.IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'
and A.IdTipoCbte<>@w_IdTipoCbte_AsientoCierre_Anual


if (@TotalRegistros>0)
begin

		SELECT        
		A.IdEmpresa	, A.IdCbteCble	, A.IdTipoCbte	, C.tc_TipoCbte AS sTipocbte	, A.IdPeriodo	, A.cb_Fecha AS FechaCbte
		, A.IdCtaCble, ct_plancta.pc_Cuenta AS nom_cuenta, 
		
		CASE WHEN LEFT(LTRIM(RTRIM(A.dc_Observacion)),20) = LEFT(LTRIM(RTRIM(A.cb_Observacion )),20)
			THEN	A.dc_Observacion
		WHEN A.dc_Observacion <> A.cb_Observacion AND A.dc_Observacion <> '' 
			THEN	A.dc_Observacion + ' | | ' + a.cb_Observacion
		ELSE A.cb_Observacion

		END
		AS Concepto
		, B.em_ruc AS ruc_empresa, B.em_nombre AS nom_empresa
		
		, @SaldoInicial AS SaldoInicial, @SaldoFinal AS SaldoFinal, 
						CASE WHEN A.dc_Valor > 0 THEN A.dc_Valor WHEN A.dc_Valor < 0 THEN 0 ELSE 0 END AS Debito, 
						CASE WHEN A.dc_Valor > 0 THEN 0 WHEN A.dc_Valor < 0 THEN abs(A.dc_Valor) ELSE 0 END AS Credito,
						
						ct_punto_cargo_grupo.nom_punto_cargo_grupo nom_grupo_punto_cargo ,ct_punto_cargo.nom_punto_cargo nom_punto_cargo 
						,  ct_centro_costo.IdCentroCosto IdCentro_Costo , ct_centro_costo.Centro_costo nom_centro_costo,
						ct_plancta.pc_clave_corta
		FROM            vwct_cbtecble_det AS A INNER JOIN
						tb_empresa AS B ON A.IdEmpresa = B.IdEmpresa INNER JOIN
						ct_cbtecble_tipo AS C ON A.IdTipoCbte = C.IdTipoCbte AND A.IdEmpresa = C.IdEmpresa INNER JOIN
						ct_plancta ON A.IdEmpresa = ct_plancta.IdEmpresa AND A.IdCtaCble = ct_plancta.IdCtaCble LEFT OUTER JOIN
						ct_centro_costo ON A.IdEmpresa = ct_centro_costo.IdEmpresa AND A.IdCentroCosto = ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
						ct_punto_cargo_grupo ON A.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
						A.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo LEFT OUTER JOIN
						ct_punto_cargo ON A.IdEmpresa = ct_punto_cargo.IdEmpresa AND A.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo
		where 
		    A.IdEmpresa=@i_IdEmpresa
		and A.cb_Fecha between @i_FechaIni and @i_FechaFin
		and A.IdCtaCble=@i_IdCtaCble
		and isnull(A.IdPunto_cargo,0) between @w_Punto_cargo_Ini and @w_Punto_cargo_Fin 
		and isnull(A.IdPunto_cargo_grupo,0) between @w_Punto_Grupo_cargo_Ini and @w_Punto_Grupo_cargo_Fin
		and isnull(A.IdCentroCosto,'') like '%' + @i_IdCentro_Costo  + '%'
		and A.IdTipoCbte<>@w_IdTipoCbte_AsientoCierre_Anual
		order by A.cb_Fecha
end 
else
begin
	SELECT        A.IdEmpresa, cast(0 as decimal) as IdCbteCble, cast(0 as int) as IdTipocbte, '' as sTipocbte, cast( 0 as int ) as IdPeriodo, @i_FechaIni FechaCbte
	,@i_IdCtaCble as  IdCtaCble, @nom_cuenta  as nom_cuenta
	, 'No Registros'  Concepto, 
							A.em_ruc ruc_empresa, A.em_nombre nom_empresa
							 ,@SaldoInicial as SaldoInicial,@SaldoFinal as SaldoFinal
							 ,cast(0 as float) as Debito,  cast(0 as float) as Credito,@nom_grupo_punto_cargo as nom_grupo_punto_cargo,@nom_punto_cargo  as nom_punto_cargo
							 ,@i_IdCentro_Costo IdCentro_Costo,@nom_centro_costo nom_centro_costo, '' as pc_clave_corta
	from tb_empresa A
	where A.IdEmpresa=@i_IdEmpresa
end 


end