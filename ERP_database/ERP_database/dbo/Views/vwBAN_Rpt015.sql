CREATE VIEW [dbo].[vwBAN_Rpt015]
AS
SELECT        dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdEmpresa, dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdCbteCble, 
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mba_IdTipocbte, dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_Secuencia, 
                         dbo.caj_Caja_Movimiento.IdEmpresa, '' AS nom_sucursal, dbo.caj_Caja_Movimiento.IdCbteCble, 
                         dbo.caj_Caja_Movimiento.IdTipocbte, dbo.ct_cbtecble_tipo.tc_TipoCbte AS nom_Tipocbte, tb_persona.pe_nombreCompleto AS Beneficiario, 
                         dbo.caj_Caja_Movimiento_det.IdCobro_tipo, GETDATE() AS Fecha_Cobro, CASE WHEN dbo.caj_Caja_Movimiento_det.cr_Valor IS NULL 
                         THEN dbo.caj_Caja_Movimiento.cm_valor ELSE dbo.caj_Caja_Movimiento_det.cr_Valor END AS cr_Valor, dbo.caj_Caja_Movimiento.cm_observacion
FROM            dbo.caj_Caja_Movimiento_det INNER JOIN
                         dbo.caj_Caja_Movimiento ON dbo.caj_Caja_Movimiento_det.IdEmpresa = dbo.caj_Caja_Movimiento.IdEmpresa AND 
                         dbo.caj_Caja_Movimiento_det.IdCbteCble = dbo.caj_Caja_Movimiento.IdCbteCble AND 
                         dbo.caj_Caja_Movimiento_det.IdTipocbte = dbo.caj_Caja_Movimiento.IdTipocbte INNER JOIN
                         dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito ON 
                         dbo.caj_Caja_Movimiento_det.IdEmpresa = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdEmpresa AND 
                         dbo.caj_Caja_Movimiento_det.IdCbteCble = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdCbteCble AND 
                         dbo.caj_Caja_Movimiento_det.IdTipocbte = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_IdTipocbte AND 
                         dbo.caj_Caja_Movimiento_det.Secuencia = dbo.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito.mcj_Secuencia LEFT OUTER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.caj_Caja_Movimiento.IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte 
						 INNER JOIN tb_persona on tb_persona.IdPersona = caj_Caja_Movimiento.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[4] 2[4] 3) )"
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
         Begin Table = "ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito"
            Begin Extent = 
               Top = 0
               Left = 946
               Bottom = 224
               Right = 1262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento"
            Begin Extent = 
               Top = 31
               Left = 62
               Bottom = 335
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento_det"
            Begin Extent = 
               Top = 22
               Left = 530
               Bottom = 319
               Right = 739
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 223
               Left = 564
               Bottom = 352
               Right = 773
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 320
               Left = 378
               Bottom = 462
               Right = 608
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
      Begin ColumnWidths = 14
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
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt015';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 8025
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt015';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt015';

