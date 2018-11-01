CREATE VIEW [dbo].[vwfa_Documento_Tipo_x_Secuencia_Talonario]
AS
SELECT     dbo.tb_bodega.bo_Descripcion, dbo.tb_sucursal.Su_Descripcion, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdEmpresa, 
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdSucursal, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdBodega, 
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.CodDocumentoTipo, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.Secuencia, 
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.Serie1, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.Serie2, 
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.FechaCaducidad, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.NAutorizacion, 
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.DocInicial, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.DocFinal, 
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.DocActual, dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.Estado
FROM         dbo.tb_bodega INNER JOIN
                      dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                      dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario ON dbo.tb_sucursal.IdEmpresa = dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdEmpresa AND 
                      dbo.tb_bodega.IdEmpresa = dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdEmpresa AND 
                      dbo.tb_sucursal.IdSucursal = dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdSucursal AND 
                      dbo.tb_bodega.IdBodega = dbo.tb_sis_Documento_Tipo_x_Secuencia_Talonario.IdBodega
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[3] 3[26] 2) )"
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
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 62
               Left = 712
               Bottom = 198
               Right = 910
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 62
               Left = 352
               Bottom = 203
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sis_Documento_Tipo_x_Secuencia_Talonario"
            Begin Extent = 
               Top = 0
               Left = 49
               Bottom = 182
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
         Width = 284
         Width = 3870
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
         Width = 2235
         Width = 2100
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
        ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_Documento_Tipo_x_Secuencia_Talonario';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Output = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_Documento_Tipo_x_Secuencia_Talonario';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_Documento_Tipo_x_Secuencia_Talonario';

