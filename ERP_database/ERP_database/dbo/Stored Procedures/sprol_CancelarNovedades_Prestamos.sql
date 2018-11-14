
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
FROM            dbo.ro_empleado_Novedad AS nov INNER JOIN
                         dbo.ro_empleado_novedad_det AS nov_det ON nov.IdEmpresa = nov_det.IdEmpresa AND nov.IdNovedad = nov_det.IdNovedad INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON nov_det.IdEmpresa = rub.IdEmpresa AND nov_det.IdRubro = rub.IdRubro
						 WHERE FechaPago between @FechaInicio and @fechaFin
						 and IdNomina_tipo=@IdNomina
						 and IdNomina_TipoLiqui=@IdNominaTipo
						 and nov.IdEmpresa=@IdEmpresa
						 and exists (select * from ro_rol_detalle r
						 where r.IdEmpresa=nov.IdEmpresa
						 and r.IdEmpleado=nov.IdEmpleado
						 and r.IdNominaTipo=nov.IdNomina_tipo
						 and r.IdNominaTipoLiqui=nov.IdNomina_TipoLiqui
						 and r.IdRubro=nov_det.IdRubro
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
