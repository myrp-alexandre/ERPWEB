create proc [dbo].[sp_sys_Borrar_tablas_inventario]
as

declare @IdEmpresa int 
set @IdEmpresa =15


delete [in_AjusteFisico_Detalle] where IdEmpresa=@IdEmpresa 
delete [in_ajusteFisico] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_AjusteFisico_tmp] where IdEmpresa=@IdEmpresa 

delete [dbo].[in_Aprobacion_Ing_a_bod_x_OC_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_Aprobacion_Ing_a_bod_x_OC]  where IdEmpresa=@IdEmpresa 




delete [dbo].[in_egreso_d_Suministro] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_Guia_x_traspaso_bodega_det_sin_oc] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_Guia_x_traspaso_bodega_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_Guia_x_traspaso_bodega] where IdEmpresa=@IdEmpresa 



delete [dbo].[in_kardex_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_kardex] where IdEmpresa=@IdEmpresa 


delete [dbo].[in_transferencia_x_fa_guia_remision] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_transferencia_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_transferencia] where IdEmpresa=@IdEmpresa 





delete [dbo].[in_movi_inve_detalle_x_com_ordencompra_local_det] where mi_IdEmpresa=@IdEmpresa 
delete [dbo].[in_movi_inve_detalle_x_Producto_CusCider] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_movi_inven_x_in_movi_inven_CusCidersus] where IdEmpresa1=@IdEmpresa 
delete [dbo].[in_movi_inven_X_imp_OrdCompraExterna] where imp_IdEmpresa=@IdEmpresa 
delete [dbo].[in_movi_inve_x_in_ordencompra_local] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_moviInventario_x_GestionProdLaminados_Cus_Talme] where mov_IdEmpresa=@IdEmpresa 
delete [dbo].[in_movi_inve_x_ct_cbteCble] where IdEmpresa=@IdEmpresa 


delete [dbo].[in_rptDispInve] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_rptMovi_Inv_x_prod_resumido] where IdEmpresa=@IdEmpresa 


delete [dbo].[in_PrecargaItemsOrdenCompra_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_PrecargaItemsOrdenCompra] where IdEmpresa=@IdEmpresa 

delete [dbo].[in_presupuesto_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_presupuesto] where IdEmpresa=@IdEmpresa 


delete [dbo].[in_recepcion_material_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_recepcion_material_cab] where IdEmpresa=@IdEmpresa 







delete [dbo].[in_Ing_Egr_Inven_det] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_Ing_Egr_Inven] where IdEmpresa=@IdEmpresa 





delete [dbo].[in_movi_inve_detalle] where IdEmpresa=@IdEmpresa 
delete from [dbo].[in_movi_inve] where IdEmpresa=@IdEmpresa 


delete [dbo].[in_producto_x_cp_proveedor] where IdEmpresa_prov =@IdEmpresa 
delete [dbo].[in_Producto_Composicion] where IdEmpresa=@IdEmpresa 
delete [dbo].[in_producto_x_tb_bodega] where IdEmpresa=@IdEmpresa 


return