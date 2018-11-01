CREATE VIEW [dbo].[vwcp_Orden_Giro_Conciliado_x_Ing_Bod_x_OC] AS
SELECT det.IdEmpresa, det.IdAprobacion, conci.IdEmpresa AS IdEmpresaConciliacion, conci.IdConciliacion , det.Secuencia  , det.IdEmpresa_Ing_Egr_Inv, det.IdSucursal_Ing_Egr_Inv, det.IdNumMovi_Ing_Egr_Inv,
		det.Secuencia_Ing_Egr_Inv, vwin_Ing_Egr.IdBodega, vwin_Ing_Egr.cm_fecha as  Fecha_Ing_Bod, vwin_Ing_Egr.IdProducto, vwin_Ing_Egr.nom_producto, vwin_Ing_Egr.IdUnidadMedida, vwin_Ing_Egr.nom_medida,
		vwin_Ing_Egr.nom_bodega, vwin_Ing_Egr.nom_sucursal, det.Cantidad, det.Costo_uni, vwin_Ing_Egr.do_porc_des,  cab.IdProveedor, pe_nombreCompleto pr_nombre,
		vwin_Ing_Egr.IdOrdenCompra
FROM dbo.cp_Aprobacion_Ing_Bod_x_OC_det det INNER JOIN 
			dbo.cp_Aprobacion_Ing_Bod_x_OC  cab ON det.IdEmpresa = cab.IdEmpresa AND det.IdAprobacion = cab.IdAprobacion INNER JOIN 
			cp_Conciliacion_Ing_Bodega_x_Orden_Giro conci ON conci.IdEmpresa_Apro_Ing = cab.IdEmpresa AND conci.IdAprobacion_Apro_Ing = cab.IdAprobacion INNER JOIN 
			dbo.cp_proveedor AS pro ON cab.IdEmpresa = pro.IdEmpresa AND cab.IdProveedor = pro.IdProveedor  INNER JOIN 
			vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det AS vwin_Ing_Egr ON det.IdEmpresa_Ing_Egr_Inv = vwin_Ing_Egr.IdEmpresa AND 
            det.IdSucursal_Ing_Egr_Inv = vwin_Ing_Egr.IdSucursal AND det.IdNumMovi_Ing_Egr_Inv = vwin_Ing_Egr.IdNumMovi AND 
            det.Secuencia_Ing_Egr_Inv = vwin_Ing_Egr.Secuencia inner join tb_persona as per on per.IdPersona = pro.IdPersona