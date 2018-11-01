CREATE view  vwin_ajusteFisico
as
SELECT       dbo.in_ajusteFisico.IdAjusteFisico, dbo.in_ajusteFisico.IdMovi_inven_tipo_Ing, dbo.in_ajusteFisico.IdNumMovi_Ing, 
                         dbo.in_ajusteFisico.IdMovi_inven_tipo_Egr, dbo.in_ajusteFisico.IdNumMovi_Egr, dbo.in_ajusteFisico.Observacion, dbo.in_ajusteFisico.Fecha, 
                         dbo.in_ajusteFisico.Estado, Tipo_Ing.tm_descripcion AS tm_descripcion_ing, Tipo_Egr.tm_descripcion AS tm_descripcion_Egr, dbo.tb_bodega.bo_Descripcion, 
                         dbo.tb_sucursal.Su_Descripcion, dbo.in_ajusteFisico.IdEmpresa, dbo.in_ajusteFisico.IdBodega, dbo.in_ajusteFisico.IdSucursal, 
                         dbo.in_Catalogo.Nombre AS Nombre_Estado, dbo.in_ajusteFisico.IdEstadoAprobacion
FROM            dbo.tb_sucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal INNER JOIN
                         dbo.in_ajusteFisico ON dbo.tb_bodega.IdEmpresa = dbo.in_ajusteFisico.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_ajusteFisico.IdSucursal AND 
                         dbo.tb_bodega.IdBodega = dbo.in_ajusteFisico.IdBodega INNER JOIN
                         dbo.in_Catalogo ON dbo.in_ajusteFisico.IdEstadoAprobacion = dbo.in_Catalogo.IdCatalogo LEFT OUTER JOIN
                         dbo.in_movi_inven_tipo AS Tipo_Egr ON dbo.in_ajusteFisico.IdEmpresa = Tipo_Egr.IdEmpresa AND 
                         dbo.in_ajusteFisico.IdMovi_inven_tipo_Egr = Tipo_Egr.IdMovi_inven_tipo LEFT OUTER JOIN
                         dbo.in_movi_inven_tipo AS Tipo_Ing ON dbo.in_ajusteFisico.IdEmpresa = Tipo_Ing.IdEmpresa AND 
                         dbo.in_ajusteFisico.IdMovi_inven_tipo_Ing = Tipo_Ing.IdMovi_inven_tipo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[59] 4[2] 2[18] 3) )"
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
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 71
               Left = 41
               Bottom = 190
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 37
               Left = 343
               Bottom = 156
               Right = 541
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_ajusteFisico"
            Begin Extent = 
               Top = 44
               Left = 707
               Bottom = 196
               Right = 906
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "Tipo_Egr"
            Begin Extent = 
               Top = 10
               Left = 1023
               Bottom = 129
               Right = 1211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tipo_Ing"
            Begin Extent = 
               Top = 135
               Left = 1022
               Bottom = 254
               Right = 1210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Catalogo"
            Begin Extent = 
               Top = 182
               Left = 481
               Bottom = 301
               Right = 649
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
      Begin ColumnWidths = 17
         Width = 284
         Width = 1500
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_ajusteFisico';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2625
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_ajusteFisico';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_ajusteFisico';

