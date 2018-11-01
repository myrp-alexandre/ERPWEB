
CREATE PROCEDURE [dbo].[spRo_Cierre_Rol]
	@IdEmpresa int,
	@IdPeriodo int,
	@IdNomina_Tipo int,
	@IdNomina_TipoLiqui int
	
AS
BEGIN
update ro_periodo_x_ro_Nomina_TipoLiqui set cerrado='S'
where IdEmpresa=@IdEmpresa and IdNomina_Tipo=@IdNomina_Tipo and IdNomina_TipoLiqui=@IdNomina_TipoLiqui
 and IdPeriodo=@IdPeriodo

 update ro_rol set cerrado='S'
where IdEmpresa=@IdEmpresa and IdNominaTipo=@IdNomina_Tipo and IdNominaTipoLiqui=@IdNomina_TipoLiqui
 and IdPeriodo=@IdPeriodo
END
