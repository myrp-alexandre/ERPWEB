CREATE VIEW dbo.vwin_Guia_x_traspaso_bodega_x_ordencompra_local_det
AS
SELECT        Guia.IdEmpresa, Guia.IdGuia, OComp.IdProducto, Guia.secuencia, Guia.IdEmpresa_OC, Guia.IdSucursal_OC, Guia.IdOrdenCompra_OC, Guia.Secuencia_OC, 
                         Guia.observacion, Guia.Cantidad_enviar, OComp.do_Cantidad, OComp.IdCentroCosto, OComp.IdCentroCosto_sub_centro_costo, OComp.IdPunto_cargo, 
                         OComp.IdUnidadMedida, OComp.do_precioCompra, OComp.IdPunto_cargo_grupo, dbo.in_Producto.pr_codigo, Guia.Referencia, 
                         dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, dbo.com_ordencompra_local.oc_observacion AS obs_OCompra, 
                         dbo.com_ordencompra_local.IdOrdenCompra
FROM            dbo.com_ordencompra_local_det AS OComp INNER JOIN
                         dbo.in_Guia_x_traspaso_bodega_det AS Guia ON OComp.IdEmpresa = Guia.IdEmpresa_OC AND OComp.IdSucursal = Guia.IdSucursal_OC AND 
                         OComp.IdOrdenCompra = Guia.IdOrdenCompra_OC AND OComp.Secuencia = Guia.Secuencia_OC INNER JOIN
                         dbo.in_Producto ON OComp.IdEmpresa = dbo.in_Producto.IdEmpresa AND OComp.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.com_ordencompra_local ON OComp.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND OComp.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND
                          OComp.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[66] 4[4] 2[4] 3) )"
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
         Begin Table = "OComp"
            Begin Extent = 
               Top = 23
               Left = 386
               Bottom = 301
               Right = 649
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Guia"
            Begin Extent = 
               Top = 0
               Left = 983
               Bottom = 263
               Right = 1192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 142
               Left = 731
               Bottom = 348
               Right = 965
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 250
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 24
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2280
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
         Width = 13350
         Width = 1500
      End
   End
   Begin Criter', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Guia_x_traspaso_bodega_x_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'iaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2910
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Guia_x_traspaso_bodega_x_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Guia_x_traspaso_bodega_x_ordencompra_local_det';

