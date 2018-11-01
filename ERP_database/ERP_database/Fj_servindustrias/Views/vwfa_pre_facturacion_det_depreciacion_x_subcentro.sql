CREATE VIEW Fj_servindustrias.vwfa_pre_facturacion_det_depreciacion_x_subcentro
AS
SELECT Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdActivoFijo, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo, 
                  isnull(ct_centro_costo_sub_centro_costo.Valor_depreciacion,0) Valor_depreciacion
FROM     ct_centro_costo_sub_centro_costo INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo ON ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa AND 
                  ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto AND 
                  ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo