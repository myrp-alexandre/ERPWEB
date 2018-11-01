
CREATE  PROCEDURE [dbo].[spROL_Rpt016]
@idempresa int,
@idnomina int,
@fecha_inicio date,
@fecha_fin date
AS
/*


declare 


@idempresa int,
@idnomina int,
@fecha_inicio date,
@fecha_fin date


set @idempresa= 1
set @idnomina =1
set @fecha_inicio ='01/07/2017'
set @fecha_fin ='31/07/2017'

*/
BEGIN
	
	SET NOCOUNT ON;
-- se extrae el total de sueldo
SELECT        dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdNominaTipo, dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rol_detalle.IdNominaTipoLiqui, dbo.ro_rol_detalle.IdPeriodo, dbo.ro_rol_detalle.IdRubro, 
                         dbo.ro_empleado.IdDepartamento, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, 
                         dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_rol_detalle.Valor, dbo.ro_Departamento.de_descripcion, dbo.ro_Nomina_Tipo.Descripcion AS Nomina, dbo.ro_cargo.ca_descripcion, dbo.ro_periodo.pe_mes, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo, dbo.ro_empleado.em_fechaSalida, dbo.ro_empleado.em_fechaIngaRol, ''Descripcion
FROM            dbo.Af_Activo_fijo INNER JOIN
                         Fj_servindustrias.ro_empleado_x_Activo_Fijo ON dbo.Af_Activo_fijo.IdEmpresa = Fj_servindustrias.ro_empleado_x_Activo_Fijo.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdActivoFijo = Fj_servindustrias.ro_empleado_x_Activo_Fijo.IdActivo_fijo INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON null = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         null = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                         dbo.Af_Activo_fijo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa RIGHT OUTER JOIN
                         dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_rol_detalle ON dbo.ro_rubro_tipo.IdRubro = dbo.ro_rol_detalle.IdRubro AND dbo.ro_rubro_tipo.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa INNER JOIN
                         dbo.ro_periodo ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_rol_detalle.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.ro_empleado ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento AND dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_rol_detalle.IdNominaTipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo AND dbo.ro_rol_detalle.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo ON Fj_servindustrias.ro_empleado_x_Activo_Fijo.IdEmpresa = dbo.ro_empleado.IdEmpresa AND 
                         Fj_servindustrias.ro_empleado_x_Activo_Fijo.IdEmpleado = dbo.ro_empleado.IdEmpleado
WHERE        (dbo.ro_rubro_tipo.rub_provision = 1)
						  AND dbo.ro_rol_detalle.Valor>0	
						 and ro_rol_detalle.IdEmpresa=@idempresa
						 and ro_rol_detalle.IdNominaTipo=@idnomina
						 And dbo.ro_periodo.pe_FechaIni between @fecha_inicio and @fecha_fin 


END
