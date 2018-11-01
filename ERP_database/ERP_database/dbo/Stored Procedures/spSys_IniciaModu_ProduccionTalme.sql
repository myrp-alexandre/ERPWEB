CREATE PROCEDURE [dbo].[spSys_IniciaModu_ProduccionTalme] 
 @IdEmpresa int 
AS
BEGIN

	Delete From	prod_CompraChatarra_CusTalme_x__in_movi_inven	Where IdEmpresa = @IdEmpresa
	Delete From	prod_Parametros_x_MoviInven_x_ModeloProduccion	Where IdEmpresa = @IdEmpresa
	Delete From	prod_ModeloProduccion_x_Producto_CusTal	Where IdEmpresa = @IdEmpresa
	Delete From	prod_GestionProductivaAcero_CusTalme_x_in_movi_inven	Where  gp_IdEmpresa = @IdEmpresa and mv_IdEmpresa = @IdEmpresa
	Delete From	prod_GestionProductivaLaminado_x_paradas_CusTalme	Where IdEmpresa = @IdEmpresa	
	Delete From	prod_Proveedores_X_Presupuesto_CusTalme	Where IdEmpresa = @IdEmpresa
	Delete From	prod_GestionProductivaTechos_CusTalme_X_in_movi_inve	Where IdEmpresa = @IdEmpresa
	Delete From	prod_GestionProductivaTechos_CusTalme_Detalle	Where IdEmpresa = @IdEmpresa	
	Delete From	prod_GestionProductivaLaminado_CusTalme	Where IdEmpresa = @IdEmpresa
	Delete From	prod_GestionProductivaAcero_CusTalme	Where IdEmpresa = @IdEmpresa
	Delete From	prod_GestionProductivaTechos_CusTalme_Cab	Where IdEmpresa = @IdEmpresa
	Delete From	prod_ChatarraTipo_CusTalme	Where IdEmpresa = @IdEmpresa
	Delete From	prod_CompraChatarra_CusTalme	Where IdEmpresa = @IdEmpresa
	Delete From	prod_Parametro	Where IdEmpresa = @IdEmpresa

END