

CREATE VIEW [dbo].[vwcxc_cancelacion_Intercompany_x_cxc_cobro_det]
AS
SELECT     can_int_det.IdEmpresa, can_int_det.IdCancelacion, can_int_det.Secuencia, cbr.IdCobro, cbr.cr_fecha, cbr.cr_fechaDocu, cbr.cr_fechaCobro, cbr.cr_observacion, 
                      cbr.cr_Banco, cbr.cr_cuenta, cbr.cr_NumDocumento, cbr.cr_Tarjeta, cbr.IdCliente, 
                      '[' + cli.Codigo + '] ' + pers.pe_nombreCompleto + ' ' + pers.pe_razonSocial AS NomCliente, can_int_det.Valor_Aplicado, fac_deb.Referencia, cbr.IdCobro_tipo
FROM         dbo.cxc_cancelacion_Intercompany_det AS can_int_det INNER JOIN
                      dbo.cxc_cobro AS cbr ON can_int_det.cbr_IdEmpresa = cbr.IdEmpresa AND can_int_det.cbr_IdSucursal = cbr.IdSucursal AND 
                      can_int_det.cbr_IdCobro = cbr.IdCobro INNER JOIN
                      dbo.cxc_cobro_det AS cbr_det ON cbr.IdEmpresa = cbr_det.IdEmpresa AND cbr.IdSucursal = cbr_det.IdSucursal AND cbr.IdCobro = cbr_det.IdCobro INNER JOIN
                      dbo.fa_cliente AS cli ON cbr.IdEmpresa = cli.IdEmpresa AND cbr.IdCliente = cli.IdCliente INNER JOIN
                      dbo.tb_persona AS pers ON cli.IdPersona = pers.IdPersona INNER JOIN
                      dbo.vwFa_Facturas_y_NotasDebito AS fac_deb ON cbr_det.IdEmpresa = fac_deb.IdEmpresa AND cbr_det.IdSucursal = fac_deb.IdSucursal AND 
                      cbr_det.IdBodega_Cbte = fac_deb.IdBodega AND cbr_det.dc_TipoDocumento = fac_deb.Tipo AND cbr_det.IdCbte_vta_nota = fac_deb.IdCbte
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[4] 2[12] 3) )"
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
         Begin Table = "can_int_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr"
            Begin Extent = 
               Top = 10
               Left = 277
               Bottom = 214
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr_det"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cli"
            Begin Extent = 
               Top = 91
               Left = 480
               Bottom = 210
               Right = 690
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pers"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fac_deb"
            Begin Extent = 
               Top = 251
               Left = 477
               Bottom = 370
               Right = 655
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
      Begin ColumnWidths = 18
         Width = 284
         Width = 1500
         Width = 1500
         Widt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cancelacion_Intercompany_x_cxc_cobro_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'h = 1500
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
         Column = 1710
         Alias = 2325
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cancelacion_Intercompany_x_cxc_cobro_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cancelacion_Intercompany_x_cxc_cobro_det';

