CREATE VIEW [dbo].[vwct_SaldosxCuentas]
AS
SELECT        A.IdEmpresa, IdAnioF, IdPeriodo, A.IdCtaCble, '[' + rtrim(ltrim(A.IdCtaCble)) + ']-' + rtrim(ltrim(B.pc_Cuenta)) AS pc_Cuenta,
 B.pc_Naturaleza, IdNivel, B.IdCtaCblePadre, 
                         sc_saldo_anterior, sc_debito_mes, sc_credito_mes, 
                         CASE B.pc_Naturaleza WHEN 'D' THEN sc_debito_mes - sc_credito_mes ELSE sc_credito_mes - sc_debito_mes END AS sc_saldoPeriodo
						 ,0 sc_debito_acum, 
                        0 sc_credito_acum, sc_saldo_acum, C.IdGrupoCble, C.gc_GrupoCble, C.gc_Orden, C.gc_estado_financiero, RTRIM(LTRIM(CAST(A.IdEmpresa AS varchar(5)))) 
                         + CAST(A.IdPeriodo AS varchar(20)) AS SIdPeriodo
FROM            dbo.ct_saldoxCuentas A, ct_plancta B, ct_grupocble C
WHERE        a.IdEmpresa = B.IdEmpresa AND A.IdCtaCble = B.IdCtaCble AND B.IdGrupoCble = C.IdGrupoCble
UNION
SELECT        IdEmpresa, idanioFiscal, idPeriodo, 'UTILIDAD', 'UTILIDAD ', NULL, 1, 'UTILIDAD', Utilidad_Anterior, 0, 0, utilidad_periodo, 0, 0, utilidad_acum, 'UTILI', 'UTILIDAD', 
                         99, 'UT', RTRIM(LTRIM(CAST(A.IdEmpresa AS varchar(5)))) + CAST(A.IdPeriodo AS varchar(20)) AS SIdPeriodo
FROM            vwct_UtilidadxPeriodo A
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[4] 2[74] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_SaldosxCuentas';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwct_SaldosxCuentas';

