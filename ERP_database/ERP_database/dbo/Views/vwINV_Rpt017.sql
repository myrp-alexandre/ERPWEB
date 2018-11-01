CREATE VIEW dbo.vwINV_Rpt017
AS
SELECT        dbo.in_transferencia_det.IdEmpresa, dbo.in_transferencia_det.IdSucursalOrigen, dbo.in_transferencia_det.IdBodegaOrigen, 
                         dbo.in_transferencia_det.IdTransferencia, dbo.in_transferencia_det.dt_secuencia, dbo.in_transferencia_det.IdProducto, dbo.in_Producto.pr_codigo, 
                         dbo.in_Producto.pr_descripcion, dbo.in_transferencia_det.dt_cantidad, dbo.in_transferencia_det.IdUnidadMedida, 
                         dbo.in_UnidadMedida.Descripcion AS nom_unidad_medida, suc_origen.codigo AS cod_sucursal_origen, suc_origen.Su_Descripcion AS nom_sucursal_origen, 
                         bod_origen.cod_bodega AS cod_bodega_origen, bod_origen.bo_Descripcion AS nom_bodega_origen, suc_destino.codigo AS cod_sucursal_destino, 
                         suc_destino.Su_Descripcion AS nom_sucursal_destino, bod_destino.cod_bodega AS cod_bodega_destino, bod_destino.bo_Descripcion AS nom_bodega_destino, 
                         dbo.in_transferencia.tr_fecha, dbo.in_transferencia.tr_Observacion, dbo.in_transferencia.Estado, dbo.in_transferencia.Codigo
FROM            dbo.in_transferencia INNER JOIN
                         dbo.in_transferencia_det ON dbo.in_transferencia.IdEmpresa = dbo.in_transferencia_det.IdEmpresa AND 
                         dbo.in_transferencia.IdSucursalOrigen = dbo.in_transferencia_det.IdSucursalOrigen AND 
                         dbo.in_transferencia.IdBodegaOrigen = dbo.in_transferencia_det.IdBodegaOrigen AND 
                         dbo.in_transferencia.IdTransferencia = dbo.in_transferencia_det.IdTransferencia INNER JOIN
                         dbo.tb_bodega AS bod_origen ON dbo.in_transferencia.IdEmpresa = bod_origen.IdEmpresa AND dbo.in_transferencia.IdSucursalOrigen = bod_origen.IdSucursal AND 
                         dbo.in_transferencia.IdBodegaOrigen = bod_origen.IdBodega INNER JOIN
                         dbo.tb_sucursal AS suc_origen ON bod_origen.IdEmpresa = suc_origen.IdEmpresa AND bod_origen.IdSucursal = suc_origen.IdSucursal INNER JOIN
                         dbo.tb_bodega AS bod_destino ON dbo.in_transferencia.IdEmpresa = bod_destino.IdEmpresa AND 
                         dbo.in_transferencia.IdSucursalDest = bod_destino.IdSucursal AND dbo.in_transferencia.IdBodegaDest = bod_destino.IdBodega INNER JOIN
                         dbo.tb_sucursal AS suc_destino ON bod_destino.IdEmpresa = suc_destino.IdEmpresa AND bod_destino.IdSucursal = suc_destino.IdSucursal INNER JOIN
                         dbo.in_UnidadMedida ON dbo.in_transferencia_det.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida INNER JOIN
                         dbo.in_Producto ON dbo.in_transferencia_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_transferencia_det.IdProducto = dbo.in_Producto.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[67] 4[4] 2[4] 3) )"
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
         Top = -589
         Left = 0
      End
      Begin Tables = 
         Begin Table = "in_transferencia"
            Begin Extent = 
               Top = 592
               Left = 354
               Bottom = 807
               Right = 630
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_transferencia_det"
            Begin Extent = 
               Top = 589
               Left = 0
               Bottom = 889
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod_origen"
            Begin Extent = 
               Top = 588
               Left = 713
               Bottom = 746
               Right = 972
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc_origen"
            Begin Extent = 
               Top = 580
               Left = 1030
               Bottom = 714
               Right = 1260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bod_destino"
            Begin Extent = 
               Top = 638
               Left = 718
               Bottom = 802
               Right = 979
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc_destino"
            Begin Extent = 
               Top = 731
               Left = 1048
               Bottom = 860
               Right = 1278
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 782
               Left = 389
               Bottom = 911
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt017';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 599
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 476
               Left = 0
               Bottom = 605
               Right = 234
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
      Begin ColumnWidths = 22
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt017';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt017';

