CREATE VIEW [Fj_servindustrias].[vwfa_pre_facturacion_det_compensacion]
AS
SELECT cuota_siguiente.IdEmpresa, cuota_siguiente.IdCompensacion, cuota_siguiente.secuencia_minima, cuota_siguiente.IdCentroCosto, cuota_siguiente.IdCentroCosto_sub_centro_costo, 
                  Fj_servindustrias.fa_compensacion_x_ct_centro_costo_det.valor_interes_diferencia
FROM     Fj_servindustrias.fa_compensacion_x_ct_centro_costo_det INNER JOIN
                      (SELECT det.IdEmpresa, det.IdCompensacion, MIN(det.Secuencia) AS secuencia_minima, cab.IdCentroCosto, cab.IdCentroCosto_sub_centro_costo
                       FROM      Fj_servindustrias.fa_compensacion_x_ct_centro_costo_det AS det INNER JOIN
                                         Fj_servindustrias.fa_compensacion_x_ct_centro_costo AS cab ON cab.IdEmpresa = det.IdEmpresa AND cab.IdCompensacion = det.IdCompensacion
                       WHERE   (det.IdPeriodo IS NULL) AND (det.num_mes <> 0) AND det.estado_cobro = 0
                       GROUP BY det.IdEmpresa, det.IdCompensacion, cab.IdCentroCosto, cab.IdCentroCosto_sub_centro_costo) AS cuota_siguiente ON 
                  cuota_siguiente.IdEmpresa = Fj_servindustrias.fa_compensacion_x_ct_centro_costo_det.IdEmpresa AND cuota_siguiente.IdCompensacion = Fj_servindustrias.fa_compensacion_x_ct_centro_costo_det.IdCompensacion AND 
                  cuota_siguiente.secuencia_minima = Fj_servindustrias.fa_compensacion_x_ct_centro_costo_det.Secuencia