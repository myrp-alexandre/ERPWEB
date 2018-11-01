CREATE VIEW Naturisa.vwCOMP_NATU_Rpt001
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_fecha AS Fecha_OC, OC.oc_observacion AS Observacion_OC, 
                         CASE WHEN OC.Estado = 'A' THEN 'ACTIVA' ELSE 'ANULADA' END AS Estado_OC, OC_det.Secuencia, OC_det.IdProducto, OC_det.do_Cantidad AS cantidad_det, 
                         OC_det.do_precioCompra AS Precio_det, OC_det.do_subtotal AS Subtotal_det, OC_det.do_iva AS Iva_det, OC_det.do_total AS Total_det, 
                         Prove.pr_codigo AS cod_proveedor, '' AS nom_proveedor, Prod.pr_codigo AS cod_producto, Prod.pr_descripcion AS nom_producto, 
                         Sucu.Su_Descripcion AS nom_sucursal, dbo.ct_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.com_comprador.IdComprador, 
                         dbo.com_comprador.Descripcion AS nom_comprador, dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo, dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, 
                         dbo.ct_punto_cargo_grupo.cod_Punto_cargo_grupo, dbo.ct_punto_cargo.codPunto_cargo, OC_det.IdUnidadMedida, OC_det.Por_Iva, OC_det.do_observacion, 
                         OC_det.do_precioFinal, OC_det.do_porc_des, OC.IdEstadoAprobacion_cat, dbo.com_catalogo.Nombre AS nom_estado_aprobacion, OC.oc_plazo
FROM            dbo.com_catalogo INNER JOIN
                         dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.com_ordencompra_local_det AS OC_det ON OC.IdEmpresa = OC_det.IdEmpresa AND OC.IdSucursal = OC_det.IdSucursal AND 
                         OC.IdOrdenCompra = OC_det.IdOrdenCompra INNER JOIN
                         dbo.tb_sucursal AS Sucu ON OC.IdEmpresa = Sucu.IdEmpresa AND OC.IdSucursal = Sucu.IdSucursal INNER JOIN
                         dbo.cp_proveedor AS Prove ON OC.IdEmpresa = Prove.IdEmpresa AND OC.IdProveedor = Prove.IdProveedor INNER JOIN
                         dbo.in_Producto AS Prod ON OC_det.IdEmpresa = Prod.IdEmpresa AND OC_det.IdProducto = Prod.IdProducto INNER JOIN
                         dbo.com_comprador ON OC.IdEmpresa = dbo.com_comprador.IdEmpresa AND OC.IdComprador = dbo.com_comprador.IdComprador ON 
                         dbo.com_catalogo.IdCatalogocompra = OC.IdEstadoAprobacion_cat LEFT OUTER JOIN
                         dbo.ct_punto_cargo_grupo ON OC_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo AND 
                         OC_det.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON OC_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND OC_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[76] 4[0] 2[5] 3) )"
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
         Begin Table = "com_catalogo"
            Begin Extent = 
               Top = 156
               Left = 0
               Bottom = 285
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC"
            Begin Extent = 
               Top = 37
               Left = 312
               Bottom = 367
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "OC_det"
            Begin Extent = 
               Top = 0
               Left = 738
               Bottom = 430
               Right = 1001
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Sucu"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prove"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prod"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_comprador"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 247
            End
            DisplayFlags = 280
     ', @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwCOMP_NATU_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       TopColumn = 0
         End
         Begin Table = "ct_punto_cargo_grupo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 261
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 34
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
         Width = 2085
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
', @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwCOMP_NATU_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwCOMP_NATU_Rpt001';

