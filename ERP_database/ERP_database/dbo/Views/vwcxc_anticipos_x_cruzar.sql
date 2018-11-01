CREATE VIEW [dbo].[vwcxc_anticipos_x_cruzar]
AS
SELECT        cbr_ant_det.IdEmpresa_Cobro, cbr_ant_det.IdSucursal_cobro, cbr_ant_det.IdCobro_cobro, cbr_ant.IdEmpresa, cbr_ant.IdAnticipo, cbr_ant.IdSucursal, 
                         cbr_ant.IdCliente, cbr_ant.Fecha, cbr_ant.Observacion, pe.pe_apellido, pe.pe_nombre, cbr_ant_det.IdCobro_tipo, cbr.cr_Banco, cbr.cr_NumDocumento, cbr.IdCaja, 
                         cbr.cr_TotalCobro, cbr.cr_TotalCobro - ISNULL(cbr_total_res.Total_Pagado, 0) AS Saldo_Pendiente, cli.IdCtaCble_cxc, cli.IdCtaCble_Anti
FROM            dbo.cxc_cobro_x_Anticipo AS cbr_ant INNER JOIN
                         dbo.cxc_cobro_x_Anticipo_det AS cbr_ant_det ON cbr_ant.IdEmpresa = cbr_ant_det.IdEmpresa AND cbr_ant.IdAnticipo = cbr_ant_det.IdAnticipo INNER JOIN
                         dbo.fa_cliente AS cli ON cbr_ant.IdEmpresa = cli.IdEmpresa AND cbr_ant.IdCliente = cli.IdCliente INNER JOIN
                         dbo.tb_persona AS pe ON cli.IdPersona = pe.IdPersona INNER JOIN
                         dbo.cxc_cobro AS cbr ON cbr_ant_det.IdEmpresa_Cobro = cbr.IdEmpresa AND cbr_ant_det.IdSucursal_cobro = cbr.IdSucursal AND 
                         cbr_ant_det.IdCobro_cobro = cbr.IdCobro LEFT OUTER JOIN
                         dbo.vwcxc_cobro_x_anticipo_total_respaldado AS cbr_total_res ON cbr.IdEmpresa = cbr_total_res.IdEmpresa_cbr AND 
                         cbr.IdSucursal = cbr_total_res.IdSucursal_cbr AND cbr.IdCobro = cbr_total_res.IdCobro_cbr
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[8] 3) )"
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
         Top = -128
         Left = 0
      End
      Begin Tables = 
         Begin Table = "cbr_ant"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 208
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "cbr_ant_det"
            Begin Extent = 
               Top = 4
               Left = 305
               Bottom = 174
               Right = 514
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "cli"
            Begin Extent = 
               Top = 122
               Left = 142
               Bottom = 325
               Right = 361
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "pe"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr"
            Begin Extent = 
               Top = 428
               Left = 393
               Bottom = 588
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 27
         End
         Begin Table = "cbr_total_res"
            Begin Extent = 
               Top = 415
               Left = 647
               Bottom = 544
               Right = 856
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
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_anticipos_x_cruzar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_anticipos_x_cruzar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_anticipos_x_cruzar';

