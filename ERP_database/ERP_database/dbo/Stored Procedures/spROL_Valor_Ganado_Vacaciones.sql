CREATE PROCEDURE [dbo].[spROL_Valor_Ganado_Vacaciones]
	@IdEmpresa int,
    @IdNomina_Tipo int,
	@IdEmpleado int,
	@Fecha_Inicio date,
	@Fecha_Hasta date,
	@IdRubro varchar

AS
/*
declare 

@IdEmpresa int,
@IdNomina_Tipo int,
@IdEmpleado int,
@IdRubro varchar,
@Fecha_Inicio date,
@Fecha_Hasta date

set @IdEmpresa=1
set @IdEmpleado=1
set @IdNomina_Tipo=1
set @Fecha_Inicio='01/01/2016'
set @Fecha_Hasta='31/12/2016'
set @IdRubro=4
 */

BEGIN
	select d.IdEmpresa,d.IdEmpleado,d.IdRubro,d.Observacion,SUM( d.Valor) Valor
	
	from ro_rol_detalle as D, ro_periodo as P
	where d.IdEmpresa=@IdEmpresa
	and d.IdEmpleado=@IdEmpleado
	and d.IdRubro=@IdRubro
	and d.IdNominaTipo=@IdNomina_Tipo
	and d.IdNominaTipoLiqui in(1,2)
	and d.IdEmpresa=p.IdEmpresa
	and d.IdPeriodo=p.IdPeriodo
	and ((p.pe_FechaIni between @Fecha_Inicio and @Fecha_Hasta) or  (p.pe_FechaFin between @Fecha_Inicio and @Fecha_Hasta ))
	group by
	d.IdEmpresa,d.IdNominaTipo, d.IdEmpleado, d.IdRubro, d.Orden, d.Observacion, d.TipoMovimiento

END