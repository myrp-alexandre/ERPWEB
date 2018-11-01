CREATE VIEW dbo.vwINV_FJ_Rpt006
AS
SELECT        dbo.in_movi_inve.IdEmpresa, dbo.in_movi_inve.IdSucursal, dbo.in_movi_inve.IdBodega, dbo.in_movi_inve.IdMovi_inven_tipo, dbo.in_movi_inve.IdNumMovi, 
                         dbo.in_movi_inve.CodMoviInven, dbo.in_movi_inve.cm_tipo, dbo.in_movi_inve.cm_fecha, dbo.in_movi_inve_detalle.Secuencia, 
                         dbo.in_movi_inve_detalle.IdProducto, dbo.in_movi_inve_detalle.dm_cantidad, dbo.in_movi_inve_detalle.dm_observacion, dbo.in_movi_inve_detalle.mv_costo, 
                         dbo.tb_empresa.em_nombre AS nom_empresa, dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.in_movi_inven_tipo.tm_descripcion AS nom_tipo_inven, dbo.in_Producto.pr_codigo AS cod_producto, 
                         dbo.in_Producto.pr_descripcion AS nom_producto, dbo.ct_centro_costo.Centro_costo AS nom_centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro_costo, ISNULL(dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, '') 
                         AS IdSubcentro_costo, ISNULL(dbo.ct_centro_costo.IdCentroCosto, '') AS IdCentro_costo
FROM            dbo.tb_bodega INNER JOIN
                         dbo.in_movi_inve INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi ON 
                         dbo.tb_bodega.IdEmpresa = dbo.in_movi_inve.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_movi_inve.IdSucursal AND 
                         dbo.tb_bodega.IdBodega = dbo.in_movi_inve.IdBodega INNER JOIN
                         dbo.tb_empresa INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_empresa.IdEmpresa = dbo.tb_sucursal.IdEmpresa ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.in_movi_inve_detalle.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                         dbo.in_movi_inve_detalle.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.in_movi_inve_detalle.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto AND 
                         dbo.in_movi_inve_detalle.IdEmpresa = dbo.ct_centro_costo.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[82] 4[4] 2[4] 3) )"
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
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 25
               Left = 60
               Bottom = 154
               Right = 321
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve"
            Begin Extent = 
               Top = 24
               Left = 226
               Bottom = 256
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve_detalle"
            Begin Extent = 
               Top = 22
               Left = 689
               Bottom = 324
               Right = 952
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 187
               Left = 5
               Bottom = 316
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 32
               Left = 7
               Bottom = 161
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 252
               Left = 375
               Bottom = 381
               Right = 665
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 199
               Left = 35
               Bottom = 328
               Right = 244
           ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_FJ_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 179
               Left = 1009
               Bottom = 308
               Right = 1272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 35
               Left = 1025
               Bottom = 164
               Right = 1234
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_FJ_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_FJ_Rpt006';

