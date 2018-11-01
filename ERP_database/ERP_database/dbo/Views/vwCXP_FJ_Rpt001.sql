CREATE VIEW [dbo].[vwCXP_FJ_Rpt001]
AS
SELECT        SucursalIni.Su_Descripcion AS Sucursal_Origen, dbo.tb_sucursal.Su_Descripcion AS Sucursal_Fin, tb_bodega_Fin.bo_Descripcion AS Bodega_Fin, 
                         tb_bodega_Ini.bo_Descripcion AS Bodega_Ini, dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.observacion, 
                         dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.cantidad, dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.dt_secuencia, 
                         dbo.in_Guia_x_traspaso_bodega.NumGuia, dbo.in_Guia_x_traspaso_bodega.IdGuia, dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Partida, 
                         dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Llegada, dbo.tb_transportista.Cedula, dbo.tb_transportista.Nombre, dbo.in_Guia_x_traspaso_bodega.Fecha, 
                         dbo.in_Guia_x_traspaso_bodega.Fecha_Traslado, dbo.in_Guia_x_traspaso_bodega.Fecha_llegada, dbo.in_Guia_x_traspaso_bodega.Hora_Traslado, 
                         dbo.in_Guia_x_traspaso_bodega.Hora_Llegada, dbo.in_Producto.pr_codigo, dbo.in_transferencia_det.IdProducto, dbo.in_Producto.pr_descripcion, 
                         dbo.vwIn_Motivo_traslado_bodega.Nombre AS Motivo_traslado, dbo.in_transferencia.IdEmpresa, dbo.in_transferencia.IdSucursalOrigen, 
                         dbo.in_transferencia.IdBodegaOrigen, dbo.in_transferencia.IdTransferencia, dbo.in_transferencia.IdSucursalDest, dbo.in_transferencia.IdBodegaDest, 
                         dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado
FROM            dbo.vwIn_Motivo_traslado_bodega INNER JOIN
                         dbo.in_Guia_x_traspaso_bodega INNER JOIN
                         dbo.tb_transportista ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_transportista.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdTransportista = dbo.tb_transportista.IdTransportista ON 
                         dbo.vwIn_Motivo_traslado_bodega.IdMotivo_Traslado = dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado RIGHT OUTER JOIN
                         dbo.in_transferencia_det INNER JOIN
                         dbo.in_Producto ON dbo.in_transferencia_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_transferencia_det.IdProducto = dbo.in_Producto.IdProducto RIGHT OUTER JOIN
                         dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det ON 
                         dbo.in_transferencia_det.IdEmpresa = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdEmpresa AND 
                         dbo.in_transferencia_det.IdSucursalOrigen = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdSucursalOrigen AND 
                         dbo.in_transferencia_det.IdBodegaOrigen = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdBodegaOrigen AND 
                         dbo.in_transferencia_det.IdTransferencia = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdTransferencia AND 
                         dbo.in_transferencia_det.dt_secuencia = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.dt_secuencia ON 
                         dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdGuia = dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdGuia LEFT OUTER JOIN
                         dbo.tb_sucursal INNER JOIN
                         dbo.tb_sucursal AS SucursalIni INNER JOIN
                         dbo.in_transferencia ON SucursalIni.IdEmpresa = dbo.in_transferencia.IdEmpresa AND SucursalIni.IdSucursal = dbo.in_transferencia.IdSucursalOrigen INNER JOIN
                         dbo.tb_bodega AS tb_bodega_Ini ON dbo.in_transferencia.IdEmpresa = tb_bodega_Ini.IdEmpresa AND 
                         dbo.in_transferencia.IdSucursalOrigen = tb_bodega_Ini.IdSucursal AND dbo.in_transferencia.IdBodegaOrigen = tb_bodega_Ini.IdBodega ON 
                         dbo.tb_sucursal.IdEmpresa = dbo.in_transferencia.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.in_transferencia.IdSucursalDest INNER JOIN
                         dbo.tb_bodega AS tb_bodega_Fin ON dbo.in_transferencia.IdEmpresa = tb_bodega_Fin.IdEmpresa AND 
                         dbo.in_transferencia.IdSucursalDest = tb_bodega_Fin.IdSucursal AND dbo.in_transferencia.IdBodegaDest = tb_bodega_Fin.IdBodega ON 
                         dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdEmpresa = dbo.in_transferencia.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdSucursalOrigen = dbo.in_transferencia.IdSucursalOrigen AND 
                         dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdBodegaOrigen = dbo.in_transferencia.IdBodegaOrigen AND 
                         dbo.in_Guia_x_traspaso_bodega_x_in_transferencia_det.IdTransferencia = dbo.in_transferencia.IdTransferencia
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[90] 4[4] 3) )"
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
         Configuration = "(H (1[51] 3) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "in_Guia_x_traspaso_bodega"
            Begin Extent = 
               Top = 60
               Left = 411
               Bottom = 394
               Right = 709
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Guia_x_traspaso_bodega_x_in_transferencia_det"
            Begin Extent = 
               Top = 0
               Left = 1007
               Bottom = 340
               Right = 1344
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SucursalIni"
            Begin Extent = 
               Top = 214
               Left = 86
               Bottom = 343
               Right = 316
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 211
               Left = 73
               Bottom = 340
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_transferencia"
            Begin Extent = 
               Top = 2
               Left = 320
               Bottom = 341
               Right = 596
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_transferencia_det"
            Begin Extent = 
               Top = 17
               Left = 974
               Bottom = 396
               Right = 1183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega_Ini"
            Begin Extent = 
               Top = 211
               Left = 86
           ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_FJ_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    Bottom = 345
               Right = 347
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega_Fin"
            Begin Extent = 
               Top = 154
               Left = 12
               Bottom = 283
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_transportista"
            Begin Extent = 
               Top = 84
               Left = 631
               Bottom = 213
               Right = 840
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 104
               Left = 820
               Bottom = 375
               Right = 1110
            End
            DisplayFlags = 280
            TopColumn = 37
         End
         Begin Table = "vwIn_Motivo_traslado_bodega"
            Begin Extent = 
               Top = 171
               Left = 639
               Bottom = 302
               Right = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 24
         Width = 284
         Width = 3450
         Width = 3270
         Width = 3240
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 930
         Width = 855
         Width = 795
         Width = 1500
         Width = 1500
         Width = 1515
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
         Alias = 1545
         Table = 2070
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_FJ_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_FJ_Rpt001';

