


CREATE procedure [dbo].[spINV_Rpt018]
(
 @i_IdEmpresa int
,@i_IdSucursalIni int
,@i_IdSucursalFin int
,@i_IdBodegaIni int
,@i_IdBodegaFin int
,@i_IdProductoIni int
,@i_IdProductoFin int
,@i_FechaIni datetime
,@i_FechaFin datetime
,@i_dias_stock int
,@i_Mostrar_reg_en_cero bit
)
as

/*
declare @i_IdEmpresa int
declare @i_IdSucursalIni int
declare @i_IdSucursalFin int
declare @i_IdBodegaIni int
declare @i_IdBodegaFin int
declare @i_IdProductoIni int
declare @i_IdProductoFin int
declare @i_FechaIni datetime
declare @i_FechaFin datetime
declare @i_dias_stock int


set @i_IdEmpresa =1
set @i_IdSucursalIni =1
set @i_IdSucursalFin =100
set @i_IdBodegaIni =1
set @i_IdBodegaFin =100
set @i_IdProductoIni =1
set @i_IdProductoFin =90000
set @i_FechaIni =DATEADD(month,-1, getdate())
set @i_FechaFin =getdate()
set @i_dias_stock=10
*/

declare @w_Intervalo_dias int

set @w_Intervalo_dias = DATEDIFF(day, @i_FechaIni,@i_FechaFin)




--select @i_FechaIni,@i_FechaFin

delete tbINV_Rpt018

--drop table tbINV_Rpt018

--create table tbINV_Rpt018
--(IdEmpresa int
--,IdSucursal int
--,IdBodega int
--,Idproducto numeric
--,cod_producto varchar(50)
--,nom_producto varchar(150)
--,nom_sucursal varchar(150)
--,nom_bodega varchar(150)
--,egresos float
--,stock_fecha_desde float
--,stock_fecha_hasta float
--,promedio float
--,indice float
--,stock_minimo float
--,stock_hoy float
--,cant_a_comprar float
--)

insert into tbINV_Rpt018
(IdEmpresa,		IdSucursal,		IdBodega,	Idproducto ,	cod_producto ,	nom_producto,		nom_sucursal,	nom_bodega ,	egresos
,stock_fecha_desde,	stock_fecha_hasta,	promedio,	indice,	stock_minimo,	stock_hoy,	cant_a_comprar )
select 
a.IdEmpresa,	B.IdSucursal,	B.IdBodega, a.IdProducto,	a.pr_codigo,	a.pr_descripcion,	'',				'',				0,				
0,					0,					0,			0,		0,				0,			0
from in_Producto A,in_producto_x_tb_bodega B
where A.IdEmpresa=B.IdEmpresa
and A.IdProducto=B.IdProducto
and A.IdEmpresa=@i_IdEmpresa
and B.IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin
and B.IdBodega between @i_IdBodegaIni and @i_IdBodegaFin
and A.IdProducto between @i_IdProductoIni and @i_IdProductoFin




------------------------ opteniendo los egresos entre rango de fecha -------------------------


update tbINV_Rpt018
set egresos=TEgresos.dm_cantidad*-1
from 
tbINV_Rpt018 as Rot
,	(	
			select A.IdEmpresa,A.IdSucursal,A.IdBodega, B.IdProducto,sum(B.dm_cantidad) as dm_cantidad from in_movi_inve A
			,in_movi_inve_detalle B
			where A.IdEmpresa=B.IdEmpresa
			and A.IdSucursal=B.IdSucursal
			and A.IdBodega=B.IdBodega
			and A.IdMovi_inven_tipo=B.IdMovi_inven_tipo
			and A.IdNumMovi=b.IdNumMovi
			and A.IdEmpresa=B.IdEmpresa
			and A.IdEmpresa=@i_IdEmpresa
			and B.IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin
			and B.IdBodega between @i_IdBodegaIni and @i_IdBodegaFin
			and B.IdProducto between @i_IdProductoIni and @i_IdProductoFin
			and A.cm_fecha between @i_FechaIni and @i_FechaFin
			and A.cm_tipo='-'
			group by A.IdEmpresa,A.IdSucursal,A.IdBodega,B.IdProducto
) TEgresos
where Rot.IdEmpresa=TEgresos.IdEmpresa
and Rot.IdSucursal=TEgresos.IdSucursal
and Rot.IdBodega=TEgresos.IdBodega
and Rot.Idproducto=TEgresos.IdProducto



			--------------------- stock a la fecha Desde -----------------
			update tbINV_Rpt018
			set stock_fecha_desde=TEgresos.stock_fecha
			from 
			tbINV_Rpt018 as Rot
			,	(	
						select A.IdEmpresa,A.IdSucursal,A.IdBodega, B.IdProducto,sum(B.dm_cantidad) as stock_fecha from in_movi_inve A
						,in_movi_inve_detalle B
						where A.IdEmpresa=B.IdEmpresa
						and A.IdSucursal=B.IdSucursal
						and A.IdBodega=B.IdBodega
						and A.IdMovi_inven_tipo=B.IdMovi_inven_tipo
						and A.IdNumMovi=b.IdNumMovi
						and A.IdEmpresa=B.IdEmpresa
						and A.IdEmpresa=@i_IdEmpresa
						and B.IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin
						and B.IdBodega between @i_IdBodegaIni and @i_IdBodegaFin
						and B.IdProducto between @i_IdProductoIni and @i_IdProductoFin
						and A.cm_fecha <=@i_FechaIni 
						group by A.IdEmpresa,A.IdSucursal,A.IdBodega,B.IdProducto
			) TEgresos
			where Rot.IdEmpresa=TEgresos.IdEmpresa
			and Rot.IdSucursal=TEgresos.IdSucursal
			and Rot.IdBodega=TEgresos.IdBodega
			and Rot.Idproducto=TEgresos.IdProducto



			--------------------- stock a la fecha hasta -----------------
			update tbINV_Rpt018
			set stock_fecha_hasta=TEgresos.stock_fecha
			from 
			tbINV_Rpt018 as Rot
			,	(	
						select A.IdEmpresa,A.IdSucursal,A.IdBodega, B.IdProducto,sum(B.dm_cantidad) as stock_fecha from in_movi_inve A
						,in_movi_inve_detalle B
						where A.IdEmpresa=B.IdEmpresa
						and A.IdSucursal=B.IdSucursal
						and A.IdBodega=B.IdBodega
						and A.IdMovi_inven_tipo=B.IdMovi_inven_tipo
						and A.IdNumMovi=b.IdNumMovi
						and A.IdEmpresa=B.IdEmpresa
						and A.IdEmpresa=@i_IdEmpresa
						and B.IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin
						and B.IdBodega between @i_IdBodegaIni and @i_IdBodegaFin
						and B.IdProducto between @i_IdProductoIni and @i_IdProductoFin
						and A.cm_fecha <=@i_FechaFin
						group by A.IdEmpresa,A.IdSucursal,A.IdBodega,B.IdProducto
			) TEgresos
			where Rot.IdEmpresa=TEgresos.IdEmpresa
			and Rot.IdSucursal=TEgresos.IdSucursal
			and Rot.IdBodega=TEgresos.IdBodega
			and Rot.Idproducto=TEgresos.IdProducto




update tbINV_Rpt018
set  promedio = (stock_fecha_desde+stock_fecha_hasta)/2
			

update tbINV_Rpt018
set  indice  = promedio/egresos
where egresos<>0


update tbINV_Rpt018
set  indice  = 0
where egresos=0


update tbINV_Rpt018
set  stock_minimo =(egresos/@w_Intervalo_dias)*@i_dias_stock
where @w_Intervalo_dias<>0



update  tbINV_Rpt018 
set  stock_hoy =prod.Stock
from tbINV_Rpt018 rot	
,vwIn_Producto_Stock prod
where rot.IdEmpresa=prod.IdEmpresa
and rot.IdSucursal=prod.IdSucursal
and rot.IdBodega=prod.IdBodega
and rot.Idproducto=prod.IdProducto


update tbINV_Rpt018
set  cant_a_comprar =stock_minimo-stock_hoy

update tbINV_Rpt018
set nom_sucursal =sucu.Su_Descripcion
from tb_sucursal sucu, tbINV_Rpt018 rot
where rot.IdEmpresa=sucu.IdEmpresa
and rot.IdSucursal=sucu.IdSucursal

update tbINV_Rpt018
set nom_bodega =bod.bo_Descripcion
from tb_bodega bod, tbINV_Rpt018 rot
where rot.IdEmpresa=bod.IdEmpresa
and rot.IdSucursal=bod.IdSucursal
and rot.IdBodega=bod.IdBodega

if (@i_Mostrar_reg_en_cero=0)
begin
	delete FROM            tbINV_Rpt018 where stock_minimo=0
end 


SELECT        IdEmpresa, IdSucursal, IdBodega, Idproducto, cod_producto, nom_producto, nom_sucursal, nom_bodega, egresos, stock_fecha_desde, stock_fecha_hasta, promedio, indice, stock_minimo, 
                         stock_hoy, cant_a_comprar
FROM            tbINV_Rpt018