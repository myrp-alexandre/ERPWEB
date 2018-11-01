CREATE VIEW [dbo].[vwINV_Rpt007]
AS
SELECT        ROW_NUMBER() OVER (ORDER BY A.IdEmpresa) AS IdRow, * FROM            (

   SELECT       a.IdEmpresa, a.IdAjusteFisico, a.CodAjusteFisico, a.IdSucursal, a.IdBodega, a.IdNumMovi_Ing, a.IdMovi_inven_tipo_Ing, a.IdNumMovi_Egr, a.IdMovi_inven_tipo_Egr, b.IdProducto, c.pr_codigo, 
							c.pr_descripcion, b.StockFisico, b.StockSistema, b.CantidadAjustada, a.IdEstadoAprobacion, D .Nombre AS nom_estado_aprobacion, a.Observacion, a.Fecha, a.Estado, b.IdCentroCosto, 
							dbo.in_categorias.IdCategoria, dbo.in_categorias.ca_Categoria, dbo.in_linea.IdLinea, dbo.in_linea.nom_linea, dbo.ct_centro_costo.Centro_costo, 
							in_movi_inven_tipo_1.tm_descripcion AS Tipo_ingreso, dbo.in_movi_inven_tipo.tm_descripcion AS Tipo_egreso, dbo.tb_bodega.bo_Descripcion, dbo.tb_sucursal.Su_Descripcion, 
							dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida, dbo.vwin_producto_Ult_Costo_Hist_x_Bod.costo, dbo.vwin_producto_Ult_Costo_Hist_x_Bod.costo * b.CantidadAjustada Total_costo
	FROM            dbo.in_categorias INNER JOIN
							dbo.in_linea ON dbo.in_categorias.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_categorias.IdCategoria = dbo.in_linea.IdCategoria INNER JOIN
							dbo.in_ajusteFisico AS a INNER JOIN
							dbo.in_AjusteFisico_Detalle AS b INNER JOIN
							dbo.in_Producto AS c ON b.IdEmpresa = c.IdEmpresa AND b.IdProducto = c.IdProducto ON a.IdEmpresa = b.IdEmpresa AND a.IdAjusteFisico = b.IdAjusteFisico INNER JOIN
							dbo.in_Catalogo AS D ON a.IdEstadoAprobacion = D .IdCatalogo ON dbo.in_linea.IdEmpresa = c.IdEmpresa AND dbo.in_linea.IdCategoria = c.IdCategoria AND 
							dbo.in_linea.IdLinea = c.IdLinea INNER JOIN
							dbo.in_movi_inven_tipo AS in_movi_inven_tipo_1 ON a.IdEmpresa = in_movi_inven_tipo_1.IdEmpresa AND a.IdMovi_inven_tipo_Ing = in_movi_inven_tipo_1.IdMovi_inven_tipo INNER JOIN
							dbo.in_movi_inven_tipo ON a.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND a.IdMovi_inven_tipo_Egr = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
							dbo.tb_bodega ON a.IdEmpresa = dbo.tb_bodega.IdEmpresa AND a.IdSucursal = dbo.tb_bodega.IdSucursal AND a.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
							dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
							dbo.in_UnidadMedida ON c.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida AND c.IdUnidadMedida_Consumo = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
							dbo.vwin_producto_Ult_Costo_Hist_x_Bod ON a.IdEmpresa = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdEmpresa AND a.IdSucursal = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdSucursal AND 
							a.IdBodega = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdBodega AND b.IdProducto = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdProducto LEFT OUTER JOIN
							dbo.ct_centro_costo ON b.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND b.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto
	WHERE        a.IdNumMovi_Egr IS NULL AND a.IdNumMovi_Ing IS NULL
	                          UNION All
	SELECT       a.IdEmpresa, a.IdAjusteFisico, a.CodAjusteFisico, a.IdSucursal, a.IdBodega, a.IdNumMovi_Ing, a.IdMovi_inven_tipo_Ing, a.IdNumMovi_Egr, a.IdMovi_inven_tipo_Egr, b.IdProducto, c.pr_codigo, 
							c.pr_descripcion, b.StockFisico, b.StockSistema, b.CantidadAjustada, a.IdEstadoAprobacion, D .Nombre AS nom_estado_aprobacion, a.Observacion, a.Fecha, a.Estado, b.IdCentroCosto, 
							dbo.in_categorias.IdCategoria, dbo.in_categorias.ca_Categoria, dbo.in_linea.IdLinea, dbo.in_linea.nom_linea, dbo.ct_centro_costo.Centro_costo, 
							in_movi_inven_tipo_1.tm_descripcion AS Tipo_ingreso, dbo.in_movi_inven_tipo.tm_descripcion AS Tipo_egreso, dbo.tb_bodega.bo_Descripcion, dbo.tb_sucursal.Su_Descripcion, 
							dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida, dbo.in_Ing_Egr_Inven_det.mv_costo, dbo.in_Ing_Egr_Inven_det.mv_costo * b.CantidadAjustada
	FROM            dbo.in_categorias INNER JOIN
							dbo.in_linea ON dbo.in_categorias.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_categorias.IdCategoria = dbo.in_linea.IdCategoria INNER JOIN
							dbo.in_ajusteFisico AS a INNER JOIN
							dbo.in_AjusteFisico_Detalle AS b INNER JOIN
							dbo.in_Producto AS c ON b.IdEmpresa = c.IdEmpresa AND b.IdProducto = c.IdProducto ON a.IdEmpresa = b.IdEmpresa AND a.IdAjusteFisico = b.IdAjusteFisico INNER JOIN
							dbo.in_Catalogo AS D ON a.IdEstadoAprobacion = D .IdCatalogo ON dbo.in_linea.IdEmpresa = c.IdEmpresa AND dbo.in_linea.IdCategoria = c.IdCategoria AND 
							dbo.in_linea.IdLinea = c.IdLinea INNER JOIN
							dbo.in_movi_inven_tipo AS in_movi_inven_tipo_1 ON a.IdEmpresa = in_movi_inven_tipo_1.IdEmpresa AND a.IdMovi_inven_tipo_Ing = in_movi_inven_tipo_1.IdMovi_inven_tipo INNER JOIN
							dbo.in_movi_inven_tipo ON a.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND a.IdMovi_inven_tipo_Egr = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
							dbo.tb_bodega ON a.IdEmpresa = dbo.tb_bodega.IdEmpresa AND a.IdSucursal = dbo.tb_bodega.IdSucursal AND a.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
							dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
							dbo.in_UnidadMedida ON c.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida AND c.IdUnidadMedida_Consumo = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
							dbo.in_Ing_Egr_Inven_det ON a.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND a.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND 
							a.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega AND a.IdMovi_inven_tipo_Ing = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND a.IdNumMovi_Ing = dbo.in_Ing_Egr_Inven_det.IdNumMovi AND 
							b.IdProducto = dbo.in_Ing_Egr_Inven_det.IdProducto LEFT OUTER JOIN
							dbo.ct_centro_costo ON b.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND b.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto
	UNION ALL
	SELECT        a.IdEmpresa, a.IdAjusteFisico, a.CodAjusteFisico, a.IdSucursal, a.IdBodega, a.IdNumMovi_Ing, a.IdMovi_inven_tipo_Ing, a.IdNumMovi_Egr, a.IdMovi_inven_tipo_Egr, b.IdProducto, c.pr_codigo, 
							c.pr_descripcion, b.StockFisico, b.StockSistema, b.CantidadAjustada, a.IdEstadoAprobacion, D .Nombre AS nom_estado_aprobacion, a.Observacion, a.Fecha, a.Estado, b.IdCentroCosto, 
							dbo.in_categorias.IdCategoria, dbo.in_categorias.ca_Categoria, dbo.in_linea.IdLinea, dbo.in_linea.nom_linea, dbo.ct_centro_costo.Centro_costo, 
							in_movi_inven_tipo_1.tm_descripcion AS Tipo_ingreso, dbo.in_movi_inven_tipo.tm_descripcion AS Tipo_egreso, dbo.tb_bodega.bo_Descripcion, dbo.tb_sucursal.Su_Descripcion, 
							dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida, in_Ing_Egr_Inven_det.mv_costo, dbo.in_Ing_Egr_Inven_det.mv_costo * b.CantidadAjustada
	FROM            dbo.in_categorias INNER JOIN
							dbo.in_linea ON dbo.in_categorias.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_categorias.IdCategoria = dbo.in_linea.IdCategoria INNER JOIN
							dbo.in_ajusteFisico AS a INNER JOIN
							dbo.in_AjusteFisico_Detalle AS b INNER JOIN
							dbo.in_Producto AS c ON b.IdEmpresa = c.IdEmpresa AND b.IdProducto = c.IdProducto ON a.IdEmpresa = b.IdEmpresa AND a.IdAjusteFisico = b.IdAjusteFisico INNER JOIN
							dbo.in_Catalogo AS D ON a.IdEstadoAprobacion = D .IdCatalogo ON dbo.in_linea.IdEmpresa = c.IdEmpresa AND dbo.in_linea.IdCategoria = c.IdCategoria AND 
							dbo.in_linea.IdLinea = c.IdLinea INNER JOIN
							dbo.in_movi_inven_tipo AS in_movi_inven_tipo_1 ON a.IdEmpresa = in_movi_inven_tipo_1.IdEmpresa AND a.IdMovi_inven_tipo_Ing = in_movi_inven_tipo_1.IdMovi_inven_tipo INNER JOIN
							dbo.in_movi_inven_tipo ON a.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND a.IdMovi_inven_tipo_Egr = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
							dbo.tb_bodega ON a.IdEmpresa = dbo.tb_bodega.IdEmpresa AND a.IdSucursal = dbo.tb_bodega.IdSucursal AND a.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
							dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
							dbo.in_UnidadMedida ON c.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida AND c.IdUnidadMedida_Consumo = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
							dbo.in_Ing_Egr_Inven_det ON a.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND a.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND 
							b.IdProducto = dbo.in_Ing_Egr_Inven_det.IdProducto AND a.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega AND a.IdMovi_inven_tipo_Egr = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND 
							a.IdNumMovi_Egr = dbo.in_Ing_Egr_Inven_det.IdNumMovi LEFT OUTER JOIN
							dbo.ct_centro_costo ON b.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND b.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto

) A