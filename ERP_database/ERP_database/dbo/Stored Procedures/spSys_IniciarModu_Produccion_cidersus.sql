-- =============================================
-- Author:		Luis Yanza
-- Create date: 27-jun-2013
-- Description:	Iniciar modulo Produccion Cidersus
-- =============================================

-- exec [sp_IniciarModu_Produccion_cidersus] 1

CREATE PROCEDURE [dbo].[spSys_IniciarModu_Produccion_cidersus] 
	@IdEmpresa int
AS
BEGIN
	delete from prd_Despacho_cusCidersus_x_in_movi_inven where IdEmpresa = @IdEmpresa 
	delete from prd_DespachoDet where IdEmpresa =@IdEmpresa
	delete from prd_Despacho where IdEmpresa =@IdEmpresa
	
	
	delete from prd_MovPteGrua_Det  where IdEmpresa =@IdEmpresa
	delete from prd_MovPteGrua  where IdEmpresa =@IdEmpresa
	
	
	delete prd_ControlInventarioProd where IdEmpresa =@IdEmpresa
	delete from prd_ControlProduccion_Obrero_x_in_movi_inve where cp_idempresa=@IdEmpresa
	delete from prd_ControlProduccion_Obrero_Det where IdEmpresa =@IdEmpresa
	delete from prd_ControlProduccion_Obrero where IdEmpresa =@IdEmpresa
	
	delete from prd_conversion_cusCidersus_x_in_movi_inven where IdEmpresa =@IdEmpresa
	delete from prd_Conversion_det_CusCidersus where IdEmpresa =@IdEmpresa
	delete from prd_Conversion_CusCidersus where IdEmpresa =@IdEmpresa
	
	
	delete from prd_ensamblado_cusCider_x_in_movi_inven where IdEmpresa =@IdEmpresa
	delete from prd_Ensamblado_Det_CusCider where IdEmpresa =@IdEmpresa
	delete from prd_Ensamblado_CusCider where IdEmpresa =@IdEmpresa
	
	delete from dbo.in_movi_inve_detalle_x_com_ordencompra_local_det  where mi_IdEmpresa =@IdEmpresa
	
	
	
	delete from dbo.com_GenerOCompra_Det_x_com_ordencompra_local_det_CusCider where goc_IdEmpresa =@IdEmpresa
	delete from dbo.com_GenerOCompra_Det where IdEmpresa =@IdEmpresa
	delete from dbo.com_GenerOCompra where IdEmpresa =@IdEmpresa
	
	delete from dbo.com_ListadoMateriales_Det_x_com_GenerOCompra_Det where go_IdEmpresa  =@IdEmpresa
	delete from dbo.com_ListadoMateriales_Det where IdEmpresa =@IdEmpresa
	delete from dbo.com_ListadoMateriales where IdEmpresa =@IdEmpresa
	
	
	DELETE FROM in_movi_inven_x_in_movi_inven_CusCidersus  where idempresa1  =@IdEmpresa
	delete from com_ordencompra_local_det where IdEmpresa =@IdEmpresa
	delete from com_ordencompra_local where IdEmpresa =@IdEmpresa
	delete from in_movi_inve_detalle_x_Producto_CusCider where IdEmpresa =@IdEmpresa
	delete from in_movi_inve_detalle where IdEmpresa =@IdEmpresa
	delete from in_movi_inve where IdEmpresa =@IdEmpresa
	
		
	delete from prd_GrupoTrabajo_Det where IdEmpresa =@IdEmpresa
	delete from prd_GrupoTrabajo where IdEmpresa =@IdEmpresa
		
		
	delete from prd_Orden_Taller where IdEmpresa =@IdEmpresa
	delete from prd_EtapaProduccion where IdEmpresa =@IdEmpresa
	delete from prd_ProcesoProductivo_x_prd_obra where IdEmpresa_Pr  =@IdEmpresa
	delete from prd_ProcesoProductivo where IdEmpresa =@IdEmpresa
	
	
	
	
END