CREATE VIEW Fj_servindustrias.vwfa_pre_facturacion
AS
SELECT        Fj_servindustrias.fa_pre_facturacion.IdEmpresa, Fj_servindustrias.fa_pre_facturacion.IdPreFacturacion, Fj_servindustrias.fa_pre_facturacion.IdPeriodo, Fj_servindustrias.fa_pre_facturacion.Observacion, 
                         Fj_servindustrias.fa_pre_facturacion.fecha, Fj_servindustrias.fa_pre_facturacion.estado, dbo.ct_periodo.pe_mes, dbo.ct_periodo.pe_FechaIni, dbo.ct_periodo.pe_FechaFin, Fj_servindustrias.fa_pre_facturacion.IdCentroCosto, 
                         dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, Fj_servindustrias.fa_pre_facturacion.estado_cierre, Fj_servindustrias.fa_pre_facturacion.TotalEquipos, Fj_servindustrias.fa_pre_facturacion.ValorFacturar
FROM            Fj_servindustrias.fa_pre_facturacion INNER JOIN
                         dbo.ct_periodo ON Fj_servindustrias.fa_pre_facturacion.IdEmpresa = dbo.ct_periodo.IdEmpresa AND Fj_servindustrias.fa_pre_facturacion.IdPeriodo = dbo.ct_periodo.IdPeriodo INNER JOIN
                         dbo.ct_centro_costo ON Fj_servindustrias.fa_pre_facturacion.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND Fj_servindustrias.fa_pre_facturacion.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto
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
         Begin Table = "fa_pre_facturacion (Fj_servindustrias)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "ct_periodo"
            Begin Extent = 
               Top = 6
               Left = 254
               Bottom = 136
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 234
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_pre_facturacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_pre_facturacion';

