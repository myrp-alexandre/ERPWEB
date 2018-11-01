CREATE VIEW Fj_servindustrias.vwfa_tarifario_facturacion_x_cliente
AS
SELECT Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.codTarifario, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente.nom_tarifario, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.observacion, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.fecha_inicio, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente.fecha_fin, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdUsuario, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.Estado, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente.nom_pc, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.ip, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdUsuarioUltMod, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente.FechaUltMod, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdUsuarioUltAnu, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.Fecha_UltAnu, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente.MotiAnula, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdCentroCosto, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.valor_minimo_movilizacion, 
                  dbo.ct_centro_costo.Centro_costo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.por_ganancia_inicial
FROM     Fj_servindustrias.fa_tarifario_facturacion_x_cliente INNER JOIN
                  dbo.ct_centro_costo ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto AND Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa = dbo.ct_centro_costo.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[84] 4[5] 2[5] 3) )"
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
         Top = -230
         Left = 0
      End
      Begin Tables = 
         Begin Table = "fa_tarifario_facturacion_x_cliente (Fj_servindustrias)"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 539
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 545
               Left = 48
               Bottom = 708
               Right = 276
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
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_tarifario_facturacion_x_cliente';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_tarifario_facturacion_x_cliente';

