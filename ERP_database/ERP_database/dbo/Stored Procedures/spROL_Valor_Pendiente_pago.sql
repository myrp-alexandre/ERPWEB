
CREATE PROCEDURE  [dbo].[spROL_Valor_Pendiente_pago]
@IdEmpresa int,
@IdNomina int,
@IdNominaTipoLiq int,
@IdPeriodo int
AS
/*

declare 
@IdEmpresa int,
@IdNomina int,
@IdNominaTipoLiq int,
@IdPeriodo int


set @IdEmpresa =1
set @IdNomina =1
set @IdNominaTipoLiq =2
set @IdPeriodo =201704

*/
BEGIN

SELECT        dbo.ro_empleado.IdEmpleado, dbo.tb_persona.pe_cedulaRuc AS CedulaRuc, dbo.tb_persona.pe_nombreCompleto AS NombreCompleto, dbo.ro_rol_detalle.IdRubro, 
                         dbo.ro_rubro_tipo.ru_codRolGen AS Tag, dbo.ro_rubro_tipo.ru_descripcion AS DescRubroLargo, dbo.ro_rubro_tipo.NombreCorto AS DescNombreRubroCorto, 
                         dbo.ro_rol_detalle.Orden, dbo.ro_rol_detalle.Valor, dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina AS NominaLiqui, 
                         dbo.ro_Nomina_Tipo.Descripcion AS Nomina, dbo.tb_empresa.em_nombre AS Empresa, dbo.tb_empresa.IdEmpresa, 
                         dbo.ro_Departamento.de_descripcion AS Departamento, dbo.ro_rol.IdNominaTipo, dbo.ro_rol.IdNominaTipoLiqui, dbo.ro_rol.FechaIngresa, 
                         dbo.ro_rol_detalle.rub_visible_reporte, dbo.ro_rol_detalle.Observacion, dbo.ro_rol_detalle.TipoMovimiento, dbo.ro_rol.Cerrado AS EstadoRol, 
                         dbo.ro_rol.IdCentroCosto, dbo.ro_periodo.IdPeriodo, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, dbo.ro_periodo.pe_FechaIni AS FechaIni, 
                         dbo.ro_periodo.pe_FechaFin AS FechaFin, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Cerrado, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Procesado, 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Contabilizado, dbo.ro_empleado.em_tipoCta AS TipoCuenta, dbo.ro_empleado.em_NumCta AS NumCuenta, 
                         dbo.ro_empleado.IdBanco, dbo.tb_persona.IdTipoDocumento AS TipoIdentificacion, dbo.ro_empleado.IdDivision, 
                         dbo.ro_Division.Descripcion AS DivisionDescripcion, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_banco.CodigoLegal, 
                         dbo.ro_Departamento.IdDepartamento, dbo.tb_banco.ba_descripcion ,
						 dbo.ro_empleado.em_status,
						isnull( (select  sum( ISNULL( P.Valor,0)) from vwro_archivos_bancos_generacion_x_empleado as P where 
						 P.IdEmpresa= dbo.ro_rol_detalle.IdEmpresa
						 and  P.IdNomina= dbo.ro_rol_detalle.IdNominaTipo 
						 and P.IdNominaTipo=dbo.ro_rol_detalle.IdNominaTipoLiqui
						 and P.IdPeriodo=dbo.ro_rol_detalle.IdPeriodo
						 and P.IdEmpleado=dbo.ro_rol_detalle.IdEmpleado

						 group by

						  IdEmpresa,
						  IdNomina ,
						  IdNominaTipo,
						  IdPeriodo,
						  IdEmpleado
						 ),0) ValorCancelado,


						ISNULL(  dbo.ro_rol_detalle.Valor- (select  sum( ISNULL( P.Valor,0)) from vwro_archivos_bancos_generacion_x_empleado as P where 
						 P.IdEmpresa= dbo.ro_rol_detalle.IdEmpresa
						 and  P.IdNomina= dbo.ro_rol_detalle.IdNominaTipo 
						 and P.IdNominaTipo=dbo.ro_rol_detalle.IdNominaTipoLiqui
						 and P.IdPeriodo=dbo.ro_rol_detalle.IdPeriodo
						 and P.IdEmpleado=dbo.ro_rol_detalle.IdEmpleado

						 group by

						  IdEmpresa,
						  IdNomina ,
						  IdNominaTipo,
						  IdPeriodo,
						  IdEmpleado
						 ),dbo.ro_rol_detalle.Valor) PendientePago


						 
FROM            dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_rol_detalle INNER JOIN
                         dbo.ro_Nomina_Tipoliqui INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND 
                         dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo INNER JOIN
                         dbo.ro_rol ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_rol.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_rol.IdNominaTipo AND 
                         dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui = dbo.ro_rol.IdNominaTipoLiqui ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rol.IdEmpresa AND 
                         dbo.ro_rol_detalle.IdNominaTipo = dbo.ro_rol.IdNominaTipo AND dbo.ro_rol_detalle.IdNominaTipoLiqui = dbo.ro_rol.IdNominaTipoLiqui AND 
                         dbo.ro_rol_detalle.IdPeriodo = dbo.ro_rol.IdPeriodo INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona ON dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa ON dbo.ro_rubro_tipo.IdRubro = dbo.ro_rol_detalle.IdRubro INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND 
                         dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui ON dbo.ro_rol.IdEmpresa = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa AND 
                         dbo.ro_rol.IdNominaTipo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo AND 
                         dbo.ro_rol.IdNominaTipoLiqui = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui AND 
                         dbo.ro_rol.IdPeriodo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo INNER JOIN
                         dbo.ro_periodo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_periodo.IdPeriodo AND 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_periodo.IdEmpresa INNER JOIN
                         dbo.tb_empresa ON dbo.ro_Departamento.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ro_Division ON dbo.ro_empleado.IdEmpresa = dbo.ro_Division.IdEmpresa AND dbo.ro_empleado.IdDivision = dbo.ro_Division.IdDivision INNER JOIN
                         dbo.tb_banco ON dbo.ro_empleado.IdBanco = dbo.tb_banco.IdBanco
						 and ro_rubro_tipo.IdEmpresa=dbo.ro_rol_detalle.IdEmpresa
						 -- and dbo.ro_rol_detalle.IdRubro = '950'
WHERE        (dbo.ro_rol_detalle.IdRubro = '950')
and dbo.ro_rol_detalle.IdEmpresa=@IdEmpresa
and dbo.ro_rol_detalle.IdNominaTipo=@IdNomina
and dbo.ro_rol_detalle.IdNominaTipoLiqui=@IdNominaTipoLiq
and dbo.ro_rol_detalle.IdPeriodo=@IdPeriodo
and dbo.ro_rol_detalle.IdPeriodo=@IdPeriodo

--and dbo.ro_rol_detalle.IdEmpleado=110

--select COUNT( IdEmpleado), IdEmpresa from ro_archivos_bancos_generacion_x_empleado

--group by IdEmpleado, IdEmpresa

--select * from ro_archivos_bancos_generacion_x_empleado where IdEmpresa=3
END