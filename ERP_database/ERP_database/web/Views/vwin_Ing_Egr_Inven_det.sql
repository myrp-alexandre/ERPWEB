CREATE VIEW web.vwin_Ing_Egr_Inven_det
AS
SELECT in_Ing_Egr_Inven_det.IdEmpresa, in_Ing_Egr_Inven_det.IdSucursal, in_Ing_Egr_Inven_det.IdMovi_inven_tipo, in_Ing_Egr_Inven_det.IdNumMovi, in_Ing_Egr_Inven_det.Secuencia, in_Ing_Egr_Inven_det.IdBodega, 
                  in_Ing_Egr_Inven_det.IdProducto, in_Ing_Egr_Inven_det.dm_cantidad, in_Ing_Egr_Inven_det.dm_observacion, in_Ing_Egr_Inven_det.mv_costo, in_Ing_Egr_Inven_det.IdCentroCosto, 
                  in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo, in_Ing_Egr_Inven_det.IdEstadoAproba, in_Ing_Egr_Inven_det.IdUnidadMedida, in_Ing_Egr_Inven_det.IdEmpresa_oc, in_Ing_Egr_Inven_det.IdSucursal_oc, 
                  in_Ing_Egr_Inven_det.IdOrdenCompra, in_Ing_Egr_Inven_det.Secuencia_oc, in_Ing_Egr_Inven_det.IdPunto_cargo_grupo, in_Ing_Egr_Inven_det.IdPunto_cargo, in_Ing_Egr_Inven_det.IdEmpresa_inv, in_Ing_Egr_Inven_det.IdSucursal_inv, 
                  in_Ing_Egr_Inven_det.IdBodega_inv, in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, in_Ing_Egr_Inven_det.IdNumMovi_inv, in_Ing_Egr_Inven_det.secuencia_inv, in_Ing_Egr_Inven_det.Motivo_Aprobacion, 
                  in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, in_Ing_Egr_Inven_det.mv_costo_sinConversion, in_Ing_Egr_Inven_det.IdMotivo_Inv, in_Producto.pr_descripcion, 
                  in_presentacion.nom_presentacion, in_Producto.lote_fecha_vcto, in_Producto.lote_num_lote
FROM     in_presentacion INNER JOIN
                  in_Producto ON in_presentacion.IdEmpresa = in_Producto.IdEmpresa AND in_presentacion.IdPresentacion = in_Producto.IdPresentacion RIGHT OUTER JOIN
                  in_Ing_Egr_Inven_det ON in_Producto.IdEmpresa = in_Ing_Egr_Inven_det.IdEmpresa AND in_Producto.IdProducto = in_Ing_Egr_Inven_det.IdProducto