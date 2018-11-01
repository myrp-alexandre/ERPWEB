CREATE VIEW [web].[VWFAC_006]
AS
SELECT        dbo.fa_proforma_det.IdEmpresa, dbo.fa_proforma_det.IdSucursal, dbo.fa_proforma_det.IdProforma, dbo.fa_proforma_det.Secuencia, dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_proforma.pf_plazo, 
                         dbo.fa_proforma.pf_codigo, dbo.fa_proforma.pf_fecha, dbo.fa_proforma.estado, dbo.fa_proforma.pf_atencion_a, dbo.fa_Vendedor.Codigo, dbo.fa_Vendedor.Ve_Vendedor, 
                         dbo.in_Producto.pr_descripcion + ' ' + dbo.in_presentacion.nom_presentacion AS pr_descripcion, dbo.fa_proforma_det.pd_cantidad, dbo.fa_proforma_det.pd_precio, dbo.fa_proforma_det.pd_por_descuento_uni, 
                         dbo.fa_proforma_det.pd_descuento_uni, dbo.fa_proforma_det.pd_precio_final, dbo.fa_proforma_det.pd_subtotal, dbo.fa_proforma_det.pd_por_iva, dbo.fa_proforma_det.pd_iva, dbo.fa_proforma_det.pd_subtotal +  dbo.fa_proforma_det.pd_iva AS pd_total, 
                         dbo.in_Marca.Descripcion AS nom_marca, dbo.in_presentacion.nom_presentacion AS nom_modelo, dbo.in_Producto.pr_observacion, dbo.fa_proforma_det.IdProducto, dbo.fa_proforma.pr_dias_entrega, 
                         dbo.fa_proforma.pf_observacion, IIF(dbo.in_Producto.se_distribuye != 1, dbo.in_Producto.lote_num_lote, NULL) lote_num_lote, IIF(dbo.in_Producto.se_distribuye != 1, dbo.in_Producto.lote_fecha_vcto, NULL) lote_fecha_vcto, 
                         in_Producto.IdProducto_padre
FROM            dbo.fa_proforma INNER JOIN
                         dbo.fa_proforma_det ON dbo.fa_proforma.IdEmpresa = dbo.fa_proforma_det.IdEmpresa AND dbo.fa_proforma.IdSucursal = dbo.fa_proforma_det.IdSucursal AND 
                         dbo.fa_proforma.IdProforma = dbo.fa_proforma_det.IdProforma INNER JOIN
                         dbo.in_Producto ON dbo.fa_proforma_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_proforma_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_proforma.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_proforma.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                         dbo.fa_TerminoPago ON dbo.fa_proforma.IdTerminoPago = dbo.fa_TerminoPago.IdTerminoPago INNER JOIN
                         dbo.in_presentacion ON dbo.in_Producto.IdEmpresa = dbo.in_presentacion.IdEmpresa AND dbo.in_Producto.IdPresentacion = dbo.in_presentacion.IdPresentacion INNER JOIN
                         dbo.in_Marca ON dbo.in_Producto.IdEmpresa = dbo.in_Marca.IdEmpresa AND dbo.in_Producto.IdMarca = dbo.in_Marca.IdMarca
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
         Begin Table = "fa_proforma"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "fa_proforma_det"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 343
               Left = 48
               Bottom = 506
               Right = 323
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 511
               Left = 48
               Bottom = 674
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_TerminoPago"
            Begin Extent = 
               Top = 679
               Left = 48
               Bottom = 842
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_presentacion"
            Begin Extent = 
               Top = 847
               Left = 48
               Bottom = 1010
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Marca"
            Begin Extent = 
               Top = 1015
               Left = 48
               Bottom = 1178
               Right = 256
           ', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWFAC_006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
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
', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWFAC_006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWFAC_006';

