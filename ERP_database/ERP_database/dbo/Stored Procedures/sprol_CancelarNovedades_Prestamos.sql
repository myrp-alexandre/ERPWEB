
CREATE procedure [dbo].[sprol_CancelarNovedades_Prestamos] 
@IdEmpresa int,
@IdNomina int,
@IdNominaTipo int,
@IdPeriodo int,
@IdSucursal int,
@IdRol int
as
begin

declare
@FechaInicio date,
@fechaFin date

select @FechaInicio=pe_FechaIni,@fechaFin=pe_FechaFin from ro_periodo where IdPeriodo=@IdPeriodo and @IdEmpresa=@IdEmpresa
update ro_empleado_novedad_det set EstadoCobro='CAN'       
FROM            dbo.ro_empleado_Novedad AS nov INNER JOIN
                         dbo.ro_empleado_novedad_det AS nov_det ON nov.IdEmpresa = nov_det.IdEmpresa AND nov.IdNovedad = nov_det.IdNovedad INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON nov_det.IdEmpresa = rub.IdEmpresa AND nov_det.IdRubro = rub.IdRubro
						 WHERE FechaPago between @FechaInicio and @fechaFin
						 and IdNomina_tipo=@IdNomina
						 and IdNomina_TipoLiqui=@IdNominaTipo
						 and nov.IdEmpresa=@IdEmpresa
						 and exists (select * from ro_rol_detalle d, ro_rol r
						 where r.IdEmpresa=nov.IdEmpresa
						 and r.IdEmpresa=d.IdEmpresa
						 and r.IdRol=d.IdRol
						 and d.IdEmpleado=nov.IdEmpleado
						 and r.IdNominaTipo=nov.IdNomina_tipo
						 and r.IdNominaTipoLiqui=nov.IdNomina_TipoLiqui
						 and d.IdRubro=nov_det.IdRubro
						 and r.IdPeriodo=@IdPeriodo
						 and nov.IdSucursal=@IdSucursal
						 and nov.Estado='A')



						 update ro_prestamo_detalle set EstadoPago='CAN'
						FROM            dbo.ro_prestamo_detalle INNER JOIN
                         dbo.ro_prestamo ON dbo.ro_prestamo_detalle.IdEmpresa = dbo.ro_prestamo.IdEmpresa AND dbo.ro_prestamo_detalle.IdPrestamo = dbo.ro_prestamo.IdPrestamo INNER JOIN
                         dbo.ro_empleado ON dbo.ro_prestamo.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_prestamo.IdEmpleado = dbo.ro_empleado.IdEmpleado
    					 WHERE FechaPago between @FechaInicio and @fechaFin
						 and ro_empleado.IdSucursal=@IdSucursal
						 
						 and ro_prestamo_detalle.IdNominaTipoLiqui=@IdNominaTipo
						 and ro_prestamo_detalle.IdEmpresa=@IdEmpresa

						 update ro_rol set Cerrado='CONTABILIZADO' 
						 where IdEmpresa=@IdEmpresa 
						 and  IdNominaTipo=@IdNomina
						 and IdNominaTipoLiqui=@IdNominaTipo
						 and IdPeriodo=@IdPeriodo
						 AND IdRol=@IdRol
end
