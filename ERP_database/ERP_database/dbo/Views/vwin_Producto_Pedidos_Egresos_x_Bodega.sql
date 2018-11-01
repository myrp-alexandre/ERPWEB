CREATE VIEW [dbo].[vwin_Producto_Pedidos_Egresos_x_Bodega]
AS
SELECT        dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdProducto, SUM(dbo.in_Ing_Egr_Inven_det.dm_cantidad) 
                         AS cantidad
FROM            dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi
WHERE        (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.in_movi_inve_detalle AS A
                               WHERE        (IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv) AND (IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv) AND (IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv) AND 
                                                         (IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv) AND (IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv) AND 
                                                         (Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv)))
											AND dbo.in_Ing_Egr_Inven_det.IdEstadoAproba = 'PEND' AND (dbo.in_Ing_Egr_Inven.signo = '-') AND (dbo.in_Ing_Egr_Inven.Estado = 'A')
GROUP BY dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdProducto, dbo.in_Ing_Egr_Inven.signo, 
                         dbo.in_Ing_Egr_Inven.Estado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[4] 2[4] 3) )"
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
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 0
               Left = 454
               Bottom = 129
               Right = 733
            End
            DisplayFlags = 280
            TopColumn = 10
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Producto_Pedidos_Egresos_x_Bodega';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Producto_Pedidos_Egresos_x_Bodega';

