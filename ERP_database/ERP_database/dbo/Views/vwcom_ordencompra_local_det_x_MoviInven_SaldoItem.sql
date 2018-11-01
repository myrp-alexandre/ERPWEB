

/* select * from com_ordencompra_local_det_x_MoviInven_SaldoItem */
CREATE VIEW [dbo].[vwcom_ordencompra_local_det_x_MoviInven_SaldoItem]
AS
SELECT     B.IdEmpresa, B.IdSucursal, B.IdOrdenCompra, B.Secuencia, B.IdProducto, ISNULL(AVG(B.do_Cantidad), 0) AS do_CantidadOC, ISNULL(SUM(D.dm_cantidad), 0) 
                      AS dm_cantidad_Inv, AVG(B.do_Cantidad) - ISNULL(SUM(D.dm_cantidad), 0) AS SaldoxRecibir, per.pe_nombreCompleto pr_nombre, 
                      dbo.com_ordencompra_local.IdProveedor, dbo.com_ordencompra_local.Estado, dbo.com_ordencompra_local.oc_fecha, 
                      dbo.com_ordencompra_local.oc_NumDocumento, dbo.com_ordencompra_local.oc_observacion, 
                      dbo.com_ordencompra_local.MotivoAnulacion, dbo.com_ordencompra_local.MotivoReprobacion, dbo.com_ordencompra_local.co_fechaReproba, 
                      dbo.com_ordencompra_local.IdUsuario_Reprue, dbo.com_ordencompra_local.IdUsuario_Aprueba, dbo.com_ordencompra_local.co_fecha_aprobacion
FROM         dbo.com_ordencompra_local INNER JOIN
                      dbo.com_ordencompra_local_det AS B ON dbo.com_ordencompra_local.IdEmpresa = B.IdEmpresa AND dbo.com_ordencompra_local.IdSucursal = B.IdSucursal AND 
                      dbo.com_ordencompra_local.IdOrdenCompra = B.IdOrdenCompra INNER JOIN
                      dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                      dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor LEFT OUTER JOIN
                      dbo.in_movi_inve_detalle AS D INNER JOIN
                      dbo.in_movi_inve_detalle_x_com_ordencompra_local_det AS C ON D.IdEmpresa = C.mi_IdEmpresa AND D.IdSucursal = C.mi_IdSucursal AND 
                      D.IdBodega = C.mi_IdBodega AND D.IdMovi_inven_tipo = C.mi_IdMovi_inven_tipo AND D.IdNumMovi = C.mi_IdNumMovi AND D.Secuencia = C.mi_Secuencia ON 
                      B.IdProducto = D.IdProducto AND B.IdEmpresa = C.ocd_IdEmpresa AND B.IdSucursal = C.ocd_IdSucursal AND B.IdOrdenCompra = C.ocd_IdOrdenCompra AND 
                      B.Secuencia = C.ocd_Secuencia INNER JOIN 
					  tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
GROUP BY B.IdEmpresa, B.IdSucursal, B.IdOrdenCompra, B.Secuencia, B.IdProducto, per.pe_nombreCompleto, dbo.com_ordencompra_local.IdProveedor, 
                      dbo.com_ordencompra_local.Estado, dbo.com_ordencompra_local.oc_fecha, dbo.com_ordencompra_local.oc_NumDocumento, 
                      dbo.com_ordencompra_local.oc_observacion, D.IdProducto,  dbo.com_ordencompra_local.MotivoAnulacion, 
                      dbo.com_ordencompra_local.MotivoReprobacion, dbo.com_ordencompra_local.co_fechaReproba, dbo.com_ordencompra_local.IdUsuario_Reprue, 
                      dbo.com_ordencompra_local.IdUsuario_Aprueba, dbo.com_ordencompra_local.co_fecha_aprobacion