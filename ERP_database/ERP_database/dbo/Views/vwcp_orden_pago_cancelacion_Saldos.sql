CREATE view [dbo].[vwcp_orden_pago_cancelacion_Saldos]
as
SELECT        OP.IdEmpresa, OP.IdOrdenPago, OP.IdTipo_op, OP.IdTipo_Persona, OP.IdPersona, OP.IdEntidad, OP.Fecha, OP.IdEstadoAprobacion, OP.IdFormaPago, OP.Fecha_Pago, OP.IdBanco, OP.Estado, 
                         dbo.tb_persona.pe_nombreCompleto, CAN.Total_OP, ISNULL(PAGO.Total_cancelado, 0) AS Total_cancelado, CAN.Total_OP - ISNULL(PAGO.Total_cancelado, 0) AS Saldo, OP.Observacion, OP.IdTipoFlujo, 
                         dbo.ba_TipoFlujo.Descricion AS nom_tipoFlujo, CASE WHEN CAN.Total_OP - ISNULL(PAGO.Total_cancelado, 0) > 0 THEN 'PENDIENTE' WHEN CAN.Total_OP - ISNULL(PAGO.Total_cancelado, 0) 
                         <= 0 THEN 'CANCELADA' END AS EstadoCancelacion, dbo.cp_orden_pago_estado_aprob.Descripcion
FROM            dbo.cp_orden_pago AS OP INNER JOIN
                         dbo.tb_persona ON OP.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.vwcp_orden_pago_total AS CAN ON OP.IdEmpresa = CAN.IdEmpresa AND OP.IdOrdenPago = CAN.IdOrdenPago INNER JOIN
                         dbo.cp_orden_pago_estado_aprob ON OP.IdEstadoAprobacion = dbo.cp_orden_pago_estado_aprob.IdEstadoAprobacion LEFT OUTER JOIN
                         dbo.ba_TipoFlujo ON OP.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND OP.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_Total_Pagado AS PAGO ON CAN.IdEmpresa = PAGO.IdEmpresa_op AND CAN.IdOrdenPago = PAGO.IdOrdenPago_op
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[24] 2[4] 3) )"
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
               Bottom = 198
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "cp_orden_pago_det"
            Begin Extent = 
               Top = 136
               Left = 27
               Bottom = 330
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 8
               Left = 656
               Bottom = 229
               Right = 883
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 7
               Left = 905
               Bottom = 165
               Right = 1126
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 173
               Left = 907
               Bottom = 302
               Right = 1176
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago_cancelaciones"
            Begin Extent = 
               Top = 0
               Left = 436
               Bottom = 344
               Right = 649
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
         Width = 28', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_cancelacion_Saldos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'4
         Width = 1335
         Width = 1830
         Width = 1500
         Width = 1500
         Width = 720
         Width = 360
         Width = 480
         Width = 1395
         Width = 1065
         Width = 2190
         Width = 2520
         Width = 1500
         Width = 2250
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1785
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2970
         Alias = 2010
         Table = 2430
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_cancelacion_Saldos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_pago_cancelacion_Saldos';

