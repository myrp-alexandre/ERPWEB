CREATE VIEW dbo.vwin_GeneracionCompraCidersus
AS
SELECT     dbo.com_ordencompra_local.IdEmpresa, dbo.com_ordencompra_local.IdSucursal, dbo.com_ordencompra_local.IdOrdenCompra, 
                      dbo.com_ordencompra_local.IdTerminoPago, dbo.com_ordencompra_local.oc_plazo, dbo.com_ordencompra_local.oc_fecha,  
                      dbo.com_ordencompra_local.oc_observacion, dbo.com_ordencompra_local.Estado, dbo.com_ordencompra_local.IdEstadoAprobacion_cat AS IdEstadoAprobacion, 
                      dbo.com_ordencompra_local.co_fecha_aprobacion, dbo.com_ordencompra_local.IdUsuario_Aprueba, dbo.com_ordencompra_local.IdUsuario_Reprue, 
                      dbo.com_ordencompra_local.co_fechaReproba, dbo.com_ordencompra_local.Fecha_Transac, dbo.com_ordencompra_local.Fecha_UltMod, 
                      dbo.com_ordencompra_local.IdUsuarioUltMod, dbo.com_ordencompra_local.FechaHoraAnul, dbo.com_ordencompra_local.IdUsuarioUltAnu, 
                       dbo.com_ordencompra_local.MotivoAnulacion, 
                      dbo.com_ordencompra_local.MotivoReprobacion, 
                      dbo.com_ordencompra_local.IdDepartamento, dbo.com_ordencompra_local.IdUsuario, dbo.com_ordencompra_local.IdMotivo, 
                      dbo.com_ordencompra_local.oc_fechaVencimiento, dbo.com_ordencompra_local.IdEstado_cierre, dbo.com_ordencompra_local.IdComprador, 
                      dbo.com_ordencompra_local_det.IdUnidadMedida, dbo.com_ordencompra_local_det.IdPunto_cargo, 
                      dbo.com_ordencompra_local_det.IdCentroCosto_sub_centro_costo, dbo.com_ordencompra_local_det.IdCentroCosto, 
                      dbo.com_ordencompra_local_det.do_observacion,  
                      dbo.com_ordencompra_local_det.do_total, dbo.com_ordencompra_local_det.do_iva, 
                      dbo.com_ordencompra_local_det.do_subtotal, dbo.com_ordencompra_local_det.do_descuento, dbo.com_ordencompra_local_det.do_porc_des, 
                      dbo.com_ordencompra_local_det.do_precioCompra, dbo.com_ordencompra_local_det.do_Cantidad, dbo.com_ordencompra_local_det.IdProducto, 
                      dbo.com_ordencompra_local_det.Secuencia, dbo.in_Producto.pr_descripcion, dbo.in_Producto.pr_observacion, dbo.in_Producto.IdUnidadMedida AS Expr1, 
                      0 pr_precio_publico, NULL AS IdCtaCble_Vta, NULL AS IdCtaCble_CosBaseIva, NULL AS IdCtaCble_CosBase0, NULL 
                      AS IdCtaCble_VenIva, NULL AS IdCtaCble_Ven0, NULL AS IdCtaCble_DesIva, NULL AS IdCtaCble_Des0, NULL AS IdCtaCble_DevIva, NULL AS IdCtaCble_Dev0, 
                       0 pr_stock_minimo
FROM         dbo.com_ordencompra_local INNER JOIN
                      dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                      dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                      dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra INNER JOIN
                      dbo.in_Producto ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                      dbo.com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[3] 2[16] 3) )"
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
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 252
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "com_ordencompra_local_det"
            Begin Extent = 
               Top = 32
               Left = 334
               Bottom = 310
               Right = 597
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 36
               Left = 670
               Bottom = 286
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 40
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 77
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
         Width = 150', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_GeneracionCompraCidersus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'0
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_GeneracionCompraCidersus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_GeneracionCompraCidersus';

