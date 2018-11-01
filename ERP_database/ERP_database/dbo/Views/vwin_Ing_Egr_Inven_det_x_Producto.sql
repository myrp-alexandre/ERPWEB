
CREATE VIEW [dbo].[vwin_Ing_Egr_Inven_det_x_Producto]
AS
SELECT        dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdNumMovi, 
                         dbo.in_Ing_Egr_Inven_det.Secuencia, dbo.in_Ing_Egr_Inven_det.IdProducto, dbo.in_Ing_Egr_Inven_det.dm_cantidad, 0 dm_stock_ante, 
                         0 dm_stock_actu, dbo.in_Ing_Egr_Inven_det.dm_observacion, 0 dm_precio, dbo.in_Ing_Egr_Inven_det.mv_costo, 
                         0 dm_peso, dbo.in_Ing_Egr_Inven_det.IdCentroCosto, dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo, 
                         dbo.in_Ing_Egr_Inven_det.IdEstadoAproba, dbo.in_Ing_Egr_Inven_det.IdPunto_cargo, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida, dbo.in_Producto.pr_descripcion, 
                         dbo.in_Producto.pr_codigo, dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc, dbo.in_Ing_Egr_Inven_det.IdSucursal_oc, dbo.in_Ing_Egr_Inven_det.IdOrdenCompra, 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc, dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv, dbo.in_Ing_Egr_Inven_det.IdSucursal_inv, 
                         dbo.in_Ing_Egr_Inven_det.IdBodega_inv, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv, 
                         dbo.in_Ing_Egr_Inven_det.secuencia_inv, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_centro_costo.Centro_costo AS Nom_Centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Nom_SubCentroCosto, dbo.in_Producto.pr_codigo AS cod_producto, 
                         dbo.in_Producto.pr_descripcion AS nom_producto_princ, isnull(dbo.vwin_Producto_Stock_x_Bodega.Stock,0) AS pr_stock, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo
FROM            dbo.in_Ing_Egr_Inven_det LEFT OUTER JOIN
                         dbo.vwin_Producto_Stock_x_Bodega ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.vwin_Producto_Stock_x_Bodega.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.vwin_Producto_Stock_x_Bodega.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.vwin_Producto_Stock_x_Bodega.IdBodega AND 
                         dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.vwin_Producto_Stock_x_Bodega.IdProducto LEFT OUTER JOIN
                         dbo.in_Producto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[70] 2[5] 3) )"
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
               Top = 31
               Left = 95
               Bottom = 418
               Right = 358
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 183
               Left = 602
               Bottom = 392
               Right = 892
            End
            DisplayFlags = 280
            TopColumn = 24
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 289
               Left = 707
               Bottom = 418
               Right = 970
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 328
               Left = 458
               Bottom = 457
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 471
               Left = 693
               Bottom = 600
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_Producto_Stock_x_Bodega"
            Begin Extent = 
               Top = 0
               Left = 941
               Bottom = 193
               Right = 1150
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
   Begin Crite', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_Producto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'riaPane = 
      Begin ColumnWidths = 11
         Column = 3735
         Alias = 1635
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_Producto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_Producto';

