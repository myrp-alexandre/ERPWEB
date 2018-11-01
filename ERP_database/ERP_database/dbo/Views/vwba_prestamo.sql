
CREATE view vwba_prestamo as
SELECT        dbo.ba_prestamo.IdEmpresa, dbo.ba_prestamo.IdPrestamo, dbo.ba_prestamo.IdBanco, dbo.ba_prestamo.CodPrestamo, dbo.ba_prestamo.IdMotivo_Prestamo,
                         dbo.ba_prestamo.Estado, dbo.ba_prestamo.Fecha, dbo.ba_prestamo.MontoSol, dbo.ba_prestamo.TasaInteres, dbo.ba_prestamo.TotalPrestamo,
                         dbo.ba_prestamo.NumCuotas, dbo.ba_prestamo.Fecha_PriPago, dbo.ba_prestamo.Observacion, dbo.ba_prestamo.IdUsuario, dbo.ba_prestamo.Fecha_Transac,
                         dbo.ba_prestamo.IdUsuarioUltMod, dbo.ba_prestamo.Fecha_UltMod, dbo.ba_prestamo.IdUsuarioUltAnu, dbo.ba_prestamo.Fecha_UltAnu, dbo.ba_prestamo.nom_pc,
                         dbo.ba_prestamo.ip, dbo.ba_prestamo.MotiAnula, dbo.ba_Banco_Cuenta.ba_descripcion AS NomBanco, dbo.ba_Banco_Cuenta.ba_Tipo,
                         dbo.ba_Banco_Cuenta.ba_Num_Cuenta, '' ba_Moneda, '' ba_Ultimo_Cheque, dbo.ba_Banco_Cuenta.ba_num_digito_cheq,
                         dbo.ba_Banco_Cuenta.IdCtaCble, dbo.vwba_PeriocidadPago.IdPeriPago, dbo.vwba_PeriocidadPago.IdTipoCatalogo, dbo.vwba_PeriocidadPago.ca_descripcion,
                         dbo.vwba_PeriocidadPago.ca_estado, dbo.ba_prestamo.IdMetCalc, dbo.vwba_MetodoCalculo.ca_descripcion AS MetodoCalculo,
                         dbo.vwba_MotivoPrestamo.IdMotivoPrestamo, dbo.vwba_MotivoPrestamo.ca_descripcion AS NomMotivo_Prestamo, dbo.ba_prestamo.IdTipoFlujo,
                         dbo.ba_TipoFlujo.Descricion AS nom_tipoFlujo, dbo.ba_prestamo.IdCtaCble AS IdCtaCble_Prestamo, dbo.ct_plancta.pc_Cuenta AS nom_CtaCble_Prestamo,
                         dbo.ba_prestamo.Pago_contado,dbo.ba_prestamo.IdCliente
FROM            dbo.ba_prestamo INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_prestamo.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND
                         dbo.ba_prestamo.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.vwba_PeriocidadPago ON dbo.ba_prestamo.IdTipo_Pago = dbo.vwba_PeriocidadPago.IdPeriPago INNER JOIN
                         dbo.vwba_MetodoCalculo ON dbo.ba_prestamo.IdMetCalc = dbo.vwba_MetodoCalculo.IdMetCalc INNER JOIN
                         dbo.vwba_MotivoPrestamo ON dbo.ba_prestamo.IdMotivo_Prestamo = dbo.vwba_MotivoPrestamo.IdMotivoPrestamo LEFT OUTER JOIN
                         dbo.ct_plancta ON dbo.ba_prestamo.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ba_prestamo.IdCtaCble = dbo.ct_plancta.IdCtaCble LEFT OUTER JOIN
                         dbo.ba_TipoFlujo ON dbo.ba_prestamo.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND dbo.ba_prestamo.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo
GROUP BY dbo.ba_prestamo.IdEmpresa, dbo.ba_prestamo.IdPrestamo, dbo.ba_prestamo.IdBanco, dbo.ba_prestamo.CodPrestamo, dbo.ba_prestamo.IdMotivo_Prestamo,
                         dbo.ba_prestamo.Estado, dbo.ba_prestamo.Fecha, dbo.ba_prestamo.MontoSol, dbo.ba_prestamo.TasaInteres, dbo.ba_prestamo.TotalPrestamo,
                         dbo.ba_prestamo.NumCuotas, dbo.ba_prestamo.Fecha_PriPago, dbo.ba_prestamo.Observacion, dbo.ba_prestamo.IdUsuario, dbo.ba_prestamo.Fecha_Transac,
                         dbo.ba_prestamo.IdUsuarioUltMod, dbo.ba_prestamo.Fecha_UltMod, dbo.ba_prestamo.IdUsuarioUltAnu, dbo.ba_prestamo.Fecha_UltAnu, dbo.ba_prestamo.nom_pc,
                         dbo.ba_prestamo.ip, dbo.ba_prestamo.MotiAnula, dbo.ba_Banco_Cuenta.ba_descripcion, dbo.ba_Banco_Cuenta.ba_Tipo, dbo.ba_Banco_Cuenta.ba_Num_Cuenta,
                         dbo.ba_Banco_Cuenta.ba_num_digito_cheq, dbo.ba_Banco_Cuenta.IdCtaCble,
                         dbo.vwba_PeriocidadPago.IdPeriPago, dbo.vwba_PeriocidadPago.IdTipoCatalogo, dbo.vwba_PeriocidadPago.ca_descripcion, dbo.vwba_PeriocidadPago.ca_estado,
                         dbo.ba_prestamo.IdMetCalc, dbo.vwba_MetodoCalculo.ca_descripcion, dbo.vwba_MotivoPrestamo.IdMotivoPrestamo, dbo.vwba_MotivoPrestamo.ca_descripcion,
                         dbo.ba_prestamo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion, dbo.ba_prestamo.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ba_prestamo.Pago_contado,dbo.ba_prestamo.IdCliente
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[68] 2[4] 3) )"
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
         Begin Table = "ba_prestamo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 383
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 0
               Left = 508
               Bottom = 119
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "vwba_PeriocidadPago"
            Begin Extent = 
               Top = 358
               Left = 358
               Bottom = 477
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwba_MetodoCalculo"
            Begin Extent = 
               Top = 112
               Left = 339
               Bottom = 231
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwba_MotivoPrestamo"
            Begin Extent = 
               Top = 234
               Left = 372
               Bottom = 353
               Right = 548
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ba_TipoFlujo"
            Begin Extent = 
               Top = 79
               Left = 698
               Bottom = 208
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 210
               Left = 690
               Bottom = 409
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_prestamo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 915
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
      Begin ColumnWidths = 47
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
         Column = 3420
         Alias = 2235
         Table = 3060
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_prestamo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_prestamo';

