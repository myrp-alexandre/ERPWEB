--- exec spCXP_NATU_Rpt003 15,1,'PROVEE','01-01-2015','31-12-2015'
CREATE procedure [dbo].[spCXP_NATU_Rpt003]
(
 @IdEmpresa as int
,@IdProveedor as numeric(18,0)
,@Tipo_Persona varchar(20)
,@FechaIni as datetime
,@FechaFin as datetime
)
as
/*
DECLARE @IdEmpresa as int
DECLARE @IdProveedor as numeric(18,0)
DECLARE @Tipo_Persona varchar(20)
DECLARE @FechaIni as datetime
DECLARE @FechaFin as datetime


SET @IdEmpresa =15
SET @Tipo_Persona ='PROVEE'
SET @IdProveedor=1
SET @FechaIni ='10-09-2010'
SET @FechaFin ='30-10-2010'

*/


declare @SaldoInicial as float
declare @SaldoFinal as float
declare @TotalRegistros as numeric



SELECT @SaldoInicial =isnull(sum(A.Valor_debe),0)-isnull(sum(A.Valor_Haber),0)
FROM vwCXP_NATU_Rpt003 A
where A.IdEmpresa=@IdEmpresa
and A.co_fechaOg <@FechaIni
and A.tipo_persona=@Tipo_Persona
and A.IdProveedor=@IdProveedor


SELECT @SaldoFinal =isnull(sum(A.Valor_debe),0)-isnull(sum(A.Valor_Haber),0)
FROM vwCXP_NATU_Rpt003 A
where A.IdEmpresa=@IdEmpresa
and A.co_fechaOg <=@FechaFin
and A.tipo_persona=@Tipo_Persona
and A.IdProveedor=@IdProveedor



SELECT @TotalRegistros =count(*)
FROM vwCXP_NATU_Rpt003 A
where A.IdEmpresa=@IdEmpresa
and A.co_fechaOg <=@FechaFin
and A.tipo_persona=@Tipo_Persona
and A.IdProveedor=@IdProveedor


if (@TotalRegistros>0)
begin
		SELECT 
		 A.[IdEmpresa]			,A.[IdCbteCble_Ogiro]		,A.[IdTipoCbte_Ogiro]		,A.[IdOrden_giro_Tipo]			,A.[Documento]				,A.[nom_tipo_doc]
		,A.[cod_tipo_doc]		,A.[co_fechaOg]				,A.[Tipo_persona]			,A.[IdProveedor]				,A.[IdPersona]				,A.[nom_proveedor]			
		,A.[Observacion]		
		,A.[Valor_a_pagar]		,A.[Valor_debe]				,A.[Valor_Haber]			,0 Saldo			,@SaldoInicial	SaldoInicial,@SaldoFinal SaldoFinal
		,B.em_ruc ruc_Empresa	,B.em_nombre nom_empresa 
		FROM [dbo].[vwCXP_NATU_Rpt003] A,tb_empresa B
		where 
			A.IdEmpresa=B.IdEmpresa
		and A.IdEmpresa=@IdEmpresa
		and A.co_fechaOg between @FechaIni and @FechaFin
		and A.tipo_persona=@Tipo_Persona
		and A.IdProveedor=@IdProveedor
end 
else
begin
	

		select 
		 A.IdEmpresa			,null IdCbteCble_Ogiro		,null IdTipoCbte_Ogiro     ,null IdOrden_giro_Tipo		,'NO HAY REGISTRO' Documento	,null nom_tipo_doc
		,null cod_tipo_doc		,null co_fechaOg			, null Tipo_persona			,@IdProveedor IdProveedor	,null IdPersona					,'NO HAY REGISTRO' nom_proveedor			
		,'NO HAY REGISTRO' Observacion		
		,0 Valor_a_pagar		,0 Valor_debe				, 0 Valor_Haber				,0 Saldo					,@SaldoInicial	SaldoInicial,@SaldoFinal SaldoFinal
		,A.em_ruc ruc_Empresa	,A.em_nombre nom_empresa 
		from tb_empresa A
		where A.IdEmpresa=@IdEmpresa


end