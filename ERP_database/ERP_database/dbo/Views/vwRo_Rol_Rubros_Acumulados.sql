CREATE VIEW dbo.vwRo_Rol_Rubros_Acumulados
AS
SELECT        dbo.ro_empleado.IdEmpresa, dbo.ro_empleado.IdEmpleado, dbo.tb_persona.pe_nombreCompleto AS NombreCompleto, 
                         dbo.tb_persona.pe_cedulaRuc AS CedulaRuc, dbo.ro_rubro_tipo.IdRubro, dbo.ro_rubro_tipo.ru_descripcion AS RubroDescripcion, 
                         dbo.ro_rol_detalle_x_rubro_acumulado.Valor, dbo.ro_rol_detalle_x_rubro_acumulado.Estado AS EstadoAcumulado, 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Cerrado, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Procesado, 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Contabilizado, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui
FROM            dbo.ro_rol_detalle_x_rubro_acumulado INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui ON dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpresa = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa AND 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdNominaTipo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo AND 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdNominaTipoLiqui = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui AND 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdPeriodo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo INNER JOIN
                         dbo.ro_empleado ON dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpresa = dbo.ro_empleado.IdEmpresa AND 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_periodo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_periodo.IdPeriodo AND 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_periodo.IdEmpresa INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_rol_detalle_x_rubro_acumulado.IdRubro = dbo.ro_rubro_tipo.IdRubro AND 
                         dbo.ro_rol_detalle_x_rubro_acumulado.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa