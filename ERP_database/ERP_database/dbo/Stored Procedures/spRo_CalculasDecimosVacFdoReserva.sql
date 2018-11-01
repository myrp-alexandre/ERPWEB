-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spRo_CalculasDecimosVacFdoReserva]
	-- Add the parameters for the stored procedure here
	@i_IdEmpresa int,		@i_IdPeriodo int,
	@i_IdNomina_Tipo int,	@i_IdNomina_TipoLiqui int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
---------------------------------------------------------------------------
--Calculo para el XIII
	
	Select 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdNomina_Tipo,		
	i_e.IdNomina_TipoLiqui,		i_e.IngEgr,						emp.pe_nombreCompleto,		
	i_E.IdPeriodo,
	SUM(i_e.Valor)/12 as ProvXIII
	--,*
	
	from vwro_Ing_Egre_x_Empleado i_e 
	Inner Join ro_Config_Rubros_x_Empresa_AportaIess ru_ie
	on i_E.IdEmpresa = ru_ie.IdEmpresa		and i_e.IdRubro = ru_ie.IdRubro
	Inner Join VWRO_empleado emp
	on emp.IdEmpleado = i_e.IdEmpleado		and emp.IdEmpresa = i_e.IdEmpresa
	where i_e.IngEgr = 'I' and i_E.IdEmpresa = 6
	GRoup by 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdPeriodo,
	i_E.IdNomina_Tipo,			i_e.IdNomina_TipoLiqui,			i_e.IngEgr,					
	emp.pe_nombreCompleto
	
	----------------------------------------------
	--Calculos para el Fdo de Reserva
	Select 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdNomina_Tipo,		
	i_e.IdNomina_TipoLiqui,		i_e.IngEgr,						emp.pe_nombreCompleto,		
	i_E.IdPeriodo,
	(SUM(i_e.Valor))* p.porc_FdoReserva as FdoRes 
	--,*
	from vwro_Ing_Egre_x_Empleado i_e 
	Inner Join ro_Config_Rubros_x_Empresa_AportaIess ru_ie
	on i_E.IdEmpresa = ru_ie.IdEmpresa		and i_e.IdRubro = ru_ie.IdRubro
	Inner Join VWRO_empleado emp
	on emp.IdEmpleado = i_e.IdEmpleado		and emp.IdEmpresa = i_e.IdEmpresa
	Inner Join ro_Parametros p
	on p.IdEmpresa = i_E.IdEmpresa 
	where i_e.IngEgr = 'I' and i_E.IdEmpresa = 6
	GRoup by 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdPeriodo,
	i_E.IdNomina_Tipo,			i_e.IdNomina_TipoLiqui,			i_e.IngEgr,					
	emp.pe_nombreCompleto,		p.porc_FdoReserva
	
	
	---------------------------------------------------
	---calculo para el XIV
	Select 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdNomina_Tipo,		
	i_e.IdNomina_TipoLiqui,		emp.pe_nombreCompleto,			i_E.IdPeriodo--,				
	--p.sb_anio_Actual/360 * 15 as ProvXIV-- * dias trabajados
	--,*
	from vwro_Ing_Egre_x_Empleado i_e 
	Inner Join VWRO_empleado emp
	on emp.IdEmpleado = i_e.IdEmpleado		and emp.IdEmpresa = i_e.IdEmpresa
	Inner Join ro_Parametros p
	on p.IdEmpresa = i_E.IdEmpresa 
	where i_E.IdEmpresa = 6
	GRoup by 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdPeriodo,
	i_E.IdNomina_Tipo,			i_e.IdNomina_TipoLiqui,			i_e.IngEgr,					
	emp.pe_nombreCompleto--,		p.sb_anio_Actual
	
	
	---------------------------------------------------
	---Cálculo para las Vacaciones
	
	Select 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdNomina_Tipo,		
	i_e.IdNomina_TipoLiqui,		i_e.IngEgr,						emp.pe_nombreCompleto,		
	i_E.IdPeriodo,
	(SUM(i_e.Valor))/24 as ProvVac 
	--,*
	from vwro_Ing_Egre_x_Empleado i_e 
	Inner Join ro_rubro_tipo ru_ie
	on i_E.IdEmpresa = ru_ie.IdEmpresa		and i_e.IdRubro = ru_ie.IdRubro
	Inner Join VWRO_empleado emp
	on emp.IdEmpleado = i_e.IdEmpleado		and emp.IdEmpresa = i_e.IdEmpresa
	where i_e.IngEgr = 'I' and i_E.IdEmpresa = 6
	GRoup by 
	i_e.IdEmpresa,				i_e.IdEmpleado,					i_E.IdPeriodo,
	i_E.IdNomina_Tipo,			i_e.IdNomina_TipoLiqui,			i_e.IngEgr,					
	emp.pe_nombreCompleto
	
END