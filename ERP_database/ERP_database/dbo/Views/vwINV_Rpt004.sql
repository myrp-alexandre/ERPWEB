CREATE VIEW [dbo].[vwINV_Rpt004]
AS
SELECT        dbo.com_ordencompra_local.IdEmpresa, dbo.com_ordencompra_local.IdSucursal AS IdSucursal_oc, dbo.com_ordencompra_local.IdOrdenCompra, 
                         dbo.com_ordencompra_local.oc_fecha AS Fecha_oc, dbo.com_ordencompra_local.oc_observacion AS Observacion_oc, 
                         dbo.com_ordencompra_local.Estado AS Estado_oc, dbo.cp_proveedor.IdProveedor, pe_nombreCompleto AS nom_proveedor, dbo.in_Producto.IdProducto, 
                         dbo.in_Producto.pr_descripcion AS nom_producto, dbo.in_Ing_Egr_Inven_det.IdSucursal AS IdSucursal_inv, dbo.in_Ing_Egr_Inven_det.IdBodega AS IdBodega_inv, 
                         dbo.com_ordencompra_local_det.do_Cantidad AS Cant_Pedida_oc, ISNULL(dbo.in_Ing_Egr_Inven_det.dm_cantidad, 0) AS Cant_Recibida_inv, 
                         dbo.com_ordencompra_local_det.do_Cantidad - ISNULL(dbo.in_Ing_Egr_Inven_det.dm_cantidad, 0) AS Cant_x_Recivir_inv, 'PE' AS EstadoPago
FROM            dbo.in_Ing_Egr_Inven INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi AND 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia INNER JOIN
                         dbo.com_ordencompra_local ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND 
                         dbo.com_ordencompra_local_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor AND 
                         dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa INNER JOIN
                         dbo.in_Producto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[76] 4[5] 2[1] 3) )"
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
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 10
               Left = 667
               Bottom = 224
               Right = 930
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local_det"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 328
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
      Begi', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt004';

