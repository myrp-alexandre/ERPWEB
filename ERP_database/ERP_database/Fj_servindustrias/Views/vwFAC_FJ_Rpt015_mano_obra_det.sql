CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt015_mano_obra_det]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdEmpresa), 0) AS IdRow, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdEmpresa, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdSucursal, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdCentroCosto, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdLiquidacion,Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.mo_secuencia, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdActividad, dbo.man_actividad.ac_descripcion
FROM     Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det INNER JOIN
                  dbo.man_actividad ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdEmpresa = dbo.man_actividad.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra_det.IdActividad = dbo.man_actividad.IdActividad