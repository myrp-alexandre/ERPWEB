CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt002]
AS
SELECT Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdPreFacturacion, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.secuencia, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentro_Costo, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentroCosto_sub_centro_costo, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdPunto_cargo, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa_ct, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTipoCbte_ct, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCbteCble_ct, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Cantidad, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Costo_Uni, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Subtotal, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Por_Iva, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Valor_Iva, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Total, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Valor_a_cobrar, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Facturar, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTarifario, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Porc_ganancia, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.num_documento, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.nom_proveedor, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                  dbo.ct_punto_cargo.nom_punto_cargo, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Fecha_documento, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Observacion, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTipoMovi_grupo, dbo.caj_Caja_Movimiento_Tipo_grupo.tg_descripcion
FROM     Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos LEFT OUTER JOIN
                  dbo.caj_Caja_Movimiento_Tipo_grupo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTipoMovi_grupo = dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                  dbo.ct_centro_costo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentro_Costo = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentro_Costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo