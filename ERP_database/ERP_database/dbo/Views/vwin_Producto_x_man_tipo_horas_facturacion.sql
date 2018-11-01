CREATE VIEW vwin_Producto_x_man_tipo_horas_facturacion
AS
SELECT in_Producto.IdEmpresa, in_Producto.IdProducto, in_Producto.pr_codigo, in_Producto.pr_descripcion, in_Producto.pr_descripcion_2, in_Producto.IdProductoTipo, in_Producto.IdMarca, in_Producto.IdPresentacion, in_Producto.IdCategoria, 
                  in_Producto.IdLinea, in_Producto.IdGrupo, in_Producto.IdSubGrupo, in_Producto.IdUnidadMedida, in_Producto.IdUnidadMedida_Consumo, '' IdNaturaleza, 0 IdMotivo_Vta, in_Producto.pr_codigo_barra, 
                  in_Producto.pr_observacion, 0 pr_precio_publico, 
                  0 pr_stock_minimo, in_Producto.IdUsuario, in_Producto.Fecha_Transac, in_Producto.IdUsuarioUltMod, in_Producto.Fecha_UltMod, in_Producto.IdUsuarioUltAnu, in_Producto.Fecha_UltAnu, 
                  in_Producto.pr_motivoAnulacion, in_Producto.nom_pc, in_Producto.ip, in_Producto.Estado, in_Producto.IdCod_Impuesto_Iva, 
                   in_Producto.Aparece_modu_Ventas, in_Producto.Aparece_modu_Compras, in_Producto.Aparece_modu_Inventario, in_Producto.Aparece_modu_Activo_F
FROM     in_Producto INNER JOIN
                  man_tipo_horas_facturacion ON in_Producto.IdEmpresa = man_tipo_horas_facturacion.IdEmpresa AND in_Producto.IdProducto = man_tipo_horas_facturacion.IdProducto