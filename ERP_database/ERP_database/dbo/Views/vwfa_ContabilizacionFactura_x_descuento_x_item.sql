CREATE VIEW  vwfa_ContabilizacionFactura_x_descuento_x_item
AS
SELECT        dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_descuento.de_IdCtaCble, 
                         dbo.fa_factura_det_x_fa_descuento.de_valor, dbo.fa_factura_det.vt_iva, dbo.fa_factura_det.IdPunto_cargo_grupo, dbo.fa_factura_det.IdPunto_Cargo, 
                         dbo.fa_factura_det.IdCentroCosto, dbo.fa_factura_det.IdCentroCosto_sub_centro_costo, dbo.fa_factura_det.vt_DescUnitario
FROM            dbo.fa_descuento INNER JOIN
                         dbo.fa_factura_det_x_fa_descuento ON dbo.fa_descuento.IdEmpresa = dbo.fa_factura_det_x_fa_descuento.IdEmpresa_de AND 
                         dbo.fa_descuento.IdDescuento = dbo.fa_factura_det_x_fa_descuento.IdDescuento RIGHT OUTER JOIN
                         dbo.fa_factura_det ON dbo.fa_factura_det_x_fa_descuento.IdEmpresa_fa = dbo.fa_factura_det.IdEmpresa AND 
                         dbo.fa_factura_det_x_fa_descuento.IdSucursal = dbo.fa_factura_det.IdSucursal AND 
                         dbo.fa_factura_det_x_fa_descuento.IdBodega = dbo.fa_factura_det.IdBodega AND dbo.fa_factura_det_x_fa_descuento.IdCbteVta = dbo.fa_factura_det.IdCbteVta AND 
                         dbo.fa_factura_det_x_fa_descuento.Secuencia = dbo.fa_factura_det.Secuencia
WHERE        (dbo.fa_factura_det.vt_DescUnitario > 0)