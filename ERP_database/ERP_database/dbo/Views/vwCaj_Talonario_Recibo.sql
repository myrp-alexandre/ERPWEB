CREATE VIEW dbo.vwCaj_Talonario_Recibo
AS
SELECT        dbo.Caj_Talonario_Recibo.IdEmpresa, dbo.Caj_Talonario_Recibo.IdRecibo, dbo.Caj_Talonario_Recibo.IdSucursal, dbo.tb_sucursal.Su_Descripcion, dbo.Caj_Talonario_Recibo.IdPuntoVta, 
                         dbo.fa_PuntoVta.nom_PuntoVta, dbo.tb_sucursal.Su_CodigoEstablecimiento, dbo.fa_PuntoVta.cod_PuntoVta, dbo.Caj_Talonario_Recibo.Num_Recibo, dbo.Caj_Talonario_Recibo.Usado, 
                         dbo.Caj_Talonario_Recibo.Estado
FROM            dbo.Caj_Talonario_Recibo INNER JOIN
                         dbo.fa_PuntoVta ON dbo.Caj_Talonario_Recibo.IdEmpresa = dbo.fa_PuntoVta.IdEmpresa AND dbo.Caj_Talonario_Recibo.IdSucursal = dbo.fa_PuntoVta.IdSucursal INNER JOIN
                         dbo.tb_sucursal ON dbo.fa_PuntoVta.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.fa_PuntoVta.IdSucursal = dbo.tb_sucursal.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[6] 2[20] 3) )"
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
         Begin Table = "Caj_Talonario_Recibo"
            Begin Extent = 
               Top = 2
               Left = 0
               Bottom = 246
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_PuntoVta"
            Begin Extent = 
               Top = 0
               Left = 295
               Bottom = 204
               Right = 504
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 0
               Left = 633
               Bottom = 265
               Right = 863
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCaj_Talonario_Recibo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCaj_Talonario_Recibo';

