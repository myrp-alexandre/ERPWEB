
--EXEC [Fj_servindustrias].[spFAC_FJ_Rpt017] 1,1,99999,'01/01/2017','20/10/2017',0
CREATE PROCEDURE  [Fj_servindustrias].[spFAC_FJ_Rpt017]
(
@IdEmpresa int,
@IdCliente_ini numeric,
@IdCliente_fin numeric,
@Fecha_ini datetime,
@Fecha_fin datetime,
@No_mostrar_saldo_0 bit
)
AS


DECLARE @Saldo_inicial float

select @Saldo_inicial = sum(Fj_servindustrias.vwFAC_FJ_Rpt017.vt_saldo) from Fj_servindustrias.vwFAC_FJ_Rpt017
where IdEmpresa = @IdEmpresa and IdCliente between @IdCliente_ini and @IdCliente_fin
and vt_fecha < @Fecha_ini 

--SELECT @Saldo_inicial

set @Saldo_inicial = isnull(@Saldo_inicial,0)

select IdRow, IdEmpresa, IdSucursal, IdBodega, IdCbteVta, vt_tipoDoc, vt_NumFactura, vt_fecha, IdCliente, 
		pe_nombreCompleto, vt_Subtotal, vt_iva, vt_total, dc_ValorPago, vt_saldo, @Saldo_inicial + SUM(vt_saldo) OVER(ORDER BY IdPeriodo, vt_fecha,IdEmpresa, IdSucursal, IdBodega, IdCbteVta, vt_tipoDoc) as saldo_total,
		cr_fecha, Estado_cobro, num_oc, cant_cobro, IdPeriodo, 
        nombre_periodo, vt_Observacion
FROM(
SELECT *
FROM     Fj_servindustrias.vwFAC_FJ_Rpt017
where IdEmpresa = @IdEmpresa and IdCliente between @IdCliente_ini and @IdCliente_fin
and vt_fecha between @Fecha_ini and @Fecha_fin and @No_mostrar_saldo_0 = 1 and vt_saldo <>0
UNION
SELECT *
FROM     Fj_servindustrias.vwFAC_FJ_Rpt017
where IdEmpresa = @IdEmpresa and IdCliente between @IdCliente_ini and @IdCliente_fin
and vt_fecha between @Fecha_ini and @Fecha_fin and @No_mostrar_saldo_0 = 0 
) A
ORDER BY IdPeriodo, vt_fecha,IdEmpresa, IdSucursal, IdBodega, IdCbteVta, vt_tipoDoc