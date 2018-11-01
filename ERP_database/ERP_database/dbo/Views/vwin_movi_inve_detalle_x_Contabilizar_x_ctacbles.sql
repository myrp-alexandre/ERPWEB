CREATE VIEW  vwin_movi_inve_detalle_x_Contabilizar_x_ctacbles
AS
SELECT        mov_inv_det.IdEmpresa, mov_inv_det.IdSucursal, mov_inv_det.IdBodega, mov_inv_det.IdMovi_inven_tipo, mov_inv_det.IdNumMovi, mov_inv_det.Secuencia, mov_inv_det.mv_tipo_movi, mov_inv_det.IdProducto, 
                         prod.pr_codigo AS cod_producto, prod.pr_descripcion AS nom_producto, mov_inv_det.dm_cantidad, 0 dm_stock_ante, 0 dm_stock_actu, mov_inv_det.dm_observacion, mov_inv_det.mv_costo, 
                         0 dm_peso, mov_inv.cm_fecha, tipo_mov.IdTipoCbte, tipo_mov.tm_descripcion AS nom_tipo_mov_inv, tip_cbt.tc_TipoCbte AS nom_TipoCbte, bod.bo_Descripcion AS nom_bodega, 
                         suc.Su_Descripcion AS nom_sucursal, mov_inv_det.IdPunto_cargo, mov_inv_det.IdPunto_cargo_grupo, mov_inv_det.IdMotivo_Inv AS IdMotivo_Inv_det, mov_inv_det.IdCentroCosto AS IdCentro_Costo_x_MoviInv, 
                         mov_inv_det.IdCentroCosto_sub_centro_costo AS IdSubCentro_Costo_x_MoviInv, prod.IdCategoria, prod.IdLinea, prod.IdGrupo, prod.IdSubGrupo, bod.IdCtaCtble_Inve AS IdCtaCtble_Inve_x_Bod, 
                         bod.IdCtaCtble_Costo AS IdCtaCtble_Costo_x_Bod, NULL AS IdCtaCble_Inven_x_Motivo_det, NULL AS IdCtaCble_Costo_x_Motivo_det, 
                         prod_x_bod.IdCtaCble_Inven AS IdCtaCble_Inven_x_Prod, prod_x_bod.IdCtaCble_Costo AS IdCtaCble_Costo_x_Prod, NULL AS IdCtaCtble_Inve_x_SubGrupo, 
                         NULL AS IdCtaCtble_Costo_x_SubGrupo, mov_inv.IdMotivo_Inv, NULL AS IdCtaCble_Inven_x_Motivo, 
                         NULL AS IdCtaCble_Costo_x_Motivo, '' es_Inven_o_Consumo, '' AS es_Inven_o_Consumo_det, mov_inv.Fecha_Transac, 
                         dbo.in_categorias.IdCtaCtble_Inve IdCtaCtble_Inve_categoria, dbo.in_categorias.IdCtaCtble_Costo IdCtaCtble_Costo_categoria, dbo.in_categorias.IdCtaCble_venta IdCtaCble_venta_categoria
FROM            dbo.in_categorias INNER JOIN
                         dbo.in_movi_inve_detalle AS mov_inv_det INNER JOIN
                         dbo.in_movi_inve AS mov_inv ON mov_inv_det.IdEmpresa = mov_inv.IdEmpresa AND mov_inv_det.IdSucursal = mov_inv.IdSucursal AND mov_inv_det.IdBodega = mov_inv.IdBodega AND 
                         mov_inv.IdMovi_inven_tipo = mov_inv_det.IdMovi_inven_tipo AND mov_inv_det.IdNumMovi = mov_inv.IdNumMovi INNER JOIN
                         dbo.in_movi_inven_tipo AS tipo_mov ON mov_inv.IdEmpresa = tipo_mov.IdEmpresa AND mov_inv.IdMovi_inven_tipo = tipo_mov.IdMovi_inven_tipo INNER JOIN
                         dbo.tb_sucursal AS suc INNER JOIN
                         dbo.tb_bodega AS bod ON suc.IdEmpresa = bod.IdEmpresa AND suc.IdSucursal = bod.IdSucursal ON mov_inv.IdEmpresa = bod.IdEmpresa AND mov_inv.IdSucursal = bod.IdSucursal AND 
                         mov_inv.IdBodega = bod.IdBodega INNER JOIN
                         dbo.in_Producto AS prod INNER JOIN
                         dbo.in_subgrupo ON prod.IdEmpresa = dbo.in_subgrupo.IdEmpresa AND prod.IdCategoria = dbo.in_subgrupo.IdCategoria AND prod.IdLinea = dbo.in_subgrupo.IdLinea AND prod.IdGrupo = dbo.in_subgrupo.IdGrupo AND 
                         prod.IdSubGrupo = dbo.in_subgrupo.IdSubgrupo ON mov_inv_det.IdEmpresa = prod.IdEmpresa AND mov_inv_det.IdProducto = prod.IdProducto ON dbo.in_categorias.IdEmpresa = prod.IdEmpresa AND 
                         dbo.in_categorias.IdCategoria = prod.IdCategoria LEFT OUTER JOIN
                         dbo.ct_cbtecble_tipo AS tip_cbt ON tipo_mov.IdEmpresa = tip_cbt.IdEmpresa AND tipo_mov.IdTipoCbte = tip_cbt.IdTipoCbte LEFT OUTER JOIN
                         dbo.in_Motivo_Inven ON mov_inv.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa AND mov_inv.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv LEFT OUTER JOIN
                         dbo.in_producto_x_tb_bodega AS prod_x_bod ON mov_inv_det.IdEmpresa = prod_x_bod.IdEmpresa AND mov_inv_det.IdProducto = prod_x_bod.IdProducto AND mov_inv_det.IdBodega = prod_x_bod.IdBodega AND 
                         mov_inv_det.IdSucursal = prod_x_bod.IdSucursal LEFT OUTER JOIN
                         dbo.in_Motivo_Inven AS in_Motivo_Inven_1 ON mov_inv_det.IdEmpresa = in_Motivo_Inven_1.IdEmpresa AND mov_inv_det.IdMotivo_Inv = in_Motivo_Inven_1.IdMotivo_Inv
WHERE        (mov_inv.Estado = 'A') AND (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            dbo.in_movi_inve_x_ct_cbteCble AS A
                               WHERE        (IdEmpresa = mov_inv.IdEmpresa) AND (IdSucursal = mov_inv.IdSucursal) AND (IdBodega = mov_inv.IdBodega) AND (IdNumMovi = mov_inv.IdNumMovi) AND (IdMovi_inven_tipo = mov_inv.IdMovi_inven_tipo)))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[59] 4[27] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[29] 2[22] 3) )"
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
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 30
               Left = 976
               Bottom = 334
               Right = 1185
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "mov_inv_det"
            Begin Extent = 
               Top = 201
               Left = 381
               Bottom = 428
               Right = 644
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_inv"
            Begin Extent = 
               Top = 0
               Left = 674
               Bottom = 251
               Right = 937
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "tipo_mov"
            Begin Extent = 
               Top = 480
               Left = 792
               Bottom = 646
               Right = 1007
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc"
            Begin Extent = 
               Top = 0
               Left = 49
               Bottom = 129
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod"
            Begin Extent = 
               Top = 0
               Left = 318
               Bottom = 108
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "prod"
            Begin Extent = 
               Top = 311
               Left = 64
               Bottom = 561
               Right = 298
            End
            DisplayFlags = 280', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_detalle_x_Contabilizar_x_ctacbles';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            TopColumn = 0
         End
         Begin Table = "in_subgrupo"
            Begin Extent = 
               Top = 505
               Left = 490
               Bottom = 646
               Right = 703
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "prod_x_bod"
            Begin Extent = 
               Top = 169
               Left = 37
               Bottom = 279
               Right = 327
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Motivo_Inven_1"
            Begin Extent = 
               Top = 192
               Left = 576
               Bottom = 392
               Right = 785
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "tip_cbt"
            Begin Extent = 
               Top = 565
               Left = 1088
               Bottom = 675
               Right = 1297
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
      Begin ColumnWidths = 41
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3465
         Alias = 4545
         Table = 3630
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_detalle_x_Contabilizar_x_ctacbles';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_detalle_x_Contabilizar_x_ctacbles';

