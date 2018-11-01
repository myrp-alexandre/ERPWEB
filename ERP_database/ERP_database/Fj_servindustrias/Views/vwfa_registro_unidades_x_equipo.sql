CREATE VIEW [Fj_servindustrias].[vwfa_registro_unidades_x_equipo]
AS
SELECT Fj_servindustrias.fa_registro_unidades_x_equipo.IdEmpresa, Fj_servindustrias.fa_registro_unidades_x_equipo.IdPeriodo, Fj_servindustrias.fa_registro_unidades_x_equipo.IdCentroCosto, 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_registro_unidades_x_equipo.Fecha, Fj_servindustrias.fa_registro_unidades_x_equipo.Observacion, 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.IdUsuarioUltMod, Fj_servindustrias.fa_registro_unidades_x_equipo.Fecha_UltMod, Fj_servindustrias.fa_registro_unidades_x_equipo.IdUsuarioUltAnu, 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.Fecha_UltAnu, Fj_servindustrias.fa_registro_unidades_x_equipo.MotiAnula, Fj_servindustrias.fa_registro_unidades_x_equipo.nom_pc, 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.ip, Fj_servindustrias.fa_registro_unidades_x_equipo.Estado, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                  dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.tb_persona.pe_nombreCompleto AS nom_Cliente, dbo.vwct_periodo.smes, dbo.vwct_periodo.pe_FechaIni, dbo.vwct_periodo.pe_FechaFin, 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.IdRegistro, Fj_servindustrias.fa_registro_unidades_x_equipo.estado_cierre
FROM     Fj_servindustrias.fa_registro_unidades_x_equipo INNER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_registro_unidades_x_equipo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_registro_unidades_x_equipo.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo INNER JOIN
                  dbo.ct_centro_costo ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                  Fj_servindustrias.fa_cliente_x_ct_centro_costo ON dbo.ct_centro_costo.IdEmpresa = Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cc AND 
                  dbo.ct_centro_costo.IdCentroCosto = Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCentroCosto_cc INNER JOIN
                  dbo.fa_cliente ON Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cli = dbo.fa_cliente.IdEmpresa AND Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCliente_cli = dbo.fa_cliente.IdCliente INNER JOIN
                  dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                  dbo.vwct_periodo ON Fj_servindustrias.fa_registro_unidades_x_equipo.IdEmpresa = dbo.vwct_periodo.IdEmpresa AND Fj_servindustrias.fa_registro_unidades_x_equipo.IdPeriodo = dbo.vwct_periodo.IdPeriodo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[16] 4[69] 2[5] 3) )"
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
         Begin Table = "fa_registro_unidades_x_equipo (Fj_servindustrias)"
            Begin Extent = 
               Top = 0
               Left = 14
               Bottom = 337
               Right = 277
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_catalogo"
            Begin Extent = 
               Top = 9
               Left = 518
               Bottom = 138
               Right = 727
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 219
               Left = 403
               Bottom = 404
               Right = 666
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 95
               Left = 466
               Bottom = 224
               Right = 675
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "fa_cliente_x_ct_centro_costo (Fj_servindustrias)"
            Begin Extent = 
               Top = 68
               Left = 662
               Bottom = 197
               Right = 871
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 66
               Left = 888
               Bottom = 195
               Right = 1126
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 82
        ', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_registro_unidades_x_equipo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Left = 1044
               Bottom = 211
               Right = 1276
            End
            DisplayFlags = 344
            TopColumn = 4
         End
         Begin Table = "vwct_periodo"
            Begin Extent = 
               Top = 147
               Left = 711
               Bottom = 478
               Right = 920
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
      Begin ColumnWidths = 23
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
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2895
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_registro_unidades_x_equipo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_registro_unidades_x_equipo';

