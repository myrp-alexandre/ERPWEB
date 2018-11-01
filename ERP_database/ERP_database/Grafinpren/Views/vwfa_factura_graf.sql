

CREATE VIEW [Grafinpren].[vwfa_factura_graf]
AS
SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.IdSucursal, dbo.fa_factura.CodCbteVta, dbo.fa_factura.vt_tipoDoc, 
                         dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.IdCliente, dbo.fa_factura.IdVendedor, dbo.fa_factura.vt_fecha, 
                         dbo.fa_factura.vt_plazo, dbo.fa_factura.vt_fech_venc, dbo.fa_factura.vt_tipo_venta, dbo.fa_factura.vt_Observacion, dbo.fa_factura.IdPeriodo, dbo.fa_factura.vt_anio, 
                         dbo.fa_factura.vt_mes, dbo.fa_factura.IdUsuario, 
                         dbo.fa_factura.Fecha_Transaccion, dbo.fa_factura.IdUsuarioUltModi, dbo.fa_factura.Fecha_UltMod, dbo.fa_factura.IdUsuarioUltAnu, dbo.fa_factura.Fecha_UltAnu, 
                         dbo.fa_factura.MotivoAnulacion,  dbo.fa_factura.Estado, dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion, 
                         dbo.fa_factura_det.vt_Subtotal, dbo.fa_factura_det.vt_iva, dbo.fa_factura_det.vt_total,  dbo.fa_factura_det.vt_detallexItems, 
                         dbo.fa_factura_det.vt_PrecioFinal, dbo.fa_factura_det.vt_DescUnitario, dbo.fa_factura_det.vt_PorDescUnitario, dbo.fa_factura_det.vt_Precio, 
                         dbo.fa_factura_det.vt_cantidad, dbo.fa_factura_det.IdProducto, dbo.fa_factura_det.Secuencia, dbo.fa_Vendedor.Ve_Vendedor, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.fa_factura.vt_autorizacion, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.fa_factura.IdCaja, 
                         dbo.fa_factura_det.vt_por_iva, dbo.fa_factura_det.IdPunto_Cargo, dbo.fa_factura_det.vt_estado, Grafinpren.fa_factura_graf.num_op, 
                         Grafinpren.fa_factura_graf.fecha_op, Grafinpren.fa_factura_graf.num_cotizacion, Grafinpren.fa_factura_graf.fecha_cotizacion, Grafinpren.fa_factura_graf.IdEquipo, 
                         Grafinpren.fa_factura_graf.porc_comision, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_direccion
FROM            dbo.fa_factura INNER JOIN
                         dbo.tb_sucursal ON dbo.fa_factura.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.fa_factura.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND 
                         dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                         dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         Grafinpren.fa_factura_graf ON dbo.fa_factura.IdEmpresa = Grafinpren.fa_factura_graf.IdEmpresa AND 
                         dbo.fa_factura.IdSucursal = Grafinpren.fa_factura_graf.IdSucursal AND dbo.fa_factura.IdBodega = Grafinpren.fa_factura_graf.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = Grafinpren.fa_factura_graf.IdCbteVta