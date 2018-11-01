CREATE VIEW [Naturisa].[vwINV_NAT_Rpt001]
AS

SELECT        Guia.IdEmpresa, Guia.IdGuia, 'con_oc' AS TipoDetalle, Guia.secuencia, Guia.IdEmpresa_OC, Guia.IdSucursal_OC, Guia.IdOrdenCompra_OC, Guia.Secuencia_OC, 
                         Guia.observacion, prod.IdProducto AS IdProducto, Guia.Cantidad_enviar, prod.pr_descripcion AS nom_producto, oc_det.do_Cantidad AS CantOC, 
                         oc_det.do_observacion AS Observacion_OC, guia.Referencia AS Num_Fact, dbo.cp_proveedor.IdProveedor, pe_nombreCompleto AS nom_proveedor, 
                         dbo.in_Guia_x_traspaso_bodega.NumGuia, dbo.in_Guia_x_traspaso_bodega.IdSucursal_Partida, dbo.tb_sucursal.Su_Descripcion AS Nom_Sucursal_Partida, 
                         dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Partida, dbo.in_Guia_x_traspaso_bodega.IdSucursal_Llegada, 
                         tb_sucursal_1.Su_Descripcion AS Nom_Sucursal_LLegada, dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Llegada, dbo.in_Guia_x_traspaso_bodega.IdTransportista, 
                         dbo.tb_transportista.Nombre AS nom_transportista, dbo.tb_transportista.Cedula AS cedu_transportista, dbo.in_Guia_x_traspaso_bodega.Fecha, 
                         dbo.in_Guia_x_traspaso_bodega.Fecha_Traslado, dbo.in_Guia_x_traspaso_bodega.Fecha_llegada, dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado, 
                         dbo.in_Guia_x_traspaso_bodega.Hora_Traslado, dbo.in_Guia_x_traspaso_bodega.Hora_Llegada, dbo.in_Catalogo.Nombre AS nom_motivo, prod.pr_codigo
FROM            dbo.in_Guia_x_traspaso_bodega_det AS Guia INNER JOIN
                         dbo.com_ordencompra_local_det AS oc_det ON Guia.IdEmpresa_OC = oc_det.IdEmpresa AND Guia.IdSucursal_OC = oc_det.IdSucursal AND 
                         Guia.IdOrdenCompra_OC = oc_det.IdOrdenCompra AND Guia.Secuencia_OC = oc_det.Secuencia INNER JOIN
                         dbo.in_Producto AS prod ON oc_det.IdEmpresa = prod.IdEmpresa AND oc_det.IdProducto = prod.IdProducto INNER JOIN
                         dbo.in_Guia_x_traspaso_bodega ON Guia.IdEmpresa = dbo.in_Guia_x_traspaso_bodega.IdEmpresa AND 
                         Guia.IdGuia = dbo.in_Guia_x_traspaso_bodega.IdGuia INNER JOIN
                         dbo.tb_sucursal ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Partida = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_sucursal AS tb_sucursal_1 ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = tb_sucursal_1.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdEmpresa = tb_sucursal_1.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Llegada = tb_sucursal_1.IdSucursal INNER JOIN
                         dbo.tb_transportista ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_transportista.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdTransportista = dbo.tb_transportista.IdTransportista INNER JOIN
                         dbo.com_ordencompra_local ON oc_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND oc_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND 
                         oc_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.in_Catalogo ON dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado = dbo.in_Catalogo.IdCatalogo
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
UNION
SELECT        dbo.in_Guia_x_traspaso_bodega_det_sin_oc.IdEmpresa, dbo.in_Guia_x_traspaso_bodega_det_sin_oc.IdGuia, 'sin_oc' AS TipoDetalle, 
                         dbo.in_Guia_x_traspaso_bodega_det_sin_oc.secuencia, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3, NULL AS Expr4, 
                         dbo.in_Guia_x_traspaso_bodega_det_sin_oc.observacion, dbo.in_Guia_x_traspaso_bodega_det_sin_oc.IdProducto AS IdProducto, 
                         dbo.in_Guia_x_traspaso_bodega_det_sin_oc.Cantidad_enviar, dbo.in_Guia_x_traspaso_bodega_det_sin_oc.nom_producto AS nom_producto, NULL AS Expr5, NULL 
                         AS Expr6, dbo.in_Guia_x_traspaso_bodega_det_sin_oc.Num_Fact, dbo.in_Guia_x_traspaso_bodega_det_sin_oc.IdProveedor, 
                         dbo.in_Guia_x_traspaso_bodega_det_sin_oc.nom_proveedor AS nom_proveedor, dbo.in_Guia_x_traspaso_bodega.NumGuia, 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Partida, dbo.tb_sucursal.Su_Descripcion AS Nom_Sucursal_Partida, 
                         dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Partida, dbo.in_Guia_x_traspaso_bodega.IdSucursal_Llegada, 
                         tb_sucursal_1.Su_Descripcion AS Nom_Sucursal_LLegada, dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Llegada, dbo.in_Guia_x_traspaso_bodega.IdTransportista, 
                         dbo.tb_transportista.Nombre AS nom_transportista, dbo.tb_transportista.Cedula AS cedu_transportista, dbo.in_Guia_x_traspaso_bodega.Fecha, 
                         dbo.in_Guia_x_traspaso_bodega.Fecha_Traslado, dbo.in_Guia_x_traspaso_bodega.Fecha_llegada, dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado, 
                         dbo.in_Guia_x_traspaso_bodega.Hora_Traslado, dbo.in_Guia_x_traspaso_bodega.Hora_Llegada, dbo.in_Catalogo.Nombre AS nom_motivo, null as pr_codigo
FROM            dbo.in_Guia_x_traspaso_bodega_det_sin_oc INNER JOIN
                         dbo.in_Guia_x_traspaso_bodega ON dbo.in_Guia_x_traspaso_bodega_det_sin_oc.IdEmpresa = dbo.in_Guia_x_traspaso_bodega.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega_det_sin_oc.IdGuia = dbo.in_Guia_x_traspaso_bodega.IdGuia INNER JOIN
                         dbo.tb_sucursal ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Partida = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_sucursal AS tb_sucursal_1 ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = tb_sucursal_1.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdEmpresa = tb_sucursal_1.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Llegada = tb_sucursal_1.IdSucursal INNER JOIN
                         dbo.tb_transportista ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_transportista.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdTransportista = dbo.tb_transportista.IdTransportista INNER JOIN
                         dbo.in_Catalogo ON dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado = dbo.in_Catalogo.IdCatalogo