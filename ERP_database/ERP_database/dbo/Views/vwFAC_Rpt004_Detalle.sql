CREATE VIEW [dbo].[vwFAC_Rpt004_Detalle] AS
SELECT        dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb.CodDocumentoTipo AS IdTipoDocumento, 
                         dbo.fa_notaCreDeb.IdCliente, dbo.fa_notaCreDeb.no_fecha, ROUND(SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.sc_total), 2) - (CASE WHEN AVG(notCxc.Valor_cobro) IS NULL 
                         THEN 0 ELSE AVG(notCxc.Valor_cobro) END) AS Saldo, (CASE WHEN AVG(notCxc.Valor_cobro) IS NULL THEN 0 ELSE AVG(notCxc.Valor_cobro) END) AS TotalCobrado, dbo.fa_notaCreDeb.NaturalezaNota, 
                        sum(dbo.fa_notaCreDeb_det.sc_subtotal) as sc_subtotal, sum(dbo.fa_notaCreDeb_det.sc_iva) as sc_iva
						, sum(dbo.fa_notaCreDeb_det.sc_total) as sc_total, dbo.fa_notaCreDeb_det.IdCod_Impuesto_Iva, dbo.fa_notaCreDeb.IdTipoNota
FROM            dbo.fa_notaCreDeb INNER JOIN
                         dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales ON dbo.fa_notaCreDeb.IdEmpresa = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdEmpresa AND 
                         dbo.fa_notaCreDeb.IdSucursal = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdBodega AND 
                         dbo.fa_notaCreDeb.IdNota = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdNota INNER JOIN
                         dbo.fa_notaCreDeb_det ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_notaCreDeb_det.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = dbo.fa_notaCreDeb_det.IdSucursal AND 
                         dbo.fa_notaCreDeb.IdBodega = dbo.fa_notaCreDeb_det.IdBodega AND dbo.fa_notaCreDeb.IdNota = dbo.fa_notaCreDeb_det.IdNota LEFT OUTER JOIN
                         dbo.fa_notaCreDeb_x_cxc_cobro AS notCxc ON notCxc.IdEmpresa_nt = dbo.fa_notaCreDeb.IdEmpresa AND notCxc.IdSucursal_nt = dbo.fa_notaCreDeb.IdSucursal AND 
                         notCxc.IdNota_nt = dbo.fa_notaCreDeb.IdNota AND notCxc.IdBodega_nt = dbo.fa_notaCreDeb.IdBodega
WHERE        (dbo.fa_notaCreDeb.Estado = 'A')
GROUP BY dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb.IdCliente, dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.NaturalezaNota, 
                         dbo.fa_notaCreDeb.CodDocumentoTipo,  dbo.fa_notaCreDeb_det.IdCod_Impuesto_Iva, 
                         dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdTipoNota,fa_notaCreDeb_det.Secuencia
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
         Begin Table = "fa_notaCreDeb"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 274
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "vwfa_notaCreDeb_det_subtotal_iva_0_totales"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_notaCreDeb_det"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "notCxc"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 263
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt004_Detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt004_Detalle';

