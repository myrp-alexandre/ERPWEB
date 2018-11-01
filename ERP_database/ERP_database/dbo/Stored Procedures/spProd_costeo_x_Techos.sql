--USE [DBERP]

CREATE procedure [dbo].[spProd_costeo_x_Techos] as
declare @i_empresa int
DECLARE @i_anio int
DECLARE @i_mes int

set @i_empresa =1
set @i_anio =2013
set @i_mes =9


declare @w_IdModeloProduccion int
declare @w_IdMovi_inven_x_SaldoInicial int
declare @w_idPeriodoActual int
declare @w_idPeriodoAnt int
declare @w_AnioAnt int
declare @w_MesAnt int
declare @w_IdTipo_Costeo varchar(20)
declare @w_RubroInvInicial varchar(20)
declare @w_RubroInvFinal varchar(20)

declare @w_ValorSaldoInicial float
declare @w_KilosSaldoInicial float

declare @w_Valorkilos_Mes_Compras float
declare @w_ValorDolares_Mes_Compras float
declare @w_ValorDolares_Mes_Ajustes float
declare @w_Valorkilos_Mes_Ajustes float
declare @w_ValorDolares_Mes_MP_Consumida float
declare @w_Valorkilos_Mes_MP_Consumida float
declare @w_ValorDolares_Mes_InvenFinal float
declare @w_Valorkilos_Mes_MP_InvenFinal float
declare @w_ValorDolares_ManoObra_Directa float
declare @w_ValorDolares_ManoObra_InDirecta  float

declare @w_Valorkilos_GestionProductiva  float
declare @w_ValorDolares_GestionProductiva  float
declare @w_ValorDolares_TOTAL_COSTO float
declare @w_ValorKilos_TOTAL_COSTO float
declare @W_CostoUnitario_ProdFinal float
declare @w_ValorDolares_CostoVta float
declare @w_Valorkilos_CostoVta float




declare @w_numReg int
declare @w_IdMovi_Inve_Tipo_Importacion int

declare @w_ValorDolares int
declare @w_Valorkilos int


-------------------------------------------
----------------------- variables de incio del costeo  
--------------------.---------------
set @w_IdTipo_Costeo ='COS_TECH'
set @w_RubroInvInicial ='MP_INVI'
set @w_RubroInvFinal ='MP_INVF'


set @w_numReg =0
-----------------------------------------------------------
-----------------------------------------------------------


select @w_idPeriodoActual =IdPeriodo  from ct_periodo 
where IdEmpresa =@i_empresa 
and IdanioFiscal =@i_anio 
and pe_mes =@i_mes 

--set @w_idPeriodoAnt =@w_idPeriodoActual 
--
select top 1 @w_idPeriodoAnt =IdPeriodo ,@w_AnioAnt=IdanioFiscal  ,@w_MesAnt =pe_mes 
from ct_periodo 
where IdEmpresa =@i_empresa 
and IdPeriodo <@w_idPeriodoActual 
order by 1 desc

--select @w_idPeriodoActual 
--select @w_idPeriodoAnt




select @w_IdModeloProduccion =IdModeloProd  
from dbo.prod_Costeo_Tipo_Costeo_cusTalme
where IdEmpresa =@i_empresa 
and IdTipo_Costeo =@w_IdTipo_Costeo

select 
@w_IdMovi_inven_x_SaldoInicial =pa_IdMovi_inven_tipo_SaldoInicial
from dbo.prod_Costeo_ParametrosGenerales


if (@w_IdModeloProduccion=0 or @w_IdModeloProduccion is null)
begin
	print 'no existe modelo de produccion...'
	--return 0

end 

-----------------------------------------------------------------------------------------
---------------------- iniciando la tabla -----------------------------------------------

update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme 
set ValorDolares_Acu =0
,ValorDolares_Mes=0
,ValorParcial_Acu=0
,ValorParcial_Mes=0
,Valorkilos_Acu=0
,Valorkilos_Mes=0
where 
anio=@i_anio and mes =@i_mes
and IdEmpresa =@i_empresa 
and IdTipo_Costeo =@w_IdTipo_Costeo


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
---------------------- ENCUENTRO LOS MOVIMEINTO DE MATERIA PRIMA POR TECHOS  -----------------------------
-- lo s movientos del mes 


------------------------------------------------------------------------------------------------
--- borro la data del mes y año que estoy calculando -------------
delete prod_Costeo_in_movi_inve_data
where idempresa=@i_empresa 
and year(cm_fecha )=@i_anio 
and month(cm_fecha )=@i_mes 

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--  optengo los movim de inven del mes y año que estoy calculando 


--alter table in_movi_inve_detalle add dm_peso float
--alter table prod_Costeo_in_movi_inve_data add dm_peso float


insert into prod_Costeo_in_movi_inve_data
( IdEmpresa		,IdSucursal		,IdBodega		,IdMovi_inven_tipo	,IdNumMovi                               
,CodMoviInven	,cm_tipo		,cm_observacion	,cm_fecha			,Secuencia   
,IdProducto		,dm_cantidad	,dm_stock_ante	,dm_stock_actu		,mv_costo	
,pr_codigo		,pr_descripcion	,pr_costo_promedio
,idanio			,idmes			,dm_peso
)
SELECT     
A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.CodMoviInven, A.cm_tipo, A.cm_observacion, A.cm_fecha, B.Secuencia, B.IdProducto, 
B.dm_cantidad, B.dm_stock_ante, B.dm_stock_actu, B.mv_costo, C.pr_codigo, C.pr_descripcion, D.pr_costo_promedio
,@i_anio		,@i_mes			,B.dm_peso
FROM         in_movi_inve AS A INNER JOIN
                      in_movi_inve_detalle AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND 
                      A.IdMovi_inven_tipo = B.IdMovi_inven_tipo AND A.IdNumMovi = B.IdNumMovi INNER JOIN
                      in_Producto AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdProducto = C.IdProducto INNER JOIN
                      in_producto_x_tb_bodega AS D ON C.IdEmpresa = D.IdEmpresa AND C.IdProducto = D.IdProducto INNER JOIN
                      prod_ModeloProduccion_x_Producto_CusTal AS F ON B.IdEmpresa = F.IdEmpresa AND B.IdProducto = F.IdProducto
WHERE A.IdEmpresa =  @i_empresa
and F.IdModeloProd =@w_IdModeloProduccion
and F.Tipo ='MATPRIMA'
and year(A.cm_fecha)=@i_anio 
and month(A.cm_fecha)=@i_mes 

               
---------------------- MATERIA PRIMA  -----------------------------
---------------------- TECHOS -----------------------------

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
------------- buscando el saldo inicial 

select 
 @w_ValorSaldoInicial  =isnull(ValorDolares_Mes ,0)
,@w_KilosSaldoInicial  =isnull(Valorkilos_Mes,0)
from dbo.prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
where IdEmpresa =@i_empresa 
and IdTipo_Costeo =@w_IdTipo_Costeo 
and Anio =@w_AnioAnt 
and mes =@w_MesAnt 
and IdRubroCosteo =@w_RubroInvFinal  -- en base al inventario Final



set @w_ValorSaldoInicial  =ISNULL(@w_ValorSaldoInicial  ,0)
set @w_KilosSaldoInicial  =ISNULL(@w_KilosSaldoInicial  ,0)

--select @w_ValorSaldoInicial  
--return 

--select @w_ValorSaldoInicial  

------- si no hay saldo inciial en el historico busco en el mes anterio 
-- si hay registro de saldo inicial de inventario
if @w_ValorSaldoInicial  =0
begin
	 
	 delete prod_Costeo_in_movi_inve_data_SALDOINICIAL
	 where idempresa=@i_empresa 
	 and idanio			=@w_AnioAnt
	 and idmes			=@w_MesAnt

	 
	 
	 -- alter table prod_Costeo_in_movi_inve_data_SALDOINICIAL add dm_peso float
	 
	insert into prod_Costeo_in_movi_inve_data_SALDOINICIAL
	( IdEmpresa			,IdSucursal		,IdBodega			,IdMovi_inven_tipo		,IdNumMovi                               
	 ,CodMoviInven		,cm_tipo		,cm_observacion		,cm_fecha				,Secuencia   
	 ,IdProducto		,dm_cantidad	,dm_stock_ante		,dm_stock_actu			,mv_costo	
	 ,pr_codigo			,pr_descripcion	,pr_costo_promedio
	 ,idanio			,idmes			,dm_peso 
	)
	SELECT     
	  A.IdEmpresa	, A.IdSucursal		, A.IdBodega		, A.IdMovi_inven_tipo	, A.IdNumMovi
	, A.CodMoviInven, A.cm_tipo			, A.cm_observacion	, A.cm_fecha			, B.Secuencia
	, B.IdProducto	, B.dm_cantidad		, B.dm_stock_ante	, B.dm_stock_actu		, B.mv_costo
	, C.pr_codigo	, C.pr_descripcion	, D.pr_costo_promedio
	, @w_AnioAnt ,@w_MesAnt				,B.dm_peso 
	FROM         in_movi_inve AS A INNER JOIN
						  in_movi_inve_detalle AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND 
						  A.IdMovi_inven_tipo = B.IdMovi_inven_tipo AND A.IdNumMovi = B.IdNumMovi INNER JOIN
						  in_Producto AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdProducto = C.IdProducto INNER JOIN
						  in_producto_x_tb_bodega AS D ON C.IdEmpresa = D.IdEmpresa AND C.IdProducto = D.IdProducto INNER JOIN
						  prod_ModeloProduccion_x_Producto_CusTal AS F ON B.IdEmpresa = F.IdEmpresa AND B.IdProducto = F.IdProducto
	WHERE A.IdEmpresa =  @i_empresa
	and F.IdModeloProd =@w_IdModeloProduccion
	and F.Tipo ='MATPRIMA'
	and year(A.cm_fecha)=@w_AnioAnt 
	and month(A.cm_fecha)=@w_MesAnt 
	and A.IdMovi_inven_tipo =@w_IdMovi_inven_x_SaldoInicial
	
	set @w_numReg =0
	
	
	

	select 
	@w_ValorSaldoInicial	=isnull(sum(dm_cantidad * isnull(mv_costo,0)),0)
	,@w_KilosSaldoInicial   =isnull(sum(dm_cantidad * isnull(dm_peso ,0)) ,0)
	from prod_Costeo_in_movi_inve_data_SALDOINICIAL A
	WHERE A.IdEmpresa =  @i_empresa
	and year(A.cm_fecha)=@w_AnioAnt 
	and month(A.cm_fecha)=@w_MesAnt 
	
	

--set @w_ValorSaldoInicial	=9999999999999
--set @w_KilosSaldoInicial=99999999999999
	
end 


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
insert into dbo.prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
(
 IdEmpresa				,IdTipo_Costeo			,IdRubroCosteo			
,Anio					,mes					,ValorParcial_Mes       
,Valorkilos_Mes         ,ValorDolares_Mes		,ValorParcial_Acu 
,Valorkilos_Acu			,ValorDolares_Acu		,CostoUnitario
)

select 
 IdEmpresa				,IdTipo_Costeo			,IdRubroCosteo			
 ,@i_anio				,@i_mes					,0
 ,0						,0						,0
 ,0						,0						,0
 from dbo.prod_Costeo_Rubros_x_Tipo_costeo_cusTalme 
where IdEmpresa =@i_empresa
and IdTipo_Costeo=@w_IdTipo_Costeo
and  IdRubroCosteo not in (
		select IdRubroCosteo
		from dbo.prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
		where IdEmpresa =@i_empresa 
		and IdTipo_Costeo=@w_IdTipo_Costeo
		and Anio =@i_anio 
		and mes =@i_mes 
	)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-------- actualizando el inventario inicial del mes en curso 
update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorSaldoInicial
,Valorkilos_Mes=@w_KilosSaldoInicial 
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='MP_INVI'
and Anio =@i_anio 
and mes =@i_mes 
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- encontrando las compras importaciones ---------------------------------------------
select 
@w_IdMovi_Inve_Tipo_Importacion= IdMovi_Inve_Tipo_Importacion
from dbo.imp_Parametros
where IdEmpresa =@i_empresa 


set @w_ValorDolares_Mes_Compras =0
set @w_Valorkilos_Mes_Compras =0

select @w_ValorDolares_Mes_Compras =isnull(sum((dm_cantidad * isnull(mv_costo,0) )),0)
,@w_Valorkilos_Mes_Compras =isnull(sum((dm_cantidad* isnull(dm_peso ,0))),0)
from prod_Costeo_in_movi_inve_data 
where IdEmpresa =@i_empresa 
and IdMovi_inven_tipo =@w_IdMovi_Inve_Tipo_Importacion


----- actualizacion de compras por importacion 

update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorDolares_Mes_Compras 
,Valorkilos_Mes=@w_Valorkilos_Mes_Compras 
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='MP_COMPRA'
and Anio =@i_anio 
and mes =@i_mes 



------------- encontrando las compras importaciones ---------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------- encontrando los Ajustes que no sean importaciones ---------------------------------------------
------------------------------------------------------------------------------------------------------

set @w_ValorDolares_Mes_Ajustes =0
set @w_Valorkilos_Mes_Ajustes =0

select @w_ValorDolares_Mes_Ajustes  =isnull(sum((dm_cantidad * isnull(mv_costo,0) )),0)
,@w_Valorkilos_Mes_Ajustes  =isnull(sum((dm_cantidad* isnull(dm_peso ,0))),0)
from prod_Costeo_in_movi_inve_data 
where IdEmpresa =@i_empresa 
and IdMovi_inven_tipo not in (@w_IdMovi_Inve_Tipo_Importacion)


update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorDolares_Mes_Ajustes
,Valorkilos_Mes=@w_Valorkilos_Mes_Ajustes
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='MP_AJUS'
and Anio =@i_anio 
and mes =@i_mes 

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- Fin encontrando los Ajustes que no sean importaciones ----------------------------------
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- Encontrando MATERIA PRIMA CONSUMIDA ----------------------------------------------------
------------------------------------------------------------------------------------------------------

set @w_ValorDolares_Mes_MP_Consumida =0
set @w_Valorkilos_Mes_MP_Consumida =0

	SELECT     
	@w_ValorDolares_Mes_MP_Consumida  = sum(A.Consumo* 0) 
	,@w_Valorkilos_Mes_MP_Consumida   = sum(A.Consumo* 0) 
	FROM         prod_GestionProductivaTechos_CusTalme_Cab AS A ,
					  prod_Costeo_Tipo_Costeo_cusTalme AS B ,
					  in_Producto AS P 
	where A.IdEmpresa				= B.IdEmpresa 
	AND A.IdModeloProd				= B.IdModeloProd 
	and A.IdEmpresa					= P.IdEmpresa 
	AND A.IdProducto_MateriaPrima	= P.IdProducto
	and A.IdEmpresa =@i_empresa
	and year(A.Fecha) =@i_anio
	and month(A.Fecha) =@i_mes


	update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	set ValorDolares_Mes =@w_ValorDolares_Mes_MP_Consumida
	,Valorkilos_Mes=@w_Valorkilos_Mes_MP_Consumida
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo ='MP_CONS'
	and Anio =@i_anio 
	and mes =@i_mes 
	
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- encontrando MATERIA PRIMA CONSUMIDA ----------------------------------------------------
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- ACTUALIZANDO EL INVENTARIO FINAL -------------------------------------------------------
------------------------------------------------------------------------------------------------------


set @w_ValorDolares_Mes_InvenFinal =0
set @w_Valorkilos_Mes_MP_InvenFinal =0


SELECT @w_Valorkilos_Mes_MP_InvenFinal =isnull(sum(T.Valorkilos_Mes),0),@w_ValorDolares_Mes_InvenFinal =isnull(sum(T.ValorDolares_Mes),0)
FROM 
(
	SELECT SUM(Valorkilos_Mes) AS Valorkilos_Mes ,SUM(ValorDolares_Mes) AS ValorDolares_Mes
	FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo IN('MP_INVI','MP_COMPRA','MP_AJUS')
	and Anio = @i_anio
	and mes = @i_mes
	UNION
	SELECT SUM(Valorkilos_Mes*-1),SUM(ValorDolares_Mes*-1)
	FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo IN('MP_CONS')
	and Anio = @i_anio
	and mes = @i_mes
) AS T


	update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	set ValorDolares_Mes =@w_ValorDolares_Mes_InvenFinal
	,Valorkilos_Mes=@w_Valorkilos_Mes_MP_InvenFinal 
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo ='MP_INVF'
	and Anio =@i_anio 
	and mes =@i_mes 
	
	
	update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	set CostoUnitario=ValorDolares_Mes/Valorkilos_Mes
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo ='MP_CONS'
	and Anio =@i_anio 
	and mes =@i_mes 
	

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- FIN ACTUALIZANDO EL INVENTARIO FINAL ---------------------------------------------------
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------- MANO DE OBRA -------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-------------- MANO DE OBRA DIRECTA ------------------

--set @w_ValorDolares_ManoObra_Directa =0
--set @w_ValorDolares_ManoObra_InDirecta  =0

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------- FIN MANO DE OBRA -------------------------------------------------------------
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------- buscandolos gastos  en conta --------------------------------------------


delete prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme_Temp

--select * from prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme_Temp

insert into prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme_Temp
(IdEmpresa   ,IdTipo_Costeo        ,IdRubroCosteo        ,dc_valor,anio,mes)
select H.IdEmpresa   ,H.IdTipo_Costeo        ,H.IdRubroCosteo        ,sum(H.dc_valor) as dc_valor,@i_anio,@i_mes
 from 
(
		select 
		Q.IdEmpresa   ,Q.IdTipo_Costeo        ,Q.IdRubroCosteo        ,Q.IdCtaCble            ,Q.IdCentroCosto        ,sum(Q.dc_valor) as dc_valor
		from (
				SELECT     A.IdEmpresa, A.IdTipo_Costeo, A.IdRubroCosteo, A.IdCtaCble, A.IdCentroCosto
				,case  H.pc_Naturaleza when 'D' then dc_Valor  else dc_Valor * -1
				end as dc_valor
				FROM         ct_cbtecble_det AS B INNER JOIN
									  ct_cbtecble AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdTipoCbte = C.IdTipoCbte AND B.IdCbteCble = C.IdCbteCble INNER JOIN
									  prod_Costeo_Rubros_x_tipo_costeo_Parametros_cusTalme AS A ON B.IdEmpresa = A.IdEmpresa AND B.IdCtaCble = A.IdCtaCble AND 
									  B.IdCentroCosto = A.IdCentroCosto INNER JOIN
									  ct_plancta AS H ON B.IdEmpresa = H.IdEmpresa 
									  AND B.IdCtaCble = H.IdCtaCble AND A.IdEmpresa = H.IdEmpresa 
									  AND A.IdCtaCble = H.IdCtaCble
				WHERE     
				(YEAR(C.cb_Fecha) = @i_anio ) 
				AND (MONTH(C.cb_Fecha) = @i_mes )
				and (A.IdEmpresa = @i_empresa) 
				AND (A.IdTipo_Costeo = @w_IdTipo_Costeo )
			) Q 
		group by 
		Q.IdEmpresa   ,Q.IdTipo_Costeo        ,Q.IdRubroCosteo        ,Q.IdCtaCble            ,Q.IdCentroCosto        

) H
group by H.IdEmpresa   ,H.IdTipo_Costeo        ,H.IdRubroCosteo        



update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme 
set ValorDolares_Mes=A.dc_valor
FROM         prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme_Temp AS A INNER JOIN
                      prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipo_Costeo = B.IdTipo_Costeo AND 
                      A.IdRubroCosteo = B.IdRubroCosteo AND A.anio = B.Anio AND A.mes = B.mes

                      
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------- contabilizando los gastos  --------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------- Encontrando la gestion productiva en Kg de Prodeuccion --------------------------------------------

set @w_Valorkilos_GestionProductiva  =0

select @w_Valorkilos_GestionProductiva  =isnull(sum(B.Prducc_Kg),0)
from prod_GestionProductivaTechos_CusTalme_Cab A, prod_GestionProductivaTechos_CusTalme_Detalle B
where 
A.IdEmpresa =B.IdEmpresa 
and A.IdGestionProductiva=B.IdGestionProductiva
and A.IdEmpresa =@i_empresa
and A.Estado ='A' 
and year(A.Fecha)=@i_anio 
and MONTH(A.fecha)=@i_mes 

---------- actualizando Gestion Productiva KG
update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set Valorkilos_Mes=@w_Valorkilos_GestionProductiva  
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='SUB_TOTAL_COSTPRO'
and Anio =@i_anio 
and mes =@i_mes 


---------- actualizando Gestion Productiva $$$

set @w_ValorDolares_GestionProductiva  =0


SELECT @w_ValorDolares_GestionProductiva   = isnull(SUM(ValorDolares_Mes) ,0)
FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and (IdRubroCosteo IN('MP_CONS','MO_DIRE','MO_INDI') or  IdRubroCosteo like 'GIFAB_%')
and Anio = @i_anio
and mes = @i_mes


update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorDolares_GestionProductiva  
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='SUB_TOTAL_COSTPRO'
and Anio =@i_anio 
and mes =@i_mes 


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------- actualizando transferencia de Chatarra -----------------------------------------------
-----'''' pendiente de definir donde esta esa tabla 

--------------- actualizando transferencia de Chatarra -----------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------




--------------- Encontrando la gestion productiva en Kg de Prodeuccion -------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

SELECT @w_ValorDolares_TOTAL_COSTO = isnull(SUM(ValorDolares_Mes) ,0)
,@w_ValorKilos_TOTAL_COSTO = isnull(SUM(Valorkilos_Mes) ,0)
FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo IN('SUB_TOTAL_COSTPRO','TRANF_CHAT') 
and Anio = @i_anio
and mes = @i_mes


update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorDolares_TOTAL_COSTO 
,Valorkilos_Mes =@w_ValorKilos_TOTAL_COSTO 
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='TOTAL_COSTO'
and Anio =@i_anio 
and mes =@i_mes 

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------- actualizando total costo de Prodeuccion -------------------------------




------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------INVENTARIO INICIAL PRODUCTOS TERMINADO -------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
------------------------- buscando el SALDO INICIAL DE PRODUCTOS FINAL --------------- 

SET @w_ValorSaldoInicial  =0
SET @w_KilosSaldoInicial  =0

-- SELECT * FROM dbo.prod_Costeo_Rubros_x_Tipo_costeo_cusTalme WHERE IdRubroCosteo like 'PROD_%' 


select 
 @w_ValorSaldoInicial  =isnull(ValorDolares_Mes ,0)
,@w_KilosSaldoInicial  =isnull(Valorkilos_Mes,0)
from dbo.prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
where IdEmpresa =@i_empresa 
and IdTipo_Costeo =@w_IdTipo_Costeo 
and Anio =@w_AnioAnt 
and mes =@w_MesAnt 
and IdRubroCosteo ='PROD_TERM_INV_FINAL' 


set @w_ValorSaldoInicial  =ISNULL(@w_ValorSaldoInicial  ,0)
set @w_KilosSaldoInicial  =ISNULL(@w_KilosSaldoInicial  ,0)


------- si no hay saldo inciial en el historico busco en el mes anterio 
-- si hay registro de saldo inicial de inventario
if @w_ValorSaldoInicial  =0
begin
	 
	 
	 
	 delete prod_Costeo_in_movi_inve_data_SALDOINICIAL_PROCTER
	 where idempresa=@i_empresa 
	 and idanio			=@w_AnioAnt
	 and idmes			=@w_MesAnt

	 	 
	insert into prod_Costeo_in_movi_inve_data_SALDOINICIAL_PROCTER
	( IdEmpresa			,IdSucursal		,IdBodega			,IdMovi_inven_tipo		,IdNumMovi                               
	 ,CodMoviInven		,cm_tipo		,cm_observacion		,cm_fecha				,Secuencia   
	 ,IdProducto		,dm_cantidad	,dm_stock_ante		,dm_stock_actu			,mv_costo	
	 ,pr_codigo			,pr_descripcion	,pr_costo_promedio
	 ,idanio			,idmes			,dm_peso 
	)
	SELECT     
	  A.IdEmpresa	, A.IdSucursal		, A.IdBodega		, A.IdMovi_inven_tipo	, A.IdNumMovi
	, A.CodMoviInven, A.cm_tipo			, A.cm_observacion	, A.cm_fecha			, B.Secuencia
	, B.IdProducto	, B.dm_cantidad		, B.dm_stock_ante	, B.dm_stock_actu		, B.mv_costo
	, C.pr_codigo	, C.pr_descripcion	, D.pr_costo_promedio
	, @w_AnioAnt ,@w_MesAnt				,B.dm_peso 
	FROM         in_movi_inve AS A INNER JOIN
						  in_movi_inve_detalle AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND 
						  A.IdMovi_inven_tipo = B.IdMovi_inven_tipo AND A.IdNumMovi = B.IdNumMovi INNER JOIN
						  in_Producto AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdProducto = C.IdProducto INNER JOIN
						  in_producto_x_tb_bodega AS D ON C.IdEmpresa = D.IdEmpresa AND C.IdProducto = D.IdProducto INNER JOIN
						  prod_ModeloProduccion_x_Producto_CusTal AS F ON B.IdEmpresa = F.IdEmpresa AND B.IdProducto = F.IdProducto
	WHERE A.IdEmpresa =  @i_empresa
	and F.IdModeloProd =@w_IdModeloProduccion
	and F.Tipo ='PRODTERMI'
	and year(A.cm_fecha)=@w_AnioAnt 
	and month(A.cm_fecha)=@w_MesAnt 
	and A.IdMovi_inven_tipo =@w_IdMovi_inven_x_SaldoInicial
	
	
	
	set @w_numReg =0
	

	select 
	@w_ValorSaldoInicial	=isnull(sum(dm_cantidad * isnull(mv_costo,0)),0)
	,@w_KilosSaldoInicial   =isnull(sum(dm_cantidad * isnull(dm_peso ,0)) ,0)
	from prod_Costeo_in_movi_inve_data_SALDOINICIAL_PROCTER A
	WHERE A.IdEmpresa =  @i_empresa
	and year(A.cm_fecha)=@w_AnioAnt 
	and month(A.cm_fecha)=@w_MesAnt 
	
	
end 




-------- actualizando el inventario inciial PROD TERMINADO del mes en curso 
update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorSaldoInicial
,Valorkilos_Mes=@w_KilosSaldoInicial 
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='PROD_TERM_INV_INI'
and Anio =@i_anio 
and mes =@i_mes 



--------------------------------------------------------------------------------------
---------------------------- opteniendo movi de inven por prodc terminado ------------
--------------------------------------------------------------------------------------


insert into prod_Costeo_in_movi_inve_data_ProdTermi
( IdEmpresa		,IdSucursal		,IdBodega		,IdMovi_inven_tipo	,IdNumMovi                               
,CodMoviInven	,cm_tipo		,cm_observacion	,cm_fecha			,Secuencia   
,IdProducto		,dm_cantidad	,dm_stock_ante	,dm_stock_actu		,mv_costo	
,pr_codigo		,pr_descripcion	,pr_costo_promedio
,idanio			,idmes			,dm_peso
)
SELECT     
A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.CodMoviInven, A.cm_tipo, A.cm_observacion, A.cm_fecha, B.Secuencia, B.IdProducto, 
B.dm_cantidad, B.dm_stock_ante, B.dm_stock_actu, B.mv_costo, C.pr_codigo, C.pr_descripcion, D.pr_costo_promedio
,@i_anio		,@i_mes			,B.dm_peso
FROM         in_movi_inve AS A INNER JOIN
                      in_movi_inve_detalle AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND 
                      A.IdMovi_inven_tipo = B.IdMovi_inven_tipo AND A.IdNumMovi = B.IdNumMovi INNER JOIN
                      in_Producto AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdProducto = C.IdProducto INNER JOIN
                      in_producto_x_tb_bodega AS D ON C.IdEmpresa = D.IdEmpresa AND C.IdProducto = D.IdProducto INNER JOIN
                      prod_ModeloProduccion_x_Producto_CusTal AS F ON B.IdEmpresa = F.IdEmpresa AND B.IdProducto = F.IdProducto
WHERE A.IdEmpresa =  @i_empresa
and F.IdModeloProd =@w_IdModeloProduccion
and F.Tipo ='PRODTERMI'
and year(A.cm_fecha)=@i_anio 
and month(A.cm_fecha)=@i_mes 


--------------------------------------------------------------------------------------
---------------------------- FIN opteniendo movi de inven por prodc terminado ------------
--------------------------------------------------------------------------------------
----------- COMPRAS  -----------

set @w_ValorDolares_Mes_Compras =0
set @w_Valorkilos_Mes_Compras =0

select @w_ValorDolares_Mes_Compras =isnull(sum((dm_cantidad * isnull(mv_costo,0) )),0)
,@w_Valorkilos_Mes_Compras =isnull(sum((dm_cantidad* isnull(dm_peso ,0))),0)
from prod_Costeo_in_movi_inve_data_ProdTermi --- productos terminados
where IdEmpresa =@i_empresa 
and IdMovi_inven_tipo =@w_IdMovi_Inve_Tipo_Importacion

----- Actualizacion de compras por importacion 

update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorDolares_Mes_Compras 
,Valorkilos_Mes=@w_Valorkilos_Mes_Compras 
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='PROD_TERM_COMPRAS'
and Anio =@i_anio 
and mes =@i_mes 


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------- FIN buscando el SALDO INICIAL DE PRODUCTOS FINAL --------------- 
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
------------- encontrando los Ajustes que no sean importaciones ---------------------------------------------
------------------------------------------------------------------------------------------------------

set @w_ValorDolares_Mes_Ajustes =0
set @w_Valorkilos_Mes_Ajustes =0

select @w_ValorDolares_Mes_Ajustes  =isnull(sum((dm_cantidad * isnull(mv_costo,0) )),0)
,@w_Valorkilos_Mes_Ajustes  =isnull(sum((dm_cantidad* isnull(dm_peso ,0))),0)
from prod_Costeo_in_movi_inve_data_ProdTermi 
where IdEmpresa =@i_empresa 
and IdMovi_inven_tipo not in (@w_IdMovi_Inve_Tipo_Importacion)


update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
set ValorDolares_Mes =@w_ValorDolares_Mes_Ajustes
,Valorkilos_Mes=@w_Valorkilos_Mes_Ajustes
where IdEmpresa =@i_empresa
and IdTipo_Costeo =@w_IdTipo_Costeo 
and IdRubroCosteo ='PROD_TERM_AJUST_INV'
and Anio =@i_anio 
and mes =@i_mes 

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- Fin encontrando los Ajustes que no sean importaciones ----------------------------------
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------- ACTUALIZANDO EL INVENTARIO FINAL producti FINAL ----------------------------------------
------------------------------------------------------------------------------------------------------


set @w_ValorDolares_Mes_InvenFinal =0
set @w_Valorkilos_Mes_MP_InvenFinal =0


SELECT 
 @w_Valorkilos_Mes_MP_InvenFinal =isnull(sum(T.Valorkilos_Mes),0)
,@w_ValorDolares_Mes_InvenFinal =isnull(sum(T.ValorDolares_Mes),0)
FROM 
(
	SELECT SUM(Valorkilos_Mes) AS Valorkilos_Mes ,SUM(ValorDolares_Mes) AS ValorDolares_Mes
	FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo IN('PROD_TERM_INV_INI','PROD_TERM_COMPRAS','PROD_TERM_AJUST_INV','PROD_TERM_AJUST')
	and Anio = @i_anio
	and mes = @i_mes
) AS T




	update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	set ValorDolares_Mes =@w_ValorDolares_Mes_InvenFinal
	,Valorkilos_Mes=@w_Valorkilos_Mes_MP_InvenFinal 
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo ='PROD_TERM_SUM_INVINI_COMP_AJUS'
	and Anio =@i_anio 
	and mes =@i_mes 
	
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-------------  ACTUALIZANDO TOTAL DISPONIBLE ---------------------------------------------------------
------------------------------------------------------------------------------------------------------



set @w_ValorDolares =0
set @w_Valorkilos =0


SELECT 
 @w_Valorkilos =isnull(sum(T.Valorkilos_Mes),0)
,@w_ValorDolares =isnull(sum(T.ValorDolares_Mes),0)
FROM 
(
	SELECT SUM(Valorkilos_Mes) AS Valorkilos_Mes ,SUM(ValorDolares_Mes) AS ValorDolares_Mes
	FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo IN('PROD_TERM_SUM_INVINI_COMP_AJUS','TOTAL_COSTO')
	and Anio = @i_anio
	and mes = @i_mes
) AS T


		update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
		set ValorDolares_Mes =@w_ValorDolares
		,Valorkilos_Mes=@w_Valorkilos 
		where IdEmpresa =@i_empresa
		and IdTipo_Costeo =@w_IdTipo_Costeo 
		and IdRubroCosteo ='PROD_TERM_TOTAL_DISPO'
		and Anio =@i_anio 
		and mes =@i_mes 
		
		-------------------------------------------------------------
		--------- calculando el costo unitario de producto final ----
		-------------------------------------------------------------
				---- kilos/dolares


				
		update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
		set CostoUnitario = Valorkilos_Mes/ValorDolares_Mes 
		where IdEmpresa   = @i_empresa
		and IdTipo_Costeo = @w_IdTipo_Costeo 
		and IdRubroCosteo = 'PROD_TERM_TOTAL_DISPO'
		and Anio =@i_anio 
		and mes =@i_mes 
		
		set @W_CostoUnitario_ProdFinal=0
		
		select @W_CostoUnitario_ProdFinal=CostoUnitario
		from prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
		where IdEmpresa   = @i_empresa
		and IdTipo_Costeo = @w_IdTipo_Costeo 
		and IdRubroCosteo = 'PROD_TERM_TOTAL_DISPO'
		and Anio =@i_anio 
		and mes =@i_mes 
		
		
		-------------------------------------------------------------
		--------- fin calculando el costo unitario de producto final ----
		-------------------------------------------------------------
		
	
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- FIN   ACTUALIZANDO TOTAL DISPONIBLE ----------------------------------------------------
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- ACTUALIZANDO COSTO DE VENTA ------------------------------------------------------------
----------------  
------------------------------------------------------------------------------------------------------

---- bsucando las ventas del mes en curso 
set @w_ValorDolares_CostoVta =0
set @w_Valorkilos_CostoVta =0

SELECT     
 @w_Valorkilos_CostoVta   =sum(B.vt_cantidad* B.vt_Peso)
,@w_ValorDolares_CostoVta =sum(B.vt_cantidad* B.vt_Peso * @W_CostoUnitario_ProdFinal)
FROM         fa_factura AS A INNER JOIN
                      fa_factura_det AS B ON A.IdEmpresa = B.IdEmpresa 
                      AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega 
                      AND A.IdCbteVta = B.IdCbteVta INNER JOIN
                      prod_ModeloProduccion_x_Producto_CusTal AS C ON B.IdEmpresa = C.IdEmpresa 
                      AND B.IdProducto = C.IdProducto
WHERE     A.IdEmpresa = @i_empresa
AND YEAR(A.vt_fecha) = @i_anio  
AND month(A.vt_fecha) = @i_mes
AND (C.Tipo = 'PRODTERMI')
and A.Estado ='A'

	update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	set 
	 Valorkilos_Mes    =@w_Valorkilos_CostoVta 
	,ValorDolares_Mes  =@w_ValorDolares_CostoVta
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo ='PROD_TERM_COST_VTA'
	and Anio =@i_anio 
	and mes =@i_mes 
	
	
		update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
		set CostoUnitario = Valorkilos_Mes/ValorDolares_Mes 
		where IdEmpresa   = @i_empresa
		and IdTipo_Costeo = @w_IdTipo_Costeo 
		and IdRubroCosteo = 'PROD_TERM_COST_VTA'
		and Anio =@i_anio 
		and mes =@i_mes 
	
	
	
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- FIN ACTUALIZANDO COSTO DE VENTA --------------------------------------------------------
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- ACTUALIZANDO EL INVENTARIO FINAL    ----------------------------------------------------
----------------  
------------------------------------------------------------------------------------------------------

set @w_ValorDolares =0
set @w_Valorkilos =0

SELECT 
 @w_Valorkilos =isnull(sum(T.Valorkilos_Mes),0)
,@w_ValorDolares =isnull(sum(T.ValorDolares_Mes),0)
FROM 
(
	SELECT SUM(Valorkilos_Mes) AS Valorkilos_Mes ,SUM(ValorDolares_Mes) AS ValorDolares_Mes
	FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo IN('PROD_TERM_TOTAL_DISPO')
	and Anio = @i_anio
	and mes = @i_mes
	UNION
	SELECT SUM(Valorkilos_Mes*-1),SUM(ValorDolares_Mes*-1)
	FROM prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	where IdEmpresa =@i_empresa
	and IdTipo_Costeo =@w_IdTipo_Costeo 
	and IdRubroCosteo IN('PROD_TERM_COST_VTA')
	and Anio = @i_anio
	and mes = @i_mes
) AS T


	
	update prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme
	set ValorDolares_Mes	=@w_ValorDolares
	   ,Valorkilos_Mes		=@w_Valorkilos 
	where IdEmpresa		= @i_empresa
	and IdTipo_Costeo	= @w_IdTipo_Costeo 
	and IdRubroCosteo	='PROD_TERM_INV_FINAL'
	and Anio =@i_anio 
	and mes =@i_mes 
	
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- ACTUALIZANDO EL INVENTARIO FINAL    ----------------------------------------------------
------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- CALCULO DE COSTO UNITARIO PRODUCTO FINAL -----------------------------------------------
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------- FIN CALCULO DE COSTO UNITARIO PRODUCTO FINAL -------------------------------------------
------------------------------------------------------------------------------------------------------



select * from prod_Costeo_Rubros_x_Tipo_costeo_Datos_cusTalme