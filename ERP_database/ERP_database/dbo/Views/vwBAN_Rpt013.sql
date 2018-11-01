CREATE VIEW dbo.vwBAN_Rpt013
AS
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.tb_empresa.em_nombre AS nom_empresa, dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.ba_Cbte_Ban.IdCbteCble, 
                         dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_banco, dbo.ba_Banco_Cuenta.ba_Num_Cuenta, 
                         dbo.ba_Banco_Cuenta.IdCtaCble AS IdCtaCble_ban, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.IdPeriodo, dbo.ba_Cbte_Ban.cb_Observacion, 
                         dbo.ba_Cbte_Ban.cb_Valor, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.ValorEnLetras, dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta AS nom_cuenta, dbo.ct_cbtecble_det.dc_Observacion, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN dbo.ct_cbtecble_det.dc_Valor ELSE 0 END AS debito, 
                         CASE WHEN dbo.ct_cbtecble_det.dc_Valor < 0 THEN dbo.ct_cbtecble_det.dc_Valor * - 1 ELSE 0 END AS credito, dbo.ct_punto_cargo.nom_punto_cargo, 
                         dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, dbo.ct_plancta.pc_clave_corta AS clave_cta
FROM            dbo.ct_punto_cargo_grupo INNER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_punto_cargo_grupo.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo = dbo.ct_punto_cargo.IdPunto_cargo_grupo RIGHT OUTER JOIN
                         dbo.ba_Cbte_Ban INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ba_Cbte_Ban.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = dbo.ct_cbtecble_det.IdTipoCbte INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa AND 
                         dbo.ba_Cbte_Ban.IdBanco = dbo.ba_Banco_Cuenta.IdBanco INNER JOIN
                         dbo.tb_empresa ON dbo.ba_Cbte_Ban.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble ON 
                         dbo.ct_punto_cargo.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_punto_cargo.IdPunto_cargo = dbo.ct_cbtecble_det.IdPunto_cargo AND 
                         dbo.ct_punto_cargo.IdPunto_cargo_grupo = dbo.ct_cbtecble_det.IdPunto_cargo_grupo
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
         Configuration = "(H (1[15] 4[60] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[91] 3) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ct_punto_cargo_grupo"
            Begin Extent = 
               Top = 312
               Left = 146
               Bottom = 441
               Right = 369
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 276
               Left = 552
               Bottom = 453
               Right = 761
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ba_Cbte_Ban"
            Begin Extent = 
               Top = 0
               Left = 518
               Bottom = 240
               Right = 728
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 0
               Left = 923
               Bottom = 287
               Right = 1186
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 140
               Left = 0
               Bottom = 269
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 106
               Left = 265
               Bottom = 279
               Right = 474
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt013';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 22
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt013';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt013';

