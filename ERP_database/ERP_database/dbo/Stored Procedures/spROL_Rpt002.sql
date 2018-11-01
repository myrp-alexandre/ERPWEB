

CREATE PROCEDURE [dbo].[spROL_Rpt002]  
(
@IdEmpresa int,
@IdNomina_Tipo int,
@IdNomina_TipoLiqui int,
@IdPeriodo Int


)
as

begin

SELECT        dbo.ro_rol.IdEmpresa, dbo.ro_rol.IdNominaTipo, dbo.ro_rol.IdNominaTipoLiqui, dbo.ro_rol.Descripcion, dbo.ro_rol.Observacion, dbo.ro_rol.Cerrado, dbo.ro_Departamento.de_descripcion, dbo.ro_rol_detalle.IdEmpleado, 
                         dbo.ro_rol_detalle.IdRubro, dbo.ro_rol_detalle.Orden, dbo.ro_rol_detalle.rub_visible_reporte, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, dbo.ro_empleado.em_codigo, 
                         dbo.ro_Departamento.IdDepartamento, dbo.ro_area.IdArea, dbo.ro_Division.IdDivision, dbo.ct_centro_costo.IdCentroCosto, dbo.ro_area.Descripcion AS Area, dbo.ro_Division.Descripcion AS Division, 
                         dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, dbo.ro_periodo.pe_estado, dbo.ro_Nomina_Tipo.Descripcion AS Nomina, dbo.ro_rol.IdPeriodo, dbo.ro_rubro_tipo.ru_codRolGen, dbo.tb_persona.pe_apellido, 
                         dbo.tb_empresa.codigo, dbo.tb_empresa.em_nombre, dbo.tb_empresa.RazonSocial, dbo.tb_empresa.NombreComercial, dbo.tb_empresa.ContribuyenteEspecial, dbo.ro_rubro_tipo.ru_descripcion, 
                         dbo.ro_rubro_tipo.NombreCorto, dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina, dbo.ro_rol_detalle.Valor, dbo.ct_centro_costo.Centro_costo, dbo.ct_centro_costo.CodCentroCosto, dbo.tb_sucursal.Su_Descripcion, 
                         dbo.ro_empleado.em_fechaIngaRol
FROM            dbo.ro_area INNER JOIN
                         dbo.ro_periodo INNER JOIN
                         dbo.ro_rol INNER JOIN
                         dbo.ro_rol_detalle ON dbo.ro_rol.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND dbo.ro_rol.IdNominaTipo = dbo.ro_rol_detalle.IdNominaTipo AND dbo.ro_rol.IdNominaTipoLiqui = dbo.ro_rol_detalle.IdNominaTipoLiqui AND 
                         dbo.ro_rol.IdPeriodo = dbo.ro_rol_detalle.IdPeriodo INNER JOIN
                         dbo.ro_empleado ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento ON 
                         dbo.ro_periodo.IdEmpresa = dbo.ro_rol.IdEmpresa AND dbo.ro_periodo.IdPeriodo = dbo.ro_rol.IdPeriodo INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_rol.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_rol_detalle.IdNominaTipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo AND 
                         dbo.ro_rol.IdNominaTipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_rol_detalle.IdRubro = dbo.ro_rubro_tipo.IdRubro AND dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa INNER JOIN
                         dbo.tb_empresa ON dbo.ro_Departamento.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ro_Nomina_Tipoliqui ON dbo.ro_rol.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND dbo.ro_rol.IdNominaTipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo AND 
                         dbo.ro_rol.IdNominaTipoLiqui = dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui AND dbo.ro_Nomina_Tipo.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND 
                         dbo.ro_Nomina_Tipo.IdNomina_Tipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo INNER JOIN
                         dbo.tb_sucursal ON dbo.ro_empleado.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.ro_empleado.IdSucursal = dbo.tb_sucursal.IdSucursal AND dbo.tb_empresa.IdEmpresa = dbo.tb_sucursal.IdEmpresa INNER JOIN
                         dbo.ro_Division ON dbo.ro_empleado.IdEmpresa = dbo.ro_Division.IdEmpresa AND dbo.ro_empleado.IdDivision = dbo.ro_Division.IdDivision ON dbo.ro_area.IdArea = dbo.ro_empleado.IdArea AND 
                         dbo.ro_area.IdEmpresa = dbo.ro_empleado.IdEmpresa INNER JOIN
                         dbo.vwro_rol_detalle_agrupado_x_proceso ON dbo.ro_rol_detalle.IdEmpresa = dbo.vwro_rol_detalle_agrupado_x_proceso.IdEmpresa AND 
                         dbo.ro_rol_detalle.IdNominaTipo = dbo.vwro_rol_detalle_agrupado_x_proceso.IdNominaTipo AND dbo.ro_rol_detalle.IdNominaTipoLiqui = dbo.vwro_rol_detalle_agrupado_x_proceso.IdNominaTipoLiqui AND 
                         dbo.ro_rol_detalle.IdPeriodo = dbo.vwro_rol_detalle_agrupado_x_proceso.IdPeriodo AND dbo.ro_rol_detalle.IdEmpleado = dbo.vwro_rol_detalle_agrupado_x_proceso.IdEmpleado LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ro_empleado.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND dbo.ro_empleado.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto

						 where vwro_rol_detalle_agrupado_x_proceso.IdEmpresa=@IdEmpresa
						 and vwro_rol_detalle_agrupado_x_proceso.IdNominaTipo=@IdNomina_Tipo
						  and vwro_rol_detalle_agrupado_x_proceso.IdNominaTipoLiqui=@IdNomina_TipoLiqui
						   and vwro_rol_detalle_agrupado_x_proceso.IdPeriodo=@IdPeriodo

 END