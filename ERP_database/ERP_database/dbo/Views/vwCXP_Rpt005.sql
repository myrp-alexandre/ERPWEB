CREATE VIEW [dbo].[vwCXP_Rpt005]
AS
SELECT        dbo.cp_orden_pago.IdEmpresa, dbo.cp_orden_pago.IdOrdenPago, dbo.cp_orden_pago.Observacion, dbo.cp_orden_pago.IdTipo_Persona, 
                         dbo.cp_orden_pago.IdPersona, dbo.cp_orden_pago.IdEntidad, dbo.cp_orden_pago.Fecha, dbo.cp_orden_pago.IdEstadoAprobacion, 
                         dbo.cp_orden_pago.IdFormaPago, dbo.cp_orden_pago.Fecha_Pago, dbo.cp_orden_pago.IdBanco, dbo.cp_orden_pago.Estado, dbo.cp_orden_pago_det.Secuencia, 
                         dbo.cp_orden_pago_det.IdEmpresa_cxp, dbo.cp_orden_pago_det.IdCbteCble_cxp, dbo.cp_orden_pago_det.IdTipoCbte_cxp, dbo.cp_orden_pago_det.Valor_a_pagar, 
                         dbo.cp_orden_pago_det.Referencia, dbo.cp_orden_pago.IdTipo_op, dbo.ba_Banco_Cuenta.ba_descripcion AS nom_Banco, 
                         dbo.cp_orden_pago_tipo.Descripcion AS nom_PagoTipo, dbo.cp_orden_pago_formapago.descripcion AS nom_FormaPago, 
                         dbo.vwtb_persona_beneficiario.Nombre AS nom_beneficiario, dbo.cp_orden_pago_estado_aprob.Descripcion AS nom_EstadoAprobacion, 
                         dbo.cp_orden_pago_det.IdUsuario_Aprobacion, dbo.cp_orden_pago_det.fecha_hora_Aproba, dbo.cp_orden_pago_det.Motivo_aproba, 
                         dbo.ba_Banco_Cuenta.ba_Num_Cuenta AS num_CuentaBanco, dbo.cp_orden_giro.co_valorpagar AS valor_factura, 
                         dbo.cp_orden_giro.co_valorpagar - dbo.cp_orden_pago_det.Valor_a_pagar AS saldo, dbo.tb_empresa.em_nombre, dbo.cp_orden_giro.co_total, 
                         ISNULL(dbo.vwcp_Retencion_valor_total_x_cbte_cxp.Total_Retencion, 0) AS Total_Retencion
FROM            dbo.cp_orden_pago INNER JOIN
                         dbo.cp_orden_pago_det ON dbo.cp_orden_pago.IdEmpresa = dbo.cp_orden_pago_det.IdEmpresa AND 
                         dbo.cp_orden_pago.IdOrdenPago = dbo.cp_orden_pago_det.IdOrdenPago INNER JOIN
                         dbo.cp_orden_pago_tipo ON dbo.cp_orden_pago.IdTipo_op = dbo.cp_orden_pago_tipo.IdTipo_op INNER JOIN
                         dbo.cp_orden_pago_formapago ON dbo.cp_orden_pago.IdFormaPago = dbo.cp_orden_pago_formapago.IdFormaPago INNER JOIN
                         dbo.vwtb_persona_beneficiario ON dbo.cp_orden_pago.IdEmpresa = dbo.vwtb_persona_beneficiario.IdEmpresa AND 
                         dbo.cp_orden_pago.IdTipo_Persona = dbo.vwtb_persona_beneficiario.IdTipo_Persona AND 
                         dbo.cp_orden_pago.IdPersona = dbo.vwtb_persona_beneficiario.IdPersona AND 
                         dbo.cp_orden_pago.IdEntidad = dbo.vwtb_persona_beneficiario.IdEntidad INNER JOIN
                         dbo.cp_orden_pago_estado_aprob ON dbo.cp_orden_pago.IdEstadoAprobacion = dbo.cp_orden_pago_estado_aprob.IdEstadoAprobacion INNER JOIN
                         dbo.tb_empresa ON dbo.cp_orden_pago.IdEmpresa = dbo.tb_empresa.IdEmpresa LEFT OUTER JOIN
                         dbo.vwcp_Retencion_valor_total_x_cbte_cxp ON dbo.cp_orden_pago.IdEmpresa = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdEmpresa AND 
                         dbo.cp_orden_pago_det.IdEmpresa_cxp = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdEmpresa_Ogiro AND 
                         dbo.cp_orden_pago_det.IdCbteCble_cxp = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdCbteCble_Ogiro AND 
                         dbo.cp_orden_pago_det.IdTipoCbte_cxp = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdTipoCbte_Ogiro LEFT OUTER JOIN
                         dbo.cp_orden_giro ON dbo.cp_orden_pago_det.IdEmpresa_cxp = dbo.cp_orden_giro.IdEmpresa AND 
                         dbo.cp_orden_pago_det.IdCbteCble_cxp = dbo.cp_orden_giro.IdCbteCble_Ogiro AND 
                         dbo.cp_orden_pago_det.IdTipoCbte_cxp = dbo.cp_orden_giro.IdTipoCbte_Ogiro LEFT OUTER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.cp_orden_pago.IdBanco = dbo.ba_Banco_Cuenta.IdBanco AND dbo.cp_orden_pago.IdEmpresa = dbo.ba_Banco_Cuenta.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "cp_orden_pago"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_det"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 135
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_tipo"
            Begin Extent = 
               Top = 6
               Left = 532
               Bottom = 135
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_formapago"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwtb_persona_beneficiario"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 267
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_estado_aprob"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 233
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 234
               Left = 532
               Bottom =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt005';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 363
               Right = 751
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcp_Retencion_valor_total_x_cbte_cxp"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 270
               Left = 285
               Bottom = 399
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Banco_Cuenta"
            Begin Extent = 
               Top = 366
               Left = 564
               Bottom = 495
               Right = 792
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt005';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt005';

