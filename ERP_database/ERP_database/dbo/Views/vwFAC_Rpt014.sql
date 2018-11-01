CREATE VIEW [dbo].[vwFAC_Rpt014]
	AS 


	SELECT        dbo.fa_guia_remision.IdEmpresa, dbo.fa_guia_remision.IdSucursal, dbo.fa_guia_remision.IdBodega, dbo.fa_guia_remision.IdGuiaRemision, dbo.fa_guia_remision.CodGuiaRemision, dbo.fa_guia_remision.CodDocumentoTipo, 
                         dbo.fa_guia_remision.Serie1, dbo.fa_guia_remision.Serie2, dbo.fa_guia_remision.NumGuia_Preimpresa, dbo.fa_guia_remision.NUAutorizacion, dbo.fa_guia_remision.Fecha_Autorizacion, dbo.fa_guia_remision.gi_fecha, 
                         dbo.fa_guia_remision.gi_fech_venc, dbo.fa_guia_remision.gi_Observacion, dbo.fa_guia_remision.gi_FechaFinTraslado, dbo.fa_guia_remision.gi_FechaInicioTraslado, dbo.fa_guia_remision.placa, dbo.fa_guia_remision.ruta, 
                         dbo.fa_guia_remision.Direccion_Origen, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_cedulaRuc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, 
                         dbo.fa_factura.Fecha_Autorizacion AS Expr1, dbo.fa_factura.vt_autorizacion, dbo.tb_transportista.Nombre, dbo.tb_transportista.Cedula, fa_guia_remision_det_1.gi_cantidad, fa_guia_remision_det_1.gi_detallexItems, 
                         dbo.in_Producto.pr_descripcion, dbo.in_Producto.pr_codigo, dbo.fa_cliente.IdCliente
FROM            dbo.fa_guia_remision INNER JOIN
                         dbo.fa_guia_remision_det ON dbo.fa_guia_remision.IdEmpresa = dbo.fa_guia_remision_det.IdEmpresa AND dbo.fa_guia_remision.IdSucursal = dbo.fa_guia_remision_det.IdSucursal AND 
                         dbo.fa_guia_remision.IdBodega = dbo.fa_guia_remision_det.IdBodega AND dbo.fa_guia_remision.IdGuiaRemision = dbo.fa_guia_remision_det.IdGuiaRemision INNER JOIN
                         dbo.fa_guia_remision_det_x_factura ON dbo.fa_guia_remision_det.IdEmpresa = dbo.fa_guia_remision_det_x_factura.IdEmpresa_guia AND 
                         dbo.fa_guia_remision_det.IdSucursal = dbo.fa_guia_remision_det_x_factura.IdSucursal_guia AND dbo.fa_guia_remision_det.IdBodega = dbo.fa_guia_remision_det_x_factura.IdBodega_guia AND 
                         dbo.fa_guia_remision_det.IdGuiaRemision = dbo.fa_guia_remision_det_x_factura.IdGuiaRemision_guia AND dbo.fa_guia_remision_det.Secuencia = dbo.fa_guia_remision_det_x_factura.Secuencia_guia INNER JOIN
                         dbo.fa_factura_det ON dbo.fa_guia_remision_det_x_factura.IdEmpresa_fact = dbo.fa_factura_det.IdEmpresa AND dbo.fa_guia_remision_det_x_factura.IdSucursal_fact = dbo.fa_factura_det.IdSucursal AND 
                         dbo.fa_guia_remision_det_x_factura.IdBodega_fact = dbo.fa_factura_det.IdBodega AND dbo.fa_guia_remision_det_x_factura.IdCbteVta_fact = dbo.fa_factura_det.IdCbteVta AND 
                         dbo.fa_guia_remision_det_x_factura.Secuencia_fact = dbo.fa_factura_det.Secuencia INNER JOIN
                         dbo.fa_factura ON dbo.fa_factura_det.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_factura_det.IdSucursal = dbo.fa_factura.IdSucursal AND dbo.fa_factura_det.IdBodega = dbo.fa_factura.IdBodega AND 
                         dbo.fa_factura_det.IdCbteVta = dbo.fa_factura.IdCbteVta INNER JOIN
                         dbo.fa_cliente ON dbo.fa_guia_remision.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_guia_remision.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                         dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_transportista ON dbo.fa_guia_remision.IdEmpresa = dbo.tb_transportista.IdEmpresa AND dbo.fa_guia_remision.IdTransportista = dbo.tb_transportista.IdTransportista INNER JOIN
                         dbo.fa_guia_remision_det AS fa_guia_remision_det_1 ON dbo.fa_guia_remision.IdEmpresa = fa_guia_remision_det_1.IdEmpresa AND dbo.fa_guia_remision.IdSucursal = fa_guia_remision_det_1.IdSucursal AND 
                         dbo.fa_guia_remision.IdBodega = fa_guia_remision_det_1.IdBodega AND dbo.fa_guia_remision.IdGuiaRemision = fa_guia_remision_det_1.IdGuiaRemision AND 
                         dbo.fa_guia_remision_det_x_factura.IdEmpresa_guia = fa_guia_remision_det_1.IdEmpresa AND dbo.fa_guia_remision_det_x_factura.IdSucursal_guia = fa_guia_remision_det_1.IdSucursal AND 
                         dbo.fa_guia_remision_det_x_factura.IdBodega_guia = fa_guia_remision_det_1.IdBodega AND dbo.fa_guia_remision_det_x_factura.IdGuiaRemision_guia = fa_guia_remision_det_1.IdGuiaRemision AND 
                         dbo.fa_guia_remision_det_x_factura.Secuencia_guia = fa_guia_remision_det_1.Secuencia INNER JOIN
                         dbo.in_Producto ON dbo.fa_guia_remision_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_guia_remision_det.IdProducto = dbo.in_Producto.IdProducto
