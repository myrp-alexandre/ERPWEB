CREATE VIEW dbo.vwfa_notaCreDeb_det_sri
AS
SELECT        dbo.fa_notaCreDeb_det.IdEmpresa, dbo.fa_notaCreDeb_det.IdSucursal, dbo.fa_notaCreDeb_det.IdBodega, dbo.fa_notaCreDeb_det.IdNota, 
                         dbo.fa_notaCreDeb_det.Secuencia, dbo.fa_notaCreDeb_det.IdProducto, dbo.fa_notaCreDeb_det.sc_cantidad, dbo.fa_notaCreDeb_det.sc_Precio, 
                         dbo.fa_notaCreDeb_det.sc_descUni, dbo.fa_notaCreDeb_det.sc_PordescUni, dbo.fa_notaCreDeb_det.sc_precioFinal, dbo.fa_notaCreDeb_det.sc_subtotal, 
                         dbo.fa_notaCreDeb_det.sc_iva, dbo.fa_notaCreDeb_det.sc_total, dbo.fa_notaCreDeb_det.sc_estado, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, 
                         dbo.fa_notaCreDeb_det.vt_por_iva, dbo.fa_notaCreDeb_det.IdCod_Impuesto_Iva, dbo.fa_notaCreDeb_det.IdCod_Impuesto_Ice, 
                         dbo.fa_notaCreDeb_det.sc_observacion, dbo.fa_notaCreDeb_det.IdCentroCosto, dbo.fa_notaCreDeb_det.IdCentroCosto_sub_centro_costo
FROM            dbo.fa_notaCreDeb_det INNER JOIN
                         dbo.in_Producto ON dbo.fa_notaCreDeb_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_notaCreDeb_det.IdProducto = dbo.in_Producto.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[2] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
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
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "fa_notaCreDeb_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 451
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 0
               Left = 470
               Bottom = 253
               Right = 699
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
      Begin ColumnWidths = 19
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
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_notaCreDeb_det_sri';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_notaCreDeb_det_sri';

