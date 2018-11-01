CREATE VIEW [dbo].[vwfa_ContabilizacionFactura_x_Item]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY fac.IdEmpresa), 0) IdRow, 
fac.IdEmpresa, fac.IdSucursal, fac.IdBodega, fac.IdCbteVta, SUM(fac.vt_Subtotal) AS Subtotal, SUM(fac.vt_DescUnitario) AS Descuento, SUM(fac.vt_iva) AS iva, 
SUM(fac.vt_total) AS Total, Pro_Bod.IdCtaCble_Vta AS IdCtaCble_Ven0, Pro_Bod.IdCtaCble_Vta AS IdCtaCble_VenIva, dbo.fa_factura.vt_tipo_venta, dbo.fa_factura.vt_plazo, '' IdCtaCble_DesIva, '' IdCtaCble_Des0, fac.Secuencia, 
Pro_Bod.IdProducto, fac.IdCod_Impuesto_Iva, fac.IdCod_Impuesto_Ice, fac.IdCentroCosto, fac.IdCentroCosto_sub_centro_costo, dbo.tb_sis_Impuesto_x_ctacble.IdCtaCble AS IdCtaCble_Imp_Iva, 
tb_sis_Impuesto_x_ctacble_1.IdCtaCble AS IdCtaCble_Imp_Ice, fac.IdPunto_Cargo, fac.IdPunto_cargo_grupo, dbo.in_categorias.IdCtaCble_venta IdCtaCble_venta_categoria, dbo.in_categorias.IdCtaCtble_Costo IdCtaCtble_Costo_categoria, 
dbo.in_categorias.IdCtaCtble_Inve IdCtaCtble_Inve_categoria, tb_sis_Impuesto_x_ctacble.IdCtaCble_vta AS IdCtaCble_vta_x_impuesto
FROM     dbo.fa_factura_det AS fac INNER JOIN
                  dbo.fa_factura ON dbo.fa_factura.IdEmpresa = fac.IdEmpresa AND dbo.fa_factura.IdSucursal = fac.IdSucursal AND dbo.fa_factura.IdBodega = fac.IdBodega AND dbo.fa_factura.IdCbteVta = fac.IdCbteVta INNER JOIN
                  dbo.in_Producto ON fac.IdEmpresa = dbo.in_Producto.IdEmpresa AND fac.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                  dbo.in_categorias ON dbo.in_Producto.IdEmpresa = dbo.in_categorias.IdEmpresa AND dbo.in_Producto.IdCategoria = dbo.in_categorias.IdCategoria LEFT OUTER JOIN
                  dbo.in_producto_x_tb_bodega AS Pro_Bod ON fac.IdEmpresa = Pro_Bod.IdEmpresa AND fac.IdSucursal = Pro_Bod.IdSucursal AND fac.IdBodega = Pro_Bod.IdBodega AND fac.IdProducto = Pro_Bod.IdProducto LEFT OUTER JOIN
                  dbo.tb_sis_Impuesto_x_ctacble ON fac.IdEmpresa = dbo.tb_sis_Impuesto_x_ctacble.IdEmpresa_cta AND fac.IdCod_Impuesto_Iva = dbo.tb_sis_Impuesto_x_ctacble.IdCod_Impuesto LEFT OUTER JOIN
                  dbo.tb_sis_Impuesto_x_ctacble AS tb_sis_Impuesto_x_ctacble_1 ON fac.IdEmpresa = tb_sis_Impuesto_x_ctacble_1.IdEmpresa_cta AND fac.IdCod_Impuesto_Ice = tb_sis_Impuesto_x_ctacble_1.IdCod_Impuesto
GROUP BY fac.IdEmpresa, fac.IdSucursal, fac.IdBodega, fac.IdCbteVta, Pro_Bod.IdCtaCble_Vta, Pro_Bod.IdCtaCble_Vta, dbo.fa_factura.vt_tipo_venta, dbo.fa_factura.vt_plazo,  fac.Secuencia, 
                  Pro_Bod.IdProducto, fac.IdCod_Impuesto_Iva, fac.IdCod_Impuesto_Ice, fac.IdCentroCosto, fac.IdCentroCosto_sub_centro_costo, dbo.tb_sis_Impuesto_x_ctacble.IdCtaCble, tb_sis_Impuesto_x_ctacble_1.IdCtaCble, fac.IdPunto_Cargo, 
                  fac.IdPunto_cargo_grupo, dbo.in_categorias.IdCtaCble_venta, dbo.in_categorias.IdCtaCtble_Costo, dbo.in_categorias.IdCtaCtble_Inve, tb_sis_Impuesto_x_ctacble.IdCtaCble_vta
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[3] 2[38] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "fac"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 292
               Left = 576
               Bottom = 422
               Right = 784
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sis_Impuesto_x_ctacble"
            Begin Extent = 
               Top = 130
               Left = 819
               Bottom = 260
               Right = 1011
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sis_Impuesto_x_ctacble_1"
            Begin Extent = 
               Top = 241
               Left = 888
               Bottom = 371
               Right = 1080
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pro_Bod"
            Begin Extent = 
               Top = 6
               Left = 1061
               Bottom = 140
               Right = 1367
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 166
               Left = 1251
               Bottom = 387
               Right = 1501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_categorias"
            Begin Extent = 
               Top = 383
               Left = 846
               Bottom = 609
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_ContabilizacionFactura_x_Item';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 1091
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_ContabilizacionFactura_x_Item';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_ContabilizacionFactura_x_Item';

