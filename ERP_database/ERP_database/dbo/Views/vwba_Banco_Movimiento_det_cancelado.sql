CREATE VIEW [dbo].[vwba_Banco_Movimiento_det_cancelado]
AS
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.IdTipocbte, dbo.vwcp_orden_pago_con_cancelacion.IdEmpresa AS IdEmpresaBanco, 
                         dbo.vwcp_orden_pago_con_cancelacion.IdTipo_op, dbo.vwcp_orden_pago_con_cancelacion.Referencia, dbo.vwcp_orden_pago_con_cancelacion.IdOrdenPago, 
                         dbo.vwcp_orden_pago_con_cancelacion.Secuencia_OP, dbo.vwcp_orden_pago_con_cancelacion.IdTipoPersona, dbo.vwcp_orden_pago_con_cancelacion.IdPersona,
                          dbo.vwcp_orden_pago_con_cancelacion.IdEntidad, dbo.vwcp_orden_pago_con_cancelacion.Fecha_OP, dbo.vwcp_orden_pago_con_cancelacion.Fecha_Fa_Prov, 
                         dbo.vwcp_orden_pago_con_cancelacion.Fecha_Venc_Fac_Prov, dbo.vwcp_orden_pago_con_cancelacion.Observacion, 
                         dbo.vwcp_orden_pago_con_cancelacion.Nom_Beneficiario, dbo.vwcp_orden_pago_con_cancelacion.Girar_Cheque_a, 
                         dbo.vwcp_orden_pago_con_cancelacion.Valor_a_pagar, dbo.vwcp_orden_pago_con_cancelacion.Valor_estimado_a_pagar_OP, 
                         dbo.vwcp_orden_pago_con_cancelacion.Total_cancelado_OP, dbo.vwcp_orden_pago_con_cancelacion.Saldo_x_Pagar_OP, 
                         dbo.vwcp_orden_pago_con_cancelacion.IdEstadoAprobacion, dbo.vwcp_orden_pago_con_cancelacion.IdFormaPago, 
                         dbo.vwcp_orden_pago_con_cancelacion.Fecha_Pago, dbo.vwcp_orden_pago_con_cancelacion.IdCtaCble, dbo.vwcp_orden_pago_con_cancelacion.IdCentroCosto, 
                         dbo.vwcp_orden_pago_con_cancelacion.IdSubCentro_Costo, dbo.vwcp_orden_pago_con_cancelacion.Cbte_cxp, dbo.vwcp_orden_pago_con_cancelacion.Estado, 
                         dbo.vwcp_orden_pago_con_cancelacion.Nom_Beneficiario_2, 'N'PosFechado, dbo.vwcp_orden_pago_con_cancelacion.IdEmpresa_cxp, 
                         dbo.vwcp_orden_pago_con_cancelacion.IdTipoCbte_cxp, dbo.vwcp_orden_pago_con_cancelacion.IdCbteCble_cxp, 
                         dbo.cp_orden_pago_cancelaciones.Idcancelacion, dbo.cp_orden_pago_cancelaciones.MontoAplicado, dbo.cp_orden_pago_cancelaciones.SaldoAnterior, 
                         dbo.cp_orden_pago_cancelaciones.SaldoActual, dbo.cp_orden_pago_cancelaciones.Secuencia
FROM            dbo.ba_Cbte_Ban INNER JOIN
                         dbo.cp_orden_pago_cancelaciones INNER JOIN
                         dbo.vwcp_orden_pago_con_cancelacion ON dbo.cp_orden_pago_cancelaciones.IdEmpresa_op = dbo.vwcp_orden_pago_con_cancelacion.IdEmpresa AND 
                         dbo.cp_orden_pago_cancelaciones.IdOrdenPago_op = dbo.vwcp_orden_pago_con_cancelacion.IdOrdenPago AND 
                         dbo.cp_orden_pago_cancelaciones.Secuencia_op = dbo.vwcp_orden_pago_con_cancelacion.Secuencia_OP ON 
                         dbo.ba_Cbte_Ban.IdEmpresa = dbo.cp_orden_pago_cancelaciones.IdEmpresa_pago AND 
                         dbo.ba_Cbte_Ban.IdTipocbte = dbo.cp_orden_pago_cancelaciones.IdTipoCbte_pago AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = dbo.cp_orden_pago_cancelaciones.IdCbteCble_pago
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[5] 2[74] 3) )"
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
         Begin Table = "ba_Cbte_Ban"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_cancelaciones"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 135
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcp_orden_pago_con_cancelacion"
            Begin Extent = 
               Top = 6
               Left = 536
               Bottom = 135
               Right = 773
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
      Begin ColumnWidths = 39
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Wi', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Banco_Movimiento_det_cancelado';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'dth = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 525
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Banco_Movimiento_det_cancelado';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Banco_Movimiento_det_cancelado';

