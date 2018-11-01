CREATE view [dbo].[vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det_x_cp_Aprobacion_Ing_Bod_x_OC_det]
as
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY IdEmpresa), 0) AS IdRow, IdEmpresa, IdSucursal, IdNumMovi, Secuencia, IdBodega, IdProducto, nom_producto, dm_cantidad, mv_costo, do_porc_des,  
dm_stock_ante, dm_stock_actu, dm_peso, dm_observacion, dm_precio, IdUnidadMedida, nom_medida, nom_sucursal, nom_bodega, IdEmpresa_oc, IdSucursal_oc, IdOrdenCompra, Secuencia_oc, IdEstadoAproba, 
IdPunto_cargo, nom_punto_cargo, signo, nom_tipo_inv, IdMovi_inven_tipo, nom_motivo, IdEmpresa_inv, IdSucursal_inv, IdBodega_inv, IdMovi_inven_tipo_inv, IdNumMovi_inv, secuencia_inv, IdProveedor, 
nom_proveedor, cm_fecha, Por_Iva, Dias, IdTerminoPago, Descripcion, es_Inven_o_Consumo, IdCtaCble_Gasto_x_cxp AS IdCtaCtble_Gasto_x_cxp_x_Produc, IdCtaCble_Inven_x_Produc, IdCtaCtble_Inve_x_Bodega, 
IdCtaCble_Inven_x_Motivo, IdCtaCble_Costo_x_Motivo, IdCategoria, IdLinea, IdGrupo, IdSubGrupo, IdCentroCosto, IdCentroCosto_sub_centro_costo, IdPunto_cargo_grupo
FROM            vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det AS S
WHERE        NOT EXISTS
                             (SELECT        A.IdEmpresa
                               FROM            cp_Aprobacion_Ing_Bod_x_OC_det A
                               WHERE        A.IdEmpresa_Ing_Egr_Inv = S.IdEmpresa AND A.IdSucursal_Ing_Egr_Inv = S.IdSucursal AND A.IdMovi_inven_tipo_Ing_Egr_Inv = S.IdMovi_inven_tipo AND 
                                                         A.IdNumMovi_Ing_Egr_Inv = S.IdNumMovi AND A.Secuencia_Ing_Egr_Inv = S.Secuencia)