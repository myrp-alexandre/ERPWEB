
CREATE PROCEDURE [dbo].[spROL_DecimoCuarto]
       (
       @IdEmpresa int,      
       @IdPeriodo int,
       @Region varchar(10),
       @IdUsuario varchar(50),
       @observacion varchar(200),
       @IdRol int
       )
       as
BEGIN

declare
@IdRubro_calculado varchar(50),
@Fi date,
@Ff date

----variables pruebas
    --   @IdEmpresa int,
    --   @IdPeriodo int,
    --   @Region varchar(10),
    --   @IdUsuario varchar(50),
    --   @observacion varchar(200),
	   --@IdRol int
    --   set @IdEmpresa =1
    --   set @IdPeriodo =2018
    --   set @Region ='COSTA'
    --   set @IdUsuario ='admin'
    --   set @observacion= '...'
	   --set @IdRol=6




if(@Region='COSTA')
select @fi=convert(varchar(4), (@IdPeriodo-1))+'-'+'03'+'-'+'01'
select @ff=convert(varchar(4), (@IdPeriodo))+'-'+'02'+'-'+'28' 

SET @IdPeriodo=concat( @IdPeriodo,'02','03' ) 

if((select  COUNT(IdPeriodo) from ro_periodo where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPeriodo)=0)
insert into ro_periodo (
IdEmpresa,                        IdPeriodo,                 pe_FechaIni,                             pe_FechaFin,                             pe_estado                  ,Fecha_Transac
)
values
(@IdEmpresa,               @IdPeriodo,                @Fi,                                            @Ff,                                            'A',                       GETDATE())



if((select  COUNT(IdPeriodo) from ro_periodo_x_ro_Nomina_TipoLiqui where IdEmpresa=@IdEmpresa and IdNomina_Tipo=1 and IdNomina_TipoLiqui=4 and IdPeriodo= @IdPeriodo)=0)
insert into ro_periodo_x_ro_Nomina_TipoLiqui(
IdEmpresa,                        IdNomina_Tipo,                    IdNomina_TipoLiqui,                             IdPeriodo,                               Cerrado                    ,Procesado,                     Contabilizado
)
values
(@IdEmpresa,               1,                                       4,                                                @IdPeriodo,                              'N',                 'S',                           'N')





if((select  COUNT(IdPeriodo) from ro_rol where IdEmpresa=@IdEmpresa and IdRol=@IdRol and IdNominaTipo=1 and IdNominaTipoLiqui=4)>0)
update ro_rol set UsuarioModifica=@IdUsuario, FechaModifica=GETDATE() where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPeriodo and IdNominaTipo=1 and IdNominaTipoLiqui=3
else
insert into ro_rol
(IdEmpresa,   IdRol,       IdNominaTipo,        IdNominaTipoLiqui,         IdPeriodo,                  Descripcion,                      Observacion,                      Cerrado,                    FechaIngresa,
UsuarioIngresa,      FechaModifica,             UsuarioModifica,           FechaAnula,                 UsuarioAnula,                     MotivoAnula,                      UsuarioCierre,              FechaCierre,
IdCentroCosto)
values
(@IdEmpresa   , @IdRol      ,1                                ,4           ,@IdPeriodo                ,@observacion                     ,@observacion                     ,'N'                        ,GETDATE()
,@IdUsuario          ,null                      ,null                             ,null                       ,null                                    ,null                                    ,null                           ,null
,null)




delete ro_rol_detalle where IdEmpresa=@IdEmpresa and IdRol= @IdRol 

----------------------------------------------------------------------------------------------------------------------------------------------
-------------calculando decimo cuarto sueldo-------------------------------------------------------------------------------------------------<
----------------------------------------------------------------------------------------------------------------------------------------------

select @IdRubro_calculado= IdRubro_tot_pagar from ro_rubros_calculados where IdEmpresa=@IdEmpresa-- obteniendo el idrubro desde parametros
insert into ro_rol_detalle
(IdEmpresa,                       IdRol,               IdSucursal,                                     IdEmpleado,                IdRubro,                   Orden,               Valor
,rub_visible_reporte,      Observacion)


select


@IdEmpresa,                       @IdRol,                                         emp.IdSucursal,                                                              emp.IdEmpleado,             @IdRubro_calculado, '1',                 SUM(acum.Valor),
1,                                       'Pago decimo cuarto sueldo'

from ro_rol_detalle_x_rubro_acumulado acum, ro_empleado emp
where acum.IdEmpresa=emp.IdEmpresa
and acum.IdEmpleado=emp.IdEmpleado    
 and acum.Estado='PEN'
AND emp.em_status='EST_ACT'
AND acum.IdRubro='200'
group by emp.IdEmpleado , emp.IdSucursal              
 end


