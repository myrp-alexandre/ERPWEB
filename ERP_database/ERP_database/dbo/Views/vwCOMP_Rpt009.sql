CREATE VIEW [dbo].[vwCOMP_Rpt009]
AS
SELECT ISNULL(ROW_NUMBER() OVER(ORDER BY dbo.com_solicitud_compra_det.IdEmpresa),0) AS IdRow, dbo.com_solicitud_compra_det.IdEmpresa, dbo.com_solicitud_compra_det.IdSucursal, dbo.com_solicitud_compra_det.IdSolicitudCompra, dbo.com_solicitud_compra_det.Secuencia, dbo.com_solicitud_compra.fecha AS fecha_sol, 
                  dbo.com_solicitante.IdSolicitante, dbo.com_solicitante.nom_solicitante, CASE WHEN com_solicitud_compra_det.IdProducto IS NULL AND com_ordencompra_local_det.IdProducto IS NULL THEN NULL 
                  WHEN com_solicitud_compra_det.IdProducto IS NOT NULL THEN in_Producto_sol.pr_codigo WHEN com_ordencompra_local_det.IdProducto IS NOT NULL THEN in_Producto_com.pr_codigo END AS pr_codigo, 
                  CASE WHEN com_solicitud_compra_det.IdProducto IS NULL AND com_ordencompra_local_det.IdProducto IS NULL THEN 0 WHEN com_solicitud_compra_det.IdProducto IS NOT NULL 
                  THEN com_solicitud_compra_det.IdProducto WHEN com_ordencompra_local_det.IdProducto IS NOT NULL THEN com_ordencompra_local_det.IdProducto END AS IdProducto, CASE WHEN com_solicitud_compra_det.IdProducto IS NULL 
                  AND com_ordencompra_local_det.IdProducto IS NULL THEN com_solicitud_compra_det.NomProducto WHEN com_solicitud_compra_det.IdProducto IS NOT NULL 
                  THEN in_Producto_sol.pr_descripcion WHEN com_ordencompra_local_det.IdProducto IS NOT NULL THEN in_Producto_com.pr_descripcion END AS nom_producto, dbo.com_solicitud_compra_det.do_Cantidad AS cantidad_sol, 
                  dbo.com_solicitud_compra_det.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdEmpresa, 
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdSucursal, dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdOrdenCompra, 
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_Secuencia, dbo.com_ordencompra_local.IdProveedor, dbo.tb_persona.pe_nombreCompleto, dbo.com_ordencompra_local.oc_fecha AS fecha_oc, 
                  dbo.com_ordencompra_local_det.do_Cantidad AS cantidad_com, dbo.com_ordencompra_local_det.do_precioCompra, MAX(dbo.in_Ing_Egr_Inven.cm_fecha) AS fecha_inv, SUM(dbo.in_Ing_Egr_Inven_det.dm_cantidad) 
                  AS cantidad_inv
FROM     dbo.com_solicitante INNER JOIN
                  dbo.com_solicitud_compra INNER JOIN
                  dbo.com_solicitud_compra_det ON dbo.com_solicitud_compra.IdEmpresa = dbo.com_solicitud_compra_det.IdEmpresa AND dbo.com_solicitud_compra.IdSucursal = dbo.com_solicitud_compra_det.IdSucursal AND 
                  dbo.com_solicitud_compra.IdSolicitudCompra = dbo.com_solicitud_compra_det.IdSolicitudCompra ON dbo.com_solicitante.IdEmpresa = dbo.com_solicitud_compra.IdEmpresa AND 
                  dbo.com_solicitante.IdSolicitante = dbo.com_solicitud_compra.IdSolicitante LEFT OUTER JOIN
                  dbo.in_Producto AS in_Producto_sol ON dbo.com_solicitud_compra_det.IdEmpresa = in_Producto_sol.IdEmpresa AND dbo.com_solicitud_compra_det.IdProducto = in_Producto_sol.IdProducto LEFT OUTER JOIN
                  dbo.in_Ing_Egr_Inven INNER JOIN
                  dbo.in_Ing_Egr_Inven_det ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND 
                  dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi RIGHT OUTER JOIN
                  dbo.cp_proveedor INNER JOIN
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det INNER JOIN
                  dbo.com_ordencompra_local_det INNER JOIN
                  dbo.com_ordencompra_local ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND dbo.com_ordencompra_local_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND 
                  dbo.com_ordencompra_local_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra ON dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_Secuencia = dbo.com_ordencompra_local_det.Secuencia ON dbo.cp_proveedor.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                  dbo.cp_proveedor.IdProveedor = dbo.com_ordencompra_local.IdProveedor INNER JOIN
                  dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                  dbo.in_Producto AS in_Producto_com ON dbo.com_ordencompra_local_det.IdEmpresa = in_Producto_com.IdEmpresa AND dbo.com_ordencompra_local_det.IdProducto = in_Producto_com.IdProducto ON 
                  dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                  dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia ON 
                  dbo.com_solicitud_compra_det.IdEmpresa = dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.scd_IdEmpresa AND 
                  dbo.com_solicitud_compra_det.IdSucursal = dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.scd_IdSucursal AND 
                  dbo.com_solicitud_compra_det.IdSolicitudCompra = dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.scd_IdSolicitudCompra AND 
                  dbo.com_solicitud_compra_det.Secuencia = dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.scd_Secuencia LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.com_solicitud_compra_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo
GROUP BY dbo.com_solicitud_compra_det.IdEmpresa, dbo.com_solicitud_compra_det.IdSucursal, dbo.com_solicitud_compra_det.IdSolicitudCompra, dbo.com_solicitud_compra_det.Secuencia, dbo.com_solicitud_compra.fecha, 
                  dbo.com_solicitante.IdSolicitante, dbo.com_solicitante.nom_solicitante, dbo.com_solicitud_compra_det.IdProducto, dbo.com_ordencompra_local_det.IdProducto, in_Producto_sol.pr_codigo, in_Producto_com.pr_codigo, 
                  dbo.com_solicitud_compra_det.NomProducto, in_Producto_sol.pr_descripcion, in_Producto_com.pr_descripcion, dbo.com_solicitud_compra_det.do_Cantidad, dbo.com_solicitud_compra_det.IdPunto_cargo, 
                  dbo.ct_punto_cargo.nom_punto_cargo, dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdEmpresa, dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdSucursal, 
                  dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_IdOrdenCompra, dbo.com_ordencompra_local_det_x_com_solicitud_compra_det.ocd_Secuencia, dbo.com_ordencompra_local.IdProveedor, 
                  dbo.tb_persona.pe_nombreCompleto, dbo.com_ordencompra_local.oc_fecha, dbo.com_ordencompra_local_det.do_Cantidad, dbo.com_ordencompra_local_det.do_precioCompra