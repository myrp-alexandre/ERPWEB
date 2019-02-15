CREATE VIEW [web].[VWROL_024]
AS
SELECT dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdRol, dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rol.IdNominaTipoLiqui, dbo.ro_rol.IdNominaTipo, dbo.ro_Nomina_Tipo.Descripcion AS NomNomina, 
                  dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina AS NomNominaTipo, dbo.tb_persona.pe_nombreCompleto, dbo.ro_rol.IdPeriodo, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, SUM(dbo.ro_rol_detalle.Valor) Valor, 
                  dbo.ro_rol_detalle.IdSucursal, dbo.tb_sucursal.Su_Descripcion, dbo.tb_persona.pe_cedulaRuc, ISNULL(D.Valor, 0) AS Dias
FROM     dbo.ro_rol INNER JOIN
                  dbo.ro_rol_detalle ON dbo.ro_rol.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND dbo.ro_rol.IdRol = dbo.ro_rol_detalle.IdRol INNER JOIN
                  dbo.ro_Nomina_Tipoliqui ON dbo.ro_rol.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND dbo.ro_rol.IdNominaTipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo AND 
                  dbo.ro_rol.IdNominaTipoLiqui = dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui INNER JOIN
                  dbo.ro_Nomina_Tipo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo INNER JOIN
                  dbo.ro_empleado ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                  dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                  dbo.ro_periodo ON dbo.ro_rol.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_rol.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                  dbo.tb_sucursal ON dbo.ro_rol_detalle.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.ro_rol_detalle.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                  dbo.ro_rubro_tipo ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa AND dbo.ro_rol_detalle.IdRubro = dbo.ro_rubro_tipo.IdRubro LEFT OUTER JOIN
                      (SELECT ro_rol_detalle_1.IdEmpresa, ro_rol_detalle_1.IdRol, ro_rol_detalle_1.IdEmpleado, ro_rol_detalle_1.Valor
                       FROM      dbo.ro_rol_detalle AS ro_rol_detalle_1 INNER JOIN
                                         dbo.ro_rubros_calculados AS ro_rubros_calculados_1 ON ro_rol_detalle_1.IdEmpresa = ro_rubros_calculados_1.IdEmpresa AND ro_rol_detalle_1.IdRubro = ro_rubros_calculados_1.IdRubro_dias_trabajados INNER JOIN
                                         dbo.ro_rol AS ro_rol_1 ON ro_rol_detalle_1.IdEmpresa = ro_rol_1.IdEmpresa AND ro_rol_detalle_1.IdRol = ro_rol_1.IdRol) AS D ON D.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND 
                  D.IdEmpleado = dbo.ro_rol_detalle.IdEmpleado AND D.IdRol = dbo.ro_rol_detalle.IdRol
				  where ro_rubro_tipo.ru_tipo = 'I' AND ISNULL(ro_rubro_tipo.rub_grupo,'INGRESOS') = 'INGRESOS'
GROUP BY dbo.ro_rol_detalle.IdEmpresa, dbo.ro_rol_detalle.IdRol, dbo.ro_rol_detalle.IdEmpleado, dbo.ro_rol.IdNominaTipoLiqui, dbo.ro_rol.IdNominaTipo, dbo.ro_Nomina_Tipo.Descripcion, 
                  dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina, dbo.tb_persona.pe_nombreCompleto, dbo.ro_rol.IdPeriodo, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, 
                  dbo.ro_rol_detalle.IdSucursal, dbo.tb_sucursal.Su_Descripcion, dbo.tb_persona.pe_cedulaRuc, D.Valor