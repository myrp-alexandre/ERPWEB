CREATE VIEW [dbo].[vwCXP_Rpt036]
AS
SELECT        ISNULL(ROW_NUMBER() OVER(ORDER BY cp_orden_giro.IdEmpresa),0) AS IdRow, cp_orden_giro.IdEmpresa, cp_orden_giro.IdTipoCbte_Ogiro, cp_orden_giro.IdCbteCble_Ogiro, cp_orden_giro.co_FechaFactura, cp_orden_giro.co_FechaContabilizacion, cp_orden_giro.co_factura, cp_orden_giro.IdProveedor, 
                         tb_persona.pe_nombreCompleto, tb_persona.pe_cedulaRuc, cp_orden_giro.co_observacion, cp_orden_giro.co_subtotal_iva, cp_orden_giro.co_subtotal_siniva, cp_orden_giro.co_valoriva, cp_orden_giro.co_total, ISNULL(vwcp_Retencion_valor_total_x_cbte_cxp.Total_Retencion,0) AS Total_Retencion, 
                         ISNULL(cance.MontoAplicado, 0) AS monto_pagado, 
						 ROUND(cp_orden_giro.co_total - ISNULL(vwcp_Retencion_valor_total_x_cbte_cxp.Total_Retencion,0) -ISNULL(cance.MontoAplicado, 0),2) AS Saldo, 
						 CASE WHEN aprobacion.IdEmpresa_Ogiro IS NOT NULL THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS origen_bodega, 
						 CASE WHEN conci.IdEmpresa_Ogiro IS NOT NULL THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS origen_caja
FROM            cp_orden_giro INNER JOIN
                         cp_proveedor ON cp_orden_giro.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_giro.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                         tb_persona ON cp_proveedor.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
                         vwcp_Retencion_valor_total_x_cbte_cxp ON cp_orden_giro.IdEmpresa = vwcp_Retencion_valor_total_x_cbte_cxp.IdEmpresa_Ogiro AND 
                         cp_orden_giro.IdCbteCble_Ogiro = vwcp_Retencion_valor_total_x_cbte_cxp.IdCbteCble_Ogiro AND cp_orden_giro.IdTipoCbte_Ogiro = vwcp_Retencion_valor_total_x_cbte_cxp.IdTipoCbte_Ogiro LEFT OUTER JOIN
                             (SELECT        IdEmpresa_Ogiro, IdTipoCbte_Ogiro, IdCbteCble_Ogiro
                               FROM            cp_Aprobacion_Ing_Bod_x_OC AS apro) AS aprobacion ON cp_orden_giro.IdEmpresa = aprobacion.IdEmpresa_Ogiro AND cp_orden_giro.IdTipoCbte_Ogiro = aprobacion.IdTipoCbte_Ogiro AND 
                         cp_orden_giro.IdCbteCble_Ogiro = aprobacion.IdCbteCble_Ogiro LEFT OUTER JOIN
                             (SELECT        IdEmpresa_OGiro, IdTipoCbte_Ogiro, IdCbteCble_Ogiro
                               FROM            cp_conciliacion_Caja_det) AS conci ON cp_orden_giro.IdEmpresa = conci.IdEmpresa_OGiro AND cp_orden_giro.IdTipoCbte_Ogiro = conci.IdTipoCbte_Ogiro AND 
                         cp_orden_giro.IdCbteCble_Ogiro = conci.IdCbteCble_Ogiro LEFT OUTER JOIN
                             (SELECT        IdEmpresa_cxp, IdTipoCbte_cxp, IdCbteCble_cxp, SUM(MontoAplicado) AS MontoAplicado
                               FROM            cp_orden_pago_cancelaciones
                               GROUP BY IdEmpresa_cxp, IdTipoCbte_cxp, IdCbteCble_cxp) AS cance ON cp_orden_giro.IdEmpresa = cance.IdEmpresa_cxp AND cp_orden_giro.IdTipoCbte_Ogiro = cance.IdTipoCbte_cxp AND 
                         cp_orden_giro.IdCbteCble_Ogiro = cance.IdCbteCble_cxp
WHERE        (cp_orden_giro.Estado = 'A')