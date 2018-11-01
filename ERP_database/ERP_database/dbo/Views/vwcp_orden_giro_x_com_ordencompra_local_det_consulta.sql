CREATE VIEW dbo.vwcp_orden_giro_x_com_ordencompra_local_det_consulta
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.Secuencia, OC.IdProducto, OC.do_Cantidad, OC.do_precioCompra, OC.do_porc_des, OC.do_descuento, 
                         OC.do_subtotal, OC.do_iva, OC.do_total,  OC.do_observacion, CASE WHEN OC_x_MOVI.mi_IdEmpresa IS NULL 
                         THEN 'N' ELSE 'S' END AS Tiene_Movi_Inven, OC.IdCentroCosto, OC.IdCentroCosto_sub_centro_costo, OC.IdPunto_cargo, OC.IdUnidadMedida, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_sub_centro_costo, dbo.com_ordencompra_local.oc_fecha, 
                         dbo.com_ordencompra_local.oc_observacion, dbo.tb_sucursal.Su_Descripcion, dbo.com_ordencompra_local.IdMotivo, 
                         dbo.com_Motivo_Orden_Compra.Descripcion AS nom_motivo_OC, dbo.in_Producto.pr_descripcion, dbo.in_UnidadMedida.Descripcion AS nom_medida, 
                         dbo.cp_orden_giro_x_com_ordencompra_local_det.IdEmpresa_Ogiro, dbo.cp_orden_giro_x_com_ordencompra_local_det.IdCbteCble_Ogiro, 
                         dbo.cp_orden_giro_x_com_ordencompra_local_det.IdTipoCbte_Ogiro, dbo.cp_orden_giro_x_com_ordencompra_local_det.Observacion
FROM            dbo.com_ordencompra_local_det AS OC INNER JOIN
                         dbo.in_Producto ON OC.IdEmpresa = dbo.in_Producto.IdEmpresa AND OC.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.cp_orden_giro_x_com_ordencompra_local_det ON OC.IdEmpresa = dbo.cp_orden_giro_x_com_ordencompra_local_det.IdEmpresa_OC AND 
                         OC.IdSucursal = dbo.cp_orden_giro_x_com_ordencompra_local_det.IdSucursal_OC AND 
                         OC.IdOrdenCompra = dbo.cp_orden_giro_x_com_ordencompra_local_det.IdOrdenCompra AND 
                         OC.Secuencia = dbo.cp_orden_giro_x_com_ordencompra_local_det.Secuencia_OC INNER JOIN
                         dbo.com_ordencompra_local ON OC.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND OC.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND 
                         OC.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra INNER JOIN
                         dbo.tb_sucursal ON dbo.com_ordencompra_local.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.com_Motivo_Orden_Compra ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdMotivo = dbo.com_Motivo_Orden_Compra.IdMotivo LEFT OUTER JOIN
                         dbo.in_UnidadMedida ON OC.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON OC.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         OC.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         OC.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.in_movi_inve_detalle_x_com_ordencompra_local_det AS OC_x_MOVI ON OC.IdEmpresa = OC_x_MOVI.ocd_IdEmpresa AND 
                         OC.IdSucursal = OC_x_MOVI.ocd_IdSucursal AND OC.IdOrdenCompra = OC_x_MOVI.ocd_IdOrdenCompra AND OC.Secuencia = OC_x_MOVI.ocd_Secuencia
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[7] 2[40] 3) )"
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
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC"
            Begin Extent = 
               Top = 24
               Left = 75
               Bottom = 153
               Right = 338
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 215
               Left = 450
               Bottom = 344
               Right = 679
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro_x_com_ordencompra_local_det"
            Begin Extent = 
               Top = 9
               Left = 485
               Bottom = 204
               Right = 874
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 100
               Left = 423
               Bottom = 229
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 78
               Left = 567
               Bottom = 207
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC_x_MOVI"
            Begin Extent = 
               Top = 137
               Left = 1103
               Bottom = 449
               Right = 1312
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 40
               Left = 889
               Bot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_giro_x_com_ordencompra_local_det_consulta';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'tom = 258
               Right = 1106
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 96
               Left = 878
               Bottom = 261
               Right = 1108
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_Motivo_Orden_Compra"
            Begin Extent = 
               Top = 33
               Left = 762
               Bottom = 199
               Right = 971
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
         Column = 2490
         Alias = 5325
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
         Or = 1410
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_giro_x_com_ordencompra_local_det_consulta';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_giro_x_com_ordencompra_local_det_consulta';

