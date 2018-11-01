
CREATE  PROCEDURE [dbo].[spFAC_Rpt013]
 @IdEmpresa as int
,@IdCliente as numeric(18,0)
,@FechaIni as datetime
,@FechaFin as datetime

AS
BEGIN


/*
DECLARE @IdEmpresa as int
DECLARE @IdCliente as numeric(18,0)
DECLARE @FechaIni as datetime
DECLARE @FechaFin as datetime


SET @IdEmpresa =15
SET @IdCliente =1
SET @FechaIni ='20-08-2015'
SET @FechaFin ='20-08-2015'

*/


declare @SaldoInicial as float
declare @SaldoFinal as float
declare @TotalRegistros as numeric


----==============================================================================================================
----------========================== SALDO FINAL ==========================
--=========================================================================

select 
@SaldoInicial = ROUND(sum(B.valor),2) 
from 		(
		
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		
					
				 select SUM( isnull(A.Debito,0)) as valor
				 from vwFAC_Rpt013 A
				 where A.IdEmpresa=@IdEmpresa
				 and A.IdCliente=@IdCliente
				 and A.fecha<@FechaIni
	

		union
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- Creditos

				select SUM( isnull(A.Debito,0)) as valor
				 from vwFAC_Rpt013 A
				 where A.IdEmpresa=@IdEmpresa
				 and A.IdCliente=@IdCliente
				 and A.fecha<@FechaIni
			

		) B



set @SaldoInicial =isnull(@SaldoInicial ,0)



----==============================================================================================================
----------========================== SALDO FINAL ==========================
--=========================================================================

select 
@SaldoFinal = ROUND(sum(B.valor),2) 
from 		(

-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		
					
				 select SUM( isnull(A.Debito,0)) as valor
				 from vwFAC_Rpt013 A
				 where A.IdEmpresa=@IdEmpresa
				 and A.IdCliente=@IdCliente
				 and A.fecha<=@FechaFin
	

		union
		-- la suma de debitos por cuenta considerando la naturaleza deudora o acreedora
		-- Creditos

				select SUM( isnull(A.Debito,0)) as valor
				 from vwFAC_Rpt013 A
				 where A.IdEmpresa=@IdEmpresa
				 and A.IdCliente=@IdCliente
				 and A.fecha<=@FechaFin
			

		) B



set @SaldoFinal =isnull(@SaldoFinal ,0)





SELECT        @TotalRegistros=count(*)
FROM            vwFAC_Rpt013 A
where 
   A.IdEmpresa=@IdEmpresa
and A.fecha between @FechaIni and @FechaFin
and A.IdCliente =@IdCliente




if (@TotalRegistros>0)
begin


	SELECT     
	 A.IdEmpresa   ,A.nom_empresa	,A.IdSucursal  ,A.nom_sucursal	,A.IdCliente	,A.nom_cliente
	,A.Cedula_Ruc	,A.fecha		,A.Documento	,A.Debito		,A.Credito		,A.Saldo       ,A.vt_Observacion
	,@SaldoInicial as SaldoInicial,@SaldoFinal as SaldoFinal
	FROM            vwFAC_Rpt013 AS A
	where 
		A.IdEmpresa=@IdEmpresa
	and A.fecha between @FechaIni and @FechaFin
	and A.IdCliente=@IdCliente
	order by A.fecha



end 
else
begin
SELECT        
	 A.IdEmpresa		,A.em_nombre nom_empresa	,0 as IdSucursal  ,'' as nom_sucursal	,0 as IdCliente	,'' as nom_cliente
	,'' as Cedula_Ruc	,@FechaIni fecha			,'NO HAY REGISTROS' Documento	,0 Debito		,0 Credito		,0 Saldo       ,'NO HAY REGISTROS' vt_Observacion
	,@SaldoInicial as SaldoInicial,@SaldoFinal as SaldoFinal

from tb_empresa A
where A.IdEmpresa=@IdEmpresa

end 


END




--select * from ba_Banco_Cuenta where IdEmpresa=15