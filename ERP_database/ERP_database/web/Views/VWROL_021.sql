CREATE view [web].[VWROL_021]
as
SELECT rol.IdSucursal, rol.IdNominaTipo, rol.IdNominaTipoLiqui, rol.IdPeriodo, rol_det.IdRubro, rol_det.Orden, rol_det.Valor, rol_det.rub_visible_reporte, rol_det.Observacion, rubr.ru_descripcion, perid.pe_FechaIni, perid.pe_FechaFin, rubr.ru_tipo, 
                  rubr.rub_codigo, rubr.ru_codRolGen, case when cat.IdCatalogo is null then '3 - TOTALES' WHEN CAT.IdCatalogo = 1 THEN '1 - INGRESOS' ELSE '2 - EGRESOS' END AS ca_descripcion, dbo.ro_empleado.em_codigo, rol_det.IdEmpleado, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_nombreCompleto, dbo.ro_empleado.IdArea, dbo.ro_empleado.IdDivision, 
                  rol_det.IdRol, rol_det.IdEmpresa, dbo.ro_area.Descripcion
FROM     dbo.ro_area INNER JOIN
                  dbo.ro_empleado INNER JOIN
                  dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona ON dbo.ro_area.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_area.IdArea = dbo.ro_empleado.IdArea RIGHT OUTER JOIN
                  dbo.ro_rol AS rol INNER JOIN
                  dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON rol.IdEmpresa = pe_x_nom.IdEmpresa AND rol.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND rol.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND 
                  rol.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                  dbo.ro_periodo AS perid ON pe_x_nom.IdEmpresa = perid.IdEmpresa AND pe_x_nom.IdPeriodo = perid.IdPeriodo INNER JOIN
                  dbo.ro_rubro_tipo AS rubr INNER JOIN
                  dbo.ro_rol_detalle AS rol_det ON rubr.IdEmpresa = rol_det.IdEmpresa AND rubr.IdRubro = rol_det.IdRubro ON rol.IdEmpresa = rol_det.IdEmpresa AND rol.IdRol = rol_det.IdRol ON dbo.ro_empleado.IdEmpresa = rol_det.IdEmpresa AND 
                  dbo.ro_empleado.IdEmpleado = rol_det.IdEmpleado LEFT OUTER JOIN
                  dbo.ro_catalogo AS cat ON rubr.rub_grupo = cat.CodCatalogo