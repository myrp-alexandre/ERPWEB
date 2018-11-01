/*select * from ba_prestamo_detalle_cancelacion */
CREATE VIEW dbo.vwba_prestamo_detalle_cancelacion
AS
SELECT        c.IdEmpresa, c.IdPrestamo, c.IdMotivo_Prestamo, c.IdMetCalc, d.NumCuota, d.EstadoPago, pag.ca_descripcion AS NomEstadoPago, 
                         ISNULL(SUM(canc.Monto_Canc), 0) AS Monto_Canc, d.TotalCuota - ISNULL(SUM(canc.Monto_Canc), 0) AS Saldo_Canc, d.TotalCuota, d.FechaPago, 
                         canc.Observacion_canc, c.IdBanco, c.NomBanco, c.IdCtaCble_Prestamo, c.IdCtaCble AS IdCtaCble_Banco, d.Interes, d.SaldoInicial, d.AbonoCapital, d.Saldo
FROM            dbo.vwba_prestamo AS c INNER JOIN
                         dbo.ba_prestamo_detalle AS d ON c.IdEmpresa = d.IdEmpresa AND c.IdPrestamo = d.IdPrestamo LEFT OUTER JOIN
                         dbo.ba_prestamo_detalle_cancelacion AS canc ON d.NumCuota = canc.NumCuota AND canc.IdPrestamo = c.IdPrestamo AND canc.IdEmpresa = c.IdEmpresa AND 
                         canc.NumCuota = d.NumCuota INNER JOIN
                         dbo.vwba_EstadoPago AS pag ON pag.IdEstadoPago = d.EstadoPago
WHERE        (d.EstadoPago = 'PEN')
GROUP BY c.IdEmpresa, c.IdPrestamo, c.IdMotivo_Prestamo, c.IdMetCalc, d.NumCuota, d.TotalCuota, pag.ca_descripcion, d.EstadoPago, d.FechaPago, canc.Observacion_canc, 
                         c.IdBanco, c.NomBanco, c.IdCtaCble_Prestamo, c.IdCtaCble, d.Interes, d.SaldoInicial, d.AbonoCapital, d.Saldo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[4] 2[20] 3) )"
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
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 451
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 0
               Left = 332
               Bottom = 368
               Right = 511
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "canc"
            Begin Extent = 
               Top = 112
               Left = 639
               Bottom = 231
               Right = 823
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "pag"
            Begin Extent = 
               Top = 207
               Left = 851
               Bottom = 326
               Right = 1029
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
      Begin ColumnWidths = 21
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1890
         Ta', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_prestamo_detalle_cancelacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ble = 1170
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_prestamo_detalle_cancelacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_prestamo_detalle_cancelacion';

