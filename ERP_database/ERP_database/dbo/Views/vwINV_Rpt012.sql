CREATE view [dbo].[vwINV_Rpt012]
as
SELECT        movIn.IdEmpresa, movIn.IdSucursal, movIn.IdBodega, movIn.IdMovi_inven_tipo, movIn.IdNumMovi, movInDet.Secuencia, suc.Su_Descripcion, bod.bo_Descripcion, 
                         tip.tm_descripcion, movIn.CodMoviInven, movIn.cm_observacion, movIn.cm_fecha, movIn.IdUsuario, pro.IdProducto, pro.pr_descripcion, movInDet.mv_tipo_movi, 
                         movInDet.dm_cantidad, 0 dm_stock_actu, 0 dm_stock_ante, movInDet.dm_observacion, movInDet.mv_costo, 0 dm_precio, 0 dm_peso, cat.IdCategoria, 
                         cat.ca_Categoria, mar.IdMarca, mar.Descripcion, pro.IdUnidadMedida, dbo.in_UnidadMedida.Descripcion AS nomUnidadMedida, 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi AS Id_Ing_Egr, dbo.in_Ing_Egr_Inven.CodMoviInven AS Cod_ing_egr, isnull(in_Ing_Egr_Inven_det.mv_costo * abs(in_Ing_Egr_Inven_det.dm_cantidad),0) as total_costo,
						 isnull(0 * abs(in_Ing_Egr_Inven_det.dm_cantidad),0) as total_precio
FROM            dbo.in_movi_inve AS movIn INNER JOIN
                         dbo.in_movi_inve_detalle AS movInDet ON movIn.IdEmpresa = movInDet.IdEmpresa AND movIn.IdSucursal = movInDet.IdSucursal AND 
                         movIn.IdBodega = movInDet.IdBodega AND movIn.IdMovi_inven_tipo = movInDet.IdMovi_inven_tipo AND movIn.IdNumMovi = movInDet.IdNumMovi INNER JOIN
                         dbo.in_movi_inven_tipo AS tip ON tip.IdEmpresa = movInDet.IdEmpresa AND tip.IdMovi_inven_tipo = movInDet.IdMovi_inven_tipo INNER JOIN
                         dbo.tb_bodega AS bod ON bod.IdEmpresa = movIn.IdEmpresa AND bod.IdBodega = movIn.IdBodega INNER JOIN
                         dbo.tb_sucursal AS suc ON suc.IdEmpresa = movIn.IdEmpresa AND suc.IdSucursal = movIn.IdSucursal INNER JOIN
                         dbo.in_Producto AS pro ON pro.IdEmpresa = movInDet.IdEmpresa AND pro.IdProducto = movInDet.IdProducto INNER JOIN
                         dbo.in_categorias AS cat ON cat.IdEmpresa = pro.IdEmpresa AND cat.IdCategoria = pro.IdCategoria INNER JOIN
                         dbo.in_Marca AS mar ON mar.IdEmpresa = pro.IdEmpresa AND mar.IdMarca = pro.IdMarca INNER JOIN
                         dbo.in_UnidadMedida ON pro.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON movInDet.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND 
                         movInDet.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND movInDet.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND 
                         movInDet.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND movInDet.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND 
                         movInDet.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[78] 4[5] 2[5] 3) )"
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
         Top = -739
         Left = 0
      End
      Begin Tables = 
         Begin Table = "movIn"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "movInDet"
            Begin Extent = 
               Top = 63
               Left = 484
               Bottom = 192
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tip"
            Begin Extent = 
               Top = 110
               Left = 435
               Bottom = 239
               Right = 644
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pro"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 328
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cat"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 267
            End
            DisplayFlags = 280
            TopColum', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt012';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n = 0
         End
         Begin Table = "mar"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 247
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt012';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt012';

