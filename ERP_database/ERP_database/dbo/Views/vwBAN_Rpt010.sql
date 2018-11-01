CREATE VIEW [dbo].[vwBAN_Rpt010]
AS
SELECT        ba_Cbte_Ban.IdEmpresa, ba_Cbte_Ban.IdCbteCble, ba_Cbte_Ban.IdTipocbte, ba_Cbte_Ban_tipo.Descripcion, ba_Cbte_Ban.IdPeriodo, ba_Cbte_Ban.IdBanco, 
                         ba_Banco_Cuenta.ba_descripcion AS nom_Banco, ba_Cbte_Ban.cb_Fecha, ct_cbtecble_det.IdCtaCble, ct_plancta.pc_Cuenta AS nom_CtaCble, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor WHEN ct_cbtecble_det.dc_Valor < 0 THEN 0 END AS Debito, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN 0 WHEN ct_cbtecble_det.dc_Valor < 0 THEN abs(ct_cbtecble_det.dc_Valor) END AS Haber, 
                         CASE WHEN ba_Cbte_Ban_tipo.CodTipoCbteBan = 'CHEQ' THEN ba_Cbte_Ban_tipo.CodTipoCbteBan + '#:' + ba_Cbte_Ban.cb_Cheque ELSE ba_Cbte_Ban_tipo.CodTipoCbteBan
                          + '#:' + CAST(ba_Cbte_Ban.IdCbteCble AS varchar(20)) END AS referencia, 
                         CASE WHEN ba_Cbte_Ban_tipo.CodTipoCbteBan = 'CHEQ' THEN ba_Cbte_Ban.cb_giradoA ELSE ba_Cbte_Ban.cb_Observacion END AS Concepto, 
                         tb_empresa.em_ruc AS ruc_empresa, tb_empresa.em_nombre AS nom_empresa
FROM            ct_cbtecble_det INNER JOIN
                         ba_Cbte_Ban INNER JOIN
                         ba_Banco_Cuenta ON ba_Cbte_Ban.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ba_Cbte_Ban.IdBanco = ba_Banco_Cuenta.IdBanco INNER JOIN
                         ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo INNER JOIN
                         ba_Cbte_Ban_tipo ON ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan = ba_Cbte_Ban_tipo.CodTipoCbteBan ON 
                         ba_Cbte_Ban.IdTipocbte = ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble AND 
                         ba_Cbte_Ban.IdEmpresa = ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa ON ct_cbtecble_det.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND 
                         ct_cbtecble_det.IdCbteCble = ba_Cbte_Ban.IdCbteCble AND ct_cbtecble_det.IdTipoCbte = ba_Cbte_Ban.IdTipocbte AND 
                         ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         tb_empresa ON ba_Cbte_Ban.IdEmpresa = tb_empresa.IdEmpresa
UNION
SELECT        ct_cbtecble.IdEmpresa, ct_cbtecble.IdTipoCbte, ct_cbtecble.IdCbteCble, ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble.IdPeriodo, ba_Banco_Cuenta.IdBanco, 
                         ba_Banco_Cuenta.ba_descripcion, ct_cbtecble.cb_Fecha, ct_plancta.IdCtaCble, ct_plancta.pc_Cuenta, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN ct_cbtecble_det.dc_Valor WHEN ct_cbtecble_det.dc_Valor < 0 THEN 0 END AS Debito, 
                         CASE WHEN ct_cbtecble_det.dc_Valor > 0 THEN 0 WHEN ct_cbtecble_det.dc_Valor < 0 THEN abs(ct_cbtecble_det.dc_Valor) END AS Haber, 
                         ct_cbtecble_tipo.CodTipoCbte + '#:' + CAST(ct_cbtecble.IdCbteCble AS varchar(20)) AS Expr1, ct_cbtecble.cb_Observacion, tb_empresa.em_ruc, 
                         tb_empresa.em_nombre
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_cbtecble_tipo ON ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble INNER JOIN
                         ct_plancta ON ct_cbtecble_det.IdEmpresa = ct_plancta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ct_plancta.IdCtaCble INNER JOIN
                         tb_empresa ON ct_cbtecble.IdEmpresa = tb_empresa.IdEmpresa
WHERE        (NOT EXISTS
                             (SELECT        IdEmpresa
                               FROM            ba_Cbte_Ban AS A
                               WHERE        (IdEmpresa = ct_cbtecble.IdEmpresa) AND (IdCbteCble = ct_cbtecble.IdCbteCble) AND (IdTipocbte = ct_cbtecble.IdTipoCbte)))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[4] 2[61] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt010';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt010';

