CREATE view [Fj_servindustrias].[vwfa_liquidacion_x_punto_cargo_det_ing_egr_inven]
as
SELECT isnull(ROW_NUMBER() OVER (ORDER BY in_Ing_Egr_Inven_det.IdEmpresa), 0) AS IdRow, in_Ing_Egr_Inven_det.IdEmpresa, in_Ing_Egr_Inven_det.IdSucursal, in_Ing_Egr_Inven_det.IdMovi_inven_tipo, in_Ing_Egr_Inven_det.IdNumMovi, 
in_Ing_Egr_Inven_det.Secuencia, in_Ing_Egr_Inven_det.IdUnidadMedida, in_UnidadMedida.Descripcion AS nom_uni_medida, in_Ing_Egr_Inven_det.IdProducto, in_Producto.pr_codigo + ' - ' + in_Producto.pr_descripcion AS pr_descripcion, 
Fj_servindustrias.in_Ing_Egr_Inven_fj.cod_orden_mantenimiento, in_Motivo_Inven.Genera_Movi_Inven, in_Ing_Egr_Inven_det.dm_cantidad, in_Ing_Egr_Inven_det.IdPunto_cargo, 
CASE WHEN in_Ing_Egr_Inven.signo = '-' THEN isnull(0, 0) ELSE in_Ing_Egr_Inven_det.mv_costo END AS mv_costo, 
 in_Ing_Egr_Inven.signo, 
CASE WHEN EGR.IdEmpresa IS NULL AND ING.IdEmpresa IS NOT NULL THEN ING.IdEmpresa WHEN EGR.IdEmpresa IS NOT NULL AND ING.IdEmpresa IS NULL THEN EGR.IdEmpresa ELSE NULL END AS li_IdEmpresa, 
CASE WHEN EGR.IdEmpresa IS NULL AND ING.IdEmpresa IS NOT NULL THEN ING.IdSucursal WHEN EGR.IdEmpresa IS NOT NULL AND ING.IdEmpresa IS NULL THEN EGR.IdSucursal ELSE NULL END AS li_IdSucursal, 
CASE WHEN EGR.IdEmpresa IS NULL AND ING.IdEmpresa IS NOT NULL THEN ING.IdCentroCosto WHEN EGR.IdEmpresa IS NOT NULL AND ING.IdEmpresa IS NULL THEN EGR.IdCentroCosto ELSE NULL END AS li_IdCentroCosto, 
CASE WHEN EGR.IdEmpresa IS NULL AND ING.IdEmpresa IS NOT NULL THEN ING.IdLiquidacion WHEN EGR.IdEmpresa IS NOT NULL AND ING.IdEmpresa IS NULL THEN EGR.IdLiquidacion ELSE NULL END AS li_IdLiquidacion
FROM     in_Motivo_Inven INNER JOIN
                  in_Ing_Egr_Inven ON in_Motivo_Inven.IdEmpresa = in_Ing_Egr_Inven.IdEmpresa AND in_Motivo_Inven.IdMotivo_Inv = in_Ing_Egr_Inven.IdMotivo_Inv INNER JOIN
                  in_Ing_Egr_Inven_det INNER JOIN
                  in_UnidadMedida ON in_Ing_Egr_Inven_det.IdUnidadMedida = in_UnidadMedida.IdUnidadMedida INNER JOIN
                  in_Producto ON in_Ing_Egr_Inven_det.IdEmpresa = in_Producto.IdEmpresa AND in_Ing_Egr_Inven_det.IdProducto = in_Producto.IdProducto INNER JOIN
                  Fj_servindustrias.in_Ing_Egr_Inven_fj ON in_Ing_Egr_Inven_det.IdEmpresa = Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa AND in_Ing_Egr_Inven_det.IdSucursal = Fj_servindustrias.in_Ing_Egr_Inven_fj.IdSucursal AND 
                  in_Ing_Egr_Inven_det.IdMovi_inven_tipo = Fj_servindustrias.in_Ing_Egr_Inven_fj.IdMovi_inven_tipo AND in_Ing_Egr_Inven_det.IdNumMovi = Fj_servindustrias.in_Ing_Egr_Inven_fj.IdNumMovi ON 
                  in_Ing_Egr_Inven.IdEmpresa = in_Ing_Egr_Inven_det.IdEmpresa AND in_Ing_Egr_Inven.IdSucursal = in_Ing_Egr_Inven_det.IdSucursal AND in_Ing_Egr_Inven.IdMovi_inven_tipo = in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND 
                  in_Ing_Egr_Inven.IdNumMovi = in_Ing_Egr_Inven_det.IdNumMovi LEFT OUTER JOIN
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_egresos_inventario AS EGR ON in_Ing_Egr_Inven_det.IdEmpresa = EGR.inv_IdEmpresa AND in_Ing_Egr_Inven_det.IdSucursal = EGR.inv_IdSucursal AND 
                  in_Ing_Egr_Inven_det.IdMovi_inven_tipo = EGR.inv_IdMovi_inven_tipo AND in_Ing_Egr_Inven_det.IdNumMovi = EGR.inv_IdNumMovi AND in_Ing_Egr_Inven_det.Secuencia = EGR.inv_Secuencia LEFT OUTER JOIN
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo_det_ingresos_consumo_directo AS ING ON in_Ing_Egr_Inven_det.IdEmpresa = ING.inv_IdEmpresa AND in_Ing_Egr_Inven_det.IdSucursal = ING.inv_IdSucursal AND 
                  in_Ing_Egr_Inven_det.IdMovi_inven_tipo = ING.inv_IdMovi_inven_tipo AND in_Ing_Egr_Inven_det.IdNumMovi = ING.inv_IdNumMovi AND in_Ing_Egr_Inven_det.Secuencia = ING.inv_Secuencia
WHERE  (in_Ing_Egr_Inven.Estado = 'A')