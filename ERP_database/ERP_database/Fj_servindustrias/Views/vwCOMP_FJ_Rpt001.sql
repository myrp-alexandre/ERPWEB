

CREATE view Fj_servindustrias. vwCOMP_FJ_Rpt001 as 

SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_NumDocumento,  OC.IdTerminoPago, OC.oc_plazo AS Plazo, OC.oc_fecha AS Fecha,  
                         OC.oc_observacion AS Observacion, OC.Estado,  OC.IdComprador, OC.IdDepartamento, depar.de_descripcion AS departamento, OC_det.Secuencia, OC_det.IdProducto, 
                         OC_det.do_Cantidad AS cantidad, OC_det.do_precioCompra AS precio, OC_det.do_porc_des AS por_desc, OC_det.do_descuento AS valor_descuento, OC_det.do_subtotal AS subtotal, OC_det.do_iva AS iva, 
                         OC_det.do_total AS total,  Prod.pr_codigo AS cod_producto, Prod.pr_descripcion AS nom_producto, sucu.Su_Descripcion AS sucursal, empr.em_nombre AS empresa, 
                         empr.em_ruc AS ruc_empresa, empr.em_logo AS logo_empresa, '' AS nom_proveedor, per_prov.pe_cedulaRuc AS ced_ruc_provee, per_prov.pe_direccion AS direc_provee, 
                         null  AS telef_provee, dbo.in_UnidadMedida.Descripcion AS NomUnidad, dbo.com_comprador.Descripcion AS Nom_comprador, OC_det.IdCentroCosto, 
                         OC_det.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo.Centro_costo AS nom_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_sub_centro_costo, 
                         OC_det.do_observacion AS Detalle_x_Items, OC_det.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, empr.em_direccion, dbo.com_solicitante.nom_solicitante, 
                         dbo.com_Motivo_Orden_Compra.Descripcion, empr.em_telefonos, 'fjservindustrias@gmail.com' AS mail_empresa, sucu.Su_Direccion AS Direccion_sucu, sucu.Su_Telefonos AS Telef_Sucursal, 
                         '' AS Contacto_Prov, per_prov.pe_correo AS mail_prove, OC.IdEstadoAprobacion_cat, dbo.com_TerminoPago.Descripcion AS Nom_TerminoPago
FROM            dbo.com_solicitante RIGHT OUTER JOIN
                         dbo.in_UnidadMedida RIGHT OUTER JOIN
                         dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.com_ordencompra_local_det AS OC_det ON OC.IdEmpresa = OC_det.IdEmpresa AND OC.IdSucursal = OC_det.IdSucursal AND OC.IdOrdenCompra = OC_det.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor AS prove ON OC.IdEmpresa = prove.IdEmpresa AND OC.IdProveedor = prove.IdProveedor INNER JOIN
                         dbo.tb_sucursal AS sucu ON OC.IdEmpresa = sucu.IdEmpresa AND OC.IdSucursal = sucu.IdSucursal INNER JOIN
                         dbo.tb_empresa AS empr ON sucu.IdEmpresa = empr.IdEmpresa INNER JOIN
                         dbo.in_Producto AS Prod ON OC_det.IdEmpresa = Prod.IdEmpresa AND OC_det.IdProducto = Prod.IdProducto INNER JOIN
                         dbo.ro_Departamento AS depar ON OC.IdEmpresa = depar.IdEmpresa AND OC.IdDepartamento = depar.IdDepartamento INNER JOIN
                         dbo.tb_persona AS per_prov ON prove.IdPersona = per_prov.IdPersona INNER JOIN
                         dbo.com_comprador ON OC.IdEmpresa = dbo.com_comprador.IdEmpresa AND OC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_Motivo_Orden_Compra ON OC.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND OC.IdMotivo = dbo.com_Motivo_Orden_Compra.IdMotivo INNER JOIN
                         dbo.com_TerminoPago ON OC.IdTerminoPago = dbo.com_TerminoPago.IdTerminoPago LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON OC_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         OC_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo ON dbo.in_UnidadMedida.IdUnidadMedida = OC_det.IdUnidadMedida ON 
                         dbo.com_solicitante.IdEmpresa = OC.IdEmpresa AND dbo.com_solicitante.IdSolicitante = 1 LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON OC_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND OC_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON OC_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND OC_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto