CREATE VIEW dbo.vwcom_solicitud_compra_det
AS
SELECT        dbo.com_solicitud_compra_det.IdEmpresa, dbo.com_solicitud_compra_det.IdSucursal, dbo.com_solicitud_compra_det.IdSolicitudCompra, dbo.com_solicitud_compra_det.Secuencia, 
                         dbo.com_solicitud_compra_det.IdProducto, dbo.com_solicitud_compra_det.do_Cantidad, dbo.com_solicitud_compra_det.NomProducto, dbo.com_solicitud_compra_det.IdCentroCosto, 
                         dbo.com_solicitud_compra_det.IdCentroCosto_sub_centro_costo, dbo.com_solicitud_compra_det.IdPunto_cargo_grupo, dbo.com_solicitud_compra_det.IdPunto_cargo, 
                         dbo.com_solicitud_compra_det.IdUnidadMedida, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_centro_costo.Centro_costo AS Nom_Centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Nom_SubCentroCosto, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto_princ, 
                         ISNULL(dbo.vwin_Producto_Stock_x_Sucursal.Stock, 0) AS pr_stock, solCom.ocd_IdOrdenCompra, solCom.ocd_IdEmpresa, solCom.ocd_IdSucursal, SC.fecha, SC.IdEstadoAprobacion, 
                         dbo.tb_sucursal.Su_Descripcion AS nom_Sucursal, dbo.in_UnidadMedida.Descripcion AS nom_Unidad, dbo.com_solicitud_compra_det.do_observacion
FROM            dbo.in_UnidadMedida RIGHT OUTER JOIN
                         dbo.com_solicitud_compra_det INNER JOIN
                         dbo.com_solicitud_compra AS SC ON dbo.com_solicitud_compra_det.IdEmpresa = SC.IdEmpresa AND dbo.com_solicitud_compra_det.IdSucursal = SC.IdSucursal AND 
                         dbo.com_solicitud_compra_det.IdSolicitudCompra = SC.IdSolicitudCompra LEFT OUTER JOIN
                         dbo.vwin_Producto_Stock_x_Sucursal ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.vwin_Producto_Stock_x_Sucursal.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdSucursal = dbo.vwin_Producto_Stock_x_Sucursal.IdSucursal AND dbo.com_solicitud_compra_det.IdProducto = dbo.vwin_Producto_Stock_x_Sucursal.IdProducto ON 
                         dbo.in_UnidadMedida.IdUnidadMedida = dbo.com_solicitud_compra_det.IdUnidadMedida LEFT OUTER JOIN
                         dbo.tb_sucursal ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.com_solicitud_compra_det.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                         dbo.in_Producto ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.com_solicitud_compra_det.IdProducto = dbo.in_Producto.IdProducto LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.com_solicitud_compra_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND dbo.com_solicitud_compra_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.com_solicitud_compra_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.com_ordencompra_local_det_x_com_solicitud_compra_det AS solCom ON solCom.scd_IdEmpresa = dbo.com_solicitud_compra_det.IdEmpresa AND 
                         solCom.scd_IdSucursal = dbo.com_solicitud_compra_det.IdSucursal AND solCom.scd_IdSolicitudCompra = dbo.com_solicitud_compra_det.IdSolicitudCompra AND 
                         solCom.scd_Secuencia = dbo.com_solicitud_compra_det.Secuencia
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[61] 4[29] 2[4] 3) )"
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
         Top = -62
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vwin_Producto_Stock_x_Sucursal"
            Begin Extent = 
               Top = 61
               Left = 1061
               Bottom = 190
               Right = 1270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 192
               Left = 49
               Bottom = 321
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 221
               Left = 691
               Bottom = 469
               Right = 925
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_solicitud_compra_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 927
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SC"
            Begin Extent = 
               Top = 480
               Left = 300
               Bottom = 609
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_solicitud_compra_det"
            Begin Extent = 
               Top = 62
               Left = 413
               Bottom = 344
               Right = 676
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "solCom"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 249
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
         Column = 2145
         Alias = 2130
         Table = 3105
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_solicitud_compra_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_solicitud_compra_det';

