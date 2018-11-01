CREATE VIEW [dbo].[vwba_op_ba_Archivo_Transferencia_Det]
AS
SELECT        dbo.cp_orden_pago_det.Valor_a_pagar, dbo.cp_orden_pago.Observacion, dbo.tb_persona.CodPersona, dbo.tb_persona.pe_Naturaleza, 
                         dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_nombre, 0 IdTipoPersona, 
                         dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.IdPersona, dbo.cp_orden_pago.Fecha_Pago, 
                         dbo.ba_Archivo_Transferencia_Det.Estado, dbo.ba_Archivo_Transferencia_Det.IdEstadoRegistro_cat, dbo.cp_orden_pago_det.IdEstadoAprobacion, 
                         dbo.ba_Archivo_Transferencia_Det.IdEmpresa, dbo.ba_Archivo_Transferencia_Det.IdArchivo, dbo.ba_Archivo_Transferencia_Det.IdProceso_bancario, 
                         dbo.ba_Archivo_Transferencia_Det.Secuencia, dbo.ba_Archivo_Transferencia_Det.IdEmpresa_OP, dbo.ba_Archivo_Transferencia_Det.IdOrdenPago, 
                         dbo.ba_Archivo_Transferencia_Det.Secuencia_OP, dbo.cp_orden_pago.IdTipo_Persona, dbo.cp_orden_pago.IdEntidad
FROM            dbo.cp_orden_pago_det INNER JOIN
                         dbo.ba_Archivo_Transferencia_Det ON dbo.cp_orden_pago_det.Secuencia = dbo.ba_Archivo_Transferencia_Det.Secuencia_OP AND 
                         dbo.cp_orden_pago_det.IdEmpresa = dbo.ba_Archivo_Transferencia_Det.IdEmpresa_OP AND 
                         dbo.cp_orden_pago_det.IdOrdenPago = dbo.ba_Archivo_Transferencia_Det.IdOrdenPago INNER JOIN
                         dbo.cp_orden_pago ON dbo.cp_orden_pago_det.IdEmpresa = dbo.cp_orden_pago.IdEmpresa AND 
                         dbo.cp_orden_pago_det.IdOrdenPago = dbo.cp_orden_pago.IdOrdenPago INNER JOIN
                         dbo.tb_persona ON dbo.cp_orden_pago.IdPersona = dbo.tb_persona.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[60] 4[4] 2[5] 3) )"
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
         Begin Table = "cp_orden_pago_det"
            Begin Extent = 
               Top = 10
               Left = 429
               Bottom = 366
               Right = 638
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Archivo_Transferencia_Det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 328
               Right = 309
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_pago"
            Begin Extent = 
               Top = 8
               Left = 679
               Bottom = 255
               Right = 888
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 12
               Left = 1008
               Bottom = 306
               Right = 1251
            End
            DisplayFlags = 280
            TopColumn = 22
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 25
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
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_op_ba_Archivo_Transferencia_Det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_op_ba_Archivo_Transferencia_Det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_op_ba_Archivo_Transferencia_Det';

