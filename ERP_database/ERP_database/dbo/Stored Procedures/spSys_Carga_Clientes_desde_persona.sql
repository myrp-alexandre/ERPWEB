CREATE proc [dbo].[spSys_Carga_Clientes_desde_persona]
as
/*
INSERT INTO fa_cliente
(IdEmpresa	, IdCliente		, IdPersona		, IdSucursal , IdVendedor 
, Idtipo_cliente
, IdTipoCredito , cl_Cat_crediticia , cl_plazo , cl_porcentaje_descuento , IdCtaCble_cxc , cl_Cell_Garante
, cl_Garante , cl_Mail_Garante , cl_observacion,
 --IdUbicacion 
 , cl_Cupo , cl_RazonSocial
, IdClienteRelacionado, cl_LocalComercial, cl_Rep_Legal ,cl_Mail_Rep_Legal , cl_Cell_Rep_Legal , cl_Ger_Gen
, cl_Mail_Ger_Gen , cl_Cell_Ger_Gen , cl_casilla, cl_fax , IdActividadComercial
, IdUsuario , Fecha_Transac
, nom_pc
, ip
, Estado
)

*/
SELECT
1		,IdPersona		,IdPersona			,2			,1 
,1
,'CRE' ,'A' ,0 ,0 ,'' ,''
,'' ,'' ,'' ,'' ,0 ,''
,0 ,'' ,'' ,'' ,'' ,''
,'' ,'' ,'' ,'' ,0
,'' ,GETDATE()
,''
,''
,'A'
FROM tb_persona
where CodPersona like '12%'


select * from fa_cliente