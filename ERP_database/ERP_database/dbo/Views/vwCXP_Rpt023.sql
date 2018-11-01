---querry para comprobante de retencion
create view [dbo].[vwCXP_Rpt023]
as
SELECT        dbo.cp_retencion.IdEmpresa, dbo.cp_retencion.IdRetencion, dbo.cp_retencion.serie1 + '-' + dbo.cp_retencion.serie2 as serie, dbo.cp_retencion.NumRetencion, dbo.cp_retencion.NAutorizacion, 
                         dbo.cp_retencion.fecha, dbo.cp_retencion.observacion, dbo.cp_retencion.IdEmpresa_Ogiro, dbo.cp_retencion.IdCbteCble_Ogiro, dbo.cp_retencion.IdTipoCbte_Ogiro, 
                         dbo.cp_retencion_det.Idsecuencia, dbo.cp_retencion_det.re_tipoRet, dbo.cp_retencion_det.re_baseRetencion, dbo.cp_retencion_det.IdCodigo_SRI, 
                         dbo.cp_retencion_det.re_Codigo_impuesto, dbo.cp_retencion_det.re_Porcen_retencion, dbo.cp_retencion_det.re_valor_retencion, dbo.cp_proveedor.IdProveedor, 
                         dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.tb_persona.pe_direccion, dbo.cp_TipoDocumento.CodTipoDocumento, dbo.cp_TipoDocumento.Descripcion, dbo.cp_orden_giro.co_serie, 
                         dbo.cp_orden_giro.co_factura, dbo.cp_orden_giro.Num_Autorizacion
FROM            dbo.tb_persona INNER JOIN
                         dbo.cp_proveedor ON dbo.tb_persona.IdPersona = dbo.cp_proveedor.IdPersona INNER JOIN
                         dbo.cp_orden_giro ON dbo.cp_proveedor.IdEmpresa = dbo.cp_orden_giro.IdEmpresa AND 
                         dbo.cp_proveedor.IdProveedor = dbo.cp_orden_giro.IdProveedor INNER JOIN
                         dbo.cp_retencion INNER JOIN
                         dbo.cp_retencion_det ON dbo.cp_retencion.IdEmpresa = dbo.cp_retencion_det.IdEmpresa AND dbo.cp_retencion.IdRetencion = dbo.cp_retencion_det.IdRetencion ON 
                         dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro AND dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento