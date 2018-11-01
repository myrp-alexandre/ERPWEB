CREATE VIEW dbo.vwin_producto_x_tb_bodega
AS
SELECT        A.IdEmpresa, A.IdProducto, B.IdBodega, A.pr_codigo, A.pr_descripcion, C.bo_Descripcion, C.IdSucursal, D.Su_Descripcion, A.IdMarca, A.IdProductoTipo, A.IdPresentacion, A.IdUnidadMedida, 0 AS pr_precio_publico, 
                         0 pr_precio_mayor, 0 pr_precio_puerta, 0 pr_precio_minimo, 0 pr_costo_fob, 0 pr_costo_CIF, ISNULL(pe_x_egr.cantidad, 0) AS pr_Pedidos_inv, ISNULL(J.Stock, 0) AS pr_stock, ISNULL(ISNULL(J.Stock, 0) 
                         + ISNULL(pe_x_egr.cantidad, 0) * - 1, 0) AS pr_Disponible, B.IdCtaCble_Inven, B.IdCtaCble_Costo, '' IdNaturaleza, B.IdCtaCble_Inven AS IdCtaCble_Inventario, '' IdCentro_Costo_Inventario, '' IdCentro_Costo_Costo, 
                         B.IdCtaCble_Gasto_x_cxp, '' IdCentroCosto_x_Gasto_x_cxp, '' IdCentroCosto_sub_centro_costo_inv, '' IdCentroCosto_sub_centro_costo_cost, '' IdCentroCosto_sub_centro_costo_cxp, '' IdCtaCble_CosBaseIva, 
                         '' IdCtaCble_CosBase0, '' IdCtaCble_VenIva, '' IdCtaCble_Ven0, '' IdCtaCble_DesIva, ''IdCtaCble_Des0, '' IdCtaCble_DevIva, '' IdCtaCble_Dev0, B.IdCtaCble_Vta, uni.Descripcion AS Descripcion_UniMedida, 
                         consu.Descripcion AS Descripcion_TipoConsumo, A.IdUnidadMedida_Consumo, ISNULL(dbo.vwin_producto_Ult_Costo_Hist_x_Bod.costo, 0) AS pr_costo_promedio, 0 AS pr_stock_minimo, A.IdCod_Impuesto_Iva, 
                         A.Aparece_modu_Ventas, A.Aparece_modu_Compras, A.Aparece_modu_Inventario, A.Aparece_modu_Activo_F, dbo.in_ProductoTipo.tp_descripcion AS nom_Tipo_Producto, dbo.in_categorias.ca_Categoria AS nom_Categoria, 
                         dbo.in_linea.nom_linea, A.pr_codigo_barra, dbo.in_categorias.IdCtaCtble_Inve AS IdCtaCtble_Inve_categoria, dbo.in_categorias.IdCtaCtble_Costo AS IdCtaCtble_Costo_categoria, A.lote_fecha_vcto, A.lote_fecha_fab, 
                         A.lote_num_lote, dbo.in_presentacion.nom_presentacion
FROM            dbo.in_linea INNER JOIN
                         dbo.in_categorias ON dbo.in_linea.IdEmpresa = dbo.in_categorias.IdEmpresa AND dbo.in_linea.IdCategoria = dbo.in_categorias.IdCategoria INNER JOIN
                         dbo.in_Producto AS A INNER JOIN
                         dbo.in_producto_x_tb_bodega AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdProducto = B.IdProducto INNER JOIN
                         dbo.tb_bodega AS C ON B.IdEmpresa = C.IdEmpresa AND B.IdBodega = C.IdBodega AND B.IdSucursal = C.IdSucursal INNER JOIN
                         dbo.tb_sucursal AS D ON C.IdEmpresa = D.IdEmpresa AND C.IdSucursal = D.IdSucursal INNER JOIN
                         dbo.in_UnidadMedida AS uni ON uni.IdUnidadMedida = A.IdUnidadMedida INNER JOIN
                         dbo.in_UnidadMedida AS consu ON A.IdUnidadMedida_Consumo = consu.IdUnidadMedida INNER JOIN
                         dbo.in_ProductoTipo ON A.IdEmpresa = dbo.in_ProductoTipo.IdEmpresa AND A.IdProductoTipo = dbo.in_ProductoTipo.IdProductoTipo ON dbo.in_linea.IdEmpresa = A.IdEmpresa AND dbo.in_linea.IdCategoria = A.IdCategoria AND 
                         dbo.in_linea.IdLinea = A.IdLinea INNER JOIN
                         dbo.in_presentacion ON A.IdEmpresa = dbo.in_presentacion.IdEmpresa AND A.IdPresentacion = dbo.in_presentacion.IdPresentacion LEFT OUTER JOIN
                         dbo.vwin_Producto_Pedidos_Egresos_x_Bodega AS pe_x_egr ON B.IdEmpresa = pe_x_egr.IdEmpresa AND B.IdSucursal = pe_x_egr.IdSucursal AND B.IdBodega = pe_x_egr.IdBodega AND 
                         B.IdProducto = pe_x_egr.IdProducto LEFT OUTER JOIN
                         dbo.vwin_producto_Ult_Costo_Hist_x_Bod ON B.IdEmpresa = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdEmpresa AND B.IdSucursal = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdSucursal AND 
                         B.IdBodega = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdBodega AND B.IdProducto = dbo.vwin_producto_Ult_Costo_Hist_x_Bod.IdProducto LEFT OUTER JOIN
                         dbo.vwin_Producto_Stock AS J ON B.IdEmpresa = J.IdEmpresa AND B.IdSucursal = J.IdSucursal AND B.IdBodega = J.IdBodega AND B.IdProducto = J.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[68] 4[5] 2[5] 3) )"
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
         Begin Table = "in_linea"
            Begin Extent = 
               Top = 21
               Left = 509
               Bottom = 198
               Right = 718
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_categorias"
            Begin Extent = 
               Top = 58
               Left = 911
               Bottom = 230
               Right = 1140
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 452
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 411
               Left = 361
               Bottom = 621
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 40
               Left = 1009
               Bottom = 169
               Right = 1270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 209
               Left = 1063
               Bottom = 338
               Right = 1293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uni"
            Begin Extent = 
               Top = 338
               Left = 771
               Bottom = 467
               Right = 981
            End
            DisplayFlags = 280
            TopC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto_x_tb_bodega';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'olumn = 0
         End
         Begin Table = "consu"
            Begin Extent = 
               Top = 541
               Left = 566
               Bottom = 670
               Right = 776
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_ProductoTipo"
            Begin Extent = 
               Top = 274
               Left = 677
               Bottom = 479
               Right = 886
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pe_x_egr"
            Begin Extent = 
               Top = 435
               Left = 1037
               Bottom = 564
               Right = 1246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_producto_Ult_Costo_Hist_x_Bod"
            Begin Extent = 
               Top = 503
               Left = 841
               Bottom = 632
               Right = 1050
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "J"
            Begin Extent = 
               Top = 886
               Left = 358
               Bottom = 1015
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_presentacion"
            Begin Extent = 
               Top = 202
               Left = 577
               Bottom = 332
               Right = 764
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
      Begin ColumnWidths = 62
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
         Column = 1815
         Alias = 3795
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto_x_tb_bodega';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto_x_tb_bodega';

