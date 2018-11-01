CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt015_ingresos_egresos]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM     (SELECT Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdEmpresa, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdSucursal, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdCentroCosto, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdLiquidacion, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.eg_secuencia, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.eg_cantidad, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.eg_precio_uni + Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.eg_valor_ganancia AS eg_precio_uni, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.eg_precio_total, dbo.in_Producto.pr_descripcion, dbo.in_UnidadMedida.Descripcion AS nom_uni_medida, 'EGR' AS Tipo, in_Producto.pr_codigo
                  FROM      Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario INNER JOIN
                                    dbo.in_UnidadMedida ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                                    dbo.in_Producto ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario.IdProducto = dbo.in_Producto.IdProducto
                  UNION
                  SELECT Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdEmpresa, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdSucursal, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdCentroCosto, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdLiquidacion, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.in_secuencia, Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.in_cantidad, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.in_precio_uni + Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.in_valor_ganancia AS eg_precio_uni, 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.in_precio_total, dbo.in_Producto.pr_descripcion, dbo.in_UnidadMedida.Descripcion, 'ING' AS Expr1, in_Producto.pr_codigo
                  FROM     Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo INNER JOIN
                                    dbo.in_UnidadMedida ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                                    dbo.in_Producto ON Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdProducto = dbo.in_Producto.IdProducto AND 
                                    Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo.IdEmpresa = dbo.in_Producto.IdEmpresa) A