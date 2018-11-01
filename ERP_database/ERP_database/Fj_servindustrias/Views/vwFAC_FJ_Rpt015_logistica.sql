CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt015_logistica]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica.IdEmpresa), 0) AS IdRow, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica.IdEmpresa, 
IdSucursal, IdCentroCosto, IdLiquidacion, lo_secuencia, lo_cantidad, lo_kilometros,Af_ruta.ru_descripcion lo_descripcion, 
lo_precio_uni_kilometro + lo_valor_ganancia AS lo_precio_uni_kilometro, lo_precio_total
FROM     Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica inner join
Af_ruta on Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica.IdEmpresa = Af_ruta.IdEmpresa
and Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_logistica.IdRuta = Af_ruta.IdRuta