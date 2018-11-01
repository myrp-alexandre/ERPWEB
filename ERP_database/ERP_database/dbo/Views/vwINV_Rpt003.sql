CREATE VIEW dbo.vwINV_Rpt003
AS
SELECT        ing_egr.IdEmpresa, ing_egr.IdSucursal, ing_egr.IdNumMovi, ing_egr.signo, ing_egr.IdMovi_inven_tipo, ing_egr.CodMoviInven, ing_egr.cm_observacion, ing_egr.cm_fecha, ing_egr.Estado, 
                         ing_egr_det.IdEmpresa_inv, ing_egr_det.IdSucursal_inv, ing_egr_det.IdBodega_inv, ing_egr_det.IdMovi_inven_tipo_inv, ing_egr_det.IdNumMovi_inv, 0 IdMotivo_oc, com_mot.Descripcion, 
                         ing_egr_det.Secuencia, ing_egr_det.IdBodega, bod.bo_Descripcion AS bodega, suc.Su_Descripcion AS sucursal, ing_egr_det.IdProducto, ing_egr_det.dm_cantidad, ing_egr_det.dm_observacion, 
                         0 dm_precio, ing_egr_det.mv_costo, ing_egr_det.IdEstadoAproba, ing_egr_det.IdUnidadMedida, dbo.ct_centro_costo.IdCentroCosto, dbo.ct_centro_costo.Centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AS IdSubCentro_Costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS SubCentro_costo, dbo.ct_punto_cargo.IdPunto_cargo, 
                         dbo.ct_punto_cargo.nom_punto_cargo AS punto_cargo, in_UnidadMedida_1.Descripcion AS Nom_Unidad_Medida, mov_ti.tm_descripcion AS Tipo_Movi_Inven, dbo.in_Motivo_Inven.IdMotivo_Inv, 
                         dbo.in_Motivo_Inven.Desc_mov_inv AS Nom_Motivo_Inv, dbo.in_Producto.pr_descripcion AS Nom_producto, 0 dm_stock_ante, 0 dm_stock_actu, ing_egr_det.dm_cantidad_sinConversion, 
                         ing_egr_det.IdUnidadMedida_sinConversion, ing_egr_det.mv_costo_sinConversion, dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida_sinConversion
FROM            dbo.in_Motivo_Inven INNER JOIN
                         dbo.in_movi_inven_tipo AS mov_ti INNER JOIN
                         dbo.in_Ing_Egr_Inven AS ing_egr INNER JOIN
                         dbo.in_Ing_Egr_Inven_det AS ing_egr_det ON ing_egr.IdEmpresa = ing_egr_det.IdEmpresa AND ing_egr.IdSucursal = ing_egr_det.IdSucursal AND ing_egr.IdNumMovi = ing_egr_det.IdNumMovi AND 
                         ing_egr.IdMovi_inven_tipo = ing_egr_det.IdMovi_inven_tipo ON mov_ti.IdEmpresa = ing_egr.IdEmpresa AND mov_ti.IdMovi_inven_tipo = ing_egr.IdMovi_inven_tipo INNER JOIN
                         dbo.tb_sucursal AS suc INNER JOIN
                         dbo.tb_bodega AS bod ON suc.IdEmpresa = bod.IdEmpresa AND suc.IdSucursal = bod.IdSucursal ON ing_egr_det.IdEmpresa = bod.IdEmpresa AND ing_egr_det.IdSucursal = bod.IdSucursal AND 
                         ing_egr_det.IdBodega = bod.IdBodega ON dbo.in_Motivo_Inven.IdEmpresa = ing_egr.IdEmpresa AND dbo.in_Motivo_Inven.IdMotivo_Inv = ing_egr.IdMotivo_Inv INNER JOIN
                         dbo.in_Producto ON ing_egr_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND ing_egr_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.in_UnidadMedida ON ing_egr_det.IdUnidadMedida_sinConversion = dbo.in_UnidadMedida.IdUnidadMedida LEFT OUTER JOIN
                         dbo.ct_centro_costo INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_centro_costo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto ON ing_egr_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         ing_egr_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         ing_egr_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.in_UnidadMedida AS in_UnidadMedida_1 ON ing_egr_det.IdUnidadMedida = in_UnidadMedida_1.IdUnidadMedida LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON ing_egr_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND ing_egr_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.com_Motivo_Orden_Compra AS com_mot ON ing_egr.IdEmpresa = com_mot.IdEmpresa AND null = com_mot.IdMotivo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[32] 2[14] 3) )"
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
         Top = -95
         Left = -302
      End
      Begin Tables = 
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 429
               Left = 1071
               Bottom = 548
               Right = 1257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_ti"
            Begin Extent = 
               Top = 340
               Left = 1193
               Bottom = 459
               Right = 1381
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ing_egr"
            Begin Extent = 
               Top = 0
               Left = 1032
               Bottom = 119
               Right = 1284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ing_egr_det"
            Begin Extent = 
               Top = 22
               Left = 363
               Bottom = 395
               Right = 615
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc"
            Begin Extent = 
               Top = 306
               Left = 1158
               Bottom = 393
               Right = 1310
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod"
            Begin Extent = 
               Top = 53
               Left = 73
               Bottom = 155
               Right = 202
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 113
               Left = 1166
               Bottom = 308
               Right = 1388
            End
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 226
               Left = 794
               Bottom = 338
               Right = 991
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 456
               Left = 831
               Bottom = 575
               Right = 1019
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 447
               Left = 647
               Bottom = 566
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida_1"
            Begin Extent = 
               Top = 396
               Left = 340
               Bottom = 526
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 199
               Left = 6
               Bottom = 318
               Right = 182
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_mot"
            Begin Extent = 
               Top = 326
               Left = 910
               Bottom = 445
               Right = 1096
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
      Begin ColumnWidths = 45
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3210
         Alias = 1725
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt003';

