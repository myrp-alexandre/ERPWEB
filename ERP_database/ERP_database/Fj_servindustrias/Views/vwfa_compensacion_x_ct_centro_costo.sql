CREATE VIEW Fj_servindustrias.vwfa_compensacion_x_ct_centro_costo
AS
SELECT Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdEmpresa, Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdCompensacion, Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdCentroCosto, 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_compensacion_x_ct_centro_costo.observacion, Fj_servindustrias.fa_compensacion_x_ct_centro_costo.valor_a_financiar, 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.num_cuotas_meses_x_centro_costo, Fj_servindustrias.fa_compensacion_x_ct_centro_costo.num_cuotas_meses_x_banco, 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.tasa_interes_anual_x_centro_costo, Fj_servindustrias.fa_compensacion_x_ct_centro_costo.tasa_interes_anual_x_banco, 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.estado, ct_centro_costo.Centro_costo AS nom_Centro_costo, ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo
FROM     Fj_servindustrias.fa_compensacion_x_ct_centro_costo INNER JOIN
                  ct_centro_costo ON Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdEmpresa = ct_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdCentroCosto = ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                  ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo.IdCentroCosto_sub_centro_costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo