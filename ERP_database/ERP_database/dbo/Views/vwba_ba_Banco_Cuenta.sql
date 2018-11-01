CREATE VIEW [dbo].[vwba_ba_Banco_Cuenta]
AS
SELECT        dbo.ba_Banco_Cuenta.IdEmpresa, dbo.ba_Banco_Cuenta.IdBanco, dbo.ba_Banco_Cuenta.ba_descripcion, dbo.ba_Banco_Cuenta.ba_Tipo, 
                         dbo.ba_Banco_Cuenta.ba_Num_Cuenta, '' ba_Moneda, '' ba_Ultimo_Cheque, dbo.ba_Banco_Cuenta.ba_num_digito_cheq, 
                         dbo.ba_Banco_Cuenta.IdCtaCble, dbo.ba_Banco_Cuenta.IdBanco_Financiero, dbo.ba_Banco_Cuenta.Imprimir_Solo_el_cheque, 
                         dbo.ba_Banco_Cuenta.MostrarVistaPreviaCheque, dbo.ba_Banco_Cuenta.ReporteSolo_Cheque, dbo.ba_Banco_Cuenta.Reporte, dbo.ba_Banco_Cuenta.MotiAnula, 
                         dbo.ba_Banco_Cuenta.Fecha_UltAnu, dbo.ba_Banco_Cuenta.IdUsuarioUltAnu, dbo.ba_Banco_Cuenta.Estado, dbo.ba_Banco_Cuenta.ip, 
                         dbo.ba_Banco_Cuenta.nom_pc, dbo.ba_Banco_Cuenta.Fecha_UltMod, dbo.tb_banco.ba_descripcion AS Expr1, dbo.tb_banco.CodigoLegal, 
                         dbo.ba_Banco_Cuenta.IdUsuario, dbo.ba_Banco_Cuenta.Fecha_Transac, dbo.ba_Banco_Cuenta.IdUsuarioUltMod
FROM            dbo.ba_Banco_Cuenta INNER JOIN
                         dbo.tb_banco ON dbo.ba_Banco_Cuenta.IdBanco_Financiero = dbo.tb_banco.IdBanco
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[64] 4[4] 2[4] 3) )"
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
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 266
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "tb_banco"
            Begin Extent = 
               Top = 0
               Left = 419
               Bottom = 245
               Right = 653
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
      Begin ColumnWidths = 27
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_ba_Banco_Cuenta';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_ba_Banco_Cuenta';

