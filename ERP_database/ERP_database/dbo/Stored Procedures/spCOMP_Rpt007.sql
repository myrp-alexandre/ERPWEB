
-- exec spCOMP_Rpt007 1,0,9999,'11/01/2016'

CREATE proc [dbo].[spCOMP_Rpt007]
(
 @i_IdEmpresa int
,@i_IdSucursalIni int
,@i_IdSucursalFin int
,@i_FechaCorte datetime
)
as


declare  @w_fechaMes_Anterior  datetime 
declare @Count int

delete [dbo].[tbCOMP_Rpt007]

INSERT INTO [dbo].[tbCOMP_Rpt007]
([IdEmpresa]		,[IdSucursal]		,[IdProducto]		,[nom_producto], [Cod_Producto], [Fecha_Corte]
--,[IdMes1_anio]		,[IdMes2_anio]		,[IdMes3_anio]		,[IdMes4_anio]
--,[Nom_Mes1_anio]	,[Nom_Mes2_anio]	,[Nom_Mes3_anio]	,[Nom_Mes4_anio]
,[Cant_Mes1_anio]	,[Cant_Mes2_anio]	,[Cant_Mes3_anio]	,[Cant_Mes4_anio]
,[Prom_cant_x_comp], [stock_a_la_fecha], [varianza]
)
select distinct
A.IdEmpresa	,B.IdSucursal		,A.IdProducto		,A.pr_descripcion, A.pr_codigo, @i_FechaCorte
,0,0,0,0,0,0,0
from in_Producto A,in_producto_x_tb_bodega B
where A.IdEmpresa=B.IdEmpresa
and A.IdProducto=B.IdProducto
and A.IdEmpresa=@i_IdEmpresa
and B.IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin



--



set @Count=1

declare @w_IdPeriodo int
declare @w_IdAnio int
declare @w_IdMes int
declare @w_nom_mesn varchar(20)

declare @w_SQL nvarchar(max)

while (@Count<=4)
begin


set @w_fechaMes_Anterior   = dateadd(month,-@Count, @i_FechaCorte)
 

 select @w_IdPeriodo=A.idperiodo,@w_nom_mesn=B.Nemonico,@w_IdAnio =A.IdanioFiscal,@w_IdMes=A.pe_mes
 from ct_periodo A ,tb_mes B
 where 
 A.pe_mes=b.idmes
 and A.idempresa=@i_IdEmpresa
 and @w_fechaMes_Anterior between A.pe_fechaIni and A.pe_fechaFin

			

			 set @w_SQL ='update [tbCOMP_Rpt007]'
			 set @w_SQL = @w_SQL  + ' set [IdMes' + cast(@Count as varchar(20)) +'_anio]=' + cast( @w_IdPeriodo as varchar(20)) 
			 set @w_SQL = @w_SQL  + ',[Nom_Mes' + cast(@Count as varchar(20))  +'_anio]=''' + @w_nom_mesn +'-'+ cast(@w_IdAnio as varchar(20))+''''
			 

			 exec sp_executesql @w_SQL

			
			set @w_SQL =''
			
			set @w_SQL ='update [tbCOMP_Rpt007] '
			set @w_SQL = @w_SQL  + ' set Cant_Mes'+cast(@Count as varchar(20))+'_anio=A.do_Cantidad'
			set @w_SQL = @w_SQL  + ' from '
			set @w_SQL = @w_SQL  + ' ('
					set @w_SQL = @w_SQL  + ' SELECT       ' 
					set @w_SQL = @w_SQL  + ' com_ordencompra_local.IdEmpresa, com_ordencompra_local.IdSucursal, com_ordencompra_local_det.IdProducto, SUM(com_ordencompra_local_det.do_Cantidad)  AS do_Cantidad '
					set @w_SQL = @w_SQL  + ' ,(year( com_ordencompra_local.oc_fecha)*100)+month( com_ordencompra_local.oc_fecha) as IdPeriodo '
					set @w_SQL = @w_SQL  + ' FROM            com_ordencompra_local INNER JOIN com_ordencompra_local_det ON com_ordencompra_local.IdEmpresa = com_ordencompra_local_det.IdEmpresa '
					set @w_SQL = @w_SQL  + ' AND  com_ordencompra_local.IdSucursal = com_ordencompra_local_det.IdSucursal '
					set @w_SQL = @w_SQL  + ' AND  com_ordencompra_local.IdOrdenCompra = com_ordencompra_local_det.IdOrdenCompra '
					set @w_SQL = @w_SQL  + ' where				com_ordencompra_local.IdEmpresa= '+cast(@i_IdEmpresa as varchar(20))	  
					set @w_SQL = @w_SQL  + ' and  year( com_ordencompra_local.oc_fecha)= '+cast( @w_IdAnio as varchar(20))
					set @w_SQL = @w_SQL  + ' and  month( com_ordencompra_local.oc_fecha)= '+cast(@w_IdMes  as varchar(20))
					set @w_SQL = @w_SQL  + ' GROUP BY com_ordencompra_local.IdEmpresa, com_ordencompra_local.IdSucursal, com_ordencompra_local_det.IdProducto '
					set @w_SQL = @w_SQL  + ' ,(year( com_ordencompra_local.oc_fecha)*100)+month( com_ordencompra_local.oc_fecha) '
			set @w_SQL = @w_SQL  + ' ) A,[tbCOMP_Rpt007] B '
			set @w_SQL = @w_SQL  + ' where A.IdEmpresa=B.IdEmpresa '
			set @w_SQL = @w_SQL  + ' and A.IdSucursal=B.IdSucursal '
			set @w_SQL = @w_SQL  + ' and A.IdProducto=B.IdProducto '
			set @w_SQL = @w_SQL  + ' and A.IdPeriodo=B.IdMes'+cast(@Count as varchar(20))+'_anio '

			exec sp_executesql @w_SQL

			--print @w_SQL 




set @Count=@Count+1
end 

update [tbCOMP_Rpt007]  
set Prom_cant_x_comp= (Cant_Mes1_anio + Cant_Mes2_anio + Cant_Mes3_anio + Cant_Mes4_anio)/4

set @w_SQL =''
			
			set @w_SQL =' update [tbCOMP_Rpt007] set [stock_a_la_fecha] = a.Stock_a_la_fecha '
			set @w_SQL = @w_SQL  + ' from( '
			set @w_SQL = @w_SQL  + ' SELECT  A.IdEmpresa,A.IdSucursal, B.IdProducto, SUM(B.dm_cantidad) AS Stock_a_la_fecha  '
			set @w_SQL = @w_SQL  + ' FROM         dbo.in_movi_inve AS a INNER JOIN '
			set @w_SQL = @w_SQL  + ' dbo.in_movi_inve_detalle AS b ON a.IdEmpresa = b.IdEmpresa AND a.IdSucursal = b.IdSucursal AND '
			set @w_SQL = @w_SQL  + ' a.IdMovi_inven_tipo = b.IdMovi_inven_tipo AND a.IdNumMovi = b.IdNumMovi '
			set @w_SQL = @w_SQL  + ' where (cm_fecha <= '+''''+CAST((@i_FechaCorte) as varchar(20))+''''+') AND a.IdEmpresa = '+cast(@i_IdEmpresa as varchar(20))+' and a.IdSucursal between '+cast(@i_IdSucursalIni as varchar(20))+'and '+cast(@i_IdSucursalFin as varchar(20))
			set @w_SQL = @w_SQL  + ' GROUP BY a.IdEmpresa,a.IdSucursal,b.IdProducto'
			set @w_SQL = @w_SQL  + ' ) A , [tbCOMP_Rpt007] B where'
			set @w_SQL = @w_SQL  + ' A.IdEmpresa = B.IdEmpresa and'
			set @w_SQL = @w_SQL  + ' A.IdSucursal = B.IdSucursal and'
			set @w_SQL = @w_SQL  + ' A.IdProducto = B.IdProducto'
			print @w_SQL 
			exec sp_executesql @w_SQL


			Update [tbCOMP_Rpt007] set Nom_Empresa = A.em_nombre, Nom_Sucursal = A.Su_Descripcion
			from (
			select E.IdEmpresa, E.em_nombre, S.IdSucursal,S.Su_Descripcion 
			from tb_empresa AS E INNER JOIN tb_sucursal AS S ON S.IdEmpresa = E.IdEmpresa
			) AS A INNER JOIN [tbCOMP_Rpt007] AS B ON
			A.IdEmpresa = B.IdEmpresa and
			A.IdSucursal = B.IdSucursal


update [tbCOMP_Rpt007]  
set [stock_min] = Prom_cant_x_comp*1.1

update [tbCOMP_Rpt007]  
set [varianza] = case 
when [stock_min]!=0 then ([stock_a_la_fecha]/[stock_min])
end

update [tbCOMP_Rpt007]
set [Alerta] =case 
when [varianza]<=1 then 1
when [varianza] between 1 and 3 then 2
when [varianza]>=3 then 3
else 0
end



select * from [tbCOMP_Rpt007]