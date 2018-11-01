
CREATE  PROCEDURE [dbo].[spROL_General_RolIndividual]  
	@idempresa int,
	@idnomina_tipo int,
	@idnomina_Tipo_liq int,
	@idperiodo int
AS

BEGIN

--declare
--    @idempresa int,
--	@idnomina_tipo int,
--	@idnomina_Tipo_liq int,
--	@idperiodo int


--	set @idempresa =1
--	set @idnomina_tipo =1
--	set @idnomina_Tipo_liq =2
--	set @idperiodo =201803
	
	delete ro_rol_individual where IdEmpresa=@idempresa
	--insert  into ro_rol_individual (IdEmpresa,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,IdEmpleado,IdRubro,Valor)	
	select D.IdEmpresa,D.IdNominaTipo,D.IdNominaTipoLiqui,D.IdPeriodo,D.IdEmpleado,D.IdRubro,D.Valor from ro_rol_detalle as D, ro_rubro_tipo as R	

	  where D.IdEmpresa=@idempresa
	  and IdNominaTipo=@idnomina_tipo
	  and IdNominaTipoLiqui=@idnomina_Tipo_liq
	  and IdPeriodo=@idperiodo
	  and D.IdRubro=R.IdRubro
	  and R.IdEmpresa=D.IdEmpresa
	  And R.ru_tipo='I'
	  and D.Valor>0


	  -- inserto si tiene saldo zero a pagar 
	--insert  into ro_rol_individual (IdEmpresa,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,IdEmpleado,IdRubro,Valor)	
	select D.IdEmpresa,D.IdNominaTipo,D.IdNominaTipoLiqui,D.IdPeriodo,D.IdEmpleado,D.IdRubro,D.Valor from ro_rol_detalle as D, ro_rubro_tipo as R	

	  where D.IdEmpresa=@idempresa
	  and IdNominaTipo=@idnomina_tipo
	  and IdNominaTipoLiqui=@idnomina_Tipo_liq
	  and IdPeriodo=@idperiodo
	  and D.IdRubro=R.IdRubro
	  and R.IdEmpresa=D.IdEmpresa
	  And R.ru_tipo='A'
	  and D.Valor=0
	  and D.IdRubro=950



	--insert  into ro_rol_individual (IdEmpresa,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,IdEmpleado,IdRubro,Valor)	
	select D.IdEmpresa,D.IdNominaTipo,D.IdNominaTipoLiqui,D.IdPeriodo,D.IdEmpleado,D.IdRubro,Valor*-1 from ro_rol_detalle as D, ro_rubro_tipo as R	

	  where D.IdEmpresa=@idempresa
	  and IdNominaTipo=@idnomina_tipo
	  and IdNominaTipoLiqui=@idnomina_Tipo_liq
	  and IdPeriodo=@idperiodo
	  and R.IdEmpresa=D.IdEmpresa
	  and D.IdRubro=R.IdRubro
	  And R.ru_tipo='E'
	  and D.Valor>0




	  SELECT        dbo.tb_persona.pe_nombreCompleto AS NombreCompleto, dbo.tb_persona.pe_cedulaRuc AS Ruc, dbo.ro_rubro_tipo.ru_descripcion AS RubroDescripcion, web.ro_SPROL_002.IdEmpresa, web.ro_SPROL_002.IdNominaTipo, 
                         web.ro_SPROL_002.IdNominaTipoLiqui, web.ro_SPROL_002.IdPeriodo, web.ro_SPROL_002.IdEmpleado, dbo.ro_cargo.ca_descripcion AS Cargo, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, 
                         dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, dbo.ro_rubro_tipo.ru_tipo, dbo.ro_empleado.em_status, dbo.ro_rubro_tipo.ru_orden, dbo.tb_empresa.em_ruc
FROM            dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         web.ro_SPROL_002 ON dbo.ro_empleado.IdEmpresa = web.ro_SPROL_002.IdEmpresa AND dbo.ro_empleado.IdEmpleado = web.ro_SPROL_002.IdEmpleado ON 
                         dbo.ro_rubro_tipo.IdRubro = web.ro_SPROL_002.IdRubro AND dbo.ro_rubro_tipo.IdEmpresa = web.ro_SPROL_002.IdEmpresa INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo AND dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa INNER JOIN
                         dbo.ro_periodo ON web.ro_SPROL_002.IdEmpresa = dbo.ro_periodo.IdEmpresa AND web.ro_SPROL_002.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.tb_empresa ON dbo.ro_empleado.IdEmpresa = dbo.tb_empresa.IdEmpresa

END
