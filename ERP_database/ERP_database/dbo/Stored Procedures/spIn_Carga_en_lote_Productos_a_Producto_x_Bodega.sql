
CREATE PROCEDURE spIn_Carga_en_lote_Productos_a_Producto_x_Bodega
(
 @IdEmpresa int
)
as
begin

INSERT INTO in_producto_x_tb_bodega
( IdEmpresa						, IdSucursal			, IdBodega			, IdProducto	
 )

SELECT        
in_Producto.IdEmpresa				,tb_bodega.IdSucursal	,tb_bodega.IdBodega	, IdProducto		
FROM            in_Producto INNER JOIN
                         in_subgrupo ON in_Producto.IdEmpresa = in_subgrupo.IdEmpresa AND in_Producto.IdCategoria = in_subgrupo.IdCategoria AND in_Producto.IdLinea = in_subgrupo.IdLinea AND 
                         in_Producto.IdGrupo = in_subgrupo.IdGrupo AND in_Producto.IdSubGrupo = in_subgrupo.IdSubgrupo INNER JOIN
                         tb_bodega ON in_Producto.IdEmpresa = tb_bodega.IdEmpresa
where not exists
			(

					select A.IdEmpresa 
					from in_producto_x_tb_bodega A
					where A.IdEmpresa=in_Producto.IdEmpresa
					and A.IdProducto=in_Producto.IdProducto
					and A.IdSucursal=tb_bodega.IdSucursal
					and A.IdBodega=tb_bodega.IdBodega

			)
and in_Producto.IdEmpresa=@IdEmpresa


end