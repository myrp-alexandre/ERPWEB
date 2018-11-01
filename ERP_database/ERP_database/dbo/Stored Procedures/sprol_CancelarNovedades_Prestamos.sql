
CREATE procedure [dbo].[sprol_CancelarNovedades_Prestamos] 
@IdEmpresa int,
@IdNomina int,
@IdNominaTipo int,
@IdPeriodo int
as
begin

declare
@FechaInicio date,
@fechaFin date

select @FechaInicio=pe_FechaIni,@fechaFin=pe_FechaFin from ro_periodo where IdPeriodo=@IdPeriodo and @IdEmpresa=@IdEmpresa
update ro_empleado_novedad_det set EstadoCobro='CAN'
FROM            dbo.ro_rol_detalle AS rol INNER JOIN
                         dbo.ro_empleado_novedad_det AS novedad ON rol.IdEmpresa = novedad.IdEmpresa AND rol.IdNominaTipo = novedad.IdNomina_tipo AND rol.IdNominaTipoLiqui = novedad.IdNomina_Tipo_Liq AND 
                         rol.IdEmpleado = novedad.IdEmpleado AND rol.IdRubro = novedad.IdRubro
						 WHERE FechaPago between @FechaInicio and @fechaFin
						 and IdNomina_tipo=@IdNomina
						 and IdNomina_Tipo_Liq=@IdNominaTipo
						 and novedad.IdEmpresa=@IdEmpresa
						 and exists (select * from ro_rol_detalle r
						 where r.IdEmpresa=novedad.IdEmpresa
						 and r.IdEmpleado=novedad.IdEmpleado
						 and r.IdNominaTipo=novedad.IdNomina_tipo
						 and r.IdNominaTipoLiqui=novedad.IdNomina_Tipo_Liq
						 and r.IdRubro=novedad.IdRubro
						 and r.IdPeriodo=@IdPeriodo)
						 update ro_prestamo_detalle set EstadoPago='CAN'
						 FROM            dbo.ro_prestamo_detalle INNER JOIN
                         dbo.ro_prestamo ON dbo.ro_prestamo_detalle.IdEmpresa = dbo.ro_prestamo.IdEmpresa AND dbo.ro_prestamo_detalle.IdPrestamo = dbo.ro_prestamo.IdPrestamo
						  WHERE FechaPago between @FechaInicio and @fechaFin
						 
						 and ro_prestamo_detalle.IdNominaTipoLiqui=@IdNominaTipo
						 and ro_prestamo_detalle.IdEmpresa=@IdEmpresa

						 update ro_periodo_x_ro_Nomina_TipoLiqui set Contabilizado='S' 
						 where IdEmpresa=@IdEmpresa 
						 and  IdNomina_Tipo=@IdNomina
						 and IdNomina_TipoLiqui=@IdNominaTipo
						 and IdPeriodo=@IdPeriodo
end
