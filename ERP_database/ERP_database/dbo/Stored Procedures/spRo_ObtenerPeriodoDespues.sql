create PROCEDURE [dbo].[spRo_ObtenerPeriodoDespues]
	@IdEmpresa int,
	@IdPeriodo int,
	@IdNomina_Tipo int,
	@IdNomina_TipoLiqui int
	
AS
BEGIN
		select top (1)* 
		from ro_periodo_x_ro_Nomina_TipoLiqui where IdEmpresa = @IdEmpresa and  
		IdNomina_Tipo=@IdNomina_Tipo and IdNomina_TipoLiqui=@IdNomina_TipoLiqui and
		IdPeriodo > @IdPeriodo 
		order by IdPeriodo  asc
END