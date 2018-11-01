CREATE VIEW vwfa_factura_x_in_movi_inve
AS
SELECT        dbo.fa_factura_x_in_movi_inve.fa_IdEmpresa, dbo.fa_factura_x_in_movi_inve.fa_IdSucursal, dbo.fa_factura_x_in_movi_inve.fa_IdBodega, 
                         dbo.fa_factura_x_in_movi_inve.fa_IdCbteVta, dbo.fa_factura_x_in_movi_inve.inv_IdEmpresa, dbo.fa_factura_x_in_movi_inve.inv_IdSucursal, 
                         dbo.fa_factura_x_in_movi_inve.inv_IdBodega, dbo.fa_factura_x_in_movi_inve.inv_IdMovi_inven_tipo, dbo.fa_factura_x_in_movi_inve.inv_IdNumMovi, 
                         dbo.fa_factura_x_in_movi_inve.Observacion, dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi
FROM            dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.fa_factura_x_in_movi_inve ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv = dbo.fa_factura_x_in_movi_inve.inv_IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_inv = dbo.fa_factura_x_in_movi_inve.inv_IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega_inv = dbo.fa_factura_x_in_movi_inve.inv_IdBodega AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv = dbo.fa_factura_x_in_movi_inve.inv_IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv = dbo.fa_factura_x_in_movi_inve.inv_IdNumMovi
GROUP BY dbo.fa_factura_x_in_movi_inve.fa_IdEmpresa, dbo.fa_factura_x_in_movi_inve.fa_IdSucursal, dbo.fa_factura_x_in_movi_inve.fa_IdBodega, 
                         dbo.fa_factura_x_in_movi_inve.fa_IdCbteVta, dbo.fa_factura_x_in_movi_inve.inv_IdEmpresa, dbo.fa_factura_x_in_movi_inve.inv_IdSucursal, 
                         dbo.fa_factura_x_in_movi_inve.inv_IdBodega, dbo.fa_factura_x_in_movi_inve.inv_IdMovi_inven_tipo, dbo.fa_factura_x_in_movi_inve.inv_IdNumMovi, 
                         dbo.fa_factura_x_in_movi_inve.Observacion, dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi