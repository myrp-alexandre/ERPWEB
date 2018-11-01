CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt004]
AS
SELECT        ISNULL(ROW_NUMBER() OVER(ORDER BY Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdEmpresa),0) AS IdRow, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdEmpresa, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdPreFacturacion, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.Secuencia, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_IdEmpresa, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_IdSucursal, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_IdMovi_inven_tipo, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_IdNumMovi, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_Secuencia, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_cantidad, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_fecha, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.eg_codigo, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.in_IdEmpresa, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.in_IdSucursal, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.in_IdMovi_inven_tipo, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.in_IdNumMovi, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.in_Secuencia, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.in_cantidad, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdProveedor, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.cp_fecha, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.cp_numero, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdActivoFijo, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.costo_uni, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.subtotal, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdProducto, 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdCentroCosto, Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdCentroCosto_sub_centro_costo, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
                         tb_persona.pe_nombreCompleto, ct_punto_cargo.nom_punto_cargo, ct_centro_costo_sub_centro_costo.Centro_costo
FROM            tb_persona INNER JOIN
                         cp_proveedor ON tb_persona.IdPersona = cp_proveedor.IdPersona AND tb_persona.IdPersona = cp_proveedor.IdPersona RIGHT OUTER JOIN
                         ct_punto_cargo INNER JOIN
                         Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo ON ct_punto_cargo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_PC AND 
                         ct_punto_cargo.IdPunto_cargo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC AND ct_punto_cargo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_PC AND 
                         ct_punto_cargo.IdPunto_cargo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC AND ct_punto_cargo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_PC AND 
                         ct_punto_cargo.IdPunto_cargo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC AND ct_punto_cargo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_PC AND 
                         ct_punto_cargo.IdPunto_cargo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC RIGHT OUTER JOIN
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven INNER JOIN
                         in_Producto ON Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdEmpresa = in_Producto.IdEmpresa AND Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdProducto = in_Producto.IdProducto LEFT OUTER JOIN
                         ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdCentroCosto_sub_centro_costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo ON 
                         Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdActivoFijo_AF = Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdActivoFijo AND 
                         Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_AF = Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdEmpresa ON 
                         cp_proveedor.IdEmpresa = Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdEmpresa AND cp_proveedor.IdProveedor = Fj_servindustrias.fa_pre_facturacion_det_ing_egr_inven.IdProveedor