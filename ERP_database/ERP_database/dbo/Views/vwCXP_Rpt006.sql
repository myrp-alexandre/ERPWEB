CREATE view [dbo].[vwCXP_Rpt006]
as 
SELECT        dbo.cp_nota_DebCre.IdEmpresa, dbo.cp_nota_DebCre.IdCbteCble_Nota, dbo.cp_nota_DebCre.IdTipoCbte_Nota, dbo.cp_nota_DebCre.DebCre, 
                         dbo.cp_nota_DebCre.IdTipoNota, dbo.ct_cbtecble.cb_Fecha AS Fecha, dbo.cp_nota_DebCre.cn_observacion AS Detalle, dbo.cp_nota_DebCre.cn_total, 
                         dbo.cp_nota_DebCre.cn_Nota, dbo.ct_cbtecble_det.IdCtaCble, dbo.ct_plancta.pc_Cuenta AS nom_Cuenta, dbo.ct_plancta.pc_clave_corta AS clave, 
                         dbo.ct_cbtecble_det.secuencia, dbo.ct_cbtecble_det.dc_Valor, CASE WHEN dbo.ct_cbtecble_det.dc_Valor > 0 THEN ISNULL(dbo.ct_cbtecble_det.dc_Valor, 0) 
                         ELSE 0 END AS valor_debe, CASE WHEN dbo.ct_cbtecble_det.dc_Valor < 0 THEN ISNULL(dbo.ct_cbtecble_det.dc_Valor * - 1, 0) ELSE 0 END AS valor_haber, 
                         dbo.ct_cbtecble_det.dc_Observacion, dbo.cp_nota_DebCre.IdProveedor, pe_nombreCompleto AS nom_Proveedor, dbo.cp_nota_DebCre.IdSucursal, 
                         dbo.tb_sucursal.Su_Descripcion AS nom_Sucursal, dbo.ct_cbtecble_tipo.tc_TipoCbte AS nom_TipoCbte, dbo.cp_catalogo.Nombre, dbo.tb_empresa.em_nombre, 
                         dbo.cp_nota_DebCre.cn_serie1, dbo.cp_nota_DebCre.cn_serie2, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_punto_cargo_grupo.nom_punto_cargo_grupo
FROM            dbo.ct_punto_cargo INNER JOIN
                         dbo.ct_punto_cargo_grupo ON dbo.ct_punto_cargo.IdEmpresa = dbo.ct_punto_cargo_grupo.IdEmpresa AND 
                         dbo.ct_punto_cargo.IdPunto_cargo_grupo = dbo.ct_punto_cargo_grupo.IdPunto_cargo_grupo RIGHT OUTER JOIN
                         dbo.cp_catalogo INNER JOIN
                         dbo.cp_nota_DebCre INNER JOIN
                         dbo.ct_cbtecble ON dbo.cp_nota_DebCre.IdEmpresa = dbo.ct_cbtecble.IdEmpresa AND dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.ct_cbtecble.IdTipoCbte AND 
                         dbo.cp_nota_DebCre.IdCbteCble_Nota = dbo.ct_cbtecble.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_det.IdTipoCbte AND 
                         dbo.ct_cbtecble.IdCbteCble = dbo.ct_cbtecble_det.IdCbteCble ON dbo.cp_catalogo.IdCatalogo = dbo.cp_nota_DebCre.IdTipoNota INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_sucursal ON dbo.cp_nota_DebCre.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_nota_DebCre.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_empresa ON dbo.cp_nota_DebCre.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_nota_DebCre.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.ct_cbtecble_tipo.IdTipoCbte ON dbo.ct_punto_cargo.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND 
                         dbo.ct_punto_cargo.IdPunto_cargo = dbo.ct_cbtecble_det.IdPunto_cargo AND 
                         dbo.ct_punto_cargo.IdPunto_cargo_grupo = dbo.ct_cbtecble_det.IdPunto_cargo_grupo LEFT OUTER JOIN
                         dbo.ct_plancta ON dbo.ct_cbtecble_det.IdCtaCble = dbo.ct_plancta.IdCtaCble AND dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_plancta.IdEmpresa
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
WHERE        (dbo.cp_nota_DebCre.DebCre = 'C')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[4] 2[61] 3) )"
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
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 0
               Left = 799
               Bottom = 115
               Right = 1008
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo_x_empresa"
            Begin Extent = 
               Top = 0
               Left = 459
               Bottom = 112
               Right = 668
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_nota_DebCre"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 280
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble"
            Begin Extent = 
               Top = 248
               Left = 522
               Bottom = 377
               Right = 731
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 303
               Left = 14
               Bottom = 542
               Right = 277
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_catalogo"
            Begin Extent = 
               Top = 397
               Left = 682
               Bottom = 526
               Right = 891
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 119
               Left = 787
               Bottom = 248
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 1008
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 250
               Left = 786
               Bottom = 379
               Right = 1016
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 117
               Left = 528
               Bottom = 246
               Right = 745
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 382
               Left = 466
               Bottom = 554
               Right = 675
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
      Begin ColumnWidths = 24
         Width = 284
         Width = 1500
         Width = 2205
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
         Column = 7890
         Alias = 2580
         Table = 2475
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt006';

