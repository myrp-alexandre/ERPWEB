CREATE view [vwAF_OrdenCompra_x_Proveedor_Factura_ActivoFijo] as 

SELECT        vwin_Ing_Egr.IdEmpresa, vwin_Ing_Egr.IdSucursal, vwin_Ing_Egr.IdNumMovi, vwin_Ing_Egr.Secuencia, vwin_Ing_Egr.IdBodega, vwin_Ing_Egr.IdProducto, 
                         vwin_Ing_Egr.nom_producto, vwin_Ing_Egr.dm_cantidad, vwin_Ing_Egr.mv_costo, vwin_Ing_Egr.dm_precio, vwin_Ing_Egr.dm_observacion, 
                         vwin_Ing_Egr.cm_fecha as Fecha_Ing_Bod, vwin_Ing_Egr.nom_bodega, vwin_Ing_Egr.IdEmpresa_oc, vwin_Ing_Egr.IdSucursal_oc, vwin_Ing_Egr.IdOrdenCompra, 
                         vwin_Ing_Egr.Secuencia_oc, vwin_Ing_Egr.IdProveedor, vwin_Ing_Egr.nom_proveedor, dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion, 
                         x_OC.Serie + '-' + x_OC.Serie2 + '-' + x_OC.num_documento AS numDocumento, x_OC.Fecha_Factura, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Cantidad, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Costo_uni, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.SubTotal, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.PorIva, 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.valor_Iva, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Total, x_OC.IdEmpresa_Ogiro, x_OC.IdCbteCble_Ogiro, 
                         x_OC.IdTipoCbte_Ogiro, x_OC.IdOrden_giro_Tipo, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCtaCble_Gasto, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCtaCble_IVA, 
                         vwin_Ing_Egr.IdNaturaleza
FROM            dbo.cp_Aprobacion_Ing_Bod_x_OC_det INNER JOIN
                         dbo.cp_Aprobacion_Ing_Bod_x_OC AS x_OC ON dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa = x_OC.IdEmpresa AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion = x_OC.IdAprobacion RIGHT OUTER JOIN
                         dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det ON dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion = dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa = dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv = dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv = dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv = dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv = dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv RIGHT OUTER JOIN
                         dbo.vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det AS vwin_Ing_Egr ON 
                         dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv = vwin_Ing_Egr.IdEmpresa AND 
                         dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv = vwin_Ing_Egr.IdSucursal AND 
                         dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv = vwin_Ing_Egr.IdNumMovi AND 
                         dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv = vwin_Ing_Egr.Secuencia
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
         Begin Table = "vwcp_Aprobacion"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "x_OC"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "x_OC_Det"
            Begin Extent = 
               Top = 6
               Left = 339
               Bottom = 135
               Right = 557
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_Ing_Egr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 301
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAF_OrdenCompra_x_Proveedor_Factura_ActivoFijo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAF_OrdenCompra_x_Proveedor_Factura_ActivoFijo';

