CREATE VIEW Naturisa.vwCONTA_NATU_Rpt002
AS
SELECT        (CASE WHEN b.dc_Valor >= 0 THEN b.dc_Valor ELSE 0 END) AS debe, (CASE WHEN b.dc_Valor <= 0 THEN b.dc_Valor * - 1 ELSE 0 END) AS Cred, a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.CodCbteCble, 
                         a.IdPeriodo, a.cb_Fecha, a.cb_Valor, a.cb_Observacion, a.cb_Estado, a.cb_Anio, a.cb_mes, b.secuencia, b.IdCtaCble, b.dc_Valor, b.dc_Observacion, c.pc_Cuenta, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, dbo.ct_punto_cargo.nom_punto_cargo, c.pc_clave_corta
FROM            dbo.ct_punto_cargo INNER JOIN
                         dbo.ct_punto_cargo_grupo ON dbo.ct_punto_cargo.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa AND 
                         dbo.ct_punto_cargo.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo RIGHT OUTER JOIN
                         dbo.ct_cbtecble AS a INNER JOIN
                         dbo.ct_cbtecble_det AS b ON a.IdEmpresa = b.IdEmpresa AND a.IdTipoCbte = b.IdTipoCbte AND a.IdCbteCble = b.IdCbteCble INNER JOIN
                         dbo.ct_plancta AS c ON b.IdCtaCble = c.IdCtaCble AND b.IdEmpresa = c.IdEmpresa INNER JOIN
                         dbo.ct_cbtecble_tipo ON a.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte AND a.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa ON dbo.ct_punto_cargo.IdPunto_cargo_grupo = b.IdPunto_cargo_grupo AND 
                         dbo.ct_punto_cargo.IdEmpresa = b.IdEmpresa AND dbo.ct_punto_cargo.IdPunto_cargo = b.IdPunto_cargo
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
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo_grupo"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 136
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 546
               Bottom = 136
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 793
               Bottom = 136
               Right = 1002
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 138
               Left = 339
               Bottom = 268
               Right = 548
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
      ', @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwCONTA_NATU_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Alias = 900
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
', @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwCONTA_NATU_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Naturisa', @level1type = N'VIEW', @level1name = N'vwCONTA_NATU_Rpt002';

