
CREATE VIEW [dbo].[vwcxc_Cobro_x_anticipo_x_cobros]
AS
SELECT     B.IdEmpresa, B.IdAnticipo, B.Secuencia, B.IdCobro_tipo, B.IdEmpresa_Cobro, B.IdSucursal_cobro, B.IdCobro_cobro, C.IdCliente, C.cr_fecha, C.cr_fechaDocu, 
                      C.cr_fechaCobro, C.cr_observacion, C.cr_Banco, C.cr_cuenta, C.cr_NumDocumento, C.cr_Tarjeta, C.cr_propietarioCta, D.mcj_IdEmpresa, D.mcj_IdCbteCble, 
                      D.mcj_IdTipocbte, C.cr_TotalCobro, C.IdBanco
FROM         dbo.cxc_cobro_x_Anticipo_det AS B INNER JOIN
                      dbo.cxc_cobro_x_Anticipo AS A ON B.IdEmpresa = A.IdEmpresa AND B.IdAnticipo = A.IdAnticipo INNER JOIN
                      dbo.cxc_cobro AS C ON B.IdEmpresa_Cobro = C.IdEmpresa AND B.IdSucursal_cobro = C.IdSucursal AND B.IdCobro_cobro = C.IdCobro LEFT OUTER JOIN
                      dbo.cxc_cobro_x_caj_Caja_Movimiento AS D ON C.IdEmpresa = D.cbr_IdEmpresa AND C.IdSucursal = D.cbr_IdSucursal AND C.IdCobro = D.cbr_IdCobro
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[65] 4[4] 2[12] 3) )"
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
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 251
               Bottom = 125
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 25
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 126
               Left = 255
               Bottom = 245
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 2
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
         Alias = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_Cobro_x_anticipo_x_cobros';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'900
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_Cobro_x_anticipo_x_cobros';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_Cobro_x_anticipo_x_cobros';

