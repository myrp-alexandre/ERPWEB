
CREATE PROCEDURE [web].[SPROL_023]
(
@IdEmpresa int,
@IdSucursalIni int,
@IdSucursalFin int,
@IdNomina int,
@IdNominaTipoLiqui int,
@IdPeriodo int,
@IdDivisionIni int,
@IdDivisionFin int,
@IdAreaIni int,
@IdAreaFin int,
@IdDepartamentoIni int,
@IdDepartamentoFin int
)
AS



SELECT IdEmpresa, IdRol,IdEmpleado,IdDivision,IdArea,IdDepartamento,IdSucursal,IdNominaTipo, Descripcion, IdNominaTipoLiqui,DescripcionProcesoNomina, IdPeriodo,pe_nombreCompleto,NombreDivision,NombreArea,NombreDepartamento,Su_Descripcion, SUM(SUELDO) SUELDO, SUM(ANTICIPO) ANTICIPO, SUM(DECIMOC) DECIMOC, SUM(DECIMOT) DECIMOT, SUM(FRESERVA)FRESERVA,SUM(IESS)IESS, SUM(PRESTAMO)PRESTAMO,SUM(SOBRET) SOBRET,
SUM(TOTALE)TOTALE, SUM(TOTALI)TOTALI,SUM(OTROEGR)OTROEGR, SUM(OTROING) OTROING, SUM(DIASTRABAJADOS) DIASTRABAJADOS, (SUM(TOTALI) - SUM(TOTALE)) NETO,NombreCargo, JORNADA
FROM (
SELECT ro_rol_detalle.IdEmpresa, ro_rol_detalle.IdRol, ro_rol_detalle.IdEmpleado, ro_empleado.IdDivision, ro_empleado.IdArea, ro_empleado.IdDepartamento, ro_rol.IdSucursal, ro_rol.IdNominaTipo,ro_Nomina_Tipo.Descripcion, ro_rol.IdNominaTipoLiqui, ro_Nomina_Tipoliqui.DescripcionProcesoNomina, tb_sucursal.Su_Descripcion,
ro_rol.IdPeriodo, tb_persona.pe_nombreCompleto, ro_Division.Descripcion AS NombreDivision, ro_area.Descripcion AS NombreArea, ro_Departamento.de_descripcion AS NombreDepartamento,
ro_cargo.ca_descripcion as NombreCargo,
				  ro_rubro_tipo.ru_tipo,ro_catalogo.ca_descripcion as NombreRubro,
				  CASE WHEN ro_catalogo.CodCatalogo = 'SUELDO' THEN VALOR ELSE 0 END AS SUELDO,
				  CASE WHEN ro_catalogo.CodCatalogo = 'ANTICIPO' THEN VALOR ELSE 0 END AS ANTICIPO,
				  CASE WHEN ro_catalogo.CodCatalogo = 'DECIMOC' THEN VALOR ELSE 0 END AS DECIMOC,
				  CASE WHEN ro_catalogo.CodCatalogo = 'DECIMOT' THEN VALOR ELSE 0 END AS DECIMOT,
				  CASE WHEN ro_catalogo.CodCatalogo = 'FRESERVA' THEN VALOR ELSE 0 END AS FRESERVA,
				  CASE WHEN ro_catalogo.CodCatalogo = 'IESS' THEN VALOR ELSE 0 END AS IESS,
				  CASE WHEN ro_catalogo.CodCatalogo = 'PRESTAMO' THEN VALOR ELSE 0 END AS PRESTAMO,
				  CASE WHEN ro_catalogo.CodCatalogo = 'SOBRET' THEN VALOR ELSE 0 END AS SOBRET,
				  CASE WHEN ro_rubro_tipo.ru_tipo = 'E' THEN VALOR ELSE 0 END AS TOTALE,
				  CASE WHEN ro_rubro_tipo.ru_tipo = 'I' THEN VALOR ELSE 0 END AS TOTALI,
				  CASE WHEN ro_rubro_tipo.ru_tipo = 'E' AND ro_rubro_tipo.rub_GrupoResumen is null THEN VALOR ELSE 0 END AS OTROEGR,
				  CASE WHEN ro_rubro_tipo.ru_tipo = 'I' AND ro_rubro_tipo.rub_GrupoResumen is null THEN VALOR ELSE 0 END AS OTROING,
				  CASE WHEN ro_rubro_tipo.IdRubro = ro_rubros_calculados.IdRubro_dias_trabajados then VALOR ELSE 0 END AS DIASTRABAJADOS,
				  CASE WHEN ro_rubro_tipo.IdRubro = ro_rubros_calculados.IdRubro_horas_matutina  then 'HORAS MATUTINA' WHEN ro_rubro_tipo.IdRubro = ro_rubros_calculados.IdRubro_horas_vespertina THEN'HORAS VESPERTINA'  ELSE 'GENERAL' END AS JORNADA
FROM            dbo.tb_persona INNER JOIN
                         dbo.ro_empleado ON dbo.tb_persona.IdPersona = dbo.ro_empleado.IdPersona INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento RIGHT OUTER JOIN
                         dbo.ro_rol INNER JOIN
                         dbo.ro_rol_detalle ON dbo.ro_rol.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND dbo.ro_rol.IdRol = dbo.ro_rol_detalle.IdRol INNER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa AND dbo.ro_rol_detalle.IdRubro = dbo.ro_rubro_tipo.IdRubro INNER JOIN
                         dbo.ro_rubros_calculados ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rubros_calculados.IdEmpresa ON dbo.ro_empleado.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND 
                         dbo.ro_empleado.IdEmpleado = dbo.ro_rol_detalle.IdEmpleado LEFT OUTER JOIN
                         dbo.ro_Nomina_Tipo INNER JOIN
                         dbo.ro_Nomina_Tipoliqui ON dbo.ro_Nomina_Tipo.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND dbo.ro_Nomina_Tipo.IdNomina_Tipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo ON 
                         dbo.ro_rol.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND dbo.ro_rol.IdNominaTipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo AND 
                         dbo.ro_rol.IdNominaTipoLiqui = dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui LEFT OUTER JOIN
                         dbo.ro_area INNER JOIN
                         dbo.ro_Division ON dbo.ro_area.IdEmpresa = dbo.ro_Division.IdEmpresa AND dbo.ro_area.IdDivision = dbo.ro_Division.IdDivision ON dbo.ro_empleado.IdEmpresa = dbo.ro_area.IdEmpresa AND 
                         dbo.ro_empleado.IdDivision = dbo.ro_area.IdDivision AND dbo.ro_empleado.IdArea = dbo.ro_area.IdArea LEFT OUTER JOIN
                         dbo.ro_catalogo ON dbo.ro_rubro_tipo.rub_GrupoResumen = dbo.ro_catalogo.CodCatalogo INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_sucursal.IdEmpresa = dbo.ro_rol.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.ro_rol.IdSucursal INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo
				  --METE EL WHERE AQUIIIIIIIIIIIIIIIIIIIIIIIIII :*

				  where ro_rol_detalle.IdEmpresa=@IdEmpresa
				  and ro_rol_detalle.IdSucursal>=@IdSucursalIni
				  and ro_rol_detalle.IdSucursal<=@IdSucursalFin

				  and ro_rol.IdNominaTipo=@IdNomina
				  and ro_rol.IdNominaTipoLiqui=@IdNominaTipoLiqui
				  and ro_rol.IdPeriodo=@IdPeriodo

				  
				  and ro_empleado.IdDivision>=@IdDivisionIni
				  and ro_empleado.IdDivision<=@IdDivisionFin

				  and ro_empleado.IdArea>=@IdAreaIni
				  and ro_empleado.IdArea<=@IdAreaFin

				  and ro_empleado.IdDepartamento>=@IdDepartamentoIni
				  and ro_empleado.IdDepartamento<=@IdDepartamentoFin

				  ) A
				  GROUP BY IdEmpresa, IdRol,IdEmpleado,IdDivision,IdArea,Descripcion,DescripcionProcesoNomina,IdDepartamento,IdSucursal,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,pe_nombreCompleto,NombreDivision,NombreArea,NombreDepartamento,Su_Descripcion,NombreCargo, JORNADA