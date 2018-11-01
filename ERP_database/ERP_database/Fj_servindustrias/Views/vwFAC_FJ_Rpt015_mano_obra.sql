CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt015_mano_obra]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdEmpresa), 0) AS IdRow,
Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdEmpresa, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdSucursal, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdCentroCosto, 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdLiquidacion, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.mo_secuencia, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdTecnico, 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.mo_horas, in_Producto.pr_descripcion AS mo_descripcion, 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.mo_precio_uni + Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.mo_valor_ganancia AS mo_precio_uni, 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.mo_precio_total, man_actividad.ac_codigo, man_actividad.ac_descripcion, man_tecnico.te_codigo, 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdProducto, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdActividad, man_tipo_horas_facturacion.ti_codigo
FROM     Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra INNER JOIN
                  in_Producto ON in_Producto.IdEmpresa = Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdProducto = in_Producto.IdProducto INNER JOIN
                  man_actividad ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdEmpresa = man_actividad.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdActividad = man_actividad.IdActividad INNER JOIN
                  man_tecnico ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdEmpresa = man_tecnico.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_mano_obra.IdTecnico = man_tecnico.IdTecnico INNER JOIN
                  man_tipo_horas_facturacion ON in_Producto.IdEmpresa = man_tipo_horas_facturacion.IdEmpresa AND in_Producto.IdProducto = man_tipo_horas_facturacion.IdProducto