

CREATE VIEW [dbo].[vwCXP_Rpt025]
AS
SELECT        ct_centro_costo.Centro_costo AS nom_Centro_costo, ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subCentro_costo, 
                         vwcp_orden_pago_con_cancelacion.IdEmpresa, vwcp_orden_pago_con_cancelacion.IdTipo_op, vwcp_orden_pago_con_cancelacion.Referencia, 
                         vwcp_orden_pago_con_cancelacion.Referencia2, vwcp_orden_pago_con_cancelacion.IdOrdenPago, vwcp_orden_pago_con_cancelacion.Secuencia_OP, 
                         vwcp_orden_pago_con_cancelacion.IdTipoPersona, vwcp_orden_pago_con_cancelacion.IdPersona, vwcp_orden_pago_con_cancelacion.Nom_Beneficiario, 
                         vwcp_orden_pago_con_cancelacion.Fecha_Fa_Prov, vwcp_orden_pago_con_cancelacion.Observacion, vwcp_orden_pago_con_cancelacion.Valor_a_pagar, 
                         vwcp_orden_pago_con_cancelacion.Saldo_x_Pagar_OP, vwcp_orden_pago_con_cancelacion.IdEstadoAprobacion, 
                         ISNULL(vwcp_orden_pago_con_cancelacion.IdCentroCosto,'') AS IdCentroCosto, ISNULL(vwcp_orden_pago_con_cancelacion.IdSubCentro_Costo,'') AS IdSubCentro_Costo, vwcp_orden_pago_con_cancelacion.IdFormaPago
FROM            vwcp_orden_pago_con_cancelacion LEFT OUTER JOIN
                         ct_centro_costo_sub_centro_costo ON 
                         vwcp_orden_pago_con_cancelacion.IdSubCentro_Costo = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                         vwcp_orden_pago_con_cancelacion.IdCentroCosto = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         vwcp_orden_pago_con_cancelacion.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa LEFT OUTER JOIN
                         ct_centro_costo ON vwcp_orden_pago_con_cancelacion.IdEmpresa = ct_centro_costo.IdEmpresa AND 
                         vwcp_orden_pago_con_cancelacion.IdCentroCosto = ct_centro_costo.IdCentroCosto