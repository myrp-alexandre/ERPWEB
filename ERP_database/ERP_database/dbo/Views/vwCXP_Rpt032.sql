--select * from tb_sis_reporte where modulo='CXP'
CREATE view vwCXP_Rpt032
AS
SELECT        cp_conciliacion_Caja_det.IdEmpresa, cp_conciliacion_Caja_det.IdConciliacion_Caja, cp_conciliacion_Caja_det.Secuencia, cp_conciliacion_Caja_det.IdEmpresa_OGiro, 
                         cp_conciliacion_Caja_det.IdCbteCble_Ogiro, cp_conciliacion_Caja_det.IdTipoCbte_Ogiro, cp_conciliacion_Caja_det.IdTipoMovi, cp_conciliacion_Caja_det.Valor_a_aplicar, 
                         cp_conciliacion_Caja_det.Tipo_documento, cp_conciliacion_Caja_det.IdEmpresa_OP, cp_conciliacion_Caja_det.IdOrdenPago_OP, cp_orden_giro.IdProveedor, pe_nombreCompleto pr_nombre, cp_orden_giro.co_serie, 
                         cp_orden_giro.co_factura, cp_orden_giro.co_FechaFactura, cp_orden_giro.co_FechaFactura_vct, cp_orden_giro.co_plazo, cp_orden_giro.co_observacion, cp_orden_giro.co_baseImponible, 
                         cp_orden_giro.co_total, cp_orden_giro.co_valorpagar, cp_TipoDocumento.Codigo, cp_conciliacion_Caja_det.IdCentroCosto, ct_centro_costo.Centro_costo AS nom_centro_costo
FROM            cp_conciliacion_Caja_det INNER JOIN
                         cp_orden_giro ON cp_conciliacion_Caja_det.IdEmpresa_OGiro = cp_orden_giro.IdEmpresa AND cp_conciliacion_Caja_det.IdCbteCble_Ogiro = cp_orden_giro.IdCbteCble_Ogiro AND 
                         cp_conciliacion_Caja_det.IdTipoCbte_Ogiro = cp_orden_giro.IdTipoCbte_Ogiro INNER JOIN
                         cp_proveedor ON cp_orden_giro.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_giro.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                         cp_TipoDocumento ON cp_orden_giro.IdOrden_giro_Tipo = cp_TipoDocumento.CodTipoDocumento LEFT OUTER JOIN
                         ct_centro_costo ON cp_conciliacion_Caja_det.IdEmpresa = ct_centro_costo.IdEmpresa AND cp_conciliacion_Caja_det.IdCentroCosto = ct_centro_costo.IdCentroCosto
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona