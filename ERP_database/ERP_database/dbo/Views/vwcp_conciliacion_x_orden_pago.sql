/*WHERE     (cp_conciliacion.IdEmpresa = 1)  AND (cp_conciliacion.IdConciliacion = 1)*/
CREATE VIEW [dbo].[vwcp_conciliacion_x_orden_pago]
AS
SELECT     B.IdEmpresa, B.IdTipo_op, B.Referencia, B.IdOrdenPago, B.Secuencia_OP, B.IdTipoPersona, B.IdPersona, B.IdEntidad, B.Fecha_OP, B.Fecha_Fa_Prov, 
                      B.Fecha_Venc_Fac_Prov, B.Observacion, B.Nom_Beneficiario, B.Girar_Cheque_a, B.Valor_a_pagar, B.Valor_estimado_a_pagar_OP, B.Total_cancelado_OP, 
                      B.Saldo_x_Pagar_OP, B.IdEstadoAprobacion, B.IdFormaPago, B.Fecha_Pago, B.IdCtaCble, B.IdCentroCosto, B.IdSubCentro_Costo, B.Cbte_cxp, B.Estado, 
                      B.Nom_Beneficiario_2, dbo.cp_conciliacion.IdConciliacion, dbo.cp_conciliacion_det.MontoAplicado, dbo.cp_conciliacion_det.SaldoAnterior, 
                      dbo.cp_conciliacion_det.SaldoActual
FROM         dbo.cp_conciliacion_det INNER JOIN
                      dbo.cp_conciliacion ON dbo.cp_conciliacion_det.IdEmpresa = dbo.cp_conciliacion.IdEmpresa AND 
                      dbo.cp_conciliacion_det.IdConciliacion = dbo.cp_conciliacion.IdConciliacion INNER JOIN
                      dbo.vwcp_orden_pago_con_cancelacion AS B ON dbo.cp_conciliacion_det.IdEmpresa_op = B.IdEmpresa AND 
                      dbo.cp_conciliacion_det.IdOrdenPago_op = B.IdOrdenPago AND dbo.cp_conciliacion_det.Secuencia_op = B.Secuencia_OP
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[17] 2[21] 3) )"
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
         Begin Table = "cp_conciliacion_det"
            Begin Extent = 
               Top = 16
               Left = 582
               Bottom = 191
               Right = 771
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "cp_conciliacion"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 125
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 266
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_conciliacion_x_orden_pago';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_conciliacion_x_orden_pago';

