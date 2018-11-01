CREATE VIEW Naturisa.vwINV_NAT_Rpt006
AS
SELECT        dbo.in_movi_inve_detalle.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_movi_inve_detalle.IdBodega, dbo.in_movi_inve_detalle.IdMovi_inven_tipo, 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_movi_inve_detalle.Secuencia, dbo.in_movi_inve_detalle.IdProducto, dbo.in_Producto.pr_codigo AS cod_producto, 
                         dbo.in_Producto.pr_descripcion AS nom_producto, dbo.in_UnidadMedida.IdUnidadMedida, dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida, 
                         dbo.in_movi_inve.cm_fecha, dbo.tb_bodega.cod_bodega, dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.tb_sucursal.codigo AS cod_sucursal, 
                         dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.ct_centro_costo.IdCentroCosto, dbo.ct_centro_costo.Centro_costo AS nom_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro_costo, 
                         ABS(dbo.in_movi_inve_detalle.dm_cantidad) AS dm_cantidad, dbo.in_movi_inve_detalle.mv_costo, ABS(dbo.in_movi_inve_detalle.dm_cantidad) 
                         * dbo.in_movi_inve_detalle.mv_costo AS Total, dbo.in_movi_inve_detalle.mv_tipo_movi
FROM            dbo.ct_centro_costo_sub_centro_costo INNER JOIN
                         dbo.in_movi_inve INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi INNER JOIN
                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.in_movi_inve_detalle.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.in_movi_inve_detalle.IdCentroCosto_sub_centro_costo INNER JOIN
                         dbo.ct_centro_costo ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                         dbo.in_UnidadMedida ON dbo.in_movi_inve_detalle.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.in_Ing_Egr_Inven_det.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo AND 
                         dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND 
                         dbo.in_movi_inve_detalle.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         dbo.in_movi_inve_detalle.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND 
                         dbo.in_movi_inve_detalle.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         dbo.in_movi_inve_detalle.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND 
                         dbo.in_movi_inve_detalle.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv LEFT OUTER JOIN
                         dbo.tb_sucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal ON 
                         dbo.in_movi_inve.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.in_movi_inve.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.in_movi_inve.IdBodega = dbo.tb_bodega.IdBodega
WHERE        (dbo.in_movi_inve_detalle.mv_tipo_movi = N'-')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[83] 2[4] 3) )"
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
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve_detalle"
            Begin Extent = 
               Top = 93
               Left = 423
               Bottom = 222
               Right = 686
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
             ', @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwINV_NAT_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 10
               Left = 838
               Bottom = 166
               Right = 1101
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
', @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwINV_NAT_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwINV_NAT_Rpt006';

