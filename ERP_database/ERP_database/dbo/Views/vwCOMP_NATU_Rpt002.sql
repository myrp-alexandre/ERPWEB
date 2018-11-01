CREATE VIEW dbo.vwCOMP_NATU_Rpt002
AS
SELECT        emp.IdEmpresa, emp.em_nombre, suc.IdSucursal, suc.Su_Descripcion, SC.IdSolicitudCompra, SC.NumDocumento, SC.fecha, SC_det.Secuencia, SC_det.IdProducto, 
                         SC_det.do_Cantidad, ISNULL(SC_det.NomProducto, '') + prod.pr_descripcion AS NomProducto, OC_det.IdSucursal AS IdSucursalOC, OC_det.IdOrdenCompra, 
                         OC_det.Secuencia AS Secuencia_OC, OC_det.IdProducto AS IdProducto_OC, OC_det.do_precioCompra, OC_det.do_subtotal, 
                         dbo.com_ordencompra_local.IdProveedor, '' AS Nom_proveedor, ISNULL(OC_det.do_Cantidad, 0) AS do_Cantidad_OC, 
                         ISNULL(Movi_Int_T.dm_cantidad_Inv, 0) AS dm_cantidad_Inv, ISNULL(OC_det.do_Cantidad, 0) - ISNULL(Movi_Int_T.dm_cantidad_Inv, 0) AS Saldo_x_Ing_a_Inv, 
                         dbo.ct_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, prod.pr_codigo
FROM            dbo.com_ordencompra_local_det AS OC_det INNER JOIN
                         dbo.com_ordencompra_local_det_x_com_solicitud_compra_det AS OC ON OC_det.IdEmpresa = OC.ocd_IdEmpresa AND OC_det.IdSucursal = OC.ocd_IdSucursal AND
                          OC_det.IdOrdenCompra = OC.ocd_IdOrdenCompra AND OC_det.Secuencia = OC.ocd_Secuencia INNER JOIN
                         dbo.com_ordencompra_local ON OC_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND OC_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND
                          OC_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON OC_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND OC_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo RIGHT OUTER JOIN
                         dbo.com_solicitud_compra AS SC INNER JOIN
                         dbo.com_solicitud_compra_det AS SC_det ON SC.IdEmpresa = SC_det.IdEmpresa AND SC.IdSucursal = SC_det.IdSucursal AND 
                         SC.IdSolicitudCompra = SC_det.IdSolicitudCompra INNER JOIN
                         dbo.tb_sucursal AS suc ON SC.IdEmpresa = suc.IdEmpresa AND SC.IdSucursal = suc.IdSucursal INNER JOIN
                         dbo.tb_empresa AS emp ON suc.IdEmpresa = emp.IdEmpresa ON OC.scd_IdEmpresa = SC_det.IdEmpresa AND OC.scd_IdSucursal = SC_det.IdSucursal AND 
                         OC.scd_IdSolicitudCompra = SC_det.IdSolicitudCompra AND OC.scd_Secuencia = SC_det.Secuencia LEFT OUTER JOIN
                         dbo.vwin_movi_inve_detalle_x_com_ordencompra_local_det_TotalCant AS Movi_Int_T ON OC_det.IdEmpresa = Movi_Int_T.ocd_IdEmpresa AND 
                         OC_det.IdSucursal = Movi_Int_T.ocd_IdSucursal AND OC_det.IdOrdenCompra = Movi_Int_T.ocd_IdOrdenCompra AND 
                         OC_det.Secuencia = Movi_Int_T.ocd_Secuencia LEFT OUTER JOIN
                         dbo.in_Producto AS prod ON SC_det.IdEmpresa = prod.IdEmpresa AND SC_det.IdProducto = prod.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[83] 4[5] 2[5] 3) )"
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
         Top = -1248
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC"
            Begin Extent = 
               Top = 36
               Left = 552
               Bottom = 165
               Right = 763
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SC"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SC_det"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 301
            End
            Displ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_NATU_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ayFlags = 280
            TopColumn = 0
         End
         Begin Table = "suc"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Movi_Int_T"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1323
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "prod"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1561
               Right = 272
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
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_NATU_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_NATU_Rpt002';

