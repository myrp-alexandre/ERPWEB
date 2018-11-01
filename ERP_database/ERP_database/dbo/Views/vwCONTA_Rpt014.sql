CREATE VIEW dbo.vwCONTA_Rpt014
AS
SELECT        dbo.ct_cbtecble_det.IdEmpresa, dbo.ct_cbtecble_det.IdTipoCbte, dbo.ct_cbtecble_det.IdCbteCble, dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble.cb_Observacion, 
                         dbo.ct_cbtecble.cb_Fecha, dbo.ct_cbtecble_tipo.tc_TipoCbte, dbo.ct_plancta.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble_det.IdCentroCosto, 
                         ISNULL(dbo.ct_centro_costo.Centro_costo, 'Sin centro de costo') AS Centro_costo, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_plancta.IdGrupoCble, 
                         dbo.ct_grupocble.gc_GrupoCble, dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo, ISNULL(dbo.ct_centro_costo_sub_centro_costo.Centro_costo, 
                         'Sin subcentro de costo') AS nom_subcentro, dbo.ct_cbtecble_det.IdPunto_cargo_grupo, ISNULL(dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo, 'Sin grupo') 
                         AS nom_punto_cargo_grupo, dbo.ct_cbtecble_det.IdPunto_cargo, ISNULL(dbo.ct_punto_cargo.nom_punto_cargo, 'Sin punto de cargo') AS nom_punto_cargo, 
                         dbo.ct_grupocble.gc_Orden
FROM            dbo.ct_cbtecble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble INNER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.ct_grupocble ON dbo.ct_plancta.IdGrupoCble = dbo.ct_grupocble.IdGrupoCble LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.ct_punto_cargo_grupo ON dbo.ct_cbtecble_det.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo AND 
                         dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto
WHERE        (NOT EXISTS
                             (SELECT        IdEmpresa, IdTipoCbte, IdCbteCble, IdEmpresa_Anu, IdTipoCbte_Anu, IdCbteCble_Anu, ip
                               FROM            dbo.ct_cbtecble_Reversado AS REVERSO
                               WHERE        (dbo.ct_cbtecble.IdEmpresa = IdEmpresa) AND (dbo.ct_cbtecble.IdTipoCbte = IdTipoCbte) AND (dbo.ct_cbtecble.IdCbteCble = IdCbteCble))) AND 
                         (NOT EXISTS
                             (SELECT        IdEmpresa, IdTipoCbte, IdCbteCble, IdEmpresa_Anu, IdTipoCbte_Anu, IdCbteCble_Anu, ip
                               FROM            dbo.ct_cbtecble_Reversado AS REVERSO
                               WHERE        (dbo.ct_cbtecble.IdEmpresa = IdEmpresa_Anu) AND (dbo.ct_cbtecble.IdTipoCbte = IdTipoCbte_Anu) AND 
                                                         (dbo.ct_cbtecble.IdCbteCble = IdCbteCble_Anu)))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[4] 2[4] 3) )"
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
         Top = -480
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ct_cbtecble"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_grupocble"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo_grupo"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 261
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCONTA_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 247
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
      Begin ColumnWidths = 9
         Width = 284
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCONTA_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCONTA_Rpt014';

