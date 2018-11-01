CREATE VIEW [dbo].[vwFa_FacturasConDevolucionxItemConsulta]
AS
SELECT        dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, 
                         dbo.vwFa_FacturasxDevolucionxIdDevolucion.IdDevolucion, dbo.fa_factura_det.IdProducto, dbo.fa_factura_det.vt_cantidad, 
                         ISNULL(dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_cantidad, 0) AS dv_cantidad, 
                         dbo.fa_factura_det.vt_cantidad - ISNULL(dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_cantidad, 0) AS dv_saldo, 
                         dbo.fa_factura_det.vt_PorDescUnitario, dbo.fa_factura_det.vt_DescUnitario, dbo.fa_factura_det.vt_iva, dbo.fa_factura_det.vt_PrecioFinal, 
                         dbo.fa_factura_det.vt_Precio, 0 AS Expr1, dbo.vwFa_FacturasxDevolucionxIdDevolucion.Estado, dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_seguro, 
                         dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_flete, dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_interes, 
                         dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_OtroValor1, dbo.vwFa_FacturasxDevolucionxIdDevolucion.dv_OtroValor2
FROM            dbo.fa_factura_det LEFT OUTER JOIN
                         dbo.vwFa_FacturasxDevolucionxIdDevolucion ON dbo.fa_factura_det.IdEmpresa = dbo.vwFa_FacturasxDevolucionxIdDevolucion.IdEmpresa AND 
                         dbo.fa_factura_det.IdSucursal = dbo.vwFa_FacturasxDevolucionxIdDevolucion.IdSucursal AND 
                         dbo.fa_factura_det.IdBodega = dbo.vwFa_FacturasxDevolucionxIdDevolucion.IdBodega AND 
                         dbo.fa_factura_det.IdCbteVta = dbo.vwFa_FacturasxDevolucionxIdDevolucion.IdCbteVta AND 
                         dbo.fa_factura_det.IdProducto = dbo.vwFa_FacturasxDevolucionxIdDevolucion.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[4] 2[47] 3) )"
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
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwFa_FacturasxDevolucionxIdDevolucion"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 135
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_FacturasConDevolucionxItemConsulta';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_FacturasConDevolucionxItemConsulta';

