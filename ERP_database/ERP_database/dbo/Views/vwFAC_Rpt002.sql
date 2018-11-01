
CREATE view [vwFAC_Rpt002]
as
SELECT        fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega,fa_factura.IdCbteVta, fa_factura.vt_tipoDoc, 
                         'FA-' + fa_factura.vt_serie1 + '-' + fa_factura.vt_serie2 + '-' + fa_factura.vt_NumFactura + '/' + CAST(fa_factura.IdCbteVta AS varchar(20)) AS vt_NunDocumento, fa_factura.vt_Observacion AS Referencia, 
                         fa_factura.IdCbteVta AS IdComprobante, fa_factura.CodCbteVta AS CodComprobante, tb_sucursal.Su_Descripcion, fa_factura.IdCliente, tb_persona.pe_nombreCompleto AS nombreCliente, 
                         tb_persona.pe_cedulaRuc, fa_factura.vt_fecha, vwfa_factura_subtotal_iva_0_totales.vt_total, vwfa_factura_subtotal_iva_0_totales.vt_total - ISNULL(vwfa_factura_total_cobrado.total_cobrado, 0) AS Saldo, 
                         ISNULL(vwfa_factura_total_cobrado.total_cobrado, 0) AS TotalCobrado, vwfa_factura_subtotal_iva_0_totales.SubTotal_0 + vwfa_factura_subtotal_iva_0_totales.SubTotal_Iva AS vt_Subtotal, 
                         vwfa_factura_subtotal_iva_0_totales.vt_iva, fa_factura.vt_fech_venc, cast(0 as float) AS dc_ValorRetFu, cast(0 as float) AS dc_ValorRetIva, fa_factura.vt_plazo, '' AS IdUsuario, vwfa_factura_subtotal_iva_0_totales.SubTotal_0, 
                         vwfa_factura_subtotal_iva_0_totales.SubTotal_Iva, fa_factura_x_formaPago.IdFormaPago, fa_formaPago.nom_FormaPago, vwfa_factura_subtotal_iva_0_totales.vt_por_iva
FROM            fa_formaPago INNER JOIN
                         fa_factura_x_formaPago ON fa_formaPago.IdFormaPago = fa_factura_x_formaPago.IdFormaPago RIGHT OUTER JOIN
                         fa_factura INNER JOIN
                         fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         vwfa_factura_subtotal_iva_0_totales ON fa_factura.IdEmpresa = vwfa_factura_subtotal_iva_0_totales.IdEmpresa AND fa_factura.IdSucursal = vwfa_factura_subtotal_iva_0_totales.IdSucursal AND 
                         fa_factura.IdBodega = vwfa_factura_subtotal_iva_0_totales.IdBodega AND fa_factura.IdCbteVta = vwfa_factura_subtotal_iva_0_totales.IdCbteVta ON 
                         fa_factura_x_formaPago.IdEmpresa = fa_factura.IdEmpresa AND fa_factura_x_formaPago.IdSucursal = fa_factura.IdSucursal AND fa_factura_x_formaPago.IdBodega = fa_factura.IdBodega AND 
                         fa_factura_x_formaPago.IdCbteVta = fa_factura.IdCbteVta LEFT OUTER JOIN
                         vwfa_factura_total_cobrado ON fa_factura.IdEmpresa = vwfa_factura_total_cobrado.IdEmpresa AND fa_factura.IdSucursal = vwfa_factura_total_cobrado.IdSucursal AND 
                         fa_factura.IdBodega = vwfa_factura_total_cobrado.IdBodega AND fa_factura.IdCbteVta = vwfa_factura_total_cobrado.IdCbteVta LEFT OUTER JOIN
                         tb_sucursal ON fa_factura.IdEmpresa = tb_sucursal.IdEmpresa AND fa_factura.IdSucursal = tb_sucursal.IdSucursal
WHERE fa_factura.Estado = 'A'