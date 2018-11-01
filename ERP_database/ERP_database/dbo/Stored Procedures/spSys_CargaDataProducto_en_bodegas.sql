CREATE proc [dbo].[spSys_CargaDataProducto_en_bodegas] as

declare @idEmpresa int
declare @idsucursal int

declare @idbodega int


set @idsucursal =1
set @idbodega =1
set @idEmpresa =6


INSERT INTO in_producto_x_tb_bodega
(IdEmpresa			, IdSucursal			, IdBodega				, IdProducto			
--,IdCtaCble_Inven	, IdCtaCble_CosBaseIva	, IdCtaCble_CosBase0, IdCtaCble_VenIva	, IdCtaCble_Ven0
--, IdCtaCble_DesIva	, IdCtaCble_Des0		, IdCtaCble_DevIva	, IdCtaCble_Dev0
)

SELECT     
IdEmpresa			, @idsucursal			,@idbodega			, IdProducto			
--, IdCtaCble_Inven	, IdCtaCble_CosBaseIva	, IdCtaCble_CosBase0, IdCtaCble_VenIva	, IdCtaCble_Ven0
--, IdCtaCble_DesIva	, IdCtaCble_Des0		, IdCtaCble_DevIva	, IdCtaCble_Dev0
FROM         in_Producto 
where IdEmpresa =@idEmpresa