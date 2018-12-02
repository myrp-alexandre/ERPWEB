
CREATE PROCEDURE [dbo].[spRo_Reverso_Rol]
	@IdEmpresa int,
	@IdNomina_Tipo int,
	@IdNomina_TipoLiqui int,
	@IdPeriodo int
	
	
AS

BEGIN
/*
declare

	@IdEmpresa int,
	@IdNomina_Tipo int,
	@IdNomina_TipoLiqui int,
	@IdPeriodo int


	set @IdEmpresa=1
	set @IdNomina_Tipo=1
	set @IdNomina_TipoLiqui=2
	set @IdPeriodo=201704
	*/
DECLARE 

@fechai date,
@fechaf date

select @fechai=pe_FechaIni,@fechaf=pe_FechaFin from ro_periodo where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPeriodo

-- eleiminando comprobante contable detalle 

delete ct_cbtecble_det
FROM            dbo.ro_Comprobantes_Contables INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ro_Comprobantes_Contables.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ro_Comprobantes_Contables.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ro_Comprobantes_Contables.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble
						 where ro_Comprobantes_Contables.IdEmpresa=@IdEmpresa
						and IdNomina=@IdNomina_Tipo
						and IdNominaTipo=@IdNomina_TipoLiqui
						and IdPeriodo=@IdPeriodo


-- eliminando comprobante contable cabecera 
delete ct_cbtecble
FROM            dbo.ro_Comprobantes_Contables AS comp_rol INNER JOIN
                  dbo.ct_cbtecble ON comp_rol.IdEmpresa = dbo.ct_cbtecble.IdEmpresa AND comp_rol.IdTipoCbte = dbo.ct_cbtecble.IdTipoCbte AND comp_rol.IdCbteCble = dbo.ct_cbtecble.IdCbteCble
			where comp_rol.IdEmpresa=@IdEmpresa
			and comp_rol.IdNomina=@IdNomina_Tipo
			and IdNominaTipo=@IdNomina_TipoLiqui
			and comp_rol.IdPeriodo=@IdPeriodo


-- eliminando comprobante contable rol

delete ro_Comprobantes_Contables 
			where IdEmpresa=@IdEmpresa
			and ro_Comprobantes_Contables.IdNomina=@IdNomina_Tipo
			and ro_Comprobantes_Contables.IdNominaTipo=@IdNomina_TipoLiqui
			and IdPeriodo=@IdPeriodo




update ro_empleado_novedad_det set EstadoCobro='PEN'
FROM            dbo.ro_empleado_Novedad AS nov INNER JOIN
                         dbo.ro_empleado_novedad_det AS nov_det ON nov.IdEmpresa = nov_det.IdEmpresa AND nov.IdNovedad = nov_det.IdNovedad INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON nov_det.IdEmpresa = rub.IdEmpresa AND nov_det.IdRubro = rub.IdRubro
						 WHERE FechaPago between @fechai and @fechaf
						 and IdNomina_Tipo=@IdNomina_Tipo
						 and IdNomina_TipoLiqui=@IdNomina_TipoLiqui
						 and nov.IdEmpresa=@IdEmpresa
						 and exists (select * from ro_rol_detalle d, ro_rol r
						 where r.IdEmpresa=nov.IdEmpresa
						 and r.IdEmpresa=d.IdEmpresa
						 and r.IdRol=d.IdRol
						 and d.IdEmpleado=nov.IdEmpleado
						 and r.IdNominaTipo=nov.IdNomina_Tipo
						 and r.IdNominaTipoLiqui=nov.IdNomina_TipoLiqui
						 and d.IdRubro=nov_det.IdRubro
						 and r.IdPeriodo=@IdPeriodo)



						 update ro_periodo_x_ro_Nomina_TipoLiqui set Contabilizado='N' 
						 where IdEmpresa=@IdEmpresa 
						 and  IdNomina_Tipo=@IdNomina_Tipo
						 and IdNomina_TipoLiqui=@IdNomina_TipoLiqui
						 and IdPeriodo=@IdPeriodo

















update ro_periodo_x_ro_Nomina_TipoLiqui set Contabilizado='N'
			where IdEmpresa=@IdEmpresa 
			and IdNomina_Tipo=@IdNomina_Tipo 
			and IdNomina_TipoLiqui=@IdNomina_TipoLiqui
			and IdPeriodo=@IdPeriodo




END
