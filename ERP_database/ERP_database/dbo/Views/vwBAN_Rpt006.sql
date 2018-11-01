
CREATE VIEW [dbo].[vwBAN_Rpt006]
AS
SELECT        dbo.vwba_Cbte_Ban.tc_TipoCbte, dbo.vwba_Cbte_Ban.ba_descripcion, dbo.vwba_Cbte_Ban.NombreProveedor, dbo.vwba_Cbte_Ban.IdEmpresa, 
                         dbo.vwba_Cbte_Ban.IdCbteCble, dbo.vwba_Cbte_Ban.IdTipocbte, dbo.vwba_Cbte_Ban.Cod_Cbtecble, dbo.vwba_Cbte_Ban.IdPeriodo, dbo.vwba_Cbte_Ban.IdBanco, 
                         dbo.vwba_Cbte_Ban.IdProveedor, dbo.vwba_Cbte_Ban.cb_Fecha, dbo.vwba_Cbte_Ban.cb_Observacion, dbo.vwba_Cbte_Ban.cb_secuencia, 
                         dbo.vwba_Cbte_Ban.cb_Valor, dbo.vwba_Cbte_Ban.cb_Cheque, dbo.vwba_Cbte_Ban.cb_ChequeImpreso, dbo.vwba_Cbte_Ban.cb_FechaCheque, 
                         dbo.vwba_Cbte_Ban.IdUsuario, dbo.vwba_Cbte_Ban.IdUsuario_Anu, dbo.vwba_Cbte_Ban.FechaAnulacion, dbo.vwba_Cbte_Ban.Fecha_Transac, 
                         dbo.vwba_Cbte_Ban.Fecha_UltMod, dbo.vwba_Cbte_Ban.IdUsuarioUltMod, dbo.vwba_Cbte_Ban.Estado, dbo.vwba_Cbte_Ban.MotivoAnulacion, 
                         dbo.vwba_Cbte_Ban.ip, dbo.vwba_Cbte_Ban.nom_pc, dbo.vwba_Cbte_Ban.cb_giradoA, dbo.vwba_Cbte_Ban.cb_ciudadChq, 
                         dbo.vwba_Cbte_Ban.IdCbteCble_Anulacion, dbo.vwba_Cbte_Ban.IdTipoCbte_Anulacion, dbo.vwba_Cbte_Ban.IdTipoFlujo, dbo.vwba_Cbte_Ban.IdTipoNota, 
                         dbo.vwba_Cbte_Ban.NomTipoNota, dbo.vwba_Cbte_Ban.Por_Anticipo, dbo.vwba_Cbte_Ban.PosFechado, dbo.vwba_Cbte_Ban.IdPersona_Girado_a, 
                         dbo.vwba_Cbte_Ban.ValorEnLetras, dbo.tb_ciudad.Descripcion_Ciudad AS nom_ciudadChq
FROM            dbo.vwba_Cbte_Ban LEFT OUTER JOIN
                         dbo.tb_ciudad ON dbo.vwba_Cbte_Ban.cb_ciudadChq = dbo.tb_ciudad.IdCiudad
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
         Begin Table = "vwba_Cbte_Ban"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 37
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwBAN_Rpt006';

