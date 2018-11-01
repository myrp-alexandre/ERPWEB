
--exec [dbo].[spCXP_Rpt035] 1,'3/10/2017',88,88
CREATE PROCEDURE [dbo].[spCXP_Rpt035]
  @idempresa int ,
  @fecha datetime ,
  @idProveedorIni decimal,
  @idProveedorFIn decimal
AS
BEGIN


         
SELECT ISNULL(ROW_NUMBER() OVER(ORDER BY VW.IdEmpresa),0) as IdRow, 
* 
from(         
Select 
        A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, A.IdOrden_giro_Tipo, A.Documento, A.nom_tipo_doc, A.cod_tipo_doc,
        A.IdProveedor, A.nom_proveedor, A.Valor_a_pagar
        
        , ISNULL(b.MontoAplicado, 0) AS MontoAplicado, round((round(A.Valor_a_pagar,2) - round(ISNULL(b.MontoAplicado, 0),2)),2)  as Saldo
        , A.Observacion,
         A.Ruc_Proveedor, A.representante_legal, A.Tipo_cbte, A.co_plazo Plazo_fact, 
          A.co_fechaOg,  co_FechaFactura_vct, A.Dias_Vcto,@fecha as Fecha_corte,
        (Case when datediff(day,co_FechaFactura_vct,@fecha) <=0 then (A.Valor_a_pagar - ISNULL(b.MontoAplicado, 0)) else 0 end) x_Vencer,
		(Case when datediff(day,co_FechaFactura_vct,@fecha) >0 then (A.Valor_a_pagar - ISNULL(b.MontoAplicado, 0)) else 0 end) Vencido,
        (Case when datediff(day,co_FechaFactura_vct,@fecha) >=1  and datediff(day,co_FechaFactura_vct,@fecha) <=30 then (A.Valor_a_pagar - ISNULL(b.MontoAplicado, 0)) else 0 end) Vencido_1_30,
        (Case when datediff(day,co_FechaFactura_vct,@fecha) >=31  and datediff(day,co_FechaFactura_vct,@fecha) <=60 then (A.Valor_a_pagar - ISNULL(b.MontoAplicado, 0)) else 0 end) Vencido_31_60,
		(Case when datediff(day,co_FechaFactura_vct,@fecha) >=61  and datediff(day,co_FechaFactura_vct,@fecha) <=90 then (A.Valor_a_pagar - ISNULL(b.MontoAplicado, 0)) else 0 end) Vencido_60_90,
        (Case when datediff(day,co_FechaFactura_vct,@fecha) >=91    then (A.Valor_a_pagar - ISNULL(b.MontoAplicado, 0)) else 0 end) Vencido_mayor_90, isnull(a.en_conciliacion,0) as en_conciliacion
 from
 (
 
                                                        select a.IdEmpresa, a.IdCbteCble_Ogiro,a.IdTipoCbte_Ogiro,IdOrden_giro_Tipo,a.Documento,a.nom_tipo_doc,a.cod_tipo_doc,
														a.IdProveedor,a.nom_proveedor,a.total Valor_a_pagar,a.Observacion,a.Ruc_Proveedor,a.representante_legal,a.Tipo_cbte, a.co_plazo,
														a.co_fechaOg, a.co_FechaFactura_vct,DATEDIFF(DAY,a.co_FechaFactura_vct,@fecha) as Dias_Vcto, 
														case when conci.IdEmpresa_OGiro is null then cast(0 as bit) else cast(1 as bit) end as en_conciliacion
														 from vwCXP_Rpt001 as a left join (
														 select cp_conciliacion_Caja_det.IdEmpresa_OGiro,cp_conciliacion_Caja_det.IdTipoCbte_Ogiro,cp_conciliacion_Caja_det.IdCbteCble_Ogiro 
														 from cp_conciliacion_Caja_det 
														 ) conci on a.IdEmpresa = conci.IdEmpresa_OGiro and a.IdTipoCbte_Ogiro = conci.IdTipoCbte_Ogiro and a.IdCbteCble_Ogiro = conci.IdCbteCble_Ogiro
                                                        where IdEmpresa = @idempresa and IdProveedor between @idProveedorIni and @idProveedorFIn and a.co_fechaOg <= @fecha
														and Tipo_cbte = 'CBTE_CXP'
) as A
 left join (
 Select IdEmpresa_cxp,IdTipoCbte_cxp ,IdCbteCble_cxp,sum(MontoAplicado)MontoAplicado
 from 
 ( 
		SELECT cp_orden_pago_cancelaciones.IdEmpresa_cxp, 
		cp_orden_pago_cancelaciones.IdTipoCbte_cxp, 
		cp_orden_pago_cancelaciones.IdCbteCble_cxp, 
		cp_orden_pago_cancelaciones.MontoAplicado
FROM     cp_orden_pago_cancelaciones INNER JOIN
                  ct_cbtecble ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble.IdEmpresa AND cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble.IdTipoCbte AND 
                  cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble.IdCbteCble
			where ct_cbtecble.cb_Fecha <= @fecha
UNION ALL
		SELECT cp_orden_giro.IdEmpresa, 
				cp_orden_giro.IdTipoCbte_Ogiro, 
				cp_orden_giro.IdCbteCble_Ogiro, 
				cp_retencion_det.re_valor_retencion
		FROM     cp_orden_giro INNER JOIN
						  cp_retencion ON cp_orden_giro.IdEmpresa = cp_retencion.IdEmpresa_Ogiro AND cp_orden_giro.IdCbteCble_Ogiro = cp_retencion.IdCbteCble_Ogiro AND cp_orden_giro.IdTipoCbte_Ogiro = cp_retencion.IdTipoCbte_Ogiro INNER JOIN
						  cp_retencion_det ON cp_retencion.IdEmpresa = cp_retencion_det.IdEmpresa AND cp_retencion.IdRetencion = cp_retencion_det.IdRetencion
		WHERE cp_retencion.fecha <= @fecha
) as VISTA 
group by IdEmpresa_cxp,IdTipoCbte_cxp ,IdCbteCble_cxp ) as 
b on
 a.IdEmpresa = b.IdEmpresa_cxp and a.IdCbteCble_Ogiro = b.IdCbteCble_cxp and a.IdTipoCbte_Ogiro = b.IdTipoCbte_cxp 
 ) VW
END