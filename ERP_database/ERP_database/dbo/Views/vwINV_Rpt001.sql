CREATE VIEW [dbo].[vwINV_Rpt001]
AS

SELECT isnull(ROW_NUMBER() OVER (ORDER BY dbo.in_Ing_Egr_Inven.IdEmpresa), 0) AS IdRow,dbo.in_Ing_Egr_Inven.IdEmpresa, dbo.in_Ing_Egr_Inven.IdSucursal, dbo.in_Ing_Egr_Inven.IdBodega, dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven.IdNumMovi, dbo.in_Ing_Egr_Inven.CodMoviInven, 
                  dbo.in_movi_inven_tipo.tm_descripcion AS Tipo_Movimiento, dbo.tb_empresa.em_nombre AS Empresa, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                  dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.in_UnidadMedida.Descripcion AS UnidadMedida, dbo.in_Ing_Egr_Inven_det.IdProducto, 
                  dbo.in_Ing_Egr_Inven_det.dm_cantidad AS Cantidad, 0 AS Stock_Ant, 0 AS Stock_Act, dbo.in_Ing_Egr_Inven_det.dm_observacion AS Observacion_det, 
                  dbo.in_Ing_Egr_Inven_det.IdCentroCosto, dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo, dbo.in_Ing_Egr_Inven_det.IdEstadoAproba, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida, 
                  dbo.in_Ing_Egr_Inven.cm_observacion AS Observacion, dbo.in_Ing_Egr_Inven.cm_fecha AS Fecha, dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, 
                  dbo.in_Ing_Egr_Inven_det.mv_costo_sinConversion, uniSin.Descripcion AS UnidadMedida_sinConversion, dbo.in_Ing_Egr_Inven.signo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.in_Ing_Egr_Inven_det.IdPunto_cargo
FROM     dbo.in_UnidadMedida RIGHT OUTER JOIN
                  dbo.in_movi_inven_tipo INNER JOIN
                  dbo.in_Ing_Egr_Inven ON dbo.in_movi_inven_tipo.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.in_movi_inven_tipo.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo INNER JOIN
                  dbo.in_Ing_Egr_Inven_det INNER JOIN
                  dbo.tb_sucursal INNER JOIN
                  dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal INNER JOIN
                  dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                  dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                  dbo.in_Producto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto ON 
                  dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi AND 
                  dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo ON dbo.in_UnidadMedida.IdUnidadMedida = dbo.in_Ing_Egr_Inven_det.IdUnidadMedida INNER JOIN
                  dbo.in_UnidadMedida AS uniSin ON uniSin.IdUnidadMedida = dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[12] 4[5] 2[83] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[19] 2[56] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
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
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -495
      End
      Begin Tables = 
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 390
               Left = 533
               Bottom = 520
               Right = 743
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 390
               Left = 781
               Bottom = 520
               Right = 996
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 390
               Left = 1034
               Bottom = 520
               Right = 1297
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 390
               Left = 1335
               Bottom = 520
               Right = 1598
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 522
               Left = 533
               Bottom = 652
               Right = 763
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 522
               Left = 801
               Bottom = 652
               Right = 1062
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 522
               Left = 1100
               Bottom = 652
            ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Right = 1319
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 522
               Left = 1357
               Bottom = 652
               Right = 1591
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uniSin"
            Begin Extent = 
               Top = 654
               Left = 533
               Bottom = 784
               Right = 743
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
      Begin ColumnWidths = 32
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
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2205
         Alias = 2610
         Table = 1845
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt001';

