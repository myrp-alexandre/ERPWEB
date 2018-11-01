CREATE VIEW [dbo].[vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det_2]
AS
SELECT        dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Ing_Egr_Inven_det.Secuencia, 
                         dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdProducto, dbo.in_Ing_Egr_Inven_det.dm_cantidad, dbo.in_Ing_Egr_Inven_det.dm_observacion, 
                         dbo.in_Ing_Egr_Inven_det.IdUnidadMedida, dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc, dbo.in_Ing_Egr_Inven_det.IdSucursal_oc, 
                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra, dbo.in_Ing_Egr_Inven_det.Secuencia_oc, dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv, 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_inv, dbo.in_Ing_Egr_Inven_det.IdBodega_inv, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv, dbo.in_Ing_Egr_Inven_det.secuencia_inv, dbo.com_ordencompra_local_det.do_precioCompra AS precioCompra_det_oc, 
                         dbo.com_ordencompra_local_det.do_descuento AS descuento_det_oc,  
                         dbo.com_ordencompra_local_det.do_subtotal AS Subtotal_det_oc, dbo.com_ordencompra_local_det.do_iva AS valor_iva_det_oc, 
                         dbo.com_ordencompra_local_det.do_total AS total_det_oc, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.tb_bodega.bo_Descripcion AS nom_bodega, 
                         dbo.in_Producto.pr_descripcion AS nom_producto, dbo.in_UnidadMedida.Descripcion AS nom_unidad, dbo.in_Ing_Egr_Inven.cm_fecha AS Fecha_Ing_Bod
FROM            dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia INNER JOIN
                         dbo.tb_sucursal ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_bodega ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.tb_bodega.IdBodega AND dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND 
                         dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal INNER JOIN
                         dbo.in_Producto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto AND
                          dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo LEFT OUTER JOIN
                         dbo.in_UnidadMedida ON dbo.in_Ing_Egr_Inven_det.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[58] 4[23] 2[5] 3) )"
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
         Left = -5
      End
      Begin Tables = 
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 15
               Left = 251
               Bottom = 265
               Right = 514
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local_det"
            Begin Extent = 
               Top = 282
               Left = 231
               Bottom = 347
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 277
               Left = 85
               Bottom = 338
               Right = 315
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 286
               Left = 0
               Bottom = 347
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 281
               Left = 471
               Bottom = 459
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 32
               Left = 709
               Bottom = 161
               Right = 972
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 276
               Left = 372
               Bottom = 405
               ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det_2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Right = 582
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
      Begin ColumnWidths = 35
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2490
         Alias = 2010
         Table = 3300
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det_2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det_2';

