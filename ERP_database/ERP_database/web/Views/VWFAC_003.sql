CREATE VIEW web.VWFAC_003
AS
SELECT dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.Secuencia, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, 
                  dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, dbo.fa_factura_det.IdProducto, dbo.in_Producto.pr_descripcion + ' - ' + pre.nom_presentacion AS pr_descripcion, dbo.fa_factura_det.vt_cantidad, 
                  dbo.fa_factura_det.vt_Precio, dbo.fa_factura_det.vt_Subtotal, dbo.fa_factura_det.vt_detallexItems AS Observacion_x_item, dbo.fa_factura.IdCliente, con.Nombres AS pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 
                  con.Direccion AS pe_direccion, con.Telefono AS pe_telefonoOfic, dbo.fa_factura.vt_Observacion AS Observacion_central, DAY(dbo.fa_factura.vt_fecha) AS dia, MONTH(dbo.fa_factura.vt_fecha) AS mes, YEAR(dbo.fa_factura.vt_fecha) 
                  AS anio, dbo.fa_factura_det.vt_iva, CASE WHEN dbo.fa_factura_det.vt_iva = 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_0, 
                  CASE WHEN dbo.fa_factura_det.vt_iva <> 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_iva, dbo.fa_factura_det.vt_total, 
                  CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '01' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_EFECTIVO, 
                  CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '17' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_DINERO_ELECTRONICO, CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '16' OR
                  dbo.fa_factura_x_formaPago.IdFormaPago = '19' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_TARJETA_CRE_DEB, CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago NOT IN ('01', '17', '16', '19') 
                  THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_CHEQUE_TRANSFERENCIA, dbo.fa_factura_det.vt_DescUnitario * dbo.fa_factura_det.vt_cantidad AS descto, dbo.in_Producto.pr_descripcion_2, 
                  dbo.fa_factura_det.IdCod_Impuesto_Iva + ' %' AS vt_por_iva, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, dbo.fa_factura_det.vt_PorDescUnitario, dbo.fa_factura_det.vt_DescUnitario, dbo.fa_factura_det.vt_PrecioFinal, 
                  dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_fech_venc, dbo.in_Producto.lote_fecha_fab, dbo.in_Producto.lote_fecha_vcto, dbo.in_Producto.lote_num_lote, dbo.tb_persona.pe_razonSocial
FROM     dbo.fa_factura INNER JOIN
                  dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND 
                  dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                  dbo.in_Producto ON dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto AND dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                  dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                  dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                  dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                  dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona AND dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                  dbo.tb_sis_Impuesto ON dbo.fa_factura_det.IdCod_Impuesto_Iva = dbo.tb_sis_Impuesto.IdCod_Impuesto INNER JOIN
                  dbo.fa_cliente_contactos AS con ON con.IdEmpresa = dbo.fa_cliente.IdEmpresa AND con.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_factura.IdEmpresa = con.IdEmpresa AND dbo.fa_factura.IdCliente = con.IdCliente AND 
                  dbo.fa_factura.IdContacto = con.IdContacto INNER JOIN
                  dbo.tb_ciudad ON con.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                  dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor LEFT OUTER JOIN
                  dbo.fa_factura_x_formaPago ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_x_formaPago.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_x_formaPago.IdSucursal AND 
                  dbo.fa_factura.IdBodega = dbo.fa_factura_x_formaPago.IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_x_formaPago.IdCbteVta INNER JOIN
                  dbo.in_presentacion AS pre ON pre.IdEmpresa = dbo.in_Producto.IdEmpresa AND pre.IdPresentacion = dbo.in_Producto.IdPresentacion
UNION ALL
SELECT c.IdEmpresa, c.IdSucursal, c.IdBodega, c.IdCbteVta, 99, c.vt_tipoDoc, c.vt_serie1, c.vt_serie2, c.vt_NumFactura, c.vt_fecha, c.Estado, 0, c.vt_Observacion, 0, 0, 0, '', c.IdCliente, con.Nombres, per.pe_cedulaRuc, con.Direccion, con.Telefono, 
                  c.vt_Observacion, day(c.vt_fecha), month(c.vt_fecha), year(c.vt_fecha), 0, 0, 0, 0, 0, 0, 0, 0, 0, c.vt_Observacion, '', ciu.Descripcion_Ciudad, '', 0, 0, 0, ve.Ve_Vendedor, c.vt_fech_venc, NULL, NULL, NULL, PER.pe_razonSocial
FROM     fa_factura AS c INNER JOIN
                  fa_cliente AS cli ON cli.IdEmpresa = c.IdEmpresa AND cli.IdCliente = c.IdCliente INNER JOIN
                  fa_cliente_contactos AS con ON con.IdEmpresa = c.IdEmpresa AND con.IdCliente = c.IdCliente AND con.IdContacto = c.IdContacto INNER JOIN
                  tb_persona AS per ON cli.IdPersona = per.IdPersona INNER JOIN
                  tb_ciudad AS ciu ON con.IdCiudad = ciu.IdCiudad INNER JOIN
                  fa_Vendedor AS ve ON ve.IdEmpresa = c.IdEmpresa AND ve.IdVendedor = c.IdVendedor
WHERE  c.vt_Observacion IS NOT NULL AND c.vt_Observacion <> ''