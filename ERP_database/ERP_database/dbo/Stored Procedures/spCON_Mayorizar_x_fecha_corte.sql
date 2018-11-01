-- exec  [dbo].[spCON_Mayorizar_x_fecha_corte] 1,'01/01/2017','31/01/2017','',0,0,0,1,0,'admin'


CREATE proc [dbo].[spCON_Mayorizar_x_fecha_corte] 
(
 @i_IdEmpresa int
,@i_Fecha_Ini datetime
,@i_Fecha_Fin datetime
,@i_IdCentroCosto varchar(20)
,@i_IdPunto_cargo_grupo int
,@i_IdPunto_cargo int
,@i_Mostrar_reg_en_cero bit
,@i_Mostrar_reg_Centro_costo bit
,@i_Considerar_Asiento_cierre_anual bit
,@i_IdUsuario varchar(20)
)
as





/*

declare @i_IdEmpresa int
declare @i_Fecha_Ini datetime
declare @i_Fecha_Fin datetime
declare @i_IdCentroCosto varchar(20)
declare @i_Mostrar_reg_en_cero bit
declare @i_IdPunto_cargo_grupo int
declare @i_IdPunto_cargo int
declare @i_Mostrar_reg_Centro_costo bit
declare @i_Considerar_Asiento_cierre_anual bit
declare @i_IdUsuario varchar(20)


set @i_IdEmpresa =1
set @i_Fecha_Ini ='01/01/2017'
set @i_Fecha_Fin ='31/01/2017'

set @i_IdCentroCosto =''
set @i_IdPunto_cargo_grupo =0
set @i_IdPunto_cargo =0
set @i_Mostrar_reg_en_cero =1
set @i_Mostrar_reg_Centro_costo =0
set @i_Considerar_Asiento_cierre_anual=0
set @i_IdUsuario ='admin'

*/


declare @w_IdPunto_cargo_grupo_ini int
declare @w_IdPunto_cargo_grupo_fin int
declare @w_IdPunto_cargo_ini int
declare @w_IdPunto_cargo_fin int

declare @w_nom_centro_costo varchar(50)
declare @w_nom_punto_cargo_grupo varchar(50)
declare @w_nom_punto_cargo varchar(50)

if (@i_IdCentroCosto='')
begin
	set @w_nom_centro_costo =''
end 
else
begin 
	SELECT @w_nom_centro_costo=Centro_costo FROM ct_centro_costo where IdEmpresa=@i_IdEmpresa and IdCentroCosto= @i_IdCentroCosto
end 


if (isnull(@i_IdPunto_cargo_grupo,0)=0)--todos los grupos
begin
	set @w_IdPunto_cargo_grupo_ini =0 -- incluir cero q son los null
	set @w_IdPunto_cargo_grupo_fin =99999
	set @w_nom_punto_cargo_grupo=''
end
else
begin
	set @w_IdPunto_cargo_grupo_ini =@i_IdPunto_cargo_grupo
	set @w_IdPunto_cargo_grupo_fin =@i_IdPunto_cargo_grupo
	
	SELECT @w_nom_punto_cargo_grupo=nom_punto_cargo_grupo FROM ct_punto_cargo_grupo where IdEmpresa=@i_IdEmpresa and IdPunto_cargo_grupo= @i_IdPunto_cargo_grupo

end 



if (isnull(@i_IdPunto_cargo,0)=0)
begin
	set @w_IdPunto_cargo_ini =0  -- incluir cero q son los null
	set @w_IdPunto_cargo_fin =99999
	set @w_nom_punto_cargo=''
end
else
begin
	set @w_IdPunto_cargo_ini =@i_IdPunto_cargo
	set @w_IdPunto_cargo_fin =@i_IdPunto_cargo
	SELECT @w_nom_punto_cargo=nom_punto_cargo FROM ct_punto_cargo where IdEmpresa=@i_IdEmpresa and IdPunto_cargo= @i_IdPunto_cargo
end 


--select * from ct_Sumatoria_x_Cuenta

       
delete ct_Sumatoria_x_Cuenta where idusuario=@i_IdUsuario and IdEmpresa=@i_IdEmpresa
delete ct_Balance_x_General where idusuario= @i_IdUsuario and IdEmpresa=@i_IdEmpresa
delete ct_Sumatoria_x_Cuenta_x_Centro_Costo where idusuario= @i_IdUsuario and IdEmpresa=@i_IdEmpresa
delete ct_Balance_x_General_Data_Final where idusuario= @i_IdUsuario and IdEmpresa=@i_IdEmpresa


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


declare @w_IdTipoCbte_AsientoCierre_Anual int

select @w_IdTipoCbte_AsientoCierre_Anual  = A.IdTipoCbte_AsientoCierre_Anual from ct_parametro A where A.IdEmpresa=@i_IdEmpresa




--==================================================================================
---------- resto el asiento de cierre del mes de fecha fin ------------------
------------  por que no debo considerarlo  -------------------------------

--========================== Fin Insert credito sumados ==============================================




insert into [dbo].[ct_Sumatoria_x_Cuenta_x_Centro_Costo]
(
 IdEmpresa			,[IdCtaCble]				,IdCtaCblePadre
,Saldo_Inicial
,dc_Saldo_deudor
,dc_Saldo_Acreedor
,dc_Saldo	
,IdCentroCosto
,Saldo_Inicial_deudor
,Saldo_Inicial_acreedor
,Saldo_fin_deudor
,Saldo_fin_acreedor
,IdUsuario
)
select 
B.idempresa			,B.idctaCble				,B.IdCtaCblePadre
,round(sum(B.Saldo_Inicial),2)
,round(sum(B.valor_Deudor),2) as valor_Deudor
,round(sum(B.Valor_Acreedor),2) as Valor_Acreedor
,0  as Valor	
,B.IdCentroCosto
,round(sum(B.Saldo_Inicial_deudor),2) as Saldo_Inicial_deudor
,round(sum(B.Saldo_Inicial_acreedor),2) as Saldo_Inicial_acreedor
,0
,0
,@i_IdUsuario
from 		(

				-- Saldo_Inicial_deudor
				select A.idempresa,A.idctaCble
				,Saldo_Inicial_deudor = A.Valor
				,0 as Saldo_Inicial_acreedor
				,0 as Saldo_Inicial 
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
							and B.dc_Valor>0 --- suma de debitos
							group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

							

						) as  A
				union all 


				-- Saldo_Inicial_acreedor
				select A.idempresa,A.idctaCble
				,0 as Saldo_Inicial_deudor 
				,Saldo_Inicial_acreedor = A.Valor
				,0 as Saldo_Inicial 
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
							and B.dc_Valor<0 --- suma de credito
							group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza


							

						) as  A
				union  all


				-- SALDO INICIAL	
				select A.idempresa,A.idctaCble
				,0 as Saldo_Inicial_deudor 
				,0 as Saldo_Inicial_acreedor
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

			union all 
		--- UTILIDAD x SALDO INICIAL
			select A.idempresa
			,@W_IdCtaCble_x_Utilidad IdCtaCble
			,0 as Saldo_Inicial_deudor 
			,0 as Saldo_Inicial_acreedor
			,valor = A.Valor
			,@W_IdCtaCble_Padre_x_Utilidad IdCtaCblePadre			
			,0 as Valor_Deudor
			,0 as valor_Acreedor 
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
					and CAST(A.cb_Fecha as date) < @i_Fecha_Ini
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					group by A.IdEmpresa

					
					) A

		union all 
		
		-- SUMA DEBITOS Y CREDITO 
		-- DEBITOS
		select A.idempresa,A.idctaCble
		,0 as Saldo_Inicial_deudor 
		,0 as Saldo_Inicial_acreedor
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
					WHERE A.IdEmpresa = @i_IdEmpresa
					and CAST(A.cb_Fecha as date) between @i_Fecha_Ini and @i_Fecha_Fin
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor>0 --- suma de debitos
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

					union all

					SELECT     
					A.IdEmpresa			
					, D.IdCtaCble	, D.IdCtaCblePadre
					, B.IdCentroCosto	, D.pc_Naturaleza		, sum(B.dc_Valor) *-1 as Valor
					FROM         ct_cbtecble AS A INNER JOIN
					ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
					ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
					ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE A.IdEmpresa = @i_IdEmpresa
					and year(A.cb_Fecha ) =year( @i_Fecha_Fin)
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor>0 --- suma de debitos
					and B.IdTipoCbte=@w_IdTipoCbte_AsientoCierre_Anual  -- considero el asiento de cierre pero lo multiplico x negativo para q el efecto sea contrario
					and @i_Considerar_Asiento_cierre_anual=0 -- logica negativa por q ya esta en el querry anterior 
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

				) as  A
		union  all
		
			select A.idempresa,A.idctaCble
			,0 as Saldo_Inicial_deudor 
			,0 as Saldo_Inicial_acreedor
			,0 as Saldo_Inicial
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
					and CAST(A.cb_Fecha as date) between @i_Fecha_Ini and @i_Fecha_Fin
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor<0 --- suma de credito
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza


					union all 
					-- asiento de cierre
					SELECT     
					A.IdEmpresa			
					, D.IdCtaCble	, D.IdCtaCblePadre
					, B.IdCentroCosto	, D.pc_Naturaleza		, sum(B.dc_Valor) *-1 as Valor
					FROM         ct_cbtecble AS A INNER JOIN
					ct_cbtecble_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte AND A.IdCbteCble = B.IdCbteCble INNER JOIN
					ct_plancta AS D ON B.IdEmpresa = D.IdEmpresa AND B.IdCtaCble = D.IdCtaCble LEFT OUTER JOIN
					ct_centro_costo ON B.IdEmpresa = ct_centro_costo.IdEmpresa AND B.IdCentroCosto = ct_centro_costo.IdCentroCosto
					WHERE A.IdEmpresa=@i_IdEmpresa
					and year(A.cb_Fecha) =year(@i_Fecha_Fin)
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor<0 --- suma de credito
					and B.IdTipoCbte=@w_IdTipoCbte_AsientoCierre_Anual  -- considero el asiento de cierre pero lo multiplico x negativo para q el efecto sea contrario
					and @i_Considerar_Asiento_cierre_anual=0 -- logica negativa por q ya esta en el querry anterior 
					group by A.IdEmpresa, D.IdCtaCble	, D.IdCtaCblePadre, B.IdCentroCosto	, D.pc_Naturaleza

					) A


		UNION all 
		--UTILIDAD 
	    -- SUMA DEBITOS Y CREDITO PARA CUENTA DE UTILIDAD
		-- DEBITO
		select A.idempresa
		,@W_IdCtaCble_x_Utilidad  IdCtaCble
		,0 as Saldo_Inicial_deudor 
		,0 as Saldo_Inicial_acreedor
		,0 as SaldoInicial
		,@W_IdCtaCble_Padre_x_Utilidad IdCtaCblePadre
		,A.Valor as valor_Deudor 
		,0		 as Valor_Acreedor
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
					and CAST(A.cb_Fecha as date) between @i_Fecha_Ini and @i_Fecha_Fin
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor>0 --- suma de debitos
					group by A.IdEmpresa


					

				) as  A
		union all 
			--- UTILIDAD CREDITO
			select A.idempresa
			,@W_IdCtaCble_x_Utilidad IdCtaCble
			,0 as Saldo_Inicial_deudor 
			,0 as Saldo_Inicial_acreedor
			,0 as SaldoInicial
			,@W_IdCtaCble_Padre_x_Utilidad IdCtaCblePadre			
			,0		 as Valor_Deudor
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
					and CAST(A.cb_Fecha as date) between @i_Fecha_Ini and @i_Fecha_Fin
					and isnull(B.IdCentroCosto,'') like '%' + @i_IdCentroCosto + '%' 
					and isnull(B.IdPunto_cargo_grupo,0)   between @w_IdPunto_cargo_grupo_ini and @w_IdPunto_cargo_grupo_fin
					and isnull(B.IdPunto_cargo ,0)   between @w_IdPunto_cargo_ini and @w_IdPunto_cargo_fin
					and B.dc_Valor<0 --- suma de CREDITO
					group by A.IdEmpresa

				
					) A


		) B
group by B.idempresa,B.idctaCble,B.IdCtaCblePadre,B.IdCentroCosto
having B.idctaCble is not null




--- FIN sumando por cuenta en base a la naturaleza 
--===========================================================
--===========================================================
--===========================================================
--- insertando cuentas del plan de cuenta para poder sumar recursivamente
--===========================================================

insert into [dbo].[ct_Sumatoria_x_Cuenta]
(
[IdEmpresa]			,[IdCtaCble]				,IdCtaCblePadre
,Saldo_Inicial
,dc_Saldo_deudor
,dc_Saldo_Acreedor
,dc_Saldo	
,es_movimento
,Saldo_Inicial_deudor
,Saldo_Inicial_acreedor
,Saldo_fin_deudor
,Saldo_fin_acreedor
,idusuario
)
select 
 sum_ct.idempresa			,sum_ct.idctaCble				,sum_ct.IdCtaCblePadre
,round(sum(Saldo_Inicial),2)
,round(sum(dc_saldo_deudor),2) as valor_Deudor
,round(sum(dc_saldo_Acreedor),2) as Valor_Acreedor
,round(sum(dc_saldo),2) as saldo
,plcta.pc_EsMovimiento
,round(sum(Saldo_Inicial_deudor),2) as Saldo_Inicial_deudor
,round(sum(Saldo_Inicial_acreedor),2) as Saldo_Inicial_acreedor
,round(sum(Saldo_fin_deudor),2) as Saldo_fin_deudor
,round(sum(Saldo_fin_acreedor),2) as Saldo_fin_acreedor
,@i_IdUsuario
from ct_Sumatoria_x_Cuenta_x_Centro_Costo sum_ct ,ct_plancta plcta
where sum_ct.IdEmpresa=plcta.IdEmpresa
and sum_ct.IdCtaCble=plcta.IdCtaCble
and sum_ct.idusuario=@i_IdUsuario
and sum_ct.IdEmpresa=@i_IdEmpresa
group by sum_ct.idempresa,sum_ct.idctacble,sum_ct.idctacblePadre,plcta.pc_EsMovimiento



insert into [dbo].[ct_Sumatoria_x_Cuenta]
(
[IdEmpresa] ,	[IdCtaCble]		,IdCtaCblePadre
,es_movimento
,Saldo_Inicial
,dc_Saldo_deudor
,dc_Saldo_Acreedor
,[dc_Saldo]		
,Saldo_Inicial_deudor
,Saldo_Inicial_acreedor
,Saldo_fin_deudor
,Saldo_fin_acreedor
,idusuario
)
SELECT 
A.IdEmpresa		, A.IdCtaCble	,A.IdCtaCblePadre
,A.pc_EsMovimiento
,0
,0
,0
,0
,0
,0
,0
,0
,@i_IdUsuario
FROM ct_plancta A
where A.IdEmpresa=@i_IdEmpresa
and not exists
(
	select IdEmpresa
	from [dbo].[ct_Sumatoria_x_Cuenta] B
	where B.IdEmpresa=A.IdEmpresa
	and B.IdCtaCble=A.IdCtaCble
	and B.idusuario=@i_IdUsuario
);



--===========================================================
--- FIN insertando cuentas del plan de cuenta
--===========================================================
--===========================================================
--- Elimino las cuentas en cero para no perder tiempo al mayorizar y q mayorize solo lo necesario 
-- 

/* LO BORRE POR AHORA, LUEGO TENGO QUE VER COMO MEJORO ESTO
delete  [ct_Sumatoria_x_Cuenta] 
from [ct_Sumatoria_x_Cuenta] 
where 
es_movimento='S' and Saldo_Inicial=0 and dc_Saldo_deudor=0 and dc_Saldo_Acreedor=0 and dc_Saldo=0
and idusuario=@i_idusuario
and idempresa=@i_IdEmpresa;
*/


/*

delete from [ct_Sumatoria_x_Cuenta] 
where idusuario=@i_idusuario
and idempresa=@i_IdEmpresa
--and idctacble!='2010101080010033'
and es_movimento='S';


select '------ct_Sumatoria_x_Cuenta  ANTES DE ENTRA EN LA RECURSIVIDAD-------------------' ;
select * from ct_Sumatoria_x_Cuenta where idusuario=@i_IdUsuario and IdCtaCble='2010101080010033';
*/


--===========================================================
--===========================================================

---======================================================
---======================================================
------- Acumulo por cuentas padre Recursivamente 
--====================================================================================


    	WITH movi(IdPadre			,IdCta			,SaldoInicial			
		,[Nivel]					
		,Debito_Mes					,Credito_Mes
		,Saldo_Inicial_deudor		,Saldo_Inicial_acreedor
		)
		AS
		(
			select 
			A.IdCtaCblePadre		,A.IdCtaCble	,A.Saldo_Inicial
			, CAST(A.IdCtaCble AS VARCHAR(1000)) + '\' AS [Nivel]
			,A.dc_Saldo_deudor		,A.dc_Saldo_Acreedor
			,A.Saldo_Inicial_deudor	,A.Saldo_Inicial_acreedor
			from [dbo].[ct_Sumatoria_x_Cuenta] A
			where A.IdCtaCblePadre is null
			and A.idempresa	=@i_IdEmpresa
			and A.idusuario=@i_IdUsuario
    		union all
			select  
				t.IdCtaCblePadre	,t.IdCtaCble	,t.Saldo_Inicial
			,CAST(p.[Nivel] AS VARCHAR(500))  + CAST(t.IdCtaCble AS VARCHAR(500)) + '\' AS [Nivel]
			,t.dc_Saldo_deudor		,t.dc_Saldo_Acreedor
			--,t.Saldo_Inicial_deudor	,t.Saldo_Inicial_acreedor
			,case when t.Saldo_Inicial > 0 then t.Saldo_Inicial else 0 end
			,case when t.Saldo_Inicial < 0 then abs(t.Saldo_Inicial) else 0 end

			from [dbo].[ct_Sumatoria_x_Cuenta] t INNER JOIN
				movi as p on p.IdCta=t.IdCtaCblePadre
			where 			t.idempresa	=@i_IdEmpresa 
			and t.idusuario=@i_IdUsuario
						
		)
		
		insert into ct_Balance_x_General
		(IdEmpresa			, [IdCtaCble]	,[IdCtaCblePadre] 
		,Saldo_Inicial		, Debito_Mes	,Credito_Mes
		,IdNivelCta			,GrupoCble		,OrderGrupoCble
		,gc_estado_financiero
		,Saldo
		,Saldo_Inicial_deudor	,Saldo_Inicial_acreedor
		,idusuario
		)
		
		select @i_IdEmpresa,  v.IdCta  , v.IdPadre , 
					(
						SELECT round(SUM( SaldoInicial),2) FROM movi 
						WHERE [Nivel] LIKE v.[Nivel] + '%'
					) as total
					,(
						SELECT round(SUM( Debito_Mes),2) FROM movi 
						WHERE [Nivel] LIKE v.[Nivel] + '%'
					) as total_deudor
					,(
						SELECT round(SUM( Credito_Mes),2) FROM movi 
						WHERE [Nivel] LIKE v.[Nivel] + '%'
					) as total_Acredor
		,0	,'',0,00,0
		,(	SELECT round(SUM( Saldo_Inicial_deudor),2) FROM movi 
			WHERE [Nivel] LIKE v.[Nivel] + '%'
		 ) as total_Saldo_Inicial_deudor
		,
		(	SELECT round(SUM( Saldo_Inicial_acreedor),2) FROM movi 
			WHERE [Nivel] LIKE v.[Nivel] + '%'
		) as total_Saldo_Inicial_acreedor
		,@i_IdUsuario
		from movi as v ;

		






---====================== INSERTANDO LOS MOVIMIENTOS POR CENTRO DE COSTO ===============================
--======================================================================================================
--======================================================================================================

update ct_Balance_x_General  
set CtaUtilidad =1
where IdCtaCble=@W_IdCtaCble_x_Utilidad
and IdEmpresa=@i_IdEmpresa
and idusuario= @i_IdUsuario

/* setear los valores creditos en positivos*/
update ct_Balance_x_General
set Credito_Mes=Credito_Mes*-1
where IdEmpresa=@i_IdEmpresa
and idusuario= @i_IdUsuario

/* setear los valores creditos en positivos*/

update ct_Balance_x_General
set Saldo=Saldo_Inicial + Debito_Mes-Credito_Mes
where IdEmpresa=@i_IdEmpresa
and   idusuario= @i_IdUsuario

update ct_Balance_x_General
set Saldo_fin_deudor= case when saldo > 0 then saldo else 0 end,
Saldo_fin_acreedor= case when saldo < 0 then abs(saldo) else 0 end
where  IdEmpresa=@i_IdEmpresa
and idusuario= @i_IdUsuario

update ct_Balance_x_General 
set Saldo_inicial_x_Movi=0
,Debito_Mes_x_Movi=0
,Credito_Mes_x_Movi=0
,Saldo_x_Movi=0
where IdEmpresa=@i_IdEmpresa
and idusuario= @i_IdUsuario

update ct_Balance_x_General 
set 
 Saldo_inicial_x_Movi=Saldo_Inicial
,Debito_Mes_x_Movi=Debito_Mes
,Credito_Mes_x_Movi=Credito_Mes
FROM            ct_Balance_x_General INNER JOIN
ct_plancta ON ct_Balance_x_General.IdEmpresa = ct_plancta.IdEmpresa 
AND ct_Balance_x_General.IdCtaCble = ct_plancta.IdCtaCble
where ct_plancta.pc_EsMovimiento='S'
and ct_Balance_x_General.IdEmpresa=@i_IdEmpresa
and ct_Balance_x_General.idusuario= @i_IdUsuario

update ct_Balance_x_General 
set Saldo_x_Movi =Saldo_inicial_x_Movi+Debito_Mes_x_Movi-Credito_Mes_x_Movi
where IdEmpresa=@i_IdEmpresa
and idusuario= @i_IdUsuario


if (@i_Mostrar_reg_en_cero = 0)
begin
	
	delete ct_Balance_x_General 
	where round(Saldo,2) = 0
	and IdEmpresa=@i_IdEmpresa
	and idusuario= @i_IdUsuario
end 



update ct_Balance_x_General
set gc_estado_financiero='UT'
WHERE IdCtaCble=@W_IdCtaCble_x_Utilidad
and IdEmpresa=@i_IdEmpresa
and idusuario= @i_IdUsuario


insert into ct_Balance_x_General_Data_Final
(
 IdEmpresa				,IdCtaCble				,nom_cuenta				,IdNivelCta			,GrupoCble
,OrderGrupoCble			,gc_estado_financiero	,IdCtaCblePadre			,Saldo_Inicial		,Debito_Mes
,Credito_Mes			,Saldo					,pc_EsMovimiento		,gc_signo_operacion	,CtaUtilidad
,Saldo_inicial_x_Movi	,Debito_Mes_x_Movi		,Credito_Mes_x_Movi		,Saldo_x_Movi		,IdCentroCosto
,nom_centro_costo		,IdPunto_cargo_grupo	,nom_punto_cargo_grupo	,IdPunto_cargo		,nom_punto_cargo
,nom_empresa			,IdGrupo_Mayor			,nom_grupo_mayor		,order_grupo_mayor	,orden_fila
,Reg_x_CC			
,Saldo_Inicial_deudor	,Saldo_Inicial_acreedor	,Saldo_fin_deudor		,Saldo_fin_acreedor
,pc_clave_corta
,idusuario
)
SELECT 
 a.IdEmpresa				,a.IdCtaCble				,a.nom_cuenta				,a.IdNivelCta			,a.GrupoCble
,a.OrderGrupoCble			,a.gc_estado_financiero		,a.IdCtaCblePadre			,a.Saldo_Inicial		,a.Debito_Mes
,a.Credito_Mes				,a.Saldo					,a.pc_EsMovimiento			,a.gc_signo_operacion	,a.CtaUtilidad
,a.Saldo_inicial_x_Movi		,a.Debito_Mes_x_Movi		,a.Credito_Mes_x_Movi		,a.Saldo_x_Movi			,a.IdCentroCosto
,a.nom_centro_costo			,a.IdPunto_cargo_grupo		,a.nom_punto_cargo_grupo	,a.IdPunto_cargo		,a.nom_punto_cargo
,a.nom_empresa				,a.IdGrupo_Mayor			,a.nom_grupo_mayor			,a.order_grupo_mayor	,a.orden_fila
,a.Reg_x_CC			
,a.Saldo_Inicial_deudor		,a.Saldo_Inicial_acreedor	,a.Saldo_fin_deudor			,a.Saldo_fin_acreedor
,a.pc_clave_corta
,@i_IdUsuario
FROM
		(
			SELECT        		 
				A.IdEmpresa,A.IdCtaCble, B.pc_Cuenta  as nom_cuenta  		,B.IdNivelCta,C.gc_GrupoCble as GrupoCble
				,CAST(C.gc_Orden AS INT) as OrderGrupoCble,C.gc_estado_financiero, A.IdCtaCblePadre,A.Saldo_Inicial, A.Debito_Mes,A.Credito_Mes,A.Saldo,B.pc_EsMovimiento,c.gc_signo_operacion
				,CAST(A.CtaUtilidad AS bit) CtaUtilidad
				,Saldo_inicial_x_Movi,Debito_Mes_x_Movi,Credito_Mes_x_Movi,Saldo_x_Movi
				,@i_IdCentroCosto as IdCentroCosto,@w_nom_centro_costo as nom_centro_costo
				,@i_IdPunto_cargo_grupo as IdPunto_cargo_grupo,@w_nom_punto_cargo_grupo as nom_punto_cargo_grupo
				,@i_IdPunto_cargo as IdPunto_cargo,@w_nom_punto_cargo as nom_punto_cargo
				,em.em_nombre nom_empresa
				,C.IdGrupo_Mayor, gr_m.nom_grupo_mayor, gr_m.orden order_grupo_mayor,0 orden_fila,0 Reg_x_CC
				,A.Saldo_Inicial_deudor	,A.Saldo_Inicial_Acreedor ,A.saldo_fin_deudor ,A.saldo_fin_acreedor
				,B.pc_clave_corta
			FROM            ct_Balance_x_General AS A INNER JOIN
								ct_plancta AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdCtaCble = B.IdCtaCble INNER JOIN
								ct_grupocble AS C ON B.IdGrupoCble = C.IdGrupoCble INNER JOIN
								tb_empresa AS em ON A.IdEmpresa = em.IdEmpresa LEFT OUTER JOIN
								ct_grupocble_Mayor AS gr_m ON C.IdGrupo_Mayor = gr_m.IdGrupo_Mayor
			where A.IdCtaCble<>isnull(@W_IdCtaCble_x_Utilidad,'') and A.IdEmpresa = @i_IdEmpresa
			and A.idusuario=@i_IdUsuario
			union all
			SELECT        		 
				A.IdEmpresa,A.IdCtaCble, B.pc_Cuenta  as nom_cuenta  		,B.IdNivelCta,C.gc_GrupoCble as GrupoCble
				,CAST(C.gc_Orden AS INT) as OrderGrupoCble,C.gc_estado_financiero, A.IdCtaCblePadre,A.Saldo_Inicial, A.Debito_Mes,A.Credito_Mes,A.Saldo,B.pc_EsMovimiento,c.gc_signo_operacion
				,CAST(A.CtaUtilidad AS bit) CtaUtilidad
				,Saldo_inicial_x_Movi,Debito_Mes_x_Movi,Credito_Mes_x_Movi,Saldo_x_Movi
				,@i_IdCentroCosto as IdCentroCosto,@w_nom_centro_costo as nom_centro_costo
				,@i_IdPunto_cargo_grupo as IdPunto_cargo_grupo,@w_nom_punto_cargo_grupo as nom_punto_cargo_grupo
				,@i_IdPunto_cargo as IdPunto_cargo,@w_nom_punto_cargo as nom_punto_cargo
				,em.em_nombre nom_empresa
				,C.IdGrupo_Mayor, gr_m.nom_grupo_mayor, gr_m.orden order_grupo_mayor,0 orden_fila,0 Reg_x_CC
				,A.Saldo_Inicial_deudor	,A.Saldo_Inicial_Acreedor ,A.saldo_fin_deudor ,A.saldo_fin_acreedor
				,B.pc_clave_corta
			FROM            ct_Balance_x_General AS A INNER JOIN
								ct_plancta AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdCtaCble = B.IdCtaCble INNER JOIN
								ct_grupocble AS C ON B.IdGrupoCble = C.IdGrupoCble INNER JOIN
								tb_empresa AS em ON A.IdEmpresa = em.IdEmpresa LEFT OUTER JOIN
								ct_grupocble_Mayor AS gr_m ON C.IdGrupo_Mayor = gr_m.IdGrupo_Mayor
			where A.IdCtaCble=isnull(@W_IdCtaCble_x_Utilidad,'') and A.IdEmpresa = @i_IdEmpresa
			and A.idusuario=@i_IdUsuario
			union all

			SELECT        A.IdEmpresa, A.IdCtaCble ,'   ' +  isnull(ct_centro_costo.Centro_costo,'sin Centro Costo') AS nom_cuenta, ct_plancta.IdNivelCta, ct_grupocble.gc_GrupoCble, ct_grupocble.gc_Orden, ct_grupocble.gc_estado_financiero, A.IdCtaCblePadre
			, A.Saldo_Inicial, A.dc_Saldo_deudor, A.dc_Saldo_Acreedor*-1, A.Saldo_Inicial+ A.dc_Saldo_deudor-( A.dc_Saldo_Acreedor*-1) as dc_Saldo
			
			, ct_plancta.pc_EsMovimiento, ct_grupocble.gc_signo_operacion, NULL AS cta_util
			
			, A.Saldo_Inicial as Saldo_Inicial_Movi, A.dc_Saldo_deudor as dc_Saldo_deudor_Movi, (A.dc_Saldo_Acreedor*-1) as Saldo_Acreedor_Movi
			, A.Saldo_Inicial+ A.dc_Saldo_deudor-( A.dc_Saldo_Acreedor*-1) as dc_Saldo_Movi

			, ct_centro_costo.IdCentroCosto, 
							ct_centro_costo.Centro_costo, 0 AS IdGrupoPtoCargo, '' AS nom_GrupoPtoCargo, 0 AS IdPtoCargo, '' AS nom_PtoCargo, tb_empresa.em_nombre, ct_grupocble_Mayor.IdGrupo_Mayor, 
							ct_grupocble_Mayor.nom_grupo_mayor, ct_grupocble_Mayor.orden AS orden_grupo_may,1 orden_fila ,1 Reg_x_CC
			,A.Saldo_Inicial_deudor	,A.Saldo_Inicial_Acreedor ,A.saldo_fin_deudor ,A.saldo_fin_acreedor
			,ct_plancta.pc_clave_corta
			FROM            ct_Sumatoria_x_Cuenta_x_Centro_Costo AS A INNER JOIN
							ct_plancta ON A.IdEmpresa = ct_plancta.IdEmpresa AND A.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
							ct_grupocble ON ct_plancta.IdGrupoCble = ct_grupocble.IdGrupoCble INNER JOIN
							tb_empresa ON A.IdEmpresa = tb_empresa.IdEmpresa LEFT OUTER JOIN
							ct_grupocble_Mayor ON ct_grupocble.IdGrupo_Mayor = ct_grupocble_Mayor.IdGrupo_Mayor LEFT OUTER JOIN
							ct_centro_costo ON A.IdEmpresa = ct_centro_costo.IdEmpresa AND A.IdCentroCosto = ct_centro_costo.IdCentroCosto
			where 1=@i_Mostrar_reg_Centro_costo and A.IdEmpresa = @i_IdEmpresa
			and A.idusuario=@i_IdUsuario
) AS a




delete ct_Balance_x_General_Data_Final 
from ct_Balance_x_General_Data_Final A,
				(
					select idempresa,idctacble,count(*) as T
					from ct_Balance_x_General_Data_Final 
					where reg_x_cc=1
					and IdEmpresa=@i_IdEmpresa
					and IdUsuario= @i_IdUsuario
					group by idempresa,idctacble
				) B
where A.idempresa=B.idempresa
and A.idctacble=B.idctacble
and reg_x_cc=1
and B.T=1
and A.IdEmpresa=@i_IdEmpresa
and A.idusuario=@i_IdUsuario

if (@i_Mostrar_reg_en_cero = 0)
begin
	
	delete ct_Balance_x_General_Data_Final 
	where round(Saldo,2) = 0
	and IdEmpresa=@i_IdEmpresa
	and idusuario= @i_IdUsuario
end 

SELECT      ISNULL(ROW_NUMBER() OVER(ORDER BY(IdEmpresa)),0) AS IdRow,  IdEmpresa,rtrim(ltrim(IdCtaCble + ' ' +  isnull(IdCentroCosto,'-000'))) as IdCtaCble , nom_cuenta, IdNivelCta, GrupoCble, OrderGrupoCble, gc_estado_financiero, IdCtaCblePadre, Saldo_Inicial, Debito_Mes, Credito_Mes, round(Saldo,2) as Saldo, pc_EsMovimiento, gc_signo_operacion, 
                         CtaUtilidad, Saldo_inicial_x_Movi, Debito_Mes_x_Movi, Credito_Mes_x_Movi, Saldo_x_Movi, IdCentroCosto, nom_centro_costo, IdPunto_cargo_grupo, nom_punto_cargo_grupo, IdPunto_cargo, 
                         nom_punto_cargo, nom_empresa, IdGrupo_Mayor, nom_grupo_mayor, order_grupo_mayor, orden_fila, Reg_x_CC, Debito_Mes - ABS(Credito_Mes) AS Saldo_Mes
						 ,Saldo_Inicial_deudor  , Saldo_Inicial_acreedor, Saldo_fin_deudor       ,Saldo_fin_acreedor
						 ,pc_clave_corta,ct_Balance_x_General_Data_Final.idusuario 
FROM            ct_Balance_x_General_Data_Final
where ct_Balance_x_General_Data_Final.idusuario=@i_IdUsuario
and ct_Balance_x_General_Data_Final.IdEmpresa=@i_IdEmpresa
--and ct_Balance_x_General_Data_Final.IdCtaCble='2010101080010033'
ORDER BY IdEmpresa, IdCtaCble, orden_fila



/*
select '------ct_Sumatoria_x_Cuenta  despues DE ENTRA EN LA RECURSIVIDAD-------------------' ;
select * from ct_Sumatoria_x_Cuenta where IdCtaCble='2010101080010033' and idusuario=@i_IdUsuario 
select * from ct_Sumatoria_x_Cuenta_x_Centro_Costo where IdCtaCble='2010101080010033' and  idusuario= @i_IdUsuario 
select * from ct_Balance_x_General_Data_Final where IdCtaCble='2010101080010033' and idusuario= @i_IdUsuario
select * from ct_Balance_x_General where IdCtaCble='2010101080010033' and idusuario= @i_IdUsuario 
*/