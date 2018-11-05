
CREATE VIEW [dbo].[XXXPADRESDIFERENTESAHIJOS]
AS
select * from in_producto
where exists(
select * from in_Producto as f
where f.IdEmpresa = in_Producto.IdEmpresa
and f.IdProducto = in_producto.IdProducto_padre
and f.precio_1 <> in_Producto.precio_1
)