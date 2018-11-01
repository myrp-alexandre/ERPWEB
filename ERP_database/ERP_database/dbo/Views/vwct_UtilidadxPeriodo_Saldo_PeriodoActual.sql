CREATE VIEW [dbo].[vwct_UtilidadxPeriodo_Saldo_PeriodoActual]
AS
SELECT        IdEmpresa, IdAnioF, IdPeriodo, SUM(Saldo * gc_signo_operacion) AS Utilidad_Periodo
FROM            (SELECT        A.IdEmpresa, A.IdAnioF, A.IdPeriodo, B.pc_Naturaleza, C.IdGrupoCble, C.gc_signo_operacion, SUM(A.sc_debito_mes) AS sc_debito_mes, 
                                                    SUM(A.sc_credito_mes) AS sc_credito_mes, CASE B.pc_Naturaleza WHEN 'D' THEN abs(SUM(A.sc_debito_mes)) - abs(SUM(A.sc_credito_mes)) 
                                                    WHEN 'C' THEN abs(SUM(A.sc_credito_mes)) - abs(SUM(A.sc_debito_mes)) END AS Saldo
                          FROM            dbo.ct_grupocble AS C INNER JOIN
                                                    dbo.ct_plancta AS B ON C.IdGrupoCble = B.IdGrupoCble INNER JOIN
                                                    dbo.ct_saldoxCuentas AS A ON B.IdEmpresa = A.IdEmpresa AND B.IdCtaCble = A.IdCtaCble
                          WHERE        (C.gc_estado_financiero = 'ER')
                          GROUP BY A.IdEmpresa, A.IdAnioF, A.IdPeriodo, B.pc_Naturaleza, C.IdGrupoCble, C.gc_signo_operacion) AS A_1
GROUP BY IdEmpresa, IdAnioF, IdPeriodo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[4] 2[68] 3) )"
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
         Begin Table = "A_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_UtilidadxPeriodo_Saldo_PeriodoActual';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_UtilidadxPeriodo_Saldo_PeriodoActual';

