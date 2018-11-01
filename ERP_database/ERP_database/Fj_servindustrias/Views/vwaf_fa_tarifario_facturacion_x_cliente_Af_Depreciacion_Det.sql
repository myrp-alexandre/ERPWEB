CREATE VIEW Fj_servindustrias.vwaf_fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det
AS
SELECT Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdDepreciacion, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdTarifario, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Secuencia, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdTipoDepreciacion, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdActivoFijo, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Concepto, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Valor_Compra, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Valor_Salvamento, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Vida_Util, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Porc_Depreciacion, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Valor_Depreciacion, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Valor_Depre_Acum, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.Valor_Importe, dbo.Af_Activo_fijo.Af_Nombre, 
                  dbo.Af_Activo_fijo_Categoria.IdCategoriaAF, dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo, dbo.Af_Activo_fijo_Categoria.Descripcion, dbo.Af_Activo_fijo_Categoria.CodCategoriaAF, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdPeriodo
FROM     Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det INNER JOIN
                  dbo.Af_Activo_fijo ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo INNER JOIN
                  dbo.Af_Activo_fijo_Categoria ON dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_Categoria.IdEmpresa AND dbo.Af_Activo_fijo.IdCategoriaAF = dbo.Af_Activo_fijo_Categoria.IdCategoriaAF
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[67] 4[3] 2[9] 3) )"
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
         Begin Table = "fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det (Fj_servindustrias)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "Af_Activo_fijo"
            Begin Extent = 
               Top = 0
               Left = 611
               Bottom = 311
               Right = 874
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_Categoria"
            Begin Extent = 
               Top = 157
               Left = 46
               Bottom = 373
               Right = 255
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter ', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwaf_fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwaf_fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwaf_fa_tarifario_facturacion_x_cliente_Af_Depreciacion_Det';

