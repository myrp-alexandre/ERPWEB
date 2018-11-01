CREATE VIEW [dbo].[vwcp_orden_pago_con_Transferencia]
AS
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.IdEmpresa, A.IdTipo_op, A.Referencia, 
 A.Referencia2 AS Referencia2, A.IdOrdenPago, A.Secuencia_OP, A.IdTipoPersona, A.IdPersona, A.IdEntidad, A.Fecha_OP, A.Fecha_Fa_Prov, A.Fecha_Venc_Fac_Prov, 
A.Observacion, A.Nom_Beneficiario, A.Girar_Cheque_a, A.Valor_a_pagar, A.Valor_estimado_a_pagar_OP, A.Total_cancelado_OP, A.Saldo_x_Pagar_OP, A.IdEstadoAprobacion, 
A.IdFormaPago, A.Fecha_Pago, A.IdCtaCble, A.IdCentroCosto, A.IdSubCentro_Costo, A.Cbte_cxp, A.Estado, A.Nom_Beneficiario_2, A.IdEmpresa_cxp, A.IdTipoCbte_cxp, 
A.IdCbteCble_cxp, CASE WHEN F.IdArchivo IS NULL THEN 'OP SIN TRANSFERENCIA' WHEN F.IdArchivo IS NOT NULL 
THEN 'OP CON TRANSFERENCIA' END AS IdEstado_Emision_file, dbo.vwtb_persona_beneficiario.IdTipoCta_acreditacion_cat, 
dbo.vwtb_persona_beneficiario.num_cta_acreditacion, dbo.vwtb_persona_beneficiario.IdBanco_acreditacion, dbo.tb_banco.ba_descripcion, dbo.tb_banco.CodigoLegal
FROM            dbo.vwcp_orden_pago_con_cancelacion AS A INNER JOIN
                         dbo.vwtb_persona_beneficiario ON A.IdTipoPersona = dbo.vwtb_persona_beneficiario.IdTipo_Persona AND 
                         A.IdPersona = dbo.vwtb_persona_beneficiario.IdPersona AND A.IdEntidad = dbo.vwtb_persona_beneficiario.IdEntidad AND 
                         A.IdEmpresa = dbo.vwtb_persona_beneficiario.IdEmpresa LEFT OUTER JOIN
                         dbo.tb_banco ON dbo.vwtb_persona_beneficiario.IdBanco_acreditacion = dbo.tb_banco.IdBanco LEFT OUTER JOIN
                         dbo.ba_Archivo_Transferencia_Det AS F ON A.IdEmpresa = F.IdEmpresa_OP AND A.IdOrdenPago = F.IdOrdenPago AND A.Secuencia_OP = F.Secuencia_OP