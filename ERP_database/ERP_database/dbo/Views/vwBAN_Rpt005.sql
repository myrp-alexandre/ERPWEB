
CREATE VIEW [dbo].[vwBAN_Rpt005]
AS
SELECT        dbo.vwBa_ChequexCbteCtble.IdEmpresa, dbo.vwBa_ChequexCbteCtble.IdCbteCble, dbo.vwBa_ChequexCbteCtble.IdTipocbte, 
                         dbo.vwBa_ChequexCbteCtble.Cod_Cbtecble, dbo.vwBa_ChequexCbteCtble.cb_Observacion, dbo.vwBa_ChequexCbteCtble.cb_secuencia, 
                         dbo.vwBa_ChequexCbteCtble.cb_Valor, dbo.vwBa_ChequexCbteCtble.cb_Cheque, dbo.vwBa_ChequexCbteCtble.cb_ChequeImpreso, 
                         dbo.vwBa_ChequexCbteCtble.cb_FechaCheque, dbo.vwBa_ChequexCbteCtble.Fecha_Transac, dbo.vwBa_ChequexCbteCtble.Estado, 
                         dbo.vwBa_ChequexCbteCtble.cb_giradoA, dbo.vwBa_ChequexCbteCtble.cb_ciudadChq, dbo.vwBa_ChequexCbteCtble.CodTipoCbteBan, 
                         dbo.vwBa_ChequexCbteCtble.cb_Fecha, dbo.vwBa_ChequexCbteCtble.con_Fecha, dbo.vwBa_ChequexCbteCtble.con_Valor, 
                         dbo.vwBa_ChequexCbteCtble.con_Observacion, dbo.vwBa_ChequexCbteCtble.con_IdCbteCble, dbo.vwBa_ChequexCbteCtble.IdCtaCble, 
                         dbo.vwBa_ChequexCbteCtble.pc_Cuenta, dbo.vwBa_ChequexCbteCtble.ValorEnLetras, dbo.vwBa_ChequexCbteCtble.dc_Valor, 
                         dbo.tb_ciudad.Descripcion_Ciudad AS nom_ciudad
FROM            dbo.vwBa_ChequexCbteCtble LEFT OUTER JOIN
                         dbo.tb_ciudad ON dbo.vwBa_ChequexCbteCtble.cb_ciudadChq = dbo.tb_ciudad.IdCiudad
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
         Begin Table = "vwBa_ChequexCbteCtble"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 211
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 16
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt005';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt005';

