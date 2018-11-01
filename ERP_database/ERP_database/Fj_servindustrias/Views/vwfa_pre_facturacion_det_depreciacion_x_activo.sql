CREATE VIEW Fj_servindustrias.vwfa_pre_facturacion_det_depreciacion_x_activo
AS
SELECT Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdActivoFijo, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdPeriodo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Valor_Depreciacion
FROM     Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo ON 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdActivoFijo = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdActivoFijo AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa