
create  PROCEDURE [web].[SPROL_013]
@idempresa int,
@idnomina int,
@fecha_inicio date,
@fecha_fin date
AS



--declare 


--@idempresa int,
--@idnomina int,
--@fecha_inicio date,
--@fecha_fin date


--set @idempresa= 1
--set @idnomina =1
--set @fecha_inicio ='2017-01-01'
--set @fecha_fin ='2018-12-31'


BEGIN
	
	
SELECT        dbo.ro_empleado.IdDepartamento,ro_empleado.IdEmpleado, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, 
                         dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_Departamento.de_descripcion, dbo.ro_Nomina_Tipo.Descripcion AS Nomina, dbo.ro_cargo.ca_descripcion, dbo.ro_periodo.pe_mes, dbo.ro_empleado.em_fechaSalida, 
                         dbo.ro_empleado.em_fechaIngaRol, '' AS Descripcion,ro_rol_detalle_x_rubro_acumulado.Valor
FROM            dbo.tb_persona INNER JOIN
                         dbo.ro_empleado ON dbo.tb_persona.IdPersona = dbo.ro_empleado.IdPersona INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento AND dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo INNER JOIN
                         dbo.ro_rol_detalle_x_rubro_acumulado INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui INNER JOIN
                         dbo.ro_periodo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_periodo.IdPeriodo ON 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpresa = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa AND dbo.ro_rol_detalle_x_rubro_acumulado.IdNominaTipo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo AND
                          dbo.ro_rol_detalle_x_rubro_acumulado.IdNominaTipoLiqui = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui AND 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdPeriodo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa AND dbo.ro_rol_detalle_x_rubro_acumulado.IdRubro = dbo.ro_rubro_tipo.IdRubro INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo ON 
                         dbo.ro_empleado.IdEmpresa = dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpleado

WHERE        (dbo.ro_rubro_tipo.rub_provision = 1)
						  AND dbo.ro_rol_detalle_x_rubro_acumulado.Valor>0	
						 and ro_rol_detalle_x_rubro_acumulado.IdEmpresa=@idempresa
						 and ro_rol_detalle_x_rubro_acumulado.IdNominaTipo=@idnomina
						 And dbo.ro_periodo.pe_FechaIni between @fecha_inicio and @fecha_fin 


END