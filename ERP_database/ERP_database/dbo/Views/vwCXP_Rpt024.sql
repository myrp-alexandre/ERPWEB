--querry para subreporte de retencion dentro OG
CREATE VIEW [dbo].[vwCXP_Rpt024]
AS
SELECT        cp_retencion.IdEmpresa, cp_retencion.IdRetencion, cp_retencion.serie1 + '-' +cp_retencion.serie2 as serie, cp_retencion.NumRetencion, cp_retencion.NAutorizacion, cp_retencion.fecha, 
                         cp_retencion.observacion, cp_retencion.IdEmpresa_Ogiro, cp_retencion.IdCbteCble_Ogiro, cp_retencion.IdTipoCbte_Ogiro, cp_retencion_det.Idsecuencia, 
                         cp_retencion_det.re_tipoRet, cp_retencion_det.re_baseRetencion, cp_retencion_det.IdCodigo_SRI, cp_retencion_det.re_Codigo_impuesto, 
                         cp_retencion_det.re_Porcen_retencion, cp_retencion_det.re_valor_retencion
FROM            cp_retencion INNER JOIN
                         cp_retencion_det ON cp_retencion.IdEmpresa = cp_retencion_det.IdEmpresa AND cp_retencion.IdRetencion = cp_retencion_det.IdRetencion