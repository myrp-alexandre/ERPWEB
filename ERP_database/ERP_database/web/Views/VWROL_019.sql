CREATE VIEW [web].[VWROL_019]
	AS 
SELECT        rol_det.IdEmpresa, rol_det.IdNominaTipo, rol_det.IdNominaTipoLiqui, rol_det.IdPeriodo, rol_det.IdEmpleado, rol_det.IdRubro, rol_det.Orden, rol_det.Valor, rol_det.Observacion, per.pe_anio, per.pe_mes, 
                         div.Descripcion AS Division, dep.de_descripcion AS Departamento, carg.ca_descripcion AS Cargo, dbo.ro_rubro_tipo.ru_descripcion AS Rubro, dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina AS NominaTipo, 
                         dbo.ro_Nomina_Tipo.Descripcion AS Nomina, pers.pe_cedulaRuc AS Cedula, pers.pe_nombreCompleto AS Empleado, dbo.ro_rubro_tipo.ru_tipo, CAST(per.pe_FechaIni AS date) AS FechaIni, CAST(per.pe_FechaFin AS date) 
                         AS FechaFin, dbo.ro_rubro_tipo.ru_codRolGen
FROM            dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.ro_rol_detalle AS rol_det ON dbo.ro_empleado.IdEmpresa = rol_det.IdEmpresa AND dbo.ro_empleado.IdEmpleado = rol_det.IdEmpleado INNER JOIN
                         dbo.tb_persona AS pers ON dbo.ro_empleado.IdPersona = pers.IdPersona INNER JOIN
                         dbo.ro_cargo AS carg ON dbo.ro_empleado.IdEmpresa = carg.IdEmpresa AND dbo.ro_empleado.IdCargo = carg.IdCargo INNER JOIN
                         dbo.ro_Division AS div ON dbo.ro_empleado.IdEmpresa = div.IdEmpresa AND dbo.ro_empleado.IdDivision = div.IdDivision INNER JOIN
                         dbo.ro_Departamento AS dep ON dbo.ro_empleado.IdEmpresa = dep.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dep.IdDepartamento INNER JOIN
                         dbo.ro_area ON div.IdEmpresa = dbo.ro_area.IdEmpresa AND div.IdDivision = dbo.ro_area.IdDivision ON dbo.ro_rubro_tipo.IdEmpresa = rol_det.IdEmpresa AND dbo.ro_rubro_tipo.IdRubro = rol_det.IdRubro LEFT OUTER JOIN
                         dbo.ro_Nomina_Tipoliqui INNER JOIN
                         dbo.ro_rol AS rol INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS ro_per_x_nom ON rol.IdEmpresa = ro_per_x_nom.IdEmpresa AND rol.IdNominaTipo = ro_per_x_nom.IdNomina_Tipo AND 
                         rol.IdNominaTipoLiqui = ro_per_x_nom.IdNomina_TipoLiqui AND rol.IdPeriodo = ro_per_x_nom.IdPeriodo INNER JOIN
                         dbo.ro_periodo AS per ON ro_per_x_nom.IdEmpresa = per.IdEmpresa AND ro_per_x_nom.IdPeriodo = per.IdPeriodo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = rol.IdEmpresa AND 
                         dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = rol.IdNominaTipo AND dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui = rol.IdNominaTipoLiqui INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo ON rol_det.IdEmpresa = rol.IdEmpresa AND 
                         rol_det.IdNominaTipo = rol.IdNominaTipo AND rol_det.IdNominaTipoLiqui = rol.IdNominaTipoLiqui AND rol_det.IdPeriodo = rol.IdPeriodo

