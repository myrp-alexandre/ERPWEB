
--exec [Fj_servindustrias].[spROLES_Rpt012] 1,1,2017,9,201709


CREATE PROCEDURE [dbo].[spRO_Novedades_no_cobradas]
	@IdEmpresa int,
	@fecha date
	as

/*
	declare 
	@IdEmpresa int,
	@fecha date

	set @IdEmpresa=3
	set @fecha='30/09/2017'
	*/
	
	begin

	select * from vwro_Empleado_Novedades
	where IdRubro not in (select IdRubro from ro_rol_detalle r where 
	r.IdEmpresa=IdEmpresa
	and r.IdEmpleado=IdEmpleado
	and r.IdNominaTipo=IdNomina_Tipo 
	and r.IdNominaTipoLiqui=IdNomina_TipoLiqui
	and r.IdEmpresa=IdEmpresa
	and r.IdEmpresa=@IdEmpresa
	and IdEmpresa=@IdEmpresa)
	and FechaPago<=@fecha
	and Estado='A'
	and IdNomina_Tipo=1
	and IdEmpresa=@IdEmpresa
	and em_status!='EST_LIQ'
end