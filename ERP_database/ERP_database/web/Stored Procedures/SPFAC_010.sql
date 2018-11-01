CREATE PROCEDURE WEB.SPFAC_010
(
@IdEmpresa int,
@IdProducto_ini numeric,
@IdProducto_fin numeric,
@IdCategoria varchar(20),
@IdLinea int,
@IdGrupo int,
@IdSubGrupo int,
@IdMarcaIni int,
@IdMarcaFin int
)
AS

delete [web].[fa_SPFAC_010]

INSERT INTO [web].[fa_SPFAC_010]
           ([IdEmpresa]
           ,[IdProducto]
           ,[IdProductoTipo]
           ,[IdMarca]
           ,[IdCategoria]
           ,[IdLinea]
           ,[IdGrupo]
           ,[IdSubGrupo]
           ,[IdPresentacion]
           ,[NomProducto]
           ,[NomPresentacion]
           ,[NomMarca]
           ,[NomTipoProducto]
           ,[NomCategoria]
           ,[NomLinea]
           ,[NomGrupo]
           ,[NomSubGrupo]
           ,[PRECIO1]
           ,[PRECIO2]
           ,[PRECIO3]
           ,[PRECIO4]
           ,[PRECIO5]
           ,[Estado])

SELECT        in_Producto.IdEmpresa, in_Producto.IdProducto, in_Producto.IdProductoTipo, in_Producto.IdMarca, in_Producto.IdCategoria, in_Producto.IdLinea, in_Producto.IdGrupo, in_Producto.IdSubGrupo, in_Producto.IdPresentacion, 
                         in_Producto.pr_descripcion AS NomProducto, in_presentacion.nom_presentacion AS NomPresentacion, in_Marca.Descripcion AS NomMarca, in_ProductoTipo.tp_descripcion AS NomTipoProducto, 
                         in_categorias.ca_Categoria AS NomCategoria, in_linea.nom_linea AS NomLinea, in_grupo.nom_grupo AS NomGrupo, in_subgrupo.nom_subgrupo AS NomSubGrupo, in_Producto.precio_1 AS PRECIO1, 
                         in_Producto.precio_2 AS PRECIO2, in_Producto.precio_3 AS PRECIO3, in_Producto.precio_4 AS PRECIO4, in_Producto.precio_5 AS PRECIO5, in_Producto.Estado
FROM            in_ProductoTipo RIGHT OUTER JOIN
                         in_Producto LEFT OUTER JOIN
                         in_Marca ON in_Producto.IdEmpresa = in_Marca.IdEmpresa AND in_Producto.IdMarca = in_Marca.IdMarca ON in_ProductoTipo.IdEmpresa = in_Producto.IdEmpresa AND 
                         in_ProductoTipo.IdProductoTipo = in_Producto.IdProductoTipo LEFT OUTER JOIN
                         in_presentacion ON in_Producto.IdEmpresa = in_presentacion.IdEmpresa AND in_Producto.IdPresentacion = in_presentacion.IdPresentacion LEFT OUTER JOIN
                         in_grupo INNER JOIN
                         in_subgrupo ON in_grupo.IdEmpresa = in_subgrupo.IdEmpresa AND in_grupo.IdCategoria = in_subgrupo.IdCategoria AND in_grupo.IdLinea = in_subgrupo.IdLinea AND in_grupo.IdGrupo = in_subgrupo.IdGrupo INNER JOIN
                         in_linea ON in_grupo.IdEmpresa = in_linea.IdEmpresa AND in_grupo.IdCategoria = in_linea.IdCategoria AND in_grupo.IdLinea = in_linea.IdLinea INNER JOIN
                         in_categorias ON in_linea.IdEmpresa = in_categorias.IdEmpresa AND in_linea.IdCategoria = in_categorias.IdCategoria ON in_Producto.IdEmpresa = in_subgrupo.IdEmpresa AND 
                         in_Producto.IdCategoria = in_subgrupo.IdCategoria AND in_Producto.IdLinea = in_subgrupo.IdLinea AND in_Producto.IdGrupo = in_subgrupo.IdGrupo AND in_Producto.IdSubGrupo = in_subgrupo.IdSubgrupo
WHERE        (in_Producto.IdProducto_padre IS NULL) AND (in_Producto.Estado = 'A') AND in_Producto.IdEmpresa = @IdEmpresa AND in_Producto.IdMarca BETWEEN @IdMarcaIni AND @IdMarcaFin AND in_Producto.IdProducto BETWEEN @IdProducto_ini AND @IdProducto_fin


BEGIN --FILTRO POR CATEGORIZACION
	IF(@IdCategoria != '')
	BEGIN
		IF(@IdLinea != 0)
			BEGIN
				IF(@IdGrupo != 0)
					BEGIN
						IF(@IdSubGrupo != 0)
							BEGIN
								DELETE [web].[fa_SPFAC_010] 
								WHERE IdCategoria !=  @IdCategoria
								AND IdLinea != @IdLinea
								AND IdGrupo != @IdGrupo
								AND IdSubGrupo != @IdSubGrupo
							END
						ELSE
							DELETE [web].[fa_SPFAC_010] 
							WHERE IdCategoria !=  @IdCategoria
							AND IdLinea != @IdLinea
							AND IdGrupo != @IdGrupo

					END
				ELSE
					DELETE [web].[fa_SPFAC_010] 
					WHERE IdCategoria != @IdCategoria
					AND IdLinea != @IdLinea
			END
		ELSE
			DELETE [web].[fa_SPFAC_010] 
			WHERE IdCategoria <> @IdCategoria

	END
END

SELECT * FROM [web].[fa_SPFAC_010]