/*select * from vwFAC_Rpt007*/
CREATE VIEW dbo.vwFAC_Rpt009
AS
SELECT        dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb_det.Secuencia, dbo.fa_TipoNota.CodTipoNota, 
                         (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END) AS IdTipoDocumento, 
                         dbo.fa_notaCreDeb.Serie1 + '-' + dbo.fa_notaCreDeb.Serie2 + '-' + dbo.fa_notaCreDeb.NumNota_Impresa + '/' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) AS numDocumento, dbo.fa_notaCreDeb.IdCliente, 
                         dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, null pe_telefonoCasa, dbo.tb_persona.pe_direccion, 
                         dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.no_fecha_venc, DATEDIFF(day, dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.no_fecha_venc) AS Plazo, dbo.fa_notaCreDeb.IdTipoNota, dbo.fa_notaCreDeb.sc_observacion, 
                         dbo.fa_notaCreDeb_det.sc_cantidad, dbo.fa_notaCreDeb_det.sc_Precio, dbo.fa_notaCreDeb_det.sc_subtotal, dbo.fa_notaCreDeb_det.sc_iva, 
                         CASE WHEN dbo.fa_notaCreDeb_det.sc_iva = 0 THEN dbo.fa_notaCreDeb_det.sc_total ELSE 0 END AS subtotal0, CASE WHEN dbo.fa_notaCreDeb_det.sc_iva > 0 THEN dbo.fa_notaCreDeb_det.sc_total ELSE 0 END AS subtotal12,
                          dbo.in_Producto.IdProducto, dbo.in_Producto.pr_descripcion AS nombreProducto, dbo.tb_bodega.bo_Descripcion, dbo.fa_notaCreDeb.IdUsuario, dbo.tb_sucursal.Su_Descripcion, 
                         dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, 
                         dbo.fa_notaCreDeb_det.sc_PordescUni, dbo.fa_notaCreDeb_det.sc_descUni
FROM            dbo.fa_notaCreDeb_x_fa_factura_NotaDeb INNER JOIN
                         dbo.fa_factura ON dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_fac_nd_doc_mod = dbo.fa_factura.IdEmpresa AND 
                         dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_fac_nd_doc_mod = dbo.fa_factura.IdSucursal AND dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_fac_nd_doc_mod = dbo.fa_factura.IdBodega AND 
                         dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdCbteVta_fac_nd_doc_mod = dbo.fa_factura.IdCbteVta INNER JOIN
                         dbo.fa_notaCreDeb INNER JOIN
                         dbo.fa_notaCreDeb_det ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_notaCreDeb_det.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = dbo.fa_notaCreDeb_det.IdSucursal AND 
                         dbo.fa_notaCreDeb.IdBodega = dbo.fa_notaCreDeb_det.IdBodega AND dbo.fa_notaCreDeb.IdNota = dbo.fa_notaCreDeb_det.IdNota  INNER JOIN
                         dbo.fa_cliente ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_notaCreDeb.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_bodega ON dbo.fa_notaCreDeb.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = dbo.tb_bodega.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.fa_TipoNota ON dbo.fa_notaCreDeb.IdTipoNota = dbo.fa_TipoNota.IdTipoNota INNER JOIN
                         dbo.in_Producto ON dbo.fa_notaCreDeb_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_notaCreDeb_det.IdProducto = dbo.in_Producto.IdProducto ON 
                         dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdEmpresa_nt = dbo.fa_notaCreDeb.IdEmpresa AND dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdSucursal_nt = dbo.fa_notaCreDeb.IdSucursal AND 
                         dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdBodega_nt = dbo.fa_notaCreDeb.IdBodega AND dbo.fa_notaCreDeb_x_fa_factura_NotaDeb.IdNota_nt = dbo.fa_notaCreDeb.IdNota