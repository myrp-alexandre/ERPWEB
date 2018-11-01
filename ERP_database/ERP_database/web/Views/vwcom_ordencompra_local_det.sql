CREATE VIEW web.vwcom_ordencompra_local_det
AS
SELECT com_ordencompra_local_det.IdEmpresa, com_ordencompra_local_det.IdSucursal, com_ordencompra_local_det.IdOrdenCompra, com_ordencompra_local_det.Secuencia, com_ordencompra_local_det.IdProducto, 
                  com_ordencompra_local_det.do_Cantidad, com_ordencompra_local_det.do_precioCompra, com_ordencompra_local_det.do_porc_des, com_ordencompra_local_det.do_descuento, com_ordencompra_local_det.do_precioFinal, 
                  com_ordencompra_local_det.do_subtotal, com_ordencompra_local_det.do_iva, com_ordencompra_local_det.do_total, com_ordencompra_local_det.do_observacion, com_ordencompra_local_det.IdCentroCosto, 
                  com_ordencompra_local_det.IdCentroCosto_sub_centro_costo, com_ordencompra_local_det.IdPunto_cargo_grupo, com_ordencompra_local_det.IdPunto_cargo, com_ordencompra_local_det.IdUnidadMedida, 
                  com_ordencompra_local_det.Por_Iva, com_ordencompra_local_det.IdCod_Impuesto, in_Producto.pr_descripcion +' '+ in_presentacion.nom_presentacion pr_descripcion
FROM     in_presentacion INNER JOIN
                  in_Producto ON in_presentacion.IdEmpresa = in_Producto.IdEmpresa AND in_presentacion.IdPresentacion = in_Producto.IdPresentacion RIGHT OUTER JOIN
                  com_ordencompra_local_det ON in_Producto.IdEmpresa = com_ordencompra_local_det.IdEmpresa AND in_Producto.IdProducto = com_ordencompra_local_det.IdProducto