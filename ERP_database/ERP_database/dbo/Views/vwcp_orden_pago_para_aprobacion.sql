CREATE view [dbo].[vwcp_orden_pago_para_aprobacion]
as
SELECT        cp_orden_pago_det.IdEmpresa, cp_orden_pago_det.IdOrdenPago, cp_orden_pago_det.Secuencia, cp_orden_pago_det.IdEmpresa_cxp, 
                         cp_orden_pago_det.IdCbteCble_cxp, cp_orden_pago_det.IdTipoCbte_cxp, cp_orden_pago_det.Valor_a_pagar, cp_orden_pago.IdEstadoAprobacion, 
                         cp_orden_pago.IdTipo_Persona, cp_orden_pago.IdEntidad, cp_orden_pago.IdPersona, LTRIM(RTRIM(tb_persona.pe_nombreCompleto)) AS pe_nombreCompleto, 
                         cp_orden_pago_det.Referencia, cp_TipoDocumento.Codigo + '# ' + CAST(CAST(cp_orden_giro.co_factura AS numeric) AS varchar) AS Referencia2, 
                         cp_orden_giro.co_FechaFactura, cp_orden_giro.co_FechaFactura_vct, DATEDIFF(day, GETDATE(), cp_orden_giro.co_FechaFactura_vct) AS dias_vencido, 
                         cp_orden_pago_formapago.IdFormaPago, cp_orden_pago_formapago.descripcion, cp_orden_pago.Estado, cp_orden_giro.co_observacion, 
                         cp_orden_pago.Fecha_Pago, cp_orden_pago.IdTipo_op
FROM            cp_orden_pago INNER JOIN
                         cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND 
                         cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago INNER JOIN
                         tb_persona ON cp_orden_pago.IdPersona = tb_persona.IdPersona INNER JOIN
                         cp_orden_giro ON cp_orden_pago_det.IdEmpresa_cxp = cp_orden_giro.IdEmpresa AND cp_orden_pago_det.IdCbteCble_cxp = cp_orden_giro.IdCbteCble_Ogiro AND 
                         cp_orden_pago_det.IdTipoCbte_cxp = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                         cp_TipoDocumento ON cp_orden_giro.IdOrden_giro_Tipo = cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         cp_orden_pago_formapago ON cp_orden_pago.IdFormaPago = cp_orden_pago_formapago.IdFormaPago
UNION
SELECT        cp_orden_pago_det.IdEmpresa, cp_orden_pago_det.IdOrdenPago, cp_orden_pago_det.Secuencia, cp_orden_pago_det.IdEmpresa_cxp, 
                         cp_orden_pago_det.IdCbteCble_cxp, cp_orden_pago_det.IdTipoCbte_cxp, cp_orden_pago_det.Valor_a_pagar, cp_orden_pago.IdEstadoAprobacion, 
                         cp_orden_pago.IdTipo_Persona, cp_orden_pago.IdEntidad, cp_orden_pago.IdPersona, LTRIM(RTRIM(tb_persona.pe_nombreCompleto)) AS pe_nombreCompleto, 
                         cp_orden_pago_det.Referencia, cp_TipoDocumento.Codigo + '# ' + CAST(CAST(cp_nota_DebCre.cod_nota AS numeric) AS varchar) AS Referencia2, 
                         cp_nota_DebCre.cn_fecha, cp_nota_DebCre.cn_Fecha_vcto, DATEDIFF(day, GETDATE(), cp_nota_DebCre.cn_Fecha_vcto) AS dias_vencido, 
                         cp_orden_pago_formapago.IdFormaPago, cp_orden_pago_formapago.descripcion, cp_orden_pago.Estado, cp_nota_DebCre.cn_observacion, 
                         cp_orden_pago.Fecha_Pago, cp_orden_pago.IdTipo_op
FROM            cp_orden_pago INNER JOIN
                         cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND 
                         cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago INNER JOIN
                         tb_persona ON cp_orden_pago.IdPersona = tb_persona.IdPersona INNER JOIN
                         cp_nota_DebCre ON cp_orden_pago_det.IdEmpresa_cxp = cp_nota_DebCre.IdEmpresa AND 
                         cp_orden_pago_det.IdCbteCble_cxp = cp_nota_DebCre.IdCbteCble_Nota AND cp_orden_pago_det.IdTipoCbte_cxp = cp_nota_DebCre.IdTipoCbte_Nota INNER JOIN
                         cp_TipoDocumento ON '05' = cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         cp_orden_pago_formapago ON cp_orden_pago.IdFormaPago = cp_orden_pago_formapago.IdFormaPago
WHERE        cp_nota_DebCre.DebCre = 'D'
UNION
SELECT        cp_orden_pago_det.IdEmpresa, cp_orden_pago_det.IdOrdenPago, cp_orden_pago_det.Secuencia, cp_orden_pago_det.IdEmpresa_cxp, 
                         cp_orden_pago_det.IdCbteCble_cxp, cp_orden_pago_det.IdTipoCbte_cxp, cp_orden_pago_det.Valor_a_pagar, cp_orden_pago.IdEstadoAprobacion, 
                         cp_orden_pago.IdTipo_Persona, cp_orden_pago.IdEntidad, cp_orden_pago.IdPersona, LTRIM(RTRIM(tb_persona.pe_nombreCompleto)) AS pe_nombreCompleto, 
                         cp_orden_pago_det.Referencia, 'OP# ' + CAST(cp_orden_pago.IdOrdenPago AS varchar) AS Referencia2, cp_orden_pago.Fecha_Pago, cp_orden_pago.Fecha_Pago, 
                         DATEDIFF(day, GETDATE(), cp_orden_pago.Fecha_Pago) AS dias_vencido, cp_orden_pago_formapago.IdFormaPago, cp_orden_pago_formapago.descripcion, 
                         cp_orden_pago.Estado, cp_orden_pago.Observacion, cp_orden_pago.Fecha_Pago, cp_orden_pago.IdTipo_op
FROM            cp_orden_pago INNER JOIN
                         cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND 
                         cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago INNER JOIN
                         tb_persona ON cp_orden_pago.IdPersona = tb_persona.IdPersona INNER JOIN
                         cp_orden_pago_formapago ON cp_orden_pago.IdFormaPago = cp_orden_pago_formapago.IdFormaPago
WHERE        NOT EXISTS
                             (SELECT        og.IdEmpresa
                               FROM            cp_orden_giro og
                               WHERE        cp_orden_pago_det.IdEmpresa_cxp = og.IdEmpresa AND cp_orden_pago_det.IdTipoCbte_cxp = og.IdTipoCbte_Ogiro AND 
                                                         cp_orden_pago_det.IdCbteCble_cxp = og.IdCbteCble_Ogiro) AND NOT EXISTS
                             (SELECT        nd.IdEmpresa
                               FROM            cp_nota_DebCre nd
                               WHERE        cp_orden_pago_det.IdEmpresa_cxp = nd.IdEmpresa AND cp_orden_pago_det.IdTipoCbte_cxp = nd.IdTipoCbte_Nota AND 
                                                         cp_orden_pago_det.IdCbteCble_cxp = nd.IdCbteCble_Nota)