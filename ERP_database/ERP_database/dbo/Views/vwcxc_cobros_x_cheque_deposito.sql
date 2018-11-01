
/*select * from vwcxc_cobros_x_cheque_deposito*/
CREATE VIEW [dbo].[vwcxc_cobros_x_cheque_deposito]
AS
SELECT     cbr.IdEmpresa, cbr.IdSucursal, sucu.Su_Descripcion AS Sucursal, cbr.IdCobro, cbr.IdCliente, cbr.IdCobro_tipo, cbrt.tc_descripcion AS TipoCobro, 
                      estacb.IdEstadoCobro, cbr.cr_fecha AS Fecha, cbr.cr_fechaCobro AS FechaCobro, cbr.cr_Banco AS Banco_del_cheq, cbr.cr_cuenta AS Cuenta, 
                      cbr.cr_NumDocumento AS Num_Cheq, cbr.cr_TotalCobro AS TotalCobro, cbrcaj.mcj_IdCbteCble, cbrcaj.mcj_IdTipocbte, caj.IdCaja, caj.ca_Codigo AS CodCaja, 
                      cbteba.IdCbteCble AS ba_IdCbteCble, cbteba.IdTipocbte AS ba_IdTipocbte, cbteba.cb_Fecha AS Fecha_dep, ban.IdBanco AS IdBanco_dep, 
                      ban.ba_descripcion AS Banco_deposito, pers.pe_apellido + ' ' + pers.pe_nombre + '/' + pers.pe_razonSocial AS Cliente, '' AS Referencia
FROM         dbo.ba_Cbte_Ban AS cbteba INNER JOIN
                      dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito AS bancam ON cbteba.IdEmpresa = bancam.mba_IdEmpresa AND 
                      cbteba.IdCbteCble = bancam.mba_IdCbteCble AND cbteba.IdTipocbte = bancam.mba_IdTipocbte INNER JOIN
                      dbo.ba_Banco_Cuenta AS ban ON cbteba.IdEmpresa = ban.IdEmpresa AND cbteba.IdBanco = ban.IdBanco RIGHT OUTER JOIN
                      dbo.caj_Caja_Movimiento AS cajm INNER JOIN
                      dbo.cxc_cobro_x_caj_Caja_Movimiento AS cbrcaj ON cajm.IdEmpresa = cbrcaj.mcj_IdEmpresa AND cajm.IdCbteCble = cbrcaj.mcj_IdCbteCble AND 
                      cajm.IdTipocbte = cbrcaj.mcj_IdTipocbte INNER JOIN
                      dbo.caj_Caja AS caj ON cajm.IdEmpresa = caj.IdEmpresa AND cajm.IdCaja = caj.IdCaja ON bancam.mcj_IdEmpresa = cajm.IdEmpresa AND 
                      bancam.mcj_IdCbteCble = cajm.IdCbteCble AND bancam.mcj_IdTipocbte = cajm.IdTipocbte RIGHT OUTER JOIN
                      dbo.cxc_cobro AS cbr INNER JOIN
                      dbo.cxc_cobro_tipo AS cbrt ON cbr.IdCobro_tipo = cbrt.IdCobro_tipo INNER JOIN
                      dbo.tb_sucursal AS sucu ON cbr.IdEmpresa = sucu.IdEmpresa AND cbr.IdSucursal = sucu.IdSucursal INNER JOIN
                      dbo.fa_cliente AS cli ON cbr.IdEmpresa = cli.IdEmpresa AND cbr.IdCliente = cli.IdCliente INNER JOIN
                      dbo.tb_persona AS pers ON cli.IdPersona = pers.IdPersona INNER JOIN
                      dbo.vwcxc_EstadoCobro_Actual AS estacb ON cbr.IdEmpresa = estacb.IdEmpresa AND cbr.IdSucursal = estacb.IdSucursal AND cbr.IdCobro = estacb.IdCobro ON 
                      cbrcaj.cbr_IdEmpresa = cbr.IdEmpresa AND cbrcaj.cbr_IdSucursal = cbr.IdSucursal AND cbrcaj.cbr_IdCobro = cbr.IdCobro
WHERE     (cbrt.tc_EsCheque = 'S')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[4] 2[72] 3) )"
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
         Begin Table = "cbteba"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bancam"
            Begin Extent = 
               Top = 6
               Left = 271
               Bottom = 125
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ban"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cajm"
            Begin Extent = 
               Top = 126
               Left = 264
               Bottom = 245
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbrcaj"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj"
            Begin Extent = 
               Top = 246
               Left = 241
               Bottom = 365
               Right = 443
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cbr"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 217
            End
            DisplayFlags = 280
            TopColum', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_x_cheque_deposito';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n = 0
         End
         Begin Table = "cbrt"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 605
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sucu"
            Begin Extent = 
               Top = 366
               Left = 255
               Bottom = 485
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cli"
            Begin Extent = 
               Top = 606
               Left = 38
               Bottom = 725
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pers"
            Begin Extent = 
               Top = 726
               Left = 38
               Bottom = 845
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "estacb"
            Begin Extent = 
               Top = 486
               Left = 313
               Bottom = 605
               Right = 474
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_x_cheque_deposito';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_x_cheque_deposito';

