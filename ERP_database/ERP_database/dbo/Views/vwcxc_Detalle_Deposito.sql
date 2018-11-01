

CREATE VIEW [dbo].[vwcxc_Detalle_Deposito]
AS
SELECT     TOP (200) dbo.ba_Cbte_Ban.cb_Observacion, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.cb_Valor, dbo.ba_Cbte_Ban.cb_Fecha, 
                      dbo.ba_Banco_Cuenta.ba_descripcion, dbo.ba_Banco_Cuenta.ba_Num_Cuenta, dbo.ba_Banco_Cuenta.IdCtaCble, dbo.vwcxc_cobro.IdPersona, 
                      dbo.vwcxc_cobro.IdEmpresa, dbo.vwcxc_cobro.IdSucursal, dbo.vwcxc_cobro.IdCobro, dbo.vwcxc_cobro.IdCobro_tipo, dbo.vwcxc_cobro.IdCliente, 
                      dbo.vwcxc_cobro.cr_TotalCobro, dbo.vwcxc_cobro.cr_fecha, dbo.vwcxc_cobro.cr_fechaCobro, dbo.vwcxc_cobro.cr_fechaDocu, dbo.vwcxc_cobro.cr_observacion, 
                      dbo.vwcxc_cobro.cr_Banco, dbo.vwcxc_cobro.cr_cuenta, dbo.vwcxc_cobro.cr_Tarjeta, dbo.vwcxc_cobro.cr_NumDocumento, dbo.vwcxc_cobro.cr_estado, 
                      dbo.vwcxc_cobro.cr_recibo, dbo.vwcxc_cobro.Fecha_Transac, dbo.vwcxc_cobro.IdUsuario, dbo.vwcxc_cobro.IdUsuarioUltMod, dbo.vwcxc_cobro.Fecha_UltMod, 
                      dbo.vwcxc_cobro.IdUsuarioUltAnu, dbo.vwcxc_cobro.Fecha_UltAnu, dbo.vwcxc_cobro.nom_pc, dbo.vwcxc_cobro.ip, dbo.vwcxc_cobro.nSucursal, 
                      dbo.vwcxc_cobro.nCliente, dbo.vwcxc_cobro.cr_NumCheque, dbo.vwcxc_cobro.IdVendedorCliente
FROM         dbo.cxc_cobro_x_caj_Caja_Movimiento INNER JOIN
                      dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito ON 
                      dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdEmpresa = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdEmpresa AND 
                      dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdCbteCble = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdCbteCble AND 
                      dbo.cxc_cobro_x_caj_Caja_Movimiento.mcj_IdTipocbte = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdTipocbte INNER JOIN
                      dbo.ba_Cbte_Ban ON dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND 
                      dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdCbteCble = dbo.ba_Cbte_Ban.IdCbteCble AND 
                      dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdTipocbte = dbo.ba_Cbte_Ban.IdTipocbte INNER JOIN
                      dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                      dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                      dbo.vwcxc_cobro ON dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdEmpresa = dbo.vwcxc_cobro.IdEmpresa AND 
                      dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdSucursal = dbo.vwcxc_cobro.IdSucursal AND 
                      dbo.cxc_cobro_x_caj_Caja_Movimiento.cbr_IdCobro = dbo.vwcxc_cobro.IdCobro
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
         Configuration = "(H (1[50] 4[25] 3) )"
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
         Begin Table = "cxc_cobro_x_caj_Caja_Movimiento"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 125
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito"
            Begin Extent = 
               Top = 6
               Left = 458
               Bottom = 125
               Right = 627
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Cbte_Ban"
            Begin Extent = 
               Top = 6
               Left = 665
               Bottom = 125
               Right = 860
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 167
               Left = 318
               Bottom = 286
               Right = 506
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcxc_cobro"
            Begin Extent = 
               Top = 29
               Left = 0
               Bottom = 148
               Right = 179
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
      Begin ColumnWidths = 10
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
      End
   End
   Begin CriteriaP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_Detalle_Deposito';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ane = 
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_Detalle_Deposito';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_Detalle_Deposito';

