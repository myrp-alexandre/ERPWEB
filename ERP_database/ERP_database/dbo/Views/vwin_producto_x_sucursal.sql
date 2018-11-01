CREATE VIEW dbo.vwin_producto_x_sucursal
AS
SELECT        dbo.vwin_producto_x_tb_bodega.IdEmpresa, dbo.vwin_producto_x_tb_bodega.IdProducto, dbo.vwin_producto_x_tb_bodega.pr_codigo, dbo.vwin_producto_x_tb_bodega.pr_descripcion, 
                        dbo.vwin_producto_x_tb_bodega.IdSucursal, 
                         dbo.vwin_producto_x_tb_bodega.Su_Descripcion, dbo.vwin_producto_x_tb_bodega.IdMarca, dbo.vwin_producto_x_tb_bodega.IdProductoTipo, dbo.vwin_producto_x_tb_bodega.IdPresentacion, 
                         dbo.vwin_producto_x_tb_bodega.IdUnidadMedida, AVG(dbo.vwin_producto_x_tb_bodega.pr_precio_minimo) AS pr_precio_minimo, AVG(dbo.vwin_producto_x_tb_bodega.pr_precio_publico) AS pr_precio_publico, 
                         dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.costo AS pr_costo_promedio, SUM(ISNULL(dbo.vwin_producto_x_tb_bodega.pr_Pedidos_inv, 0)) AS pr_pedidos, 
                         SUM(ISNULL(dbo.vwin_producto_x_tb_bodega.pr_stock, 0)) AS pr_stock, SUM(ISNULL(dbo.vwin_producto_x_tb_bodega.pr_stock, 0)) - SUM(ISNULL(dbo.vwin_producto_x_tb_bodega.pr_Pedidos_inv, 0)) 
                         AS pr_disponible, dbo.vwin_producto_x_tb_bodega.Descripcion_UniMedida, dbo.vwin_producto_x_tb_bodega.Descripcion_TipoConsumo, 
                         dbo.vwin_producto_x_tb_bodega.IdUnidadMedida_Consumo, '' AS IdCtaCble_Inventario, '' AS IdCtaCble_Gasto_x_cxp, '' AS IdCentroCosto_sub_centro_costo_cost, '' AS IdCentroCosto_sub_centro_costo_cxp, 
                         '' AS IdCtaCble_Costo, '' AS IdCtaCble_CosBaseIva, '' AS IdCtaCble_CosBase0, '' AS IdCtaCble_VenIva, '' AS IdCtaCble_Ven0, '' AS IdCtaCble_DesIva, '' AS IdCtaCble_Des0, '' AS IdCtaCble_DevIva, 
                         '' AS IdCtaCble_Dev0, '' AS IdCtaCble_Vta, '' AS IdCentroCosto_sub_centro_costo_inv, '' AS IdCentroCosto_x_Gasto_x_cxp, '' AS IdCentro_Costo_Inventario, '' AS IdCentro_Costo_Costo, 
                         dbo.vwin_producto_x_tb_bodega.IdCod_Impuesto_Iva,  dbo.vwin_producto_x_tb_bodega.Aparece_modu_Ventas, 
                         dbo.vwin_producto_x_tb_bodega.Aparece_modu_Compras, dbo.vwin_producto_x_tb_bodega.Aparece_modu_Inventario, dbo.vwin_producto_x_tb_bodega.Aparece_modu_Activo_F, 
                         in_precio_minimo.precio_minimo
FROM            dbo.vwin_producto_x_tb_bodega LEFT OUTER JOIN
                         dbo.vwin_producto_Ult_Costo_Hist_x_Sucu ON dbo.vwin_producto_x_tb_bodega.IdEmpresa = dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.IdEmpresa AND 
                         dbo.vwin_producto_x_tb_bodega.IdProducto = dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.IdProducto AND 
                         dbo.vwin_producto_x_tb_bodega.IdSucursal = dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.IdSucursal LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdProducto, MIN(do_precioCompra) AS precio_minimo
                               FROM            dbo.com_ordencompra_local_det
                               GROUP BY IdEmpresa, IdProducto) AS in_precio_minimo ON dbo.vwin_producto_x_tb_bodega.IdEmpresa = in_precio_minimo.IdEmpresa AND 
                         dbo.vwin_producto_x_tb_bodega.IdProducto = in_precio_minimo.IdProducto
GROUP BY dbo.vwin_producto_x_tb_bodega.IdEmpresa, dbo.vwin_producto_x_tb_bodega.IdProducto, dbo.vwin_producto_x_tb_bodega.pr_codigo, dbo.vwin_producto_x_tb_bodega.pr_descripcion, 
                          dbo.vwin_producto_x_tb_bodega.IdSucursal, dbo.vwin_producto_x_tb_bodega.Su_Descripcion, 
                         dbo.vwin_producto_x_tb_bodega.IdMarca, dbo.vwin_producto_x_tb_bodega.IdProductoTipo, dbo.vwin_producto_x_tb_bodega.IdPresentacion, dbo.vwin_producto_x_tb_bodega.IdUnidadMedida, 
                         dbo.vwin_producto_x_tb_bodega.Descripcion_UniMedida, dbo.vwin_producto_x_tb_bodega.Descripcion_TipoConsumo, 
                         dbo.vwin_producto_x_tb_bodega.IdUnidadMedida_Consumo, dbo.vwin_producto_Ult_Costo_Hist_x_Sucu.costo, dbo.vwin_producto_x_tb_bodega.IdCod_Impuesto_Iva, 
                         dbo.vwin_producto_x_tb_bodega.Aparece_modu_Ventas, dbo.vwin_producto_x_tb_bodega.Aparece_modu_Compras, 
                         dbo.vwin_producto_x_tb_bodega.Aparece_modu_Inventario, dbo.vwin_producto_x_tb_bodega.Aparece_modu_Activo_F, in_precio_minimo.precio_minimo

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[85] 4[4] 2[4] 3) )"
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
         Begin Table = "vwin_producto_x_tb_bodega"
            Begin Extent = 
               Top = 0
               Left = 484
               Bottom = 351
               Right = 790
            End
            DisplayFlags = 280
            TopColumn = 37
         End
         Begin Table = "vwin_producto_Ult_Costo_Hist_x_Sucu"
            Begin Extent = 
               Top = 60
               Left = 69
               Bottom = 189
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_precio_minimo"
            Begin Extent = 
               Top = 6
               Left = 828
               Bottom = 119
               Right = 1053
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
      Begin ColumnWidths = 42
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
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto_x_sucursal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto_x_sucursal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto_x_sucursal';

