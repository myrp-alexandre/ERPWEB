

create VIEW [dbo].[vwCXP_Rpt034]
AS
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_orden_giro.IdProveedor, dbo.vwcp_ProveedorRuc.pr_nombre AS nom_proveedor, dbo.vwcp_ProveedorRuc.pe_cedulaRuc AS ced_proveedor, 
                         dbo.vwcp_ProveedorRuc.pe_direccion AS dir_proveedor, dbo.cp_orden_giro.co_fechaOg, dbo.cp_orden_giro.co_serie, dbo.cp_orden_giro.co_factura AS num_factura, 
                         dbo.cp_orden_giro.co_FechaFactura, dbo.cp_orden_giro.Estado, dbo.cp_TipoDocumento.Descripcion AS TipoDocumento, dbo.cp_retencion.fecha AS fecha_retencion, 
                         YEAR(dbo.cp_retencion.fecha) AS ejercicio_fiscal, dbo.cp_retencion_det.IdRetencion, dbo.cp_retencion_det.Idsecuencia, 
                         dbo.cp_retencion_det.re_tipoRet AS Impuesto, dbo.cp_retencion_det.re_baseRetencion AS base_retencion, dbo.cp_retencion_det.IdCodigo_SRI, 
                         dbo.cp_codigo_SRI.codigoSRI AS cod_Impuesto_SRI, dbo.cp_codigo_SRI.co_porRetencion AS por_Retencion_SRI, 
                         dbo.cp_retencion_det.re_valor_retencion AS valor_Retenido, dbo.cp_retencion.IdEmpresa_Ogiro, dbo.cp_retencion.serie1 + '-'+ dbo.cp_retencion.serie2  as serie, dbo.cp_retencion.NumRetencion, 
                         dbo.cp_retencion.re_EstaImpresa, dbo.cp_TipoDocumento.Codigo AS cod_Tipo_Documento
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.vwcp_ProveedorRuc ON dbo.cp_orden_giro.IdEmpresa = dbo.vwcp_ProveedorRuc.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.vwcp_ProveedorRuc.IdProveedor INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_retencion ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro AND 
                         dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro INNER JOIN
                         dbo.cp_retencion_det ON dbo.cp_retencion.IdEmpresa = dbo.cp_retencion_det.IdEmpresa AND 
                         dbo.cp_retencion.IdRetencion = dbo.cp_retencion_det.IdRetencion INNER JOIN
                         dbo.cp_codigo_SRI ON dbo.cp_retencion_det.IdCodigo_SRI = dbo.cp_codigo_SRI.IdCodigo_SRI