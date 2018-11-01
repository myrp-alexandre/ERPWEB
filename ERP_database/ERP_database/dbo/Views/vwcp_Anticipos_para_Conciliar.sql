CREATE VIEW dbo.vwcp_Anticipos_para_Conciliar
AS
SELECT        OPD.IdEmpresa_cxp, OPD.IdCbteCble_cxp, OPD.IdTipoCbte_cxp, OP.Fecha, OP.Observacion, '' AS referencia, CBT_TP.tc_TipoCbte, 
                         OPD.Valor_a_pagar AS Valor_cbte, ISNULL(can.Total_Pagado, 0) AS Valor_cancelado, OPD.Valor_a_pagar - ISNULL(can.Total_Pagado, 0) AS valor_saldo_cbte, 
                         OP.IdTipo_op AS tipo, OPD.IdEmpresa AS IdEmpresaOP, OPD.IdOrdenPago AS IdOrdenPagoOP, OPD.Secuencia AS SecuenciaOP, Per.IdCtaCble, 
                         Per.IdCtaCble_Anticipo, Per.Nombre AS Beneficiario, Per.IdEntidad AS IdProveedor, Per.IdPersona
FROM            dbo.cp_orden_pago AS OP INNER JOIN
                         dbo.cp_orden_pago_det AS OPD ON OP.IdEmpresa = OPD.IdEmpresa AND OP.IdOrdenPago = OPD.IdOrdenPago INNER JOIN
                         dbo.vwtb_persona_beneficiario AS Per ON OP.IdEmpresa = Per.IdEmpresa AND OP.IdTipo_Persona = Per.IdTipo_Persona AND OP.IdPersona = Per.IdPersona AND 
                         OP.IdEntidad = Per.IdEntidad LEFT OUTER JOIN
                         dbo.ct_cbtecble_tipo AS CBT_TP ON OPD.IdEmpresa_cxp = CBT_TP.IdEmpresa AND OPD.IdTipoCbte_cxp = CBT_TP.IdTipoCbte LEFT OUTER JOIN
                             (SELECT        IdEmpresa_op_padre, IdOrdenPago_op_padre, Secuencia_op_padre, SUM(MontoAplicado) AS Total_Pagado
                               FROM            dbo.cp_orden_pago_cancelaciones
                               GROUP BY IdEmpresa_op_padre, IdOrdenPago_op_padre, Secuencia_op_padre) AS can ON OPD.IdEmpresa = can.IdEmpresa_op_padre AND 
                         OPD.IdOrdenPago = can.IdOrdenPago_op_padre AND OPD.Secuencia = can.Secuencia_op_padre
WHERE        (OP.IdTipo_op <> 'FACT_PROVEE') AND (OP.IdTipo_op <> 'OTROS_CONC') AND (OPD.IdCbteCble_cxp IS NOT NULL) AND EXISTS
                             (SELECT        IdEmpresa_op, IdOrdenPago_op
                               FROM            dbo.cp_orden_pago_cancelaciones AS cp_orden_pago_cancelaciones_1
                               WHERE        (IdEmpresa_op = OPD.IdEmpresa) AND (IdOrdenPago_op = OPD.IdOrdenPago))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[57] 4[4] 2[4] 3) )"
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
         Begin Table = "OP"
            Begin Extent = 
               Top = 0
               Left = 371
               Bottom = 240
               Right = 580
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OPD"
            Begin Extent = 
               Top = 136
               Left = 230
               Bottom = 298
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "Per"
            Begin Extent = 
               Top = 0
               Left = 770
               Bottom = 276
               Right = 979
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CBT_TP"
            Begin Extent = 
               Top = 140
               Left = 517
               Bottom = 269
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "can"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 298
               Right = 251
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
      Begin ColumnWidths = 20
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
         W', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Anticipos_para_Conciliar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'idth = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Anticipos_para_Conciliar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Anticipos_para_Conciliar';

