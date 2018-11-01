
CREATE view [dbo].[vwcp_Anticipos_x_NotaCred_Saldo]
as
/*ANTICIPOS*/ SELECT OPD.IdEmpresa_cxp AS IdEmpresa, OPD.IdCbteCble_cxp AS IdCbteCble, OPD.IdTipoCbte_cxp AS IdTipoCbte, OP.Fecha, OP.Observacion, '' AS Referencia, CBT_TP.tc_TipoCbte, 
                         OPD.Valor_a_pagar AS Valor_cbte, ISNULL(CAN.Total_Pagado, 0) AS valor_cancelado, OPD.Valor_a_pagar - ISNULL(CAN.Total_Pagado, 0) AS valor_saldo_cbte, OP.IdTipo_op Tipo, 
                         OPD.IdEmpresa AS IdEmpresaOP, OPD.IdOrdenPago AS IdOrdenPagoOP, OPD.Secuencia AS SecuenciaOP, Per.IdCtaCble, Per.IdCtaCble_Anticipo, 
                         '[' + OP.IdTipo_Persona + ']-' + '[' + CAST(OP.IdEntidad AS varchar(20)) + ']-' + Per.Nombre AS Beneficiario, OP.IdEntidad
FROM            dbo.cp_orden_pago AS OP INNER JOIN
                         dbo.cp_orden_pago_det AS OPD ON OP.IdEmpresa = OPD.IdEmpresa AND OP.IdOrdenPago = OPD.IdOrdenPago INNER JOIN
                         dbo.vwtb_persona_beneficiario AS Per ON OP.IdEmpresa = Per.IdEmpresa AND OP.IdTipo_Persona = Per.IdTipo_Persona AND OP.IdPersona = Per.IdPersona AND OP.IdEntidad = Per.IdEntidad INNER JOIN
                         dbo.cp_orden_pago_tipo_x_empresa ON OP.IdEmpresa = dbo.cp_orden_pago_tipo_x_empresa.IdEmpresa AND OP.IdTipo_op = dbo.cp_orden_pago_tipo_x_empresa.IdTipo_op LEFT OUTER JOIN
                         dbo.ct_cbtecble_tipo AS CBT_TP ON OPD.IdEmpresa_cxp = CBT_TP.IdEmpresa AND OPD.IdTipoCbte_cxp = CBT_TP.IdTipoCbte LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_cancelacion_Total_pagado_x_cbteble AS CAN ON OPD.IdEmpresa_cxp = CAN.IdEmpresa_cbtecble AND OPD.IdTipoCbte_cxp = CAN.IdTipoCbte_cbtecble AND 
                         OPD.IdCbteCble_cxp = CAN.IdCbteCble_cbtecble
WHERE        (OPD.IdCbteCble_cxp IS NOT NULL) AND (OPD.Valor_a_pagar - ISNULL(CAN.Total_Pagado, 0) > 0) AND (OP.Estado = 'A') AND isnull(cp_orden_pago_tipo_x_empresa.Dispara_Alerta, 0) = 1
UNION ALL
/*-NOTAS DE CREDITOS*/ SELECT A.IdEmpresa, A.IdCbteCble_Nota, A.IdTipoCbte_Nota, A.cn_fecha, A.cn_observacion, A.cn_observacion AS referencia, D .tc_TipoCbte, a.cn_total AS Valor_Cbte, 
                         isnull(sum(ISNULL(B.MontoAplicado, 0)), 0) AS Valor_Cancelado_cbte, a.cn_total - isnull(sum(ISNULL(B.MontoAplicado, 0)), 0) AS Valor_saldo_cbte, 'NOTA-CRED' AS Tipo, NULL AS Expr1, 
                         A.IdCbteCble_Nota AS Expr2, NULL AS Expr3, P.IdCtaCble_CXP AS IdCtaCble, P.IdCtaCble_Anticipo AS IdCtaAnticipo, per.pe_nombreCompleto AS Beneficiario, P.IdProveedor AS IdEntidad
FROM            dbo.cp_nota_DebCre AS A INNER JOIN
                         dbo.cp_proveedor AS P ON A.IdEmpresa = P.IdEmpresa AND A.IdProveedor = P.IdProveedor INNER JOIN
                         dbo.vwct_cbtecble_det_TotalDiario AS C ON A.IdEmpresa = C.IdEmpresa AND A.IdTipoCbte_Nota = C.IdTipoCbte AND A.IdCbteCble_Nota = C.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_tipo AS D ON A.IdTipoCbte_Nota = D .IdTipoCbte AND A.IdEmpresa = D .IdEmpresa LEFT OUTER JOIN
                         dbo.cp_orden_pago_cancelaciones B ON A.IdEmpresa = B.IdEmpresa_pago AND A.IdCbteCble_Nota = B.IdCbteCble_pago AND A.IdTipoCbte_Nota = B.IdTipoCbte_pago
						 inner join tb_persona as per on p.IdPersona = per.IdPersona
WHERE        (A.Estado = 'A') AND (A.DebCre = 'C')
GROUP BY A.IdEmpresa, A.IdCbteCble_Nota, A.IdTipoCbte_Nota, A.cn_fecha, a.cn_total, A.cn_observacion, D .tc_TipoCbte, P.IdCtaCble_CXP, P.IdCtaCble_Anticipo, per.pe_nombreCompleto, P.IdProveedor