
CREATE PROCEDURE spROLES_Rpt002 
	@IdEmpresa int,
	@IdNomina int,
	@IdPeriodo int,
	@Anio int,
	@Mes int

AS
BEGIN
	
--CREATE view  [Fj_servindustrias].[vwROL_Rpt002] as
SELECT        dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdNominaTipo, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_apellido + ' ' + dbo.tb_persona.pe_nombre AS Nombres, dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_cargo.ca_descripcion, Fj_servindustrias.ro_zona.zo_descripcion, 
                         Fj_servindustrias.ro_fuerza.fu_descripcion, dbo.ro_rubro_tipo.ru_orden, SUM(dbo.ro_rol_detalle.Valor) AS Expr1, dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rubro_tipo.ru_tipo,
						( select Valor from ro_rol_detalle D 
where 
D.IdEmpresa=ro_rol_detalle.IdEmpresa 
and D.IdEmpleado=ro_rol_detalle.IdEmpleado
and D.IdNominaTipo=ro_rol_detalle.IdNominaTipo
and  D.IdNominaTipoLiqui=2
and IdRubro=2
and IdPeriodo=@IdPeriodo) DiasTrabajados
FROM            dbo.ro_periodo_x_ro_Nomina_TipoLiqui INNER JOIN
                         dbo.ro_periodo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.ro_rol_detalle INNER JOIN
                         dbo.ro_empleado ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado ON 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo = dbo.ro_rol_detalle.IdNominaTipo AND 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui = dbo.ro_rol_detalle.IdNominaTipoLiqui AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_rol_detalle.IdPeriodo INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa AND dbo.ro_rol_detalle.IdRubro = dbo.ro_rubro_tipo.IdRubro INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo INNER JOIN
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det ON dbo.ro_empleado.IdEmpresa = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpleado AND 
                         dbo.ro_empleado.IdEmpresa = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpleado AND 
                         dbo.ro_empleado.IdEmpresa = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpleado INNER JOIN
                         Fj_servindustrias.ro_fuerza ON Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza INNER JOIN
                         Fj_servindustrias.ro_zona ON Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND 
                         dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona
WHERE        (dbo.ro_rubro_tipo.ru_tipo IN ('I', 'E'))
and  ro_rubro_tipo.IdRubro  not in ('1018','201','277','1019','1047','294')
and ro_rol_detalle.IdEmpresa=@IdEmpresa
and ro_rol_detalle.IdNominaTipo=@IdNomina
and pe_anio=@Anio
and pe_mes=@Mes
and ro_rol_detalle.IdEmpresa=@IdEmpresa

--and ro_rol_detalle.IdEmpresa=2
--and pe_anio=2017
--and pe_mes=6
--and ro_rol_detalle.IdEmpleado=1
--and Valor>0



GROUP BY dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdNominaTipo, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido + ' ' + dbo.tb_persona.pe_nombre, 
                         dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_cargo.ca_descripcion, Fj_servindustrias.ro_zona.zo_descripcion, Fj_servindustrias.ro_fuerza.fu_descripcion, dbo.ro_rubro_tipo.ru_orden, 
                         dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rubro_tipo.ru_tipo

union

SELECT        dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdNominaTipo, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_apellido + ' ' + dbo.tb_persona.pe_nombre AS Nombres,'OTROS DESCUENTOS' as ru_descripcion, dbo.ro_cargo.ca_descripcion, Fj_servindustrias.ro_zona.zo_descripcion, 
                         Fj_servindustrias.ro_fuerza.fu_descripcion, '1000' as ru_orden, SUM(dbo.ro_rol_detalle.Valor) AS Expr1, dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rubro_tipo.ru_tipo,
												( select Valor from ro_rol_detalle D 
where 
D.IdEmpresa=ro_rol_detalle.IdEmpresa 
and D.IdEmpleado=ro_rol_detalle.IdEmpleado
and D.IdNominaTipo=ro_rol_detalle.IdNominaTipo
and  D.IdNominaTipoLiqui=2
and IdRubro=2
and IdPeriodo=@IdPeriodo) DiasTrabajados
FROM            dbo.ro_periodo_x_ro_Nomina_TipoLiqui INNER JOIN
                         dbo.ro_periodo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.ro_rol_detalle INNER JOIN
                         dbo.ro_empleado ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado ON 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo = dbo.ro_rol_detalle.IdNominaTipo AND 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui = dbo.ro_rol_detalle.IdNominaTipoLiqui AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_rol_detalle.IdPeriodo INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa AND dbo.ro_rol_detalle.IdRubro = dbo.ro_rubro_tipo.IdRubro INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo INNER JOIN
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det ON dbo.ro_empleado.IdEmpresa = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpleado AND 
                         dbo.ro_empleado.IdEmpresa = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpleado AND 
                         dbo.ro_empleado.IdEmpresa = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpleado INNER JOIN
                         Fj_servindustrias.ro_fuerza ON Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_fuerza.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdFuerza = Fj_servindustrias.ro_fuerza.IdFuerza INNER JOIN
                         Fj_servindustrias.ro_zona ON Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdEmpresa = Fj_servindustrias.ro_zona.IdEmpresa AND 
                         Fj_servindustrias.ro_planificacion_x_ruta_x_empleado_det.IdZona = Fj_servindustrias.ro_zona.IdZona INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND 
                         dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona
WHERE        dbo.ro_rubro_tipo.ru_tipo = 'E'
and ro_rubro_tipo.IdRubro not in ('1018','201','277','1019')
and ro_rol_detalle.IdEmpresa=@IdEmpresa
and ro_rol_detalle.IdNominaTipo=@IdNomina
and pe_anio=@Anio
and pe_mes=@Mes
and ro_rol_detalle.IdEmpresa=@IdEmpresa
--and ro_rol_detalle.IdEmpresa=2
--and pe_anio=2017
--and pe_mes=6
--and ro_rol_detalle.IdEmpleado=1
--and Valor>0
GROUP BY dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdNominaTipo, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido + ' ' + dbo.tb_persona.pe_nombre, 
                          dbo.ro_cargo.ca_descripcion, Fj_servindustrias.ro_zona.zo_descripcion, Fj_servindustrias.ro_fuerza.fu_descripcion, 
                         dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rubro_tipo.ru_tipo

						 order by ru_orden asc

					--	 select * from ro_rubro_tipo 

					--select * from ro_rol_detalle where IdEmpresa=2 and IdPeriodo=201706 and Valor=0.39
END