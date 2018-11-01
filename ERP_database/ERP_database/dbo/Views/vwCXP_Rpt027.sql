CREATE VIEW [dbo].[vwCXP_Rpt027]
AS
SELECT        dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdConciliacion_Caja, 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.Secuencia, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja, 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja, dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja, 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCtaCble, dbo.caj_Caja_Movimiento.cm_valor, per.pe_nombreCompleto cm_beneficiario, 
                         dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi, dbo.caj_Caja_Movimiento_Tipo.tm_descripcion, dbo.caj_Caja_Movimiento.cm_observacion, 
                         dbo.ct_plancta.pc_Cuenta
FROM            dbo.cp_conciliacion_Caja_det_x_ValeCaja INNER JOIN
                         dbo.caj_Caja_Movimiento ON dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa_movcaja = dbo.caj_Caja_Movimiento.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCbteCble_movcaja = dbo.caj_Caja_Movimiento.IdCbteCble AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdTipocbte_movcaja = dbo.caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento.IdTipoMovi = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi INNER JOIN
                         dbo.ct_plancta ON dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdEmpresa = dbo.ct_plancta.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja_det_x_ValeCaja.IdCtaCble = dbo.ct_plancta.IdCtaCble inner join tb_persona as per
						 on caj_Caja_Movimiento.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[5] 2[7] 3) )"
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
         Begin Table = "cp_conciliacion_Caja_det_x_ValeCaja"
            Begin Extent = 
               Top = 14
               Left = 383
               Bottom = 275
               Right = 592
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento"
            Begin Extent = 
               Top = 7
               Left = 0
               Bottom = 165
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento_Tipo"
            Begin Extent = 
               Top = 151
               Left = 100
               Bottom = 280
               Right = 366
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 2
               Left = 735
               Bottom = 273
               Right = 944
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
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2100
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
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt027';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Append = 1400
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt027';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt027';

