CREATE view [dbo].[vwRo_ConfLiqui_X_Empleado]
as
SELECT     null IdEmpresa, ro_rubro_tipo.IdRubro, dbo.ro_rubro_tipo.ru_descripcion AS Descripción, 
                      null Tipo, null SecuPresentacion
FROM         dbo.ro_rubro_tipo