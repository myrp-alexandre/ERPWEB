/*select * from vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega*/
CREATE VIEW dbo.vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega_consul
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.oc_fecha, OC.oc_observacion, OC.IdEstadoAprobacion_cat, OC.Estado, Prov.IdProveedor, per.pe_nombreCompleto AS nom_proveedor, Prod.IdProducto, 
                         Prod.pr_codigo AS cod_producto, Prod.pr_descripcion AS nom_producto, OC_det.do_Cantidad, OC_det.do_precioCompra, OC_det.do_subtotal, dbo.tb_sucursal.Su_Descripcion, OC.oc_NumDocumento, 
                         OC_det.Secuencia, dbo.in_Guia_x_traspaso_bodega_det.Cantidad_enviar, dbo.in_Guia_x_traspaso_bodega_det.observacion AS observacion_det_gui, dbo.in_Guia_x_traspaso_bodega_det.IdGuia, 
                         OC.oc_fechaVencimiento, dbo.in_Guia_x_traspaso_bodega_det.Referencia
FROM            dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.com_ordencompra_local_det AS OC_det ON OC.IdEmpresa = OC_det.IdEmpresa AND OC.IdSucursal = OC_det.IdSucursal AND OC.IdOrdenCompra = OC_det.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor AS Prov ON OC.IdEmpresa = Prov.IdEmpresa AND OC.IdProveedor = Prov.IdProveedor INNER JOIN
                         dbo.in_Producto AS Prod ON OC_det.IdEmpresa = Prod.IdEmpresa AND OC_det.IdProducto = Prod.IdProducto INNER JOIN
                         dbo.tb_sucursal ON OC.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND OC.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Guia_x_traspaso_bodega_det ON OC_det.IdEmpresa = dbo.in_Guia_x_traspaso_bodega_det.IdEmpresa_OC AND OC_det.IdSucursal = dbo.in_Guia_x_traspaso_bodega_det.IdSucursal_OC AND 
                         OC_det.IdOrdenCompra = dbo.in_Guia_x_traspaso_bodega_det.IdOrdenCompra_OC AND OC_det.Secuencia = dbo.in_Guia_x_traspaso_bodega_det.Secuencia_OC
						 inner join tb_persona as per on prov.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[23] 2[3] 3) )"
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
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC_det"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prov"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prod"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Guia_x_traspaso_bodega_det"
            Begin Extent = 
               Top = 504
               Left = 784
               Bottom = 739
               Right = 993
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
      Begin ColumnWidths = 24
         Width = 284
         Width = 1500
         Wid', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega_consul';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'th = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega_consul';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_sin_Guia_x_traspaso_bodega_consul';

