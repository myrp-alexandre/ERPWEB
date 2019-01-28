
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

SELECT IdEmpresa, IdRol,IdEmpleado,IdDivision,IdArea,IdDepartamento,IdSucursal,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,pe_nombreCompleto,NombreDivision,NombreArea,NombreDepartamento,Su_Descripcion, SUM(SUELDO) SUELDO, SUM(ANTICIPO) ANTICIPO, SUM(DECIMOC) DECIMOC, SUM(DECIMOT) DECIMOT, SUM(FRESERVA)FRESERVA,SUM(IESS)IESS, SUM(PRESTAMO)PRESTAMO,SUM(SOBRET) SOBRET,
SUM(TOTALE)TOTALE, SUM(TOTALI)TOTALI,SUM(OTROEGR)OTROEGR, SUM(OTROING) OTROING, SUM(DIASTRABAJADOS) DIASTRABAJADOS, ROUND(SUM(TOTALI) - SUM(TOTALE),2) NETO
FROM (
SELECT ro_rol_detalle.IdEmpresa, ro_rol_detalle.IdRol, ro_rol_detalle.IdEmpleado, ro_empleado.IdDivision, ro_empleado.IdArea, ro_empleado.IdDepartamento, ro_rol.IdSucursal, ro_rol.IdNominaTipo, ro_rol.IdNominaTipoLiqui, tb_sucursal.Su_Descripcion,
ro_rol.IdPeriodo, tb_persona.pe_nombreCompleto, ro_Division.Descripcion AS NombreDivision, ro_area.Descripcion AS NombreArea, ro_Departamento.de_descripcion AS NombreDepartamento,
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
				  CASE WHEN ro_rubro_tipo.IdRubro = ro_rubros_calculados.IdRubro_dias_trabajados then VALOR ELSE 0 END AS DIASTRABAJADOS
FROM     tb_persona INNER JOIN
                  ro_empleado ON tb_persona.IdPersona = ro_empleado.IdPersona INNER JOIN
                  ro_Departamento ON ro_empleado.IdEmpresa = ro_Departamento.IdEmpresa AND ro_empleado.IdDepartamento = ro_Departamento.IdDepartamento RIGHT OUTER JOIN
                  ro_rol INNER JOIN
                  ro_rol_detalle ON ro_rol.IdEmpresa = ro_rol_detalle.IdEmpresa AND ro_rol.IdRol = ro_rol_detalle.IdRol INNER JOIN
                  ro_rubro_tipo ON ro_rol_detalle.IdEmpresa = ro_rubro_tipo.IdEmpresa AND ro_rol_detalle.IdRubro = ro_rubro_tipo.IdRubro INNER JOIN
                  ro_rubros_calculados ON ro_rol_detalle.IdEmpresa = ro_rubros_calculados.IdEmpresa ON ro_empleado.IdEmpresa = ro_rol_detalle.IdEmpresa AND ro_empleado.IdEmpleado = ro_rol_detalle.IdEmpleado LEFT OUTER JOIN
                  ro_Nomina_Tipo INNER JOIN
                  ro_Nomina_Tipoliqui ON ro_Nomina_Tipo.IdEmpresa = ro_Nomina_Tipoliqui.IdEmpresa AND ro_Nomina_Tipo.IdNomina_Tipo = ro_Nomina_Tipoliqui.IdNomina_Tipo ON ro_rol.IdEmpresa = ro_Nomina_Tipoliqui.IdEmpresa AND 
                  ro_rol.IdNominaTipo = ro_Nomina_Tipoliqui.IdNomina_Tipo AND ro_rol.IdNominaTipoLiqui = ro_Nomina_Tipoliqui.IdNomina_TipoLiqui LEFT OUTER JOIN
                  ro_area INNER JOIN
                  ro_Division ON ro_area.IdEmpresa = ro_Division.IdEmpresa AND ro_area.IdDivision = ro_Division.IdDivision ON ro_empleado.IdEmpresa = ro_area.IdEmpresa AND ro_empleado.IdDivision = ro_area.IdDivision AND 
                  ro_empleado.IdArea = ro_area.IdArea LEFT OUTER JOIN
                  ro_catalogo ON ro_rubro_tipo.rub_GrupoResumen = ro_catalogo.CodCatalogo inner join tb_sucursal on tb_sucursal.IdEmpresa = ro_rol.IdEmpresa
				  and tb_sucursal.IdSucursal = ro_rol.IdSucursal
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

				  ) A
				  GROUP BY IdEmpresa, IdRol,IdEmpleado,IdDivision,IdArea,IdDepartamento,IdSucursal,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,pe_nombreCompleto,NombreDivision,NombreArea,NombreDepartamento,Su_Descripcion