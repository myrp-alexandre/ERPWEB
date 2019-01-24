
CREATE VIEW [web].[VWROL_022]
AS
SELECT        dbo.tb_persona.pe_nombreCompleto AS NombreCompleto, dbo.tb_persona.pe_cedulaRuc AS Ruc, web.ro_SPROL_022.ru_descripcion AS RubroDescripcion, web.ro_SPROL_022.IdEmpresa, web.ro_SPROL_022.IdNominaTipo, 
                         web.ro_SPROL_022.IdNominaTipoLiqui, web.ro_SPROL_022.IdPeriodo, web.ro_SPROL_022.IdEmpleado, web.ro_SPROL_022.Valor, dbo.ro_cargo.ca_descripcion AS Cargo, dbo.tb_persona.pe_apellido, 
                         dbo.tb_persona.pe_nombre, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, dbo.ro_rubro_tipo.ru_tipo, dbo.ro_empleado.em_status, dbo.ro_rubro_tipo.ru_orden, dbo.tb_empresa.em_ruc, 
                         dbo.ro_empleado.IdSucursal, dbo.ro_catalogo.ca_descripcion AS Grupo, ISNULL( dbo.ro_empleado.em_codigo, ro_empleado.IdEmpleado)em_codigo, dbo.ro_Departamento.de_descripcion, dbo.ro_area.Descripcion AS Area, dbo.ro_empleado.IdArea, ro_empleado.Pago_por_horas,ro_SPROL_022.IdRubro,
						 ro_rubro_tipo. ru_descripcion as Rubro
FROM            dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         web.ro_SPROL_022 ON dbo.ro_empleado.IdEmpresa = web.ro_SPROL_022.IdEmpresa AND dbo.ro_empleado.IdEmpleado = web.ro_SPROL_022.IdEmpleado ON dbo.ro_rubro_tipo.IdRubro = web.ro_SPROL_022.IdRubro AND 
                         dbo.ro_rubro_tipo.IdEmpresa = web.ro_SPROL_022.IdEmpresa INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo AND dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa INNER JOIN
                         dbo.ro_periodo ON web.ro_SPROL_022.IdEmpresa = dbo.ro_periodo.IdEmpresa AND web.ro_SPROL_022.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.tb_empresa ON dbo.ro_empleado.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ro_catalogo ON dbo.ro_rubro_tipo.rub_grupo = dbo.ro_catalogo.CodCatalogo INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento AND 
                         dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento AND dbo.tb_empresa.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND 
                         dbo.tb_empresa.IdEmpresa = dbo.ro_Departamento.IdEmpresa INNER JOIN
                         dbo.ro_area ON dbo.ro_rubro_tipo.IdEmpresa = dbo.ro_area.IdEmpresa AND dbo.ro_empleado.IdArea = dbo.ro_area.IdArea