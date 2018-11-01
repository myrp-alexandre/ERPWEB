--EXEC [dbo].[spCXP_Rpt001] 1,516,516,1,999,'2017-09-24'
CREATE PROCEDURE [dbo].[spCXP_Rpt001]
(
@IdEmpresa int,
@IdProveedor_ini numeric,
@IdProveedor_fin numeric,
@IdClase_proveedor_ini int,
@IdClase_proveedor_fin int,
@Fecha_corte datetime
)AS
BEGIN

			SELECT        IdRow, vwCXP_Rpt001.IdEmpresa, vwCXP_Rpt001.IdTipoCbte_Ogiro, vwCXP_Rpt001.IdCbteCble_Ogiro, IdOrden_giro_Tipo, Documento, nom_tipo_doc, cod_tipo_doc, co_fechaOg, IdProveedor, nom_proveedor, total,valor, Valor_debe, Valor_Haber, 
						ROUND(SUM(Valor_debe-Valor_Haber) OVER(PARTITION BY vwCXP_Rpt001.IdEmpresa, vwCXP_Rpt001.IdTipoCbte_Ogiro, vwCXP_Rpt001.IdCbteCble_Ogiro order by IdProveedor, vwCXP_Rpt001.IdEmpresa, vwCXP_Rpt001.IdTipoCbte_Ogiro, vwCXP_Rpt001.IdCbteCble_Ogiro, NUM_QUERRY,co_fechaOG,IdTipoCbte_pago,IdCbteCble_pago),2) as Saldo, 
						    CASE WHEN round((abs(total) - ISNULL(query_saldos.valor_pagado,0)),2) = 0 THEN 'PAGADO' ELSE 'PENDIENTE' END as estado_pago,  Observacion, Ruc_Proveedor, representante_legal, Tipo_cbte, IdEmpresa_pago, IdTipoCbte_pago, IdCbteCble_pago, cb_Observacion_pago, tc_TipoCbte_pago, cb_Cheque_pago, IdClaseProveedor, descripcion_clas_prove, 
							NUM_QUERRY, en_conciliacion
			FROM            dbo.vwCXP_Rpt001 INNER JOIN(
			SELECT qs.IdEmpresa,qs.IdTipoCbte_Ogiro,qs.IdCbteCble_Ogiro,sum(Valor_debe) as valor_pagado 
			FROM dbo.vwCXP_Rpt001 AS qs
			WHERE co_fechaOg <= @Fecha_corte and qs.IdEmpresa = @IdEmpresa and IdProveedor between @IdProveedor_ini and @IdProveedor_fin and IdClaseProveedor between @IdClase_proveedor_ini and @IdClase_proveedor_fin
			group by qs.IdEmpresa,qs.IdTipoCbte_Ogiro,qs.IdCbteCble_Ogiro
			) as query_saldos on query_saldos.IdEmpresa = vwCXP_Rpt001.IdEmpresa and query_saldos.IdTipoCbte_Ogiro = vwCXP_Rpt001.IdTipoCbte_Ogiro and vwCXP_Rpt001.IdCbteCble_Ogiro = query_saldos.IdCbteCble_Ogiro
			WHERE co_fechaOg <= @Fecha_corte and vwCXP_Rpt001.IdEmpresa = @IdEmpresa and IdProveedor between @IdProveedor_ini and @IdProveedor_fin and IdClaseProveedor between @IdClase_proveedor_ini and @IdClase_proveedor_fin
			order by IdProveedor, vwCXP_Rpt001.IdEmpresa, vwCXP_Rpt001.IdTipoCbte_Ogiro, vwCXP_Rpt001.IdCbteCble_Ogiro, NUM_QUERRY,co_fechaOG,IdTipoCbte_pago,IdCbteCble_pago
END