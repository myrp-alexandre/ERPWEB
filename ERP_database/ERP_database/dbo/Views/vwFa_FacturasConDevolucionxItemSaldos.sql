CREATE VIEW [dbo].[vwFa_FacturasConDevolucionxItemSaldos]
AS
SELECT        dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.IdProducto, 
                         dbo.fa_factura_det.vt_cantidad, ISNULL(dbo.vwFa_FacturasxDevolucionxItem.dv_cantidad, 0) AS dv_cantidad, 
                         dbo.fa_factura_det.vt_cantidad - ISNULL(dbo.vwFa_FacturasxDevolucionxItem.dv_cantidad, 0) AS dv_saldo,
                         dbo.fa_factura_det.vt_PorDescUnitario, dbo.fa_factura_det.vt_DescUnitario, dbo.fa_factura_det.vt_iva, dbo.fa_factura_det.vt_PrecioFinal, 
                         dbo.fa_factura_det.vt_Precio, 0 AS Expr1, dbo.vwFa_FacturasxDevolucionxItem.Estado, dbo.vwFa_FacturasxDevolucionxItem.dv_seguro, 
                         dbo.vwFa_FacturasxDevolucionxItem.dv_flete, dbo.vwFa_FacturasxDevolucionxItem.dv_interes, dbo.vwFa_FacturasxDevolucionxItem.dv_OtroValor1, 
                         dbo.vwFa_FacturasxDevolucionxItem.dv_OtroValor2
FROM            dbo.fa_factura_det LEFT OUTER JOIN
                         dbo.vwFa_FacturasxDevolucionxItem ON dbo.fa_factura_det.IdEmpresa = dbo.vwFa_FacturasxDevolucionxItem.IdEmpresa AND 
                         dbo.fa_factura_det.IdSucursal = dbo.vwFa_FacturasxDevolucionxItem.IdSucursal AND 
                         dbo.fa_factura_det.IdBodega = dbo.vwFa_FacturasxDevolucionxItem.IdBodega AND 
                         dbo.fa_factura_det.IdCbteVta = dbo.vwFa_FacturasxDevolucionxItem.IdCbteVta AND dbo.fa_factura_det.IdProducto = dbo.vwFa_FacturasxDevolucionxItem.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[35] 2[44] 3) )"
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
         Begin Table = "fa_factura_det"
            Begin Extent = 
               Top = 6
               Left = 357
               Bottom = 245
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwFa_FacturasxDevolucionxItem"
            Begin Extent = 
               Top = 46
               Left = 710
               Bottom = 165
               Right = 870
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
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
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 7605
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 4425
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_FacturasConDevolucionxItemSaldos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_FacturasConDevolucionxItemSaldos';

