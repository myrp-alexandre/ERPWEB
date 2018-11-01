CREATE VIEW [dbo].[vwCXP_Rpt028]
AS
SELECT        dbo.cp_conciliacion_Caja.IdEmpresa, dbo.cp_conciliacion_Caja.IdConciliacion_Caja, dbo.cp_conciliacion_Caja.Fecha, dbo.cp_conciliacion_Caja.IdCaja, 
                         dbo.cp_conciliacion_Caja.IdEstadoCierre, dbo.cp_conciliacion_Caja.Observacion, dbo.cp_orden_pago.IdOrdenPago, dbo.cp_orden_pago.IdTipo_Persona, 
                         dbo.cp_orden_pago.IdPersona, dbo.cp_orden_pago.IdTipo_op, dbo.cp_orden_pago.Fecha AS Fecha_OP, dbo.cp_orden_pago_det.Valor_a_pagar, 
                         dbo.cp_orden_pago_det.Referencia, dbo.tb_persona.pe_nombreCompleto, dbo.cp_orden_pago_det.IdCbteCble_cxp, dbo.ct_plancta.IdCtaCble, 
                         dbo.ct_plancta.pc_Cuenta, dbo.ct_cbtecble_det.dc_Valor, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS SubCentroCosto, 
                         dbo.ct_centro_costo.Centro_costo, dbo.cp_orden_pago.Observacion AS Observacion_OP
FROM            dbo.ct_plancta INNER JOIN
                         dbo.ct_cbtecble_det ON dbo.ct_plancta.IdEmpresa = dbo.ct_cbtecble_det.IdEmpresa AND dbo.ct_plancta.IdCtaCble = dbo.ct_cbtecble_det.IdCtaCble INNER JOIN
                         dbo.ct_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.ct_cbtecble_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_cbtecble_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.ct_cbtecble_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                         dbo.ct_centro_costo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto INNER JOIN
                         dbo.cp_conciliacion_Caja INNER JOIN
                         dbo.cp_orden_pago ON dbo.cp_conciliacion_Caja.IdEmpresa_op = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_conciliacion_Caja.IdOrdenPago_op = dbo.cp_orden_pago.IdOrdenPago INNER JOIN
                         dbo.cp_orden_pago_det ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa AND 
                         dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_det.IdOrdenPago INNER JOIN
                         dbo.tb_persona ON dbo.cp_orden_pago.IdPersona = dbo.tb_persona.IdPersona ON dbo.ct_cbtecble_det.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa_cxp AND 
                         dbo.ct_cbtecble_det.IdCbteCble = dbo.cp_orden_pago_det.IdCbteCble_cxp AND dbo.ct_cbtecble_det.IdTipoCbte = dbo.cp_orden_pago_det.IdTipoCbte_cxp
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[4] 2[17] 3) )"
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
         Begin Table = "cp_conciliacion_Caja"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "cp_orden_pago"
            Begin Extent = 
               Top = 4
               Left = 269
               Bottom = 249
               Right = 487
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_det"
            Begin Extent = 
               Top = 0
               Left = 483
               Bottom = 236
               Right = 692
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 155
               Left = 32
               Bottom = 284
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_det"
            Begin Extent = 
               Top = 0
               Left = 774
               Bottom = 253
               Right = 1037
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_plancta"
            Begin Extent = 
               Top = 29
               Left = 1172
               Bottom = 199
               Right = 1381
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 56
               Left = 1157
               Bottom = 310
               Right = 1366', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt028';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 76
               Left = 1088
               Bottom = 266
               Right = 1351
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
      Begin ColumnWidths = 22
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt028';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt028';

