CREATE VIEW dbo.vwin_VistaParaContabilizarInventario
AS
SELECT        mov_inv_det.IdEmpresa, mov_inv_det.IdSucursal, mov_inv_det.IdBodega, mov_inv_det.IdMovi_inven_tipo, mov_inv_det.IdNumMovi, mov_inv_det.Secuencia, 
                         mov_inv_det.mv_tipo_movi, mov_inv_det.IdProducto, mov_inv_det.dm_cantidad, 0 dm_stock_ante, 0 dm_stock_actu, 
                         mov_inv_det.dm_observacion, mov_inv_det.mv_costo, 0 dm_peso, prod_x_bod.IdCtaCble_Inven, prod_x_bod.IdCtaCble_Costo, mov_inv.cm_fecha, 
                         tipo_mov.IdTipoCbte, prod.pr_descripcion, tipo_mov.tm_descripcion, tip_cbt.tc_TipoCbte, bod.bo_Descripcion, suc.Su_Descripcion, prod.pr_codigo, 
                         mov_inv_det.IdCentroCosto AS IdCentro_Costo_Inventario, mov_inv_det.IdCentroCosto_sub_centro_costo, mov_inv_det.IdCentroCosto AS IdCentro_Costo_Costo, 
                         mov_inv_det.IdPunto_cargo, mov_inv_det.IdPunto_cargo_grupo, mov_inv_det.IdMotivo_Inv, NULL AS IdCtaCble_Inven_Motivo, 
                         NULL AS IdCtaCble_Costo_Motivo
FROM            dbo.tb_sucursal AS suc INNER JOIN
                         dbo.tb_bodega AS bod ON suc.IdEmpresa = bod.IdEmpresa AND suc.IdSucursal = bod.IdSucursal INNER JOIN
                         dbo.in_movi_inve_detalle AS mov_inv_det INNER JOIN
                         dbo.in_producto_x_tb_bodega AS prod_x_bod ON mov_inv_det.IdEmpresa = prod_x_bod.IdEmpresa AND mov_inv_det.IdProducto = prod_x_bod.IdProducto AND 
                         mov_inv_det.IdBodega = prod_x_bod.IdBodega AND mov_inv_det.IdSucursal = prod_x_bod.IdSucursal INNER JOIN
                         dbo.in_movi_inve AS mov_inv ON mov_inv_det.IdEmpresa = mov_inv.IdEmpresa AND mov_inv_det.IdSucursal = mov_inv.IdSucursal AND 
                         mov_inv_det.IdBodega = mov_inv.IdBodega AND mov_inv.IdMovi_inven_tipo = mov_inv_det.IdMovi_inven_tipo AND 
                         mov_inv_det.IdNumMovi = mov_inv.IdNumMovi INNER JOIN
                         dbo.in_movi_inven_tipo AS tipo_mov ON mov_inv.IdEmpresa = tipo_mov.IdEmpresa AND mov_inv.IdMovi_inven_tipo = tipo_mov.IdMovi_inven_tipo INNER JOIN
                         dbo.in_Producto AS prod ON prod_x_bod.IdEmpresa = prod.IdEmpresa AND prod_x_bod.IdProducto = prod.IdProducto ON suc.IdEmpresa = mov_inv.IdEmpresa AND 
                         suc.IdSucursal = mov_inv.IdSucursal AND bod.IdEmpresa = mov_inv.IdEmpresa AND bod.IdSucursal = mov_inv.IdSucursal AND 
                         bod.IdBodega = mov_inv.IdBodega LEFT OUTER JOIN
                         dbo.in_Motivo_Inven ON mov_inv_det.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa AND 
                         mov_inv_det.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv LEFT OUTER JOIN
                         dbo.ct_cbtecble_tipo AS tip_cbt ON tipo_mov.IdTipoCbte = tip_cbt.IdTipoCbte
WHERE        (mov_inv.Estado = 'A') AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.in_movi_inve_x_ct_cbteCble AS A
                               WHERE        (IdEmpresa = mov_inv.IdEmpresa) AND (IdSucursal = mov_inv.IdSucursal) AND (IdBodega = mov_inv.IdBodega) AND 
                                                         (IdNumMovi = mov_inv.IdNumMovi) AND (IdMovi_inven_tipo = mov_inv.IdMovi_inven_tipo)))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[85] 2[5] 3) )"
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
         Top = -663
         Left = 0
      End
      Begin Tables = 
         Begin Table = "suc"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_inv_det"
            Begin Extent = 
               Top = 53
               Left = 551
               Bottom = 182
               Right = 814
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "prod_x_bod"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 328
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_inv"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tipo_mov"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "prod"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 272
            End
            DisplayFlags = 280
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_VistaParaContabilizarInventario';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          TopColumn = 0
         End
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "tip_cbt"
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
      Begin ColumnWidths = 27
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 4095
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_VistaParaContabilizarInventario';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_VistaParaContabilizarInventario';

