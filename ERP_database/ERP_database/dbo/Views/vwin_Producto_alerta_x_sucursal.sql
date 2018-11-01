CREATE VIEW vwin_Producto_alerta_x_sucursal
AS
SELECT in_producto_x_tb_bodega.IdEmpresa, in_producto_x_tb_bodega.IdSucursal, in_producto_x_tb_bodega.IdProducto, isnull(in_Producto_alerta_x_sucursal.se_controla_stock_minimo,cast(0 as bit)) se_controla_stock_minimo, 
		isnull(in_Producto_alerta_x_sucursal.pr_stock_minimo,0)pr_stock_minimo, in_Producto_alerta_x_sucursal.observacion, in_Producto.pr_codigo, in_Producto.pr_descripcion
FROM     in_Producto_alerta_x_sucursal RIGHT OUTER JOIN
                  in_producto_x_tb_bodega INNER JOIN
                  in_Producto ON in_producto_x_tb_bodega.IdEmpresa = in_Producto.IdEmpresa AND in_producto_x_tb_bodega.IdProducto = in_Producto.IdProducto INNER JOIN
                  tb_sucursal ON in_producto_x_tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND in_producto_x_tb_bodega.IdSucursal = tb_sucursal.IdSucursal ON 
                  in_Producto_alerta_x_sucursal.IdProducto = in_producto_x_tb_bodega.IdProducto AND in_Producto_alerta_x_sucursal.IdSucursal = in_producto_x_tb_bodega.IdSucursal AND 
                  in_Producto_alerta_x_sucursal.IdEmpresa = in_producto_x_tb_bodega.IdEmpresa
GROUP BY in_Producto_alerta_x_sucursal.pr_stock_minimo, in_Producto_alerta_x_sucursal.observacion, in_Producto.pr_codigo, in_Producto.pr_descripcion, in_producto_x_tb_bodega.IdEmpresa, in_producto_x_tb_bodega.IdSucursal, 
                  in_producto_x_tb_bodega.IdProducto, in_Producto_alerta_x_sucursal.se_controla_stock_minimo