
-- =============================================
-- Author:		<Modulo Roles>
-- Create date: <8-Julio-2013>
-- Description:	<Inicializar las Tablas de Roles>
-- =============================================
CREATE PROCEDURE [dbo].[spSys_IniciaModu_Roles]
	-- Add the parameters for the stored procedure here
	@empresa int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    begin try
    	delete from dbo.ro_CargaFamiliar WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
		delete from dbo.ro_Empleado_estudios WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_empleado_x_titulos WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Cargo WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_contrato WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Config_Rubros_Acumulado WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_ConfigLiquiRol_x_Empleado WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Cxc_tipo;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Departamento WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_DocumentoxEmp WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_empleado_historial_Sueldo WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_empleado_novedad_det WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Empleado_Novedad WHERE IdEmpresa = @empresa
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_empresa_x_TipoLiqui_Rol WHERE IdEmpresa = @empresa
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_empresa WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Ing_Egre_x_Empleado WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_marcaciones_x_empleado WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_Rol_x_Empleado ;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_rubro_tipo_x_Empresa WHERE IdEmpresa = @empresa;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
	delete dbo.ro_TablaSectorial;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin
		declare @persona  numeric(18,0)
		
		DECLARE cursor_Empleado CURSOR FOR 
			select IdPersona from ro_empleado where IdEmpresa = @empresa
		
		OPEN cursor_Empleado
		FETCH NEXT FROM cursor_Empleado 
		INTO	@persona
		
		WHILE @@FETCH_STATUS = 0
			BEGIN
				DELETE FROM TB_PERSONA WHERE IdPersona = @persona
				
				FETCH NEXT FROM cursor_Empleado 
				INTO @persona	
			END	
			
		CLOSE cursor_Empleado;
		DEALLOCATE cursor_Empleado;
		--DELETE FROM TB_PERSONA WHERE CodPersona LIKE 'EMPL%'
		
	end 
	
	begin try
	delete ro_empleado WHERE IdEmpresa = @empresa
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
		delete dbo.ro_IdRol ;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	begin try
		delete dbo.tbMG_Talme_Empleado;
	end try
	begin catch
		select ERROR_LINE() AS Linea_de_Error;
	end catch
	
	
	
END