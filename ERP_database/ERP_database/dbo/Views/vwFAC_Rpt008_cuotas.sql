CREATE VIEW [dbo].[vwFAC_Rpt008_cuotas]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY IdEmpresa), 0) AS IdRow, *
FROM     (SELECT dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.Secuencia, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, 
                                    dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, dbo.fa_factura_det.IdProducto, dbo.in_Producto.pr_descripcion + ' - ' + pre.nom_presentacion + ' - ' + isnull(in_producto.lote_num_lote,'') AS pr_descripcion, 
                                    dbo.fa_factura_det.vt_cantidad, dbo.fa_factura_det.vt_Precio, dbo.fa_factura_det.vt_Subtotal, dbo.fa_factura_det.vt_detallexItems AS Observacion_x_item, dbo.fa_factura.IdCliente, con.Nombres AS pe_nombreCompleto, 
                                    dbo.tb_persona.pe_cedulaRuc, con.Direccion AS pe_direccion, con.Telefono AS pe_telefonoOfic, dbo.fa_factura.vt_Observacion AS Observacion_central, DAY(dbo.fa_factura.vt_fecha) AS dia, MONTH(dbo.fa_factura.vt_fecha) 
                                    AS mes, YEAR(dbo.fa_factura.vt_fecha) AS anio, dbo.fa_factura_det.vt_iva, CASE WHEN dbo.fa_factura_det.vt_iva = 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_0, 
                                    CASE WHEN dbo.fa_factura_det.vt_iva <> 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_iva, dbo.fa_factura_det.vt_total, 
                                    CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '01' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_EFECTIVO, 
                                    CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '17' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_DINERO_ELECTRONICO, CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '16' OR
                                    dbo.fa_factura_x_formaPago.IdFormaPago = '19' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_TARJETA_CRE_DEB, CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago NOT IN ('01', '17', '16', '19') 
                                    THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_CHEQUE_TRANSFERENCIA, dbo.fa_factura_det.vt_DescUnitario * dbo.fa_factura_det.vt_cantidad AS descto, dbo.in_Producto.pr_descripcion_2, 
                                    dbo.fa_factura_det.IdCod_Impuesto_Iva + ' %' AS vt_por_iva, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, dbo.fa_factura_det.vt_PorDescUnitario, dbo.fa_factura_det.vt_DescUnitario, 
                                    dbo.fa_factura_det.vt_PrecioFinal, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_fech_venc, dbo.in_Producto.lote_fecha_fab, dbo.in_Producto.lote_fecha_vcto, dbo.in_Producto.lote_num_lote, 
                                    dbo.tb_persona.pe_razonSocial, 1 orden
                  FROM      dbo.fa_factura INNER JOIN
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
                  SELECT dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.Secuencia, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, 
                                    dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, dbo.fa_factura_det.IdProducto, 'MARCA: ' + in_Marca.Descripcion, 0 AS Expr1, 0 AS Expr2, 0 AS Expr3, 
                                    dbo.fa_factura_det.vt_detallexItems, dbo.fa_factura.IdCliente, dbo.fa_cliente_contactos.Nombres, dbo.tb_persona.pe_cedulaRuc, dbo.fa_cliente_contactos.Direccion, dbo.fa_cliente_contactos.Telefono, 
                                    dbo.fa_factura.vt_Observacion, 0 AS Expr4, dbo.fa_factura.vt_mes, dbo.fa_factura.vt_anio, 0 AS Expr5, 0 AS Expr6, 0 AS Expr7, 0 AS Expr8, 0 AS Expr9, 0 AS Expr10, 0 AS Expr11, 0 AS Expr12, 0 AS Expr13, 
                                    in_Producto.pr_descripcion_2, dbo.tb_sis_Impuesto.nom_impuesto, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, 0 AS Expr14, 0 AS Expr15, 0 AS Expr16, dbo.fa_Vendedor.Ve_Vendedor, 
                                    dbo.fa_factura.vt_fech_venc, NULL AS Expr17, NULL AS Expr18, NULL AS Expr19, dbo.tb_persona.pe_razonSocial, 2 orden
                  FROM     dbo.fa_factura_det INNER JOIN
                                    dbo.fa_factura ON dbo.fa_factura_det.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_factura_det.IdSucursal = dbo.fa_factura.IdSucursal AND dbo.fa_factura_det.IdBodega = dbo.fa_factura.IdBodega AND 
                                    dbo.fa_factura_det.IdCbteVta = dbo.fa_factura.IdCbteVta INNER JOIN
                                    dbo.in_Producto ON dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                                    dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                                    dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto INNER JOIN
                                    dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_cliente_contactos.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                                    dbo.fa_cliente_contactos.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                    dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                                    dbo.tb_sis_Impuesto ON dbo.fa_factura_det.IdCod_Impuesto_Iva = dbo.tb_sis_Impuesto.IdCod_Impuesto INNER JOIN
                                    dbo.tb_ciudad ON dbo.fa_cliente_contactos.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                                    dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                                    dbo.in_Marca ON dbo.in_Producto.IdEmpresa = dbo.in_Marca.IdEmpresa AND dbo.in_Producto.IdMarca = dbo.in_Marca.IdMarca
                  UNION ALL
                  SELECT dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.Secuencia, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, 
                                    dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, dbo.fa_factura_det.IdProducto, 'MODELO: ' + in_presentacion.nom_presentacion, 0 AS Expr1, 0 AS Expr2, 0 AS Expr3, 
                                    dbo.fa_factura_det.vt_detallexItems, dbo.fa_factura.IdCliente, dbo.fa_cliente_contactos.Nombres, dbo.tb_persona.pe_cedulaRuc, dbo.fa_cliente_contactos.Direccion, dbo.fa_cliente_contactos.Telefono, 
                                    dbo.fa_factura.vt_Observacion, 0 AS Expr4, dbo.fa_factura.vt_mes, dbo.fa_factura.vt_anio, 0 AS Expr5, 0 AS Expr6, 0 AS Expr7, 0 AS Expr8, 0 AS Expr9, 0 AS Expr10, 0 AS Expr11, 0 AS Expr12, 0 AS Expr13, 
                                    in_Producto.pr_descripcion_2, dbo.tb_sis_Impuesto.nom_impuesto, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, 0 AS Expr14, 0 AS Expr15, 0 AS Expr16, dbo.fa_Vendedor.Ve_Vendedor, 
                                    dbo.fa_factura.vt_fech_venc, NULL AS Expr17, NULL AS Expr18, NULL AS Expr19, dbo.tb_persona.pe_razonSocial, 3 orden
                  FROM     dbo.fa_factura_det INNER JOIN
                                    dbo.fa_factura ON dbo.fa_factura_det.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_factura_det.IdSucursal = dbo.fa_factura.IdSucursal AND dbo.fa_factura_det.IdBodega = dbo.fa_factura.IdBodega AND 
                                    dbo.fa_factura_det.IdCbteVta = dbo.fa_factura.IdCbteVta INNER JOIN
                                    dbo.in_Producto ON dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                                    dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                                    dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto INNER JOIN
                                    dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_cliente_contactos.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                                    dbo.fa_cliente_contactos.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                    dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                                    dbo.tb_sis_Impuesto ON dbo.fa_factura_det.IdCod_Impuesto_Iva = dbo.tb_sis_Impuesto.IdCod_Impuesto INNER JOIN
                                    dbo.tb_ciudad ON dbo.fa_cliente_contactos.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                                    dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                                    dbo.in_presentacion ON dbo.in_Producto.IdEmpresa = in_presentacion.IdEmpresa AND in_Producto.IdPresentacion = in_presentacion.IdPresentacion
                  UNION ALL
                  SELECT dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, 25 AS Expr20, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, 
                                    dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, 0 AS Expr1, fa_factura.vt_Observacion AS Expr21, 0 AS Expr2, 0 AS Expr3, 0 AS Expr4, '' AS Expr22, dbo.fa_factura.IdCliente, 
                                    dbo.fa_cliente_contactos.Nombres, dbo.tb_persona.pe_cedulaRuc, dbo.fa_cliente_contactos.Direccion, dbo.fa_cliente_contactos.Telefono, dbo.fa_factura.vt_Observacion, 0 AS Expr5, dbo.fa_factura.vt_mes, 
                                    dbo.fa_factura.vt_anio, 0 AS Expr6, 0 AS Expr7, 0 AS Expr8, 0 AS Expr9, 0 AS Expr10, 0 AS Expr11, 0 AS Expr12, 0 AS Expr13, 0 AS Expr14, '' AS Expr23, '' AS Expr24, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, 
                                    0 AS Expr15, 0 AS Expr16, 0 AS Expr25, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_fech_venc, NULL AS Expr17, NULL AS Expr18, NULL AS Expr19, dbo.tb_persona.pe_razonSocial, 4 AS orden
                  FROM     dbo.fa_factura INNER JOIN
                                    dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                                    dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto INNER JOIN
                                    dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_cliente_contactos.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                                    dbo.fa_cliente_contactos.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                    dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                                    dbo.tb_ciudad ON dbo.fa_cliente_contactos.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                                    dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor
                  UNION ALL
                  SELECT dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdSucursal, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, 100 + fa_cuotas_x_doc.secuencia AS Expr20, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, 
                                    dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, 0 AS Expr1, CONVERT(varchar(10), fa_cuotas_x_doc.fecha_vcto_cuota, 103) 
                                    + '    ' + cast(FORMAT(fa_cuotas_x_doc.valor_a_cobrar, 'C', 'en-us') AS varchar(20)) AS Expr21, 0 AS Expr2, 0 AS Expr3, 0 AS Expr4, '' AS Expr22, dbo.fa_factura.IdCliente, dbo.fa_cliente_contactos.Nombres, 
                                    dbo.tb_persona.pe_cedulaRuc, dbo.fa_cliente_contactos.Direccion, dbo.fa_cliente_contactos.Telefono, dbo.fa_factura.vt_Observacion, 0 AS Expr5, dbo.fa_factura.vt_mes, dbo.fa_factura.vt_anio, 0 AS Expr6, 0 AS Expr7, 
                                    0 AS Expr8, 0 AS Expr9, 0 AS Expr10, 0 AS Expr11, 0 AS Expr12, 0 AS Expr13, 0 AS Expr14, '' AS Expr23, '' AS Expr24, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, 0 AS Expr15, 0 AS Expr16, 0 AS Expr25, 
                                    dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_fech_venc, NULL AS Expr17, NULL AS Expr18, NULL AS Expr19, dbo.tb_persona.pe_razonSocial, 5 AS orden
                  FROM     dbo.fa_factura INNER JOIN
                                    dbo.fa_cliente_contactos ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente_contactos.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente_contactos.IdCliente AND 
                                    dbo.fa_factura.IdContacto = dbo.fa_cliente_contactos.IdContacto INNER JOIN
                                    dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_cliente_contactos.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                                    dbo.fa_cliente_contactos.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                                    dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                                    dbo.tb_ciudad ON dbo.fa_cliente_contactos.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                                    dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                                    dbo.fa_cuotas_x_doc ON dbo.fa_factura.IdEmpresa = dbo.fa_cuotas_x_doc.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_cuotas_x_doc.IdSucursal AND dbo.fa_factura.IdBodega = dbo.fa_cuotas_x_doc.IdBodega AND 
                                    dbo.fa_factura.IdCbteVta = dbo.fa_cuotas_x_doc.IdCbteVta) AS A