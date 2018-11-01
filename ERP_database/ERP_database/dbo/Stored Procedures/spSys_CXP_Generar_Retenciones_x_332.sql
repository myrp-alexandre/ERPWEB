CREATE proc [dbo].[spSys_CXP_Generar_Retenciones_x_332]
(
 @i_IdEmpresa int
,@i_fechaIni datetime
,@i_fechaFin datetime
,@i_Aplicar_Cambio bit
)
as
begin
/*
declare @i_IdEmpresa int
declare @i_fechaIni datetime
declare @i_fechaFin datetime


set @i_IdEmpresa =1
set @i_fechaIni ='01/09/2016'
set @i_fechaFin ='30/09/2016'
*/

declare @C_IdEmpresa int
declare @C_IdTipoCbte_Ogiro int 
declare @C_IdCbteCble_Ogiro numeric
declare @C_co_fechaOg datetime
DECLARE @C_co_observacion VARCHAR(500)
declare @C_co_baseImponible float

declare @W_IdRetencion numeric
declare @i_secuencia int
set @W_IdRetencion=0
set @i_secuencia =0


DECLARE CURSOR_OG CURSOR FOR   
		select og.IdEmpresa,Og.IdTipoCbte_Ogiro,OG.IdCbteCble_Ogiro
		,Og.co_fechaOg,og.co_observacion,OG.co_baseImponible
		from cp_orden_giro OG
		where not exists
		(
			select * from cp_retencion RT
			where OG.IdEmpresa=RT.IdEmpresa_Ogiro
			and OG.IdTipoCbte_Ogiro=RT.IdTipoCbte_Ogiro
			and OG.IdCbteCble_Ogiro=RT.IdCbteCble_Ogiro
		)
		and OG.IdEmpresa=@i_idempresa
		and OG.co_fechaOg between @i_fechaIni and @i_fechaFin
		and OG.co_vaCoa='S'
  
OPEN CURSOR_OG  
  
FETCH NEXT FROM CURSOR_OG   
INTO @C_IdEmpresa	,@C_IdTipoCbte_Ogiro	,@C_IdCbteCble_Ogiro
    ,@C_co_fechaOg	,@C_co_observacion		,@C_co_baseImponible
  
  select @W_IdRetencion=max(isnull(R.IdRetencion,0)) +1
		from cp_retencion R where R.IdEmpresa=@i_IdEmpresa

WHILE @@FETCH_STATUS = 0  
BEGIN  
		


		INSERT INTO [dbo].[cp_retencion]
		([IdEmpresa]        ,[IdRetencion]           
		,[fecha]			,[observacion]						,[re_Tiene_RTiva]			,[re_Tiene_RFuente]		,[IdEmpresa_Ogiro]  ,[IdCbteCble_Ogiro]       ,[IdTipoCbte_Ogiro]
		,[re_EstaImpresa]	,[Estado]					
		,[IdUsuario]		,[Fecha_Transac]					,[nom_pc]
		)
		values
		(
		 @C_IdEmpresa		,@W_IdRetencion						
		,@C_co_fechaOg		,'FAC SIN RT' + @C_co_observacion	,'N'						,'S'					 ,@C_IdEmpresa		,@C_IdCbteCble_Ogiro	,@C_IdTipoCbte_Ogiro
		,'N'				,'A'
		,'sysAdmin'			,GETDATE()							,'Generado_x_sys'
		)

		INSERT INTO [dbo].[cp_retencion_det]
        ( [IdEmpresa]				,[IdRetencion]           ,[Idsecuencia]				,[re_tipoRet]           ,[re_baseRetencion]
         ,[IdCodigo_SRI]			,[re_Codigo_impuesto]	 ,[re_Porcen_retencion]		,[re_valor_retencion]	,[re_estado]
         ,[IdUsuario]				,[Fecha_Transac]		 ,[nom_pc]			
		)
		VALUES
		(
		@C_IdEmpresa				,@W_IdRetencion			,1							,'RTF'					,@C_co_baseImponible
		,966						,'332'					,0							,0						,'A'
		,'SysAdmin'					,GETDATE()				,'Generado_x_sys'
		)

		
		

		

		set @W_IdRetencion=@W_IdRetencion+1

		--select @W_IdRetencion
  
    FETCH NEXT FROM CURSOR_OG   
    INTO @C_IdEmpresa	,@C_IdTipoCbte_Ogiro	,@C_IdCbteCble_Ogiro
    ,@C_co_fechaOg	,@C_co_observacion			,@C_co_baseImponible

END   
CLOSE CURSOR_OG;  
DEALLOCATE CURSOR_OG;  

print '*****************'
print 'select * from [dbo].[cp_retencion] RT where RT.nom_pc=Generado_x_sys and RT.fecha between @i_fechaIni and @i_fechaFin'
select * from [dbo].[cp_retencion] RT where RT.nom_pc='Generado_x_sys'and RT.fecha between @i_fechaIni and @i_fechaFin
print '*****************'
print 'select * from cp_retencion RT ,cp_retencion_det  RT_det where Rt.IdEmpresa=RT_det.IdEmpresa and RT.IdRetencion=RT_det.IdRetencion and RT.nom_pc=Generado_x_sys and RT.fecha between @i_fechaIni and @i_fechaFin '
select * from cp_retencion RT ,cp_retencion_det  RT_det where Rt.IdEmpresa=RT_det.IdEmpresa and RT.IdRetencion=RT_det.IdRetencion and RT.nom_pc='Generado_x_sys' and RT.fecha between @i_fechaIni and @i_fechaFin 
print '*****************'

if (@i_Aplicar_Cambio =0)
begin


	print 'delete cp_retencion_det '
	delete cp_retencion_det 
	from cp_retencion RT ,cp_retencion_det  RT_det 
	where 	Rt.IdEmpresa=RT_det.IdEmpresa and RT.IdRetencion=RT_det.IdRetencion and RT.nom_pc='Generado_x_sys' and RT.fecha between @i_fechaIni and @i_fechaFin 

	print 'delete cp_retencion '
	delete from [dbo].[cp_retencion] where nom_pc='Generado_x_sys' and fecha between @i_fechaIni and @i_fechaFin

end 


end