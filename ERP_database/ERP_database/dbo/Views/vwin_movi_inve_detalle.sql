CREATE view [dbo].[vwin_movi_inve_detalle]
as
SELECT        ISNULL(ROW_NUMBER() over(order by C.IdEmpresa),0) AS IdRow, C.IdEmpresa, C.IdSucursal, C.IdBodega, C.IdMovi_inven_tipo, C.IdNumMovi, C.Secuencia, C.mv_tipo_movi, C.IdProducto, C.dm_cantidad, 0 dm_stock_ante, 
                         0 dm_stock_actu, C.dm_observacion, C.mv_costo, A.Su_Descripcion, B.bo_Descripcion, D.pr_codigo, D.pr_descripcion, F.IdMarca, F.Descripcion, E.IdCategoria, 
                         E.ca_Categoria, '' RutaPadre, H.cm_observacion, H.cm_fecha, H.CodMoviInven, dbo.in_movi_inven_tipo.Codigo AS CodTipoMoviInven, 
                         dbo.in_movi_inven_tipo.tm_descripcion AS TipoMoviInvent, C.IdPunto_cargo, C.IdPunto_cargo_grupo, C.IdMotivo_Inv, 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa AS IdEmpresa_ing_egr, dbo.in_Ing_Egr_Inven_det.IdSucursal AS IdSucursal_ing_egr, 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AS IdMovi_inven_tipo_ing_egr, dbo.in_Ing_Egr_Inven_det.IdNumMovi AS IdNumMovi_ing_egr, 
                         dbo.in_Ing_Egr_Inven_det.Secuencia AS Secuencia_ing_egr, C.IdCentroCosto, C.IdCentroCosto_sub_centro_costo, C.IdUnidadMedida, 
                         C.dm_cantidad_sinConversion, C.IdUnidadMedida_sinConversion, C.mv_costo_sinConversion, dbo.ct_punto_cargo.nom_punto_cargo
FROM            dbo.in_categorias AS E RIGHT OUTER JOIN
                         dbo.in_movi_inve_detalle AS C INNER JOIN
                         dbo.in_Producto AS D ON C.IdEmpresa = D.IdEmpresa AND C.IdProducto = D.IdProducto LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON C.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND C.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa LEFT OUTER JOIN
                         dbo.in_Ing_Egr_Inven_det ON C.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv AND C.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND 
                         C.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND C.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND 
                         C.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND C.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv LEFT OUTER JOIN
                         dbo.in_movi_inve AS H INNER JOIN
                         dbo.tb_bodega AS B INNER JOIN
                         dbo.tb_sucursal AS A ON B.IdEmpresa = A.IdEmpresa AND B.IdSucursal = A.IdSucursal ON H.IdEmpresa = B.IdEmpresa AND H.IdSucursal = B.IdSucursal AND 
                         H.IdBodega = B.IdBodega INNER JOIN
                         dbo.in_movi_inven_tipo ON H.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND H.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo ON 
                         C.IdEmpresa = H.IdEmpresa AND C.IdSucursal = H.IdSucursal AND C.IdBodega = H.IdBodega AND C.IdMovi_inven_tipo = H.IdMovi_inven_tipo AND 
                         C.IdNumMovi = H.IdNumMovi AND C.IdEmpresa = B.IdEmpresa AND C.IdSucursal = B.IdSucursal AND C.IdBodega = B.IdBodega ON E.IdEmpresa = D.IdEmpresa AND
                          E.IdCategoria = D.IdCategoria LEFT OUTER JOIN
                         dbo.in_Marca AS F ON D.IdEmpresa = F.IdEmpresa AND D.IdMarca = F.IdMarca
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[4] 2[4] 3) )"
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
         Begin Table = "F"
            Begin Extent = 
               Top = 386
               Left = 50
               Bottom = 515
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 10
               Left = 661
               Bottom = 435
               Right = 924
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 14
               Left = 181
               Bottom = 143
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 41
               Left = 1081
               Bottom = 482
               Right = 1344
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "H"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 149
               Left = 0
               Bottom = 280
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 240
               Left = 54
               Bottom = 369
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 190
               Left = 386
               Bottom = 319
               Right = 595
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
      Begin ColumnWidths = 31
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_detalle';

