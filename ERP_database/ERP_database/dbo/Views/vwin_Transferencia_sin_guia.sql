CREATE VIEW dbo.vwin_Transferencia_sin_guia
AS
SELECT        dbo.in_transferencia_det.IdEmpresa, dbo.in_transferencia_det.IdSucursalOrigen, dbo.in_transferencia_det.IdBodegaOrigen, 
                         dbo.in_transferencia_det.IdTransferencia, dbo.in_transferencia_det.dt_secuencia, dbo.in_transferencia_det.IdProducto, dbo.in_transferencia_det.dt_cantidad, 
                         dbo.in_transferencia_det.tr_Observacion, dbo.in_Producto.pr_observacion, dbo.in_Producto.pr_descripcion, dbo.in_transferencia_det.IdCentroCosto, 
                         dbo.in_transferencia_det.IdCentroCosto_sub_centro_costo, dbo.in_transferencia_det.IdUnidadMedida
FROM            dbo.in_transferencia_det INNER JOIN
                         dbo.in_Producto ON dbo.in_transferencia_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_transferencia_det.IdProducto = dbo.in_Producto.IdProducto AND 
                         dbo.in_transferencia_det.IdTransferencia NOT IN
                             (SELECT        IdTransferencia
                               FROM            dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det AS G
                               WHERE        (IdTransferencia = IdTransferencia) AND (dt_secuencia = dt_secuencia) AND (cantidad < dbo.in_transferencia_det.dt_cantidad))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[5] 2[13] 3) )"
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
         Begin Table = "in_transferencia_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 256
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 0
               Left = 406
               Bottom = 255
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Transferencia_sin_guia';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Transferencia_sin_guia';

