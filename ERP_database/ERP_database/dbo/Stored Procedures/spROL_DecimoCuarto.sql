
 --exec spROL_DecimoCuarto 1,'01/08/2016','41/07/2017','SIERRA'
CREATE PROCEDURE [dbo].[spROL_DecimoCuarto]
	(
	@IdEmpresa int,	
	@IdPeriodo int,
	@Region varchar(10),
	@IdUsuario varchar(50),
	@observacion varchar(200)
	)
	as
BEGIN

declare
@IdRubro_calculado varchar(50),
@Fi date,
@Ff date

-- variables pruebas
	--@IdEmpresa int,
	--@IdPeriodo int,
	--@Region varchar(10),
	--@IdUsuario varchar(50),
	--@observacion varchar(200)
	--set @IdEmpresa =1
	--set @IdPeriodo =2018
	--set @Region ='COSTA'
	--set @IdUsuario ='admin'
	--set @observacion= '...'






if(@Region='COSTA')
select @fi=convert(varchar(4), (@IdPeriodo-1))+'-'+'12'+'-'+'01'
select @ff=convert(varchar(4), (@IdPeriodo))+'-'+'11'+'-'+'30' 
if((select  COUNT(IdPeriodo) from ro_periodo where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPeriodo)=0)
insert into ro_periodo (
IdEmpresa,				IdPeriodo,			pe_FechaIni,					pe_FechaFin,					pe_estado			,Fecha_Transac
)
values
(@IdEmpresa,			@IdPeriodo,			@Fi,							@Ff,							'A',				GETDATE())



if((select  COUNT(IdPeriodo) from ro_periodo_x_ro_Nomina_TipoLiqui where IdEmpresa=@IdEmpresa and IdNomina_Tipo=1 and IdNomina_TipoLiqui=4)=0)
insert into ro_periodo_x_ro_Nomina_TipoLiqui(
IdEmpresa,				IdNomina_Tipo,			IdNomina_TipoLiqui,					IdPeriodo,					Cerrado			,Procesado,			Contabilizado
)
values
(@IdEmpresa,			1,						4,									@IdPeriodo,					'N',			'S',				'N')





if((select  COUNT(IdPeriodo) from ro_rol where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPEriodo and IdNominaTipo=1 and IdNominaTipoLiqui=4)>0)
update ro_rol set UsuarioModifica=@IdUsuario, FechaModifica=GETDATE() where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPEriodo and IdNominaTipo=1 and IdNominaTipoLiqui=4
else
insert into ro_rol
(IdEmpresa,		IdNominaTipo,		IdNominaTipoLiqui,		IdPeriodo,			Descripcion,				Observacion,				Cerrado,			FechaIngresa,
UsuarioIngresa,	FechaModifica,		UsuarioModifica,		FechaAnula,			UsuarioAnula,				MotivoAnula,				UsuarioCierre,		FechaCierre,
IdCentroCosto)
values
(@IdEmpresa		,1					,4						,@IdPEriodo			,@observacion				,@observacion				,'N'				,GETDATE()
,@IdUsuario		,null				,null					,null				,null						,null						,null				,null
,null)



delete ro_rol_detalle where IdEmpresa=@IdEmpresa and IdNominaTipo=1 and IdNominaTipoLiqui=4 and IdPeriodo=@IdPeriodo

----------------------------------------------------------------------------------------------------------------------------------------------
-------------calculando decimo cuarto sueldo-------------------------------------------------------------------------------------------------<
----------------------------------------------------------------------------------------------------------------------------------------------

select @IdRubro_calculado= IdRubro_DIII from ro_rubros_calculados where IdEmpresa=@IdEmpresa-- obteniendo el idrubro desde parametros
insert into ro_rol_detalle
(IdEmpresa,				IdNominaTipo,			IdNominaTipoLiqui,			IdPeriodo,			IdEmpleado,			IdRubro,			Orden,			Valor
,rub_visible_reporte,	Observacion,			TipoMovimiento,				IdCentroCosto		,IdCentroCosto_sub_centro_costo			,IdPunto_cargo)


select

@IdEmpresa,				1,						4,							@IdPeriodo,			emp.IdEmpleado,		@IdRubro_calculado, '1',			SUM(acum.Valor),
1,						'Pago decimo cuarto sueldo', null,					null,				 null,										 null

 from ro_rol_detalle_x_rubro_acumulado acum, ro_empleado emp
 where acum.IdEmpresa=emp.IdEmpresa
 and acum.IdEmpleado=emp.IdEmpleado    
 and acum.Estado='PEN'
 AND emp.em_status='EST_ACT'
 AND acum.IdRubro='200'
 group by emp.IdEmpleado               
 end
