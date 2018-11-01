

CREATE PROCEDURE [dbo].[spPRO_CUS_CID_Rpt006]  
(@i_IdEmpresa Int, 
@i_IdUsuario varchar(20), 
@i_nom_pc varchar(50),
@i_IdSucursal int,
@i_IdBodega int,
@i_IdMovi_inven_tipo int,
@i_IdNumMovi numeric(18,0) ) 
 AS /*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/
  BEGIN
  
  CREATE TABLE [dbo].[tbPRO_CUS_CID_Rpt006_temporal](
	[IdUsuario] [varchar](20) NULL,
	[Fecha_Transac] [datetime] NULL,
	[nom_pc] [varchar](50) NULL,
	[CodigoBarra] [nvarchar](100) NULL,
	[dm_observacion] [nvarchar](1000) NULL,
	[IdEmpresa] [int] NULL,
	[IdSucursal] [int] NULL,
	[IdBodega] [int] NULL,
	[IdMovi_inven_tipo] [int] NULL,
	[IdNumMovi] [numeric](18, 0) NULL,
	[Secuencia] [int] NULL,
	[cb_secuencia] [int] NULL,
	[IdProducto] [numeric](18, 0) NULL,
	[cm_fecha] [date] NULL,
	[dm_cantidad] [float] NULL,
	[cm_observacion] [nvarchar](1000) NULL,
	[Su_Descripcion] [nchar](60) NULL,
	[bo_Descripcion] [nchar](100) NULL,
	[tm_descripcion] [nvarchar](50) NULL,
	[pr_descripcion] [nvarchar](500) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]


  
Insert Into [tbPRO_CUS_CID_Rpt006_temporal](IdEmpresa,IdUsuario	,Fecha_Transac	,nom_pc	,CodigoBarra	,dm_observacion	,
IdSucursal	,IdBodega	,IdMovi_inven_tipo	,IdNumMovi	,Secuencia	,cb_secuencia	,IdProducto	,cm_fecha	,
dm_cantidad	,cm_observacion	,Su_Descripcion	,bo_Descripcion	,tm_descripcion	,pr_descripcion	)

Select cab.IdEmpresa,@i_IdUsuario,GETDATE(),@i_nom_pc  ,cb.CodigoBarra,cb.dm_observacion, 
 cab.IdSucursal ,cab.IdBodega,cab.IdMovi_inven_tipo,cab.IdNumMovi, det.Secuencia, 
 cb.Secuencia as cb_secuencia ,det.IdProducto,cab.cm_fecha , det.dm_cantidad ,cab.cm_observacion,
suc.Su_Descripcion , bod.bo_Descripcion,mv.tm_descripcion,prod.pr_descripcion
From in_movi_inve cab inner join in_movi_inve_detalle det 
 on  cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal 
 and cab.IdBodega = det.IdBodega and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo 
 and cab.IdNumMovi = det.IdNumMovi 
 left join in_movi_inve_detalle_x_Producto_CusCider cb 
 on cb.IdEmpresa = det.IdEmpresa and cb.IdSucursal = det.IdSucursal 
 and cb.IdBodega = det.IdBodega and cb.IdMovi_inven_tipo = det.IdMovi_inven_tipo 
 and cb.IdNumMovi = det.IdNumMovi and cb.mv_Secuencia = det.Secuencia 
 left join cp_proveedor prov 
 on  prov.IdEmpresa = cab.IdEmpresa and prov.IdProveedor = cab.IdProvedor 
 inner join in_Producto prod
 on prod.IdEmpresa = det.IdEmpresa and prod.IdProducto = det.IdProducto 
 inner join tb_sucursal suc
 on suc.IdEmpresa = cab.IdEmpresa and cab.IdSucursal = suc.IdSucursal 
 inner join tb_bodega bod
 on bod.IdEmpresa = cab.IdEmpresa and cab.IdBodega = bod.IdBodega and cab.IdSucursal = bod.IdSucursal 
 inner join in_movi_inven_tipo mv
 on mv.IdEmpresa = cab.IdEmpresa and mv.IdMovi_inven_tipo = cab.IdMovi_inven_tipo 
where cab.IdEmpresa = @i_IdEmpresa and cab.IdSucursal = @i_IdSucursal and cab.IdBodega = @i_IdBodega and cab.IdMovi_inven_tipo = @i_IdMovi_inven_tipo 
and cab.IdNumMovi =@i_IdNumMovi 
  
  
 Delete tbPRO_CUS_CID_Rpt006 where IdUsuario = @i_IdUsuario and nom_pc = @i_nom_pc 
  
  Insert Into tbPRO_CUS_CID_Rpt006(IdEmpresa,IdUsuario	,Fecha_Transac	,nom_pc	,CodigoBarra	,dm_observacion	,
IdSucursal	,IdBodega	,IdMovi_inven_tipo	,IdNumMovi	,Secuencia	,cb_secuencia	,IdProducto	,cm_fecha	,
dm_cantidad	,cm_observacion	,Su_Descripcion	,bo_Descripcion	,tm_descripcion	,pr_descripcion,id	)
select IdEmpresa,IdUsuario	,Fecha_Transac	,nom_pc	,CodigoBarra	,dm_observacion	,
IdSucursal	,IdBodega	,IdMovi_inven_tipo	,IdNumMovi	,Secuencia	,cb_secuencia	,IdProducto	,cm_fecha	,
dm_cantidad	,cm_observacion	,Su_Descripcion	,bo_Descripcion	,tm_descripcion	,pr_descripcion,id 
from [tbPRO_CUS_CID_Rpt006_temporal]

drop table [tbPRO_CUS_CID_Rpt006_temporal]
  
  END