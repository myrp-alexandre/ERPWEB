CREATE VIEW [dbo].[vwINV_Rpt009]
AS
SELECT        dbo.vwin_Producto_Stock.IdEmpresa, dbo.vwin_Producto_Stock.IdSucursal, dbo.vwin_Producto_Stock.IdBodega, dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.in_Producto.pr_observacion, dbo.vwin_Producto_Stock.Stock, dbo.vwin_Producto_Stock.IdProducto, dbo.vwin_producto_Ult_Costo_Hist_x_Bod.costo, 
                         dbo.vwin_Producto_Stock.Stock * dbo.vwin_producto_Ult_Costo_Hist_x_Bod.costo AS costo_total, dbo.in_Producto.IdCategoria, dbo.in_categorias.ca_Categoria, dbo.in_Producto.IdLinea, dbo.in_linea.nom_linea, 
                         dbo.in_UnidadMedida.Descripcion AS nom_UnidadMedida, dbo.in_presentacion.nom_presentacion, dbo.in_Marca.Descripcion, dbo.in_Producto.IdGrupo, dbo.in_Producto.IdSubGrupo, dbo.in_grupo.nom_grupo
FROM            dbo.in_categorias INNER JOIN
                         dbo.in_linea ON dbo.in_categorias.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_categorias.IdCategoria = dbo.in_linea.IdCategoria INNER JOIN
                         dbo.tb_bodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Producto INNER JOIN
                         dbo.vwin_Producto_Stock ON dbo.in_Producto.IdEmpresa = dbo.vwin_Producto_Stock.IdEmpresa AND dbo.in_Producto.IdProducto = dbo.vwin_Producto_Stock.IdProducto ON 
                         dbo.tb_bodega.IdEmpresa = dbo.vwin_Producto_Stock.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.vwin_Producto_Stock.IdSucursal AND dbo.tb_bodega.IdBodega = dbo.vwin_Producto_Stock.IdBodega ON 
                         dbo.in_linea.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_linea.IdCategoria = dbo.in_Producto.IdCategoria AND dbo.in_linea.IdLinea = dbo.in_Producto.IdLinea INNER JOIN
                         dbo.in_UnidadMedida ON dbo.in_Producto.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                         dbo.in_presentacion ON dbo.in_Producto.IdEmpresa = dbo.in_presentacion.IdEmpresa AND dbo.in_Producto.IdPresentacion = dbo.in_presentacion.IdPresentacion INNER JOIN
                         dbo.in_Marca ON dbo.in_Producto.IdEmpresa = dbo.in_Marca.IdEmpresa AND dbo.in_Producto.IdMarca = dbo.in_Marca.IdMarca INNER JOIN
                         dbo.in_grupo ON dbo.in_Producto.IdEmpresa = dbo.in_grupo.IdEmpresa AND dbo.in_Producto.IdGrupo = dbo.in_grupo.IdGrupo AND dbo.in_Producto.IdCategoria = dbo.in_grupo.IdCategoria AND 
                         dbo.in_Producto.IdLinea = dbo.in_grupo.IdLinea LEFT OUTER JOIN
                         dbo.vwin_producto_Ult_Costo_Hist_x_Bod ON dbo.vwin_Producto_Stock.IdEmpresa = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdEmpresa AND 
                         dbo.vwin_Producto_Stock.IdSucursal = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdSucursal AND dbo.vwin_Producto_Stock.IdBodega = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdBodega AND 
                         dbo.vwin_Producto_Stock.IdProducto = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[72] 4[3] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[58] 2[14] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
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
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "in_categorias"
            Begin Extent = 
               Top = 360
               Left = 686
               Bottom = 489
               Right = 915
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "in_linea"
            Begin Extent = 
               Top = 342
               Left = 421
               Bottom = 471
               Right = 630
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 36
               Left = 625
               Bottom = 203
               Right = 834
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 17
               Left = 1087
               Bottom = 208
               Right = 1317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 236
               Left = 73
               Bottom = 482
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_Producto_Stock"
            Begin Extent = 
               Top = 0
               Left = 292
               Bottom = 219
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_producto_Ult_Costo_Hist_x_Bod"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 205
               Right = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt009';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'209
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
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2340
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt009';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt009';

