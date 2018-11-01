CREATE VIEW [dbo].[vwACTF_Rpt014]
AS
SELECT        dbo.Af_Activo_fijo.IdEmpresa, dbo.Af_Depreciacion.IdPeriodo,  SUM(dbo.Af_Activo_fijo.Af_costo_compra) 
                         AS Af_costo_compra, isnull(dbo.Af_Activo_fijo.Af_Depreciacion_acum,0) + SUM(isnull(dbo.Af_Depreciacion_Det.Valor_Depre_Acum,0)) AS Valor_Depre_Acum, SUM(dbo.Af_Depreciacion_Det.Valor_Depreciacion) AS Dep_Actual, 
                         AVG(dbo.Af_Depreciacion_Det.Porc_Depreciacion) AS Porc_Depreciacion, dbo.Af_Activo_fijo.IdActivoFijoTipo IdActijoFijoTipo, 
                         dbo.Af_Activo_fijo_tipo.Af_Descripcion AS nom_ActijoFijoTipo, dbo.Af_Activo_fijo.IdCategoriaAF, dbo.Af_Activo_fijo_Categoria.Descripcion AS nom_CategoriaAF, 
                         dbo.Af_Activo_fijo.IdSucursal, dbo.tb_sucursal.Su_Descripcion
FROM            dbo.Af_Activo_fijo_Categoria INNER JOIN
                         dbo.Af_Activo_fijo ON dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         dbo.Af_Activo_fijo_Categoria.IdCategoriaAF = dbo.Af_Activo_fijo.IdCategoriaAF AND 
                         dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo = dbo.Af_Activo_fijo.IdActivoFijoTipo INNER JOIN
                         dbo.Af_Activo_fijo_tipo ON dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa AND 
                         dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo INNER JOIN
                         dbo.Af_Catalogo ON dbo.Af_Activo_fijo.Estado_Proceso = dbo.Af_Catalogo.IdCatalogo INNER JOIN
                         dbo.tb_sucursal ON dbo.Af_Activo_fijo.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.Af_Activo_fijo.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                         dbo.Af_Depreciacion INNER JOIN
                         dbo.Af_Depreciacion_Det ON dbo.Af_Depreciacion.IdEmpresa = dbo.Af_Depreciacion_Det.IdEmpresa AND 
                         dbo.Af_Depreciacion.IdDepreciacion = dbo.Af_Depreciacion_Det.IdDepreciacion 
                          ON 
                         dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Depreciacion_Det.IdEmpresa AND dbo.Af_Activo_fijo.IdActivoFijo = dbo.Af_Depreciacion_Det.IdActivoFijo
GROUP BY dbo.Af_Activo_fijo.IdEmpresa, dbo.Af_Depreciacion.IdPeriodo, dbo.Af_Activo_fijo.IdActivoFijoTipo, 
                         dbo.Af_Activo_fijo_tipo.Af_Descripcion,isnull(dbo.Af_Activo_fijo.Af_Depreciacion_acum,0), dbo.Af_Activo_fijo.IdCategoriaAF, dbo.Af_Activo_fijo_Categoria.Descripcion, dbo.Af_Activo_fijo.IdSucursal, 
                         dbo.tb_sucursal.Su_Descripcion

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[50] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[28] 2[61] 3) )"
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
         Begin Table = "Af_Activo_fijo_Categoria"
            Begin Extent = 
               Top = 439
               Left = 420
               Bottom = 568
               Right = 645
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_tipo"
            Begin Extent = 
               Top = 514
               Left = 556
               Bottom = 643
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Catalogo"
            Begin Extent = 
               Top = 448
               Left = 895
               Bottom = 577
               Right = 1120
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 839
               Left = 581
               Bottom = 968
               Right = 827
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Depreciacion"
            Begin Extent = 
               Top = 0
               Left = 798
               Bottom = 129
               Right = 1023
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Depreciacion_Det"
            Begin Extent = 
               Top = 5
               Left = 507
               Bottom = 134
            ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Right = 732
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Tipo_Depreciacion"
            Begin Extent = 
               Top = 16
               Left = 1058
               Bottom = 145
               Right = 1287
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
      Begin ColumnWidths = 23
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3435
         Alias = 2790
         Table = 3465
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt014';

