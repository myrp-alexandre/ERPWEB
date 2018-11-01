

CREATE PROCEDURE [dbo].[spPRO_CUS_CID_Rpt008]  
(@i_IdEmpresa Int, 
@i_IdUsuario varchar(20), 
@i_nom_pc varchar(50),
@i_IdSucursal int,
@i_IdBodega int,
@i_IdMovi_inven_tipo int,
@i_IdNumMovi numeric(18,0) ) 
 AS /*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/
  BEGIN
  
  CREATE TABLE [dbo].[tbPRO_CUS_CID_Rpt008_temporal](
	[IdUsuario] [varchar](20) NULL,
	[Fecha_Transac] [datetime] NULL,
	[nom_pc] [varchar](50) NULL,
	[IdEmpresa] [int] NULL,
	[CodigoBarra] [nvarchar](100) NULL,
	[dm_observacion] [nvarchar](1000) NULL,
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
	[id] [int] IDENTITY(1,1) NOT NULL,
	pr_nombre varchar(100) not null,
	NumDocumentoRelacionado varchar(25) not null,
	NumFactura varchar(25) not null,
	oc_NumDocumento varchar(20) not null,
	IdOrdenCompra numeric(18,0) null,
	oc_fecha date null,
	oc_observacion varchar(1000) null,
	ocdet_cantidad float 
) ON [PRIMARY]


  
Insert Into [tbPRO_CUS_CID_Rpt008_temporal](IdEmpresa,IdUsuario	,Fecha_Transac	,nom_pc	,CodigoBarra	,dm_observacion	,
IdSucursal	,IdBodega	,IdMovi_inven_tipo	,IdNumMovi	,Secuencia	,cb_secuencia	,IdProducto	,cm_fecha	,
dm_cantidad	,cm_observacion	,Su_Descripcion	,bo_Descripcion	,tm_descripcion	,pr_descripcion,pr_nombre,NumDocumentoRelacionado,
NumFactura, oc_NumDocumento, IdOrdenCompra ,oc_fecha, oc_observacion,ocdet_cantidad )

Select cab.IdEmpresa,@i_IdUsuario,GETDATE(),@i_nom_pc,cb.CodigoBarra,cb.dm_observacion,
cab.IdSucursal ,cab.IdBodega,cab.IdMovi_inven_tipo,cab.IdNumMovi, det.Secuencia, 
cb.Secuencia as cb_secuencia ,det.IdProducto,cab.cm_fecha , det.dm_cantidad ,cab.cm_observacion,
suc.Su_Descripcion , bod.bo_Descripcion,mv.tm_descripcion,prod.pr_descripcion,
prov.pr_nombre,cab.NumDocumentoRelacionado,cab.NumFactura,oc.oc_NumDocumento, oc.IdOrdenCompra, oc.oc_fecha,
oc.oc_observacion , ocdet.do_Cantidad as ocdet_cantidad

From in_movi_inve cab inner join in_movi_inve_detalle det 
 on  cab.IdEmpresa = det.IdEmpresa and cab.IdSucursal = det.IdSucursal 
 and cab.IdBodega = det.IdBodega and cab.IdMovi_inven_tipo = det.IdMovi_inven_tipo 
 and cab.IdNumMovi = det.IdNumMovi 
 inner join prd_parametros_CusCidersus prm
 on prm.IdEmpresa = cab.IdEmpresa and prm.IdMovi_inven_tipo_ing_suc_princ  = cab.IdMovi_inven_tipo 
 inner join in_movi_inve_detalle_x_Producto_CusCider cb 
 on cb.IdEmpresa = det.IdEmpresa and cb.IdSucursal = det.IdSucursal 
 and cb.IdBodega = det.IdBodega and cb.IdMovi_inven_tipo = det.IdMovi_inven_tipo 
 and cb.IdNumMovi = det.IdNumMovi and cb.mv_Secuencia = det.Secuencia 
 inner join in_Producto prod
 on prod.IdEmpresa = det.IdEmpresa and prod.IdProducto = det.IdProducto 
 inner join tb_sucursal suc
 on suc.IdEmpresa = cab.IdEmpresa and cab.IdSucursal = suc.IdSucursal 
 inner join tb_bodega bod
 on bod.IdEmpresa = cab.IdEmpresa and cab.IdBodega = bod.IdBodega and cab.IdSucursal = bod.IdSucursal 
 inner join in_movi_inven_tipo mv
 on mv.IdEmpresa = cab.IdEmpresa and mv.IdMovi_inven_tipo = cab.IdMovi_inven_tipo 
 inner join cp_proveedor prov
 on cab.IdProvedor = prov.IdProveedor and cab.IdEmpresa = prov.IdEmpresa 
 left join in_movi_inve_detalle_x_com_ordencompra_local_det TI
 on TI.mi_IdEmpresa = cab.IdEmpresa and TI.mi_IdSucursal = cab.IdSucursal and mi_IdBodega = cab.IdBodega 
 and mi_IdMovi_inven_tipo = cab.IdMovi_inven_tipo and det.Secuencia = mi_Secuencia 
 inner join com_ordencompra_local oc
 on oc.IdEmpresa = cab.IdEmpresa and TI.ocd_IdSucursal = oc.IdSucursal and TI.ocd_IdOrdenCompra = oc.IdOrdenCompra 
 inner join com_ordencompra_local_det  ocdet
 on ocdet.IdEmpresa = cab.IdEmpresa and TI.ocd_IdSucursal = ocdet.IdSucursal and TI.ocd_IdOrdenCompra = ocdet.IdOrdenCompra and 
 ocdet.Secuencia = TI.ocd_Secuencia 

where cab.IdEmpresa = @i_IdEmpresa and cab.IdSucursal = @i_IdSucursal and 
 cab.IdBodega = @i_IdBodega and cab.IdMovi_inven_tipo = @i_IdMovi_inven_tipo and
 cab.IdNumMovi = @i_IdNumMovi 

 
  
 Delete tbPRO_CUS_CID_Rpt008 where IdUsuario = @i_IdUsuario and nom_pc = @i_nom_pc 
  
  Insert Into tbPRO_CUS_CID_Rpt008(IdEmpresa,IdUsuario	,Fecha_Transac	,nom_pc	,CodigoBarra	,dm_observacion	,
IdSucursal	,IdBodega	,IdMovi_inven_tipo	,IdNumMovi	,Secuencia	,cb_secuencia	,IdProducto	,cm_fecha	,
dm_cantidad	,cm_observacion	,Su_Descripcion	,bo_Descripcion	,tm_descripcion	,pr_descripcion,pr_nombre,NumDocumentoRelacionado,
NumFactura, oc_NumDocumento, IdOrdenCompra ,oc_fecha, oc_observacion,ocdet_cantidad ,id)
select IdEmpresa,IdUsuario	,Fecha_Transac	,nom_pc	,CodigoBarra	,dm_observacion	,
IdSucursal	,IdBodega	,IdMovi_inven_tipo	,IdNumMovi	,Secuencia	,cb_secuencia	,IdProducto	,cm_fecha	,
dm_cantidad	,cm_observacion	,Su_Descripcion	,bo_Descripcion	,tm_descripcion	,pr_descripcion,pr_nombre,NumDocumentoRelacionado,
NumFactura, oc_NumDocumento, IdOrdenCompra ,oc_fecha, oc_observacion,ocdet_cantidad,id from [tbPRO_CUS_CID_Rpt008_temporal]

drop table [tbPRO_CUS_CID_Rpt008_temporal]
  
  END

--exec spPRO_CUS_CID_Rpt008 6,'','',1,1,1,1
--select * from tbPRO_CUS_CID_Rpt008