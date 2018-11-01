CREATE proc [dbo].[spSys_Carga_Diarios_SIAC_DBERP] as
declare @i_compania_Insert int
set @i_compania_Insert =2

delete from dbo.xxxtb_cabcbte
where cp_compania>1

delete from dbo.xxxtb_detcbte
where ic_compania>1

delete from dbo.xxxtb_plan_cuenta
where pc_compania>1

delete from dbo.xxxtb_nivel_cuenta
where nv_compania>1

delete from dbo.ct_plancta  where IdEmpresa=@i_compania_Insert
delete from dbo.ct_plancta_nivel  where IdEmpresa=@i_compania_Insert
delete from dbo.ct_cbtecble_det  where IdEmpresa=@i_compania_Insert
delete from dbo.ct_cbtecble where IdEmpresa=@i_compania_Insert




--==================================================================================


INSERT INTO [DBERP].[dbo].[ct_plancta_nivel]
([IdEmpresa],[IdNivelCta],[nv_NumDigitos],[nv_Descripcion],[Estado])
select 
@i_compania_Insert ,nv_nivel,nv_numdig,nv_descripcion,'A'
from xxxtb_nivel_cuenta


--========================================================================

update [DBERP].[dbo].[xxxtb_plan_cuenta]
set [pc_grupo_cble]='ACTIV'
where [pc_grupo_cble]='A'


update [DBERP].[dbo].[xxxtb_plan_cuenta]
set [pc_grupo_cble]='PASIV'
where [pc_grupo_cble]='P'


update [DBERP].[dbo].[xxxtb_plan_cuenta]
set [pc_grupo_cble]='PATRI'
where [pc_grupo_cble]='T'


update [DBERP].[dbo].[xxxtb_plan_cuenta]
set [pc_grupo_cble]='INGRE'
where [pc_grupo_cble]='I'


update [DBERP].[dbo].[xxxtb_plan_cuenta]
set [pc_grupo_cble]='EGRES'
where [pc_grupo_cble]='E'

update [DBERP].[dbo].[xxxtb_plan_cuenta]
set [pc_ctapadre]=null
where [pc_ctapadre]=''


INSERT INTO [DBERP].[dbo].[ct_plancta]
([IdEmpresa]			,[IdCtaCble]	,[pc_Cuenta]	,[IdCtaCblePadre]	,[IdCatalogo]
,[pc_Naturaleza]		,[IdNivelCta]	,[IdGrupoCble]	,[pc_Estado]		,[pc_EsMovimiento]
,[pc_es_flujo_efectivo]	,[pc_clave_corta]
)
SELECT 
@i_compania_Insert		,
[pc_cuenta]     ,[pc_nombre]     ,[pc_ctapadre]     ,0
,[pc_naturaleza]		,[pc_nivel]		 ,[pc_grupo_cble] ,'A'				 ,[pc_movimiento] 
,'N'					,null
FROM [DBERP].[dbo].[xxxtb_plan_cuenta]
where [pc_ctapadre] is null


INSERT INTO [DBERP].[dbo].[ct_plancta]
([IdEmpresa]			,[IdCtaCble]	,[pc_Cuenta]	,[IdCtaCblePadre]	,[IdCatalogo]
,[pc_Naturaleza]		,[IdNivelCta]	,[IdGrupoCble]	,[pc_Estado]		,[pc_EsMovimiento]
,[pc_es_flujo_efectivo]	,[pc_clave_corta]
)
SELECT 
@i_compania_Insert		,
[pc_cuenta]     ,[pc_nombre]     ,[pc_ctapadre]     ,0
,[pc_naturaleza]		,[pc_nivel]		 ,[pc_grupo_cble] ,'A'				 ,[pc_movimiento] 
,'N'					,null
FROM [DBERP].[dbo].[xxxtb_plan_cuenta]
where [pc_ctapadre] in
(
select [pc_cuenta] from [DBERP].[dbo].[xxxtb_plan_cuenta]
)
order by 1



--====================================================================================
--====================================================================================
--- cabecera de cbte cble

INSERT INTO [DBERP].[dbo].[ct_cbtecble]
([IdEmpresa]		,[IdTipoCbte]	,[IdCbteCble]		
,[CodCbteCble]		,[IdPeriodo]
,[cb_Fecha]			,[cb_Valor]		,[cb_Observacion]	,[cb_Secuencia]		,[cb_Estado]
,[cb_Anio]			,[cb_mes]		,[IdUsuario]		,[IdUsuarioAnu]		,[cb_MotivoAnu]
,[IdUsuarioUltModi]	,[cb_FechaAnu]	,[cb_FechaTransac]	,[cb_FechaUltModi]	,[cb_Mayorizado]
)
SELECT distinct 
@i_compania_Insert	,[cp_tipocbte]		,([cp_aniofiscal]*100000)+ [cp_numcbte]
,''					,(year([cp_fecha])*100)+MONTH([cp_fecha])
,[cp_fecha]			,[cp_valor]			,[cp_descripcion]	,[cp_secuencia]		,'A'
,year([cp_fecha])	,month([cp_fecha])	,''				,''					,''
,''					,null				,[cp_fecha]	,null				,'N'
FROM [DBERP].[dbo].[xxxtb_cabcbte]

--====================================================================================
--====================================================================================
--- FIN cabecera de cbte cble



--====================================================================================
--====================================================================================
--- detalle de cbte cble

INSERT INTO [DBERP].[dbo].[ct_cbtecble_det]
(
[IdEmpresa]				,[IdTipoCbte]		,[IdCbteCble]		
,[secuencia]			,[IdCtaCble]		,[IdCentroCosto]		
,[dc_Valor]				
,[dc_Observacion]		,[dc_Numconciliacion]	,[dc_EstaConciliado]
)
SELECT distinct 
@i_compania_Insert	,[ic_tipocbte]			,([ic_aniofiscal]*100000) +[ic_numcbte]		
,[ic_secuencia]		,[ic_cuenta]			,null
,valor=case 
when  [ic_dbcr]='D' then [ic_valor]
when  [ic_dbcr]='C' then [ic_valor]*-1
end 
,[ic_descripcion]	,0							,'N'
FROM [DBERP].[dbo].[xxxtb_detcbte]

--====================================================================================
--====================================================================================


select * from dbo.ct_plancta_nivel  where IdEmpresa=@i_compania_Insert
select * from dbo.ct_plancta  where IdEmpresa=@i_compania_Insert
select * from dbo.ct_cbtecble_det  where IdEmpresa=2
select * from dbo.ct_cbtecble where IdEmpresa=@i_compania_Insert