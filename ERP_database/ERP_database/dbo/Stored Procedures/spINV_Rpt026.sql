
--exec [dbo].[spINV_Rpt026] 1,1,99999,2,2,'01/08/2016','31/08/2016'


CREATE PROCEDURE [dbo].[spINV_Rpt026]
(
@IdEmpresa int,
@IdSucursal_ini int,
@IdSucursal_fin int,
@IdBodega_ini int,
@IdBodega_fin int,
@Fecha_ini Datetime, 
@Fecha_fin datetime 
)
AS
BEGIN
/*


declare @IdEmpresa int
declare @IdSucursal_ini int
declare @IdSucursal_fin int
declare @IdBodega_ini int
declare @IdBodega_fin int
declare @Fecha_ini Datetime
declare @Fecha_fin datetime 



set @IdEmpresa =1
set @IdSucursal_ini =1
set @IdSucursal_fin =1
set @IdBodega_ini =2
set @IdBodega_fin =2
set @Fecha_ini ='01/01/2017'
set @Fecha_fin ='31/01/2017'

*/


DELETE [dbo].[in_INV_Rpt026]

--INSERTO SALDO INICIAL

INSERT INTO [dbo].[in_INV_Rpt026]
           ([IdEmpresa]           ,[IdSucursal]           ,[IdBodega]				,[IdProducto]            ,[Fecha_ini]
           ,[Fecha_fin]           ,[pr_codigo]            ,[nom_producto]           ,[IdCategoria]           ,[nom_categoria]
           ,[IdLinea]             ,[nom_linea]            ,[Saldo_inicial]          ,[Ingresos]              ,[Egresos]
           ,[Saldo_final]         ,[IdUnidadMedida]       ,[nom_unidad_medida]		,[nom_Sucursal]			 ,[nom_Bodega]
		   ,[costo_inicial]		  ,[costo_ingresos]		  ,[costo_egresos]			,[costo_final])
	  
SELECT        in_movi_inve.IdEmpresa, in_movi_inve.IdSucursal, in_movi_inve.IdBodega, in_movi_inve_detalle.IdProducto, @Fecha_ini AS Expr1, @Fecha_fin AS Expr2, 
                         in_Producto.pr_codigo, in_Producto.pr_descripcion, in_categorias.IdCategoria, in_categorias.ca_Categoria, in_linea.IdLinea, in_linea.nom_linea, 
                         SUM(ISNULL(in_movi_inve_detalle.dm_cantidad, 0)) AS Expr3, 0 AS Expr4, 0 AS Expr5, 0 AS Expr6, in_UnidadMedida.IdUnidadMedida, 
                         in_UnidadMedida.Descripcion, tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion, 
						 sum(Costo_historico.costo* in_movi_inve_detalle.dm_cantidad) costo_inicial, 0 costo_ingresos, 0 costo_egresos, 0 costo_final
FROM            in_movi_inve INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi INNER JOIN
                         in_Producto ON in_movi_inve_detalle.IdEmpresa = in_Producto.IdEmpresa AND in_movi_inve_detalle.IdProducto = in_Producto.IdProducto INNER JOIN
                         in_UnidadMedida ON in_Producto.IdUnidadMedida = in_UnidadMedida.IdUnidadMedida INNER JOIN
                         in_linea ON in_Producto.IdEmpresa = in_linea.IdEmpresa AND in_Producto.IdCategoria = in_linea.IdCategoria AND in_Producto.IdLinea = in_linea.IdLinea INNER JOIN
                         in_categorias ON in_linea.IdEmpresa = in_categorias.IdEmpresa AND in_linea.IdCategoria = in_categorias.IdCategoria INNER JOIN
                         tb_bodega ON in_movi_inve.IdEmpresa = tb_bodega.IdEmpresa AND in_movi_inve.IdSucursal = tb_bodega.IdSucursal AND 
                         in_movi_inve.IdBodega = tb_bodega.IdBodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
						 (
							select * from (
							select
							his.IdEmpresa,
							his.IdSucursal,
							his.IdBodega,
							his.IdProducto,
							his.costo,
							row_number() over(partition by his.IdProducto order by his.fecha desc) as rn
		
							from
							in_producto_x_tb_bodega_Costo_Historico as his
							where his.fecha <= @Fecha_fin 
							) t
							where t.rn = 1
						 ) Costo_historico ON in_movi_inve_detalle.IdEmpresa = Costo_historico.IdEmpresa and in_movi_inve_detalle.IdSucursal = Costo_historico.IdSucursal and
						 in_movi_inve_detalle.IdBodega = Costo_historico.IdBodega and in_movi_inve_detalle.IdProducto = Costo_historico.IdProducto
WHERE        (in_movi_inve.cm_fecha < @Fecha_ini) AND (in_movi_inve.IdSucursal BETWEEN @IdSucursal_ini AND @IdSucursal_fin) AND (in_movi_inve.IdBodega BETWEEN 
                         @IdBodega_ini AND @IdBodega_fin)
GROUP BY in_movi_inve.IdEmpresa, in_movi_inve.IdSucursal, in_movi_inve.IdBodega, in_movi_inve_detalle.IdProducto, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
                         in_categorias.IdCategoria, in_categorias.ca_Categoria, in_linea.IdLinea, in_linea.nom_linea, in_UnidadMedida.IdUnidadMedida, in_UnidadMedida.Descripcion, 
                         tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion
--HAVING SUM(ISNULL(in_movi_inve_detalle.dm_cantidad, 0)) <> 0

-- INSERTO INGRESOS Y EGRESOS QUE NO TENGAN SALDO INICIAL

INSERT INTO [dbo].[in_INV_Rpt026]
           ([IdEmpresa]           ,[IdSucursal]           ,[IdBodega]				,[IdProducto]            ,[Fecha_ini]
           ,[Fecha_fin]           ,[pr_codigo]            ,[nom_producto]           ,[IdCategoria]           ,[nom_categoria]
           ,[IdLinea]             ,[nom_linea]            ,[Saldo_inicial]          ,[Ingresos]              ,[Egresos]
           ,[Saldo_final]         ,[IdUnidadMedida]       ,[nom_unidad_medida]		,[nom_Sucursal]			 ,[nom_Bodega]
		   ,[costo_inicial]		  ,[costo_ingresos]		  ,[costo_egresos]			,[costo_final])
	
		   
SELECT        in_movi_inve.IdEmpresa, in_movi_inve.IdSucursal, in_movi_inve.IdBodega, in_movi_inve_detalle.IdProducto, @Fecha_ini AS Expr1, @Fecha_fin AS Expr2, 
                         in_Producto.pr_codigo, in_Producto.pr_descripcion, in_categorias.IdCategoria, in_categorias.ca_Categoria, in_linea.IdLinea, in_linea.nom_linea, 
                         0, SUM(iif(in_movi_inve_detalle.dm_cantidad > 0, in_movi_inve_detalle.dm_cantidad,0)) as Ingresos,
						 SUM(iif(in_movi_inve_detalle.dm_cantidad < 0, in_movi_inve_detalle.dm_cantidad,0)) as Egresos, 0 AS Expr6, in_UnidadMedida.IdUnidadMedida, 
                         in_UnidadMedida.Descripcion, tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion,
						 0, SUM(iif(in_movi_inve_detalle.dm_cantidad > 0, Costo_historico.costo* in_movi_inve_detalle.dm_cantidad,0)),
						 SUM(iif(in_movi_inve_detalle.dm_cantidad < 0, Costo_historico.costo * in_movi_inve_detalle.dm_cantidad,0)),0 
FROM            in_movi_inve INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi INNER JOIN
                         in_Producto ON in_movi_inve_detalle.IdEmpresa = in_Producto.IdEmpresa AND in_movi_inve_detalle.IdProducto = in_Producto.IdProducto INNER JOIN
                         in_UnidadMedida ON in_Producto.IdUnidadMedida = in_UnidadMedida.IdUnidadMedida INNER JOIN
                         in_linea ON in_Producto.IdEmpresa = in_linea.IdEmpresa AND in_Producto.IdCategoria = in_linea.IdCategoria AND in_Producto.IdLinea = in_linea.IdLinea INNER JOIN
                         in_categorias ON in_linea.IdEmpresa = in_categorias.IdEmpresa AND in_linea.IdCategoria = in_categorias.IdCategoria INNER JOIN
                         tb_bodega ON in_movi_inve.IdEmpresa = tb_bodega.IdEmpresa AND in_movi_inve.IdSucursal = tb_bodega.IdSucursal AND 
                         in_movi_inve.IdBodega = tb_bodega.IdBodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
						 (
							select * from (
							select
							his.IdEmpresa,
							his.IdSucursal,
							his.IdBodega,
							his.IdProducto,
							his.costo,
							row_number() over(partition by his.IdProducto order by his.fecha desc) as rn
		
							from
							in_producto_x_tb_bodega_Costo_Historico as his
							where his.fecha <= @Fecha_fin 
							) t
							where t.rn = 1
						 ) Costo_historico ON in_movi_inve_detalle.IdEmpresa = Costo_historico.IdEmpresa and in_movi_inve_detalle.IdSucursal = Costo_historico.IdSucursal and
						 in_movi_inve_detalle.IdBodega = Costo_historico.IdBodega and in_movi_inve_detalle.IdProducto = Costo_historico.IdProducto
WHERE        (in_movi_inve.cm_fecha between @Fecha_ini and @Fecha_fin) AND (in_movi_inve.IdSucursal BETWEEN @IdSucursal_ini AND @IdSucursal_fin) AND (in_movi_inve.IdBodega BETWEEN 
                         @IdBodega_ini AND @IdBodega_fin) AND NOT EXISTS(
						 Select A.IdEmpresa,A.IdSucursal,A.IdBodega,A.IdProducto from in_INV_Rpt026 A where 
						 A.IdEmpresa = in_movi_inve_detalle.IdEmpresa and
						 a.IdSucursal = in_movi_inve_detalle.IdSucursal and
						 a.IdBodega = in_movi_inve_detalle.IdBodega and
						 a.IdProducto = in_movi_inve_detalle.IdProducto
						 GROUP BY A.IdEmpresa,A.IdSucursal,A.IdBodega,A.IdProducto
						 )
GROUP BY in_movi_inve.IdEmpresa, in_movi_inve.IdSucursal, in_movi_inve.IdBodega, in_movi_inve_detalle.IdProducto, in_Producto.pr_codigo, in_Producto.pr_descripcion, 
                         in_categorias.IdCategoria, in_categorias.ca_Categoria, in_linea.IdLinea, in_linea.nom_linea, in_UnidadMedida.IdUnidadMedida, in_UnidadMedida.Descripcion, 
                         tb_sucursal.Su_Descripcion, tb_bodega.bo_Descripcion
--HAVING SUM(ISNULL(in_movi_inve_detalle.dm_cantidad, 0)) <> 0


--return

--ACTUALIZO INGRESOS Y EGRESOS
UPDATE [dbo].[in_INV_Rpt026]
   SET [Ingresos] = A.Ingresos
      ,[Egresos] = A.Egresos      
	  ,[costo_ingresos] = A.costo_ingresos
	  ,[costo_egresos] = A.costo_egresos	  
FROM(
SELECT        in_movi_inve.IdEmpresa, in_movi_inve.IdSucursal, in_movi_inve.IdBodega, in_movi_inve_detalle.IdProducto, 
                         SUM(iif(in_movi_inve_detalle.dm_cantidad > 0, in_movi_inve_detalle.dm_cantidad,0)) as Ingresos, SUM(iif(in_movi_inve_detalle.dm_cantidad < 0, in_movi_inve_detalle.dm_cantidad,0)) as Egresos,
						 sum(isnull(in_movi_inve_detalle.dm_cantidad,0)) as Saldo,SUM(iif(in_movi_inve_detalle.dm_cantidad > 0, Costo_historico.costo* in_movi_inve_detalle.dm_cantidad,0)) costo_ingresos,
						 SUM(iif(in_movi_inve_detalle.dm_cantidad < 0, Costo_historico.costo * in_movi_inve_detalle.dm_cantidad,0)) costo_egresos
FROM            in_movi_inve INNER JOIN
                         in_movi_inve_detalle ON in_movi_inve.IdEmpresa = in_movi_inve_detalle.IdEmpresa AND in_movi_inve.IdSucursal = in_movi_inve_detalle.IdSucursal AND 
                         in_movi_inve.IdBodega = in_movi_inve_detalle.IdBodega AND in_movi_inve.IdMovi_inven_tipo = in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         in_movi_inve.IdNumMovi = in_movi_inve_detalle.IdNumMovi 
						 INNER JOIN
						 (
							select * from (
							select
							his.IdEmpresa,
							his.IdSucursal,
							his.IdBodega,
							his.IdProducto,
							his.costo,
							row_number() over(partition by his.IdProducto order by his.fecha desc) as rn
		
							from
							in_producto_x_tb_bodega_Costo_Historico as his
							where his.fecha <= @Fecha_fin 
							) t
							where t.rn = 1
						 ) Costo_historico ON in_movi_inve_detalle.IdEmpresa = Costo_historico.IdEmpresa and in_movi_inve_detalle.IdSucursal = Costo_historico.IdSucursal and
						 in_movi_inve_detalle.IdBodega = Costo_historico.IdBodega and in_movi_inve_detalle.IdProducto = Costo_historico.IdProducto
WHERE			(in_movi_inve.cm_fecha between @Fecha_ini and @Fecha_fin) and (in_movi_inve.IdSucursal between @IdSucursal_ini and @IdSucursal_fin) and (in_movi_inve.IdBodega between @IdBodega_ini and @IdBodega_fin) 
group by in_movi_inve.IdEmpresa, in_movi_inve.IdSucursal, in_movi_inve.IdBodega, in_movi_inve_detalle.IdProducto
) A
where [dbo].[in_INV_Rpt026].IdEmpresa = A.IdEmpresa
and [dbo].[in_INV_Rpt026].IdSucursal = A.IdSucursal
and [dbo].[in_INV_Rpt026].IdBodega = A.IdBodega
and [dbo].[in_INV_Rpt026].IdProducto = A.IdProducto
and (A.Ingresos <> 0 or A.Egresos <>0)

UPDATE [dbo].[in_INV_Rpt026]
   SET costo_final = costo_inicial + costo_ingresos + costo_egresos ,
   Saldo_final = Saldo_inicial + Ingresos + Egresos 
   where (Saldo_inicial + Ingresos + Egresos ) <> 0

select * from [dbo].[in_INV_Rpt026] WHERE costo_inicial <> 0 OR costo_final <> 0 OR costo_egresos <>0 OR costo_ingresos <> 0
end