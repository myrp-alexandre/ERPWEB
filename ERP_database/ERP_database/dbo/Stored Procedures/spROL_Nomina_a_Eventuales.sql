

CREATE PROCEDURE [dbo].[spROL_Nomina_a_Eventuales]
@IdEmpresa int,
@IdNomina_Tipo int,
@IdPeriodo int,
@FechaDesde date,
@FechaHasta date,
@IdEmpleado int
AS

/*
declare 

@IdEmpresa int,
@IdNomina_Tipo int,
@IdPeriodo int,
@FechaDesde date,
@FechaHasta date,
@IdEmpleado int

set @IdEmpresa=2
set @IdNomina_Tipo=2
set @IdPeriodo=201707

--set @FechaDesde='01/01/2017'
--set @FechaHasta='31/01/2017'
set @IdEmpleado=290



*/

BEGIN
SELECT        dbo.vwRo_Empleado_X_Nomina.cargo, dbo.vwRo_Empleado_X_Nomina.departamento, dbo.vwRo_Empleado_X_Nomina.IdEmpresa, dbo.vwRo_Empleado_X_Nomina.IdEmpleado, 
                         dbo.vwRo_Empleado_X_Nomina.IdPersona, dbo.vwRo_Empleado_X_Nomina.em_fecha_ingreso, dbo.vwRo_Empleado_X_Nomina.em_fechaSalida, dbo.vwRo_Empleado_X_Nomina.em_fechaTerminoContra, 
                         dbo.vwRo_Empleado_X_Nomina.em_fechaIngaRol, dbo.vwRo_Empleado_X_Nomina.em_SeAcreditaBanco, dbo.vwRo_Empleado_X_Nomina.em_tipoCta, dbo.vwRo_Empleado_X_Nomina.em_NumCta, 
                         dbo.vwRo_Empleado_X_Nomina.em_estado, dbo.vwRo_Empleado_X_Nomina.IdDepartamento, dbo.vwRo_Empleado_X_Nomina.IdCargo, dbo.vwRo_Empleado_X_Nomina.NomCompleto, 
                         dbo.vwRo_Empleado_X_Nomina.Apellido, dbo.vwRo_Empleado_X_Nomina.pe_razonSocial, dbo.vwRo_Empleado_X_Nomina.Nombre, dbo.vwRo_Empleado_X_Nomina.pe_cedulaRuc, 
                         dbo.vwRo_Empleado_X_Nomina.pe_estado, dbo.vwRo_Empleado_X_Nomina.pe_fechaCreacion, dbo.vwRo_Empleado_X_Nomina.pe_fechaModificacion, dbo.vwRo_Empleado_X_Nomina.Sucursal, 
                         dbo.vwRo_Empleado_X_Nomina.IdSucursal, dbo.vwRo_Empleado_X_Nomina.IdArea, dbo.vwRo_Empleado_X_Nomina.IdDivision, dbo.vwRo_Empleado_X_Nomina.em_status, 
                         dbo.vwRo_Empleado_X_Nomina.es_TruncarDecimalAnticipo, dbo.vwRo_Empleado_X_Nomina.IdTipoNomina, dbo.vwRo_Empleado_X_Nomina.Marca_Biometrico, dbo.vwRo_Empleado_X_Nomina.IdTipoAnticipo, 
                         dbo.vwRo_Empleado_X_Nomina.em_AnticipoSueldo, dbo.vwRo_Empleado_X_Nomina.Nomina, dbo.ro_contrato.FechaInicio, dbo.ro_contrato.FechaFin, dbo.ro_contrato.EstadoContrato, 
                        ISNULL( Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.Valor_Alimen,0)Valor_Alimen,
						isnull( Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.Valor_Transp,0)Valor_Transp,
						isnull(dbo.vwro_sueldoActual.SueldoActual,0)SueldoActual, 
                        isnull(Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.Valor_bono,0)Valor_bono,
						isnull( vwRo_Empleado_X_Nomina.IdGrupo,0)IdGrupo,
						dbo.vwRo_Empleado_X_Nomina.Cod_Region,


						  (select count(DISTINCT es_fechaRegistro) from ro_marcaciones_x_empleado 
						  where dbo.vwRo_Empleado_X_Nomina.IdEmpresa=ro_marcaciones_x_empleado .IdEmpresa 
						  and dbo.vwRo_Empleado_X_Nomina.IdEmpleado=ro_marcaciones_x_empleado .IdEmpleado 
						 -- and ro_marcaciones_x_empleado .IdNomina=@IdNomina_Tipo
						  and ro_marcaciones_x_empleado .es_fechaRegistro between @FechaDesde and @FechaHasta
						  and datepart(dw,es_fechaRegistro) in(6)) as Dias_SyD,
						  
						  
						  (select count(DISTINCT es_fechaRegistro) from ro_marcaciones_x_empleado  
						  where dbo.vwRo_Empleado_X_Nomina.IdEmpresa=@IdEmpresa 
						  and dbo.vwRo_Empleado_X_Nomina.IdEmpleado=ro_marcaciones_x_empleado .IdEmpleado 
						 -- and ro_marcaciones_x_empleado .IdNomina_Tipo=@IdNomina_Tipo
						 and CAST( ro_marcaciones_x_empleado .es_fechaRegistro as date) between @FechaDesde and @FechaHasta
						--and ro_marcaciones_x_empleado.IdPeriodo=@IdPeriodo
						  and ro_marcaciones_x_empleado .IdEmpresa=@IdEmpresa) as Dias_Efectivos,
						  (SELECT     max( IdEmpleado)
                               FROM            dbo.ro_empleado_x_ro_rubro
                               WHERE        (dbo.vwRo_Empleado_X_Nomina.IdEmpresa = @IdEmpresa) AND (dbo.vwRo_Empleado_X_Nomina.IdEmpleado = IdEmpleado)) 
                              AS si_tiene_rubros_fijo
						  


FROM            dbo.vwRo_Empleado_X_Nomina INNER JOIN
                         dbo.ro_contrato ON dbo.vwRo_Empleado_X_Nomina.IdEmpresa = dbo.ro_contrato.IdEmpresa AND dbo.vwRo_Empleado_X_Nomina.IdEmpleado = dbo.ro_contrato.IdEmpleado INNER JOIN
                         dbo.vwro_sueldoActual ON dbo.vwRo_Empleado_X_Nomina.IdEmpresa = dbo.vwro_sueldoActual.IdEmpresa AND dbo.vwRo_Empleado_X_Nomina.IdEmpleado = dbo.vwro_sueldoActual.IdEmpleado LEFT OUTER JOIN
                         Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo ON dbo.vwRo_Empleado_X_Nomina.IdTipoNomina = Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.IdNomina AND 
                         dbo.vwRo_Empleado_X_Nomina.IdEmpleado = Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.IdEmpleado AND 
                         dbo.vwRo_Empleado_X_Nomina.IdEmpresa = Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.IdEmpresa
						 WHERE        (dbo.ro_contrato.EstadoContrato = 'ECT_ACT')
						 and dbo.vwRo_Empleado_X_Nomina.IdEmpresa=@IdEmpresa
						 and dbo.vwRo_Empleado_X_Nomina.IdTipoNomina=@IdNomina_Tipo
						 and Fj_servindustrias.vwro_empleado_x_cargo_fuerza_grupo.IdPeriodo=@IdPeriodo
						and dbo.vwRo_Empleado_X_Nomina.IdEmpleado=@IdEmpleado
                        --  and dbo.ro_contrato.Estado='A'

				-- select * from vwRo_Empleado_X_Nomina

				--	select * from ro_empleado_x_ro_tipoNomina where IdEmpresa=2 and IdEmpleado=274

				--delete ro_rol_detalle where IdEmpresa=2 and IdPeriodo=201705
						  
						 
						 
						  
						 



--     select * from vwRo_Empleado_X_Nomina
 --    select * from ro_rubro_tipo 
END