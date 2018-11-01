create proc [dbo].[spSys_CargaPedidos_desde_siac]
as
declare @idEmpresa int
declare @idsucursal int

set @idEmpresa =1
set @idsucursal =1

delete fa_pedido where IdEmpresa=@idEmpresa and IdSucursal=@idsucursal

update tbINcabPedidos
set cp_vendedor=1
where cp_vendedor>15

update tbINcabPedidos
set cp_vendedor=1
where cp_vendedor=0




INSERT INTO fa_pedido
(IdEmpresa	, IdSucursal	, IdBodega				, IdPedido			
, IdCliente		
, IdVendedor
, cp_fecha	, cp_diasPlazo	, cp_fechaVencimiento	, cp_observacion	, cp_tipopago	, IdEstadoAprobacion
, IdUsuario	, Fecha_Transac	
--, IdUsuarioUltMod		, Fecha_UltMod		, IdUsuarioUltAnu, Fecha_UltAnu
, nom_pc	, ip	
, Estado
)

select 
cp_compania,cp_sucursal		,1						,cp_numero			
,cast(cp_compania as varchar(1))+cast(cp_sucursal as varchar(1))+cast(cp_cliente as varchar(20))  
,cp_vendedor
,cp_fecha	,cp_diasPlazo	,cp_fechaVencimiento	,cp_observacion	,cp_tipopago		,'A'
,cp_usuario	,GETDATE()
,'',''
,cp_estado
from dbo.tbINcabPedidos 
where cp_compania=@idEmpresa
and cp_sucursal=@idsucursal




INSERT INTO fa_pedido_det
(IdEmpresa			, IdSucursal	, IdBodega		, IdPedido
, Secuencial		, IdProducto	, dp_cantidad	, dp_precio
, dp_PorDescuento	, cp_desUni		, cp_PrecioFinal, dp_subtotal
, dp_iva			, dp_total		, dp_pagaIva	, dp_detallexItems
)

select 
cp_compania			,cp_sucursal		,1				,cp_numero
,dp_secuencial		,dp_producto		,dp_cantidad	,dp_precio
,dp_PorDescuento	,dp_ValorDescuento	,cp_PrecioFinal	,dp_subtotal
,dp_iva				,dp_total			,dp_pagaIva		,isnull(dp_detallexItems,'')	
from tbINdetPedidos
where cp_compania=@idEmpresa
and cp_sucursal=@idsucursal
and cp_numero in 
(
	select cp_numero from tbINcabPedidos where cp_compania=@idEmpresa and cp_sucursal=@idsucursal
)