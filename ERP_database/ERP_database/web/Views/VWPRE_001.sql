CREATE VIEW web.VWPRE_001
AS
SELECT        d.IdEmpresa, d.IdPresupuesto, d.Secuencia, c.IdSucursal, su.Su_Descripcion, c.IdPeriodo, pe.DescripciónPeriodo, c.IdGrupo, gr.Descripcion AS DescripcionGrupo, d.IdRubro, ru.Descripcion AS DescripcionRubro, d.IdCtaCble, 
                         pc.pc_Cuenta, d.Cantidad, d.ValorUnitario, d.Monto, c.Estado, c.MontoSolicitado, c.MontoAprobado, c.Observacion, c.MotivoAnulacion, c.IdUsuarioAprobacion
FROM            dbo.pre_Presupuesto AS c INNER JOIN
                         dbo.pre_PresupuestoDet AS d ON c.IdEmpresa = d.IdEmpresa AND c.IdPresupuesto = d.IdPresupuesto INNER JOIN
                         dbo.pre_PresupuestoPeriodo AS pe ON c.IdEmpresa = pe.IdEmpresa AND c.IdPeriodo = pe.IdPeriodo INNER JOIN
                         dbo.pre_Grupo AS gr ON c.IdEmpresa = gr.IdEmpresa AND c.IdGrupo = gr.IdGrupo INNER JOIN
                         dbo.tb_sucursal AS su ON c.IdEmpresa = su.IdEmpresa AND c.IdSucursal = su.IdSucursal INNER JOIN
                         dbo.pre_Rubro AS ru ON d.IdEmpresa = ru.IdEmpresa AND d.IdRubro = ru.IdRubro LEFT OUTER JOIN
                         dbo.ct_plancta AS pc ON d.IdCtaCble = pc.IdCtaCble AND d.IdEmpresa = pc.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWPRE_001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
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
', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWPRE_001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[76] 4[3] 2[2] 3) )"
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
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 136
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pe"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gr"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "su"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ru"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pc"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 268
               Right = 468
            End
            DisplayFlags = 280
            TopColumn = 0
         End', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWPRE_001';

