-- RYANZA
----- OJO  HE CAMBIADO ESTE SP POR Q LA VISTA vwINV_Rpt015 EN LA BASE NO TIENE ESTOS CAMPOS PARA MANTENER ESTABLE EL SP 
-- HE SOBREMONTADO LOS CAMPOS CON NULL Y ESPACIOS EN BLANCO  CORREGISTA LA VISTA Y ESTE SP AQUIN CORRESPONDA..

CREATE proc [dbo].[spINV_Rpt015] 
(
 @i_IdEmpresa int
,@i_IdSucursalIni int
,@i_IdSucursalFin int
,@i_IdBodegaIni int
,@i_IdBodegaFin int
,@i_IdProductoIni numeric
,@i_IdProductoFin numeric
,@i_FechaIni datetime
,@i_FechaFin datetime
,@i_tipo_movi varchar(1)

)
as

select 
IdEmpresa, nom_empresa, IdSucursal, nom_sucursal, IdBodega, nom_bodega, IdMovi_inven_tipo, nom_Movi_inven_tipo, IdProducto, nom_Producto, 
		IdSubCentro_Costo, nom_subCentroCosto, IdUnidadMedida, nom_UnidadMedida, sum(dm_cantidad) as dm_cantidad, sum(SubTotal) as SubTotal, IdNumMovi
		,cm_tipo_movi
from 
(
		SELECT        
		IdEmpresa, '' AS nom_empresa, IdSucursal, nom_sucursal, IdBodega, nom_bodega, IdMovi_inven_tipo,'' AS nom_Movi_inven_tipo, IdProducto, nom_Producto, 
		'' AS IdSubCentro_Costo, '' AS nom_subCentroCosto, IdUnidadMedida, '' AS nom_UnidadMedida, dm_cantidad, mv_costo,0 AS  SubTotal, IdNumMovi,GETDATE() AS Fecha
		,'' AS cm_tipo_movi
		FROM            vwINV_Rpt015
		where IdEmpresa=@i_IdEmpresa
		and IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin
		and IdBodega between @i_IdBodegaIni and @i_IdBodegaFin
		and IdProducto between @i_IdProductoIni and @i_IdProductoFin
		--and Fecha between @i_FechaIni and @i_FechaFin  SE COMENTA NO EXISTE ESTOS CAMPOS EN LA VISTA
		--and cm_tipo_movi like @i_tipo_movi  SE COMENTA NO EXISTE ESTOS CAMPOS EN LA VISTA
) as A
group by 
IdEmpresa, nom_empresa, IdSucursal, nom_sucursal, IdBodega, nom_bodega, IdMovi_inven_tipo, nom_Movi_inven_tipo, IdProducto, nom_Producto, 
		IdSubCentro_Costo, nom_subCentroCosto, IdUnidadMedida, nom_UnidadMedida, IdNumMovi,cm_tipo_movi