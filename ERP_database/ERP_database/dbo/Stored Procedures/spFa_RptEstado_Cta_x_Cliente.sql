/*

exec spFa_RptEstado_Cta_x_Cliente 
 @i_IdEmpresa =1
,@i_IdCliente =1
,@i_IdSucursalIni =1
,@i_IdSucursalFin =1
,@i_FechaIni ='01/01/2014'
,@i_FechaFin ='12/31/2014'
,@i_Fecha_Corte ='01/01/2014'
,@i_Mostrar_Doc_Saldo_cero ='S'
,@i_Usuario ='admin'
,@i_PC ='pc'


*/


CREATE proc [dbo].[spFa_RptEstado_Cta_x_Cliente]
(
 @i_IdEmpresa int
,@i_IdCliente numeric
,@i_IdSucursalIni int
,@i_IdSucursalFin int
,@i_FechaIni date
,@i_FechaFin date
,@i_Fecha_Corte date
,@i_Mostrar_Doc_Saldo_cero char(1)
,@i_Usuario varchar(50)
,@i_PC varchar(50)
)
as
/*
declare @i_IdEmpresa int
declare @i_IdCliente numeric
declare @i_IdSucursalIni int
declare @i_IdSucursalFin int
declare @i_FechaIni date
declare @i_FechaFin date
declare @i_Fecha_Corte date
declare @i_Mostrar_Doc_Saldo_cero char(1)
declare @i_Usuario varchar(50)
declare @i_PC varchar(50)



set @i_IdEmpresa =1
set @i_IdCliente =1
set @i_IdSucursalIni=1
set @i_IdSucursalFin=100
set @i_FechaIni ='01/01/2014'
set @i_FechaFin ='12/31/2014'
set @i_Mostrar_Doc_Saldo_cero ='N'
set @i_Usuario ='lyanza'
set @i_PC ='pc'
set @i_Fecha_Corte='01/12/2014'

*/





delete [tbFa_Rpt_EstadoCta_x_cliente_TAL]
where [Usuario]	=@i_Usuario
and [PC] = @i_PC

--select * from [tbFa_Rpt_EstadoCta_x_cliente_TAL]



INSERT INTO [tbFa_Rpt_EstadoCta_x_cliente_TAL]
([IdEmpresa]			,[IdSucursal]			,[IdBodega]	,[Tipo_Trans]	,[IdCobro]		,[IdCobro_Tipo]	,[IdEstadoCobro]
,[Secuencia]			,IdCbte_vta_nt				,[Fecha]	,[Fecha_vto]	,[Dias_Plazo]	
,[Referencia]			
,[IdCliente]			,[IdEstado_Vencimiento]	,[Subtotal]	,[Iva]			,[Total]		,[Usuario]		,[PC]
,Saldo
,Nom_Empresa			,Nom_Sucursal			,Nom_Cliente
,Fecha_Corte			,Dias_Vencidos			
,Valor_Vencido			,Valor_x_vencer
)
SELECT     
A.IdEmpresa				, A.IdSucursal			, A.IdBodega	, A.Tipo			,null			,null			,null
,0						,A.IdCbte				, A.fecha		, A.no_fecha_venc	,DATEDIFF(day,A.fecha,A.no_fecha_venc)
,A.Referencia
,A.IdCliente			,null					,A.SubTotal		, A.Iva				, A.Total			,@i_Usuario		,@i_PC
,A.Total
, B.em_nombre			, C.Su_Descripcion		,pe.pe_nombreCompleto
,@i_Fecha_Corte			,DATEDIFF(day,A.no_fecha_venc,@i_Fecha_Corte)
,0						,0
FROM         vwFa_Facturas_y_NotasDebito AS A ,tb_empresa AS B 
,tb_sucursal AS C ,fa_cliente AS cli ,tb_persona AS pe 
where 
	A.IdEmpresa = B.IdEmpresa 
and A.IdEmpresa = C.IdEmpresa 
AND A.IdSucursal = C.IdSucursal 
and A.IdEmpresa = cli.IdEmpresa 
AND A.IdCliente = cli.IdCliente 
and cli.IdPersona = pe.IdPersona
and A.IdEmpresa		=@i_IdEmpresa
and A.IdCliente		=@i_IdCliente
and A.IdSucursal between @i_IdSucursalIni and @i_IdSucursalIni
and A.fecha between @i_FechaIni and @i_FechaFin



INSERT INTO [tbFa_Rpt_EstadoCta_x_cliente_TAL]
([IdEmpresa]			,[IdSucursal]			,[IdBodega]			,[Tipo_Trans]		,[IdCobro]		,[IdCobro_Tipo]	,[IdEstadoCobro]
,[Secuencia]			,IdCbte_vta_nt				,[Fecha]			,[Fecha_vto]		,[Dias_Plazo]	
,[Referencia]			
,[IdCliente]			,[IdEstado_Vencimiento]	,[Subtotal]			,[Iva]				,[Total]		,[Usuario]		,[PC]
,Saldo
,Nom_Empresa			,Nom_Sucursal			,Nom_Cliente
,Fecha_Corte			,Dias_Vencidos
,Valor_Vencido			,Valor_x_vencer
)
SELECT     
A.IdEmpresa				, A.IdSucursal			,B.IdBodega_Cbte	, B.dc_TipoDocumento,A.IdCobro		,A.IdCobro_tipo	,C.IdEstadoCobro
,B.secuencial			,B.IdCbte_vta_nota		,A.cr_fecha			, A.cr_fechaCobro	,DATEDIFF(day,	A.cr_fecha,A.cr_fechaCobro)
,'Cbr x ' + A.IdCobro_tipo +'#' + cast(A.IdCobro  as varchar(20))
,A.IdCliente			,NULL					,B.dc_ValorPago		,0					,B.dc_ValorPago	,@i_Usuario		,@i_PC
,B.dc_ValorPago			
,em.em_nombre			,Su.Su_Descripcion		,pe.pe_nombreCompleto
,@i_Fecha_Corte			,DATEDIFF(day,A.cr_fechaCobro,@i_Fecha_Corte)
,0						,0
FROM         cxc_cobro AS A INNER JOIN
cxc_cobro_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdCobro = B.IdCobro INNER JOIN
tb_empresa AS em ON A.IdEmpresa = em.IdEmpresa INNER JOIN
fa_cliente AS cli ON A.IdEmpresa = cli.IdEmpresa AND A.IdCliente = cli.IdCliente INNER JOIN
tb_sucursal AS Su ON A.IdEmpresa = Su.IdEmpresa AND A.IdSucursal = Su.IdSucursal INNER JOIN
tb_persona AS pe ON cli.IdPersona = pe.IdPersona LEFT OUTER JOIN
vwcxc_EstadoCobro_Actual AS C ON A.IdEmpresa = C.IdEmpresa AND A.IdSucursal = C.IdSucursal AND A.IdCobro = C.IdCobro
WHERE A.IdEmpresa = @i_IdEmpresa
and A.IdSucursal between @i_IdSucursalIni and @i_IdSucursalFin
and A.IdCliente =@i_IdCliente
and A.cr_fecha between @i_FechaIni and @i_FechaFin 




update tbFa_Rpt_EstadoCta_x_cliente_TAL 
set Saldo=B.Saldo
FROM         tbFa_Rpt_EstadoCta_x_cliente_TAL AS A INNER JOIN
vwcxc_cartera_x_cobrar AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND A.Tipo_Trans = B.vt_tipoDoc AND 
A.IdCbte_vta_nt = B.IdComprobante
where 
    [Usuario]=@i_Usuario		
and [PC]=@i_PC



  select * from [tbFa_Rpt_EstadoCta_x_cliente_TAL]