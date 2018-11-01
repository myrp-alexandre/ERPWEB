CREATE VIEW [dbo].[vwAf_Activo_fijo]
AS
SELECT dbo.Af_Activo_fijo.IdEmpresa, dbo.Af_Activo_fijo.IdActivoFijo, dbo.Af_Activo_fijo.CodActivoFijo, dbo.Af_Activo_fijo.Af_Nombre, dbo.Af_Activo_fijo.IdActivoFijoTipo IdActijoFijoTipo, 0 IdDepartamento, '' de_descripcion, 
                  Af_Catalogo_2.Descripcion AS Marca, Af_Catalogo_1.Descripcion AS Modelo, dbo.Af_Activo_fijo.Af_NumSerie, dbo.Af_Activo_fijo.Af_fecha_compra, dbo.Af_Activo_fijo.Af_fecha_ini_depre, dbo.Af_Activo_fijo.Af_fecha_fin_depre, 
                  dbo.Af_Activo_fijo.Af_Costo_historico, dbo.Af_Activo_fijo.Af_costo_compra, dbo.Af_Activo_fijo.Af_Vida_Util, dbo.Af_Activo_fijo.Af_Meses_depreciar, dbo.Af_Activo_fijo.Af_porcentaje_deprec, dbo.Af_Activo_fijo.Af_NumSerie_Motor, 
                  dbo.Af_Activo_fijo.Af_NumSerie_Chasis, dbo.tb_sucursal.IdSucursal, dbo.tb_sucursal.Su_Descripcion AS nom_Sucursal, dbo.Af_Activo_fijo_Categoria.Descripcion AS nom_Categoria, dbo.Af_Activo_fijo.Estado, 
                  '' nom_encargado, 0 Af_ValorUnidad_Actu, cat_Color.Descripcion AS nom_Color, '' IdUnidadFact_cat, 
                  cast(0 as bit) Es_carroceria, dbo.Af_Activo_fijo_tipo.Af_Descripcion AS nom_tipo, '' IdCentroCosto_sub_centro_costo, 0 as costo_compra_carroceria, 0 valor_salvamento_carroceria
FROM     dbo.Af_Catalogo AS Af_Catalogo_1 RIGHT OUTER JOIN
                  dbo.Af_Activo_fijo_Categoria RIGHT OUTER JOIN
                  dbo.Af_Activo_fijo_tipo ON dbo.Af_Activo_fijo_Categoria.IdActivoFijoTipo = dbo.Af_Activo_fijo_tipo.IdActivoFijoTipo AND dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo_tipo.IdEmpresa RIGHT OUTER JOIN
                  dbo.Af_Activo_fijo ON dbo.Af_Activo_fijo_Categoria.IdCategoriaAF = dbo.Af_Activo_fijo.IdCategoriaAF AND dbo.Af_Activo_fijo_Categoria.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa LEFT OUTER JOIN
                  dbo.Af_Catalogo AS cat_Color ON dbo.Af_Activo_fijo.IdCatalogo_Color = cat_Color.IdCatalogo LEFT OUTER JOIN
                  dbo.Af_Catalogo AS Af_Catalogo_2 ON dbo.Af_Activo_fijo.IdCatalogo_Marca = Af_Catalogo_2.IdCatalogo ON Af_Catalogo_1.IdCatalogo = dbo.Af_Activo_fijo.IdCatalogo_Modelo LEFT OUTER JOIN
                  dbo.tb_sucursal ON dbo.Af_Activo_fijo.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.Af_Activo_fijo.IdSucursal = dbo.tb_sucursal.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[85] 4[5] 2[5] 3) )"
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
         Begin Table = "Af_Catalogo_1"
            Begin Extent = 
               Top = 0
               Left = 983
               Bottom = 129
               Right = 1192
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_Categoria"
            Begin Extent = 
               Top = 156
               Left = 153
               Bottom = 368
               Right = 362
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_tipo"
            Begin Extent = 
               Top = 312
               Left = 75
               Bottom = 441
               Right = 312
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo"
            Begin Extent = 
               Top = 0
               Left = 423
               Bottom = 403
               Right = 652
            End
            DisplayFlags = 280
            TopColumn = 64
         End
         Begin Table = "vwAf_Activo_fijo_x_ct_centro_costo (Fj_servindustrias)"
            Begin Extent = 
               Top = 387
               Left = 19
               Bottom = 716
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "cat_Color"
            Begin Extent = 
               Top = 87
               Left = 176
               Bottom = 216
               Right = 385
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ro_Departamento"
            Begin Extent = 
               Top = 98
               Left = 1010
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAf_Activo_fijo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         Bottom = 227
               Right = 1219
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Af_Catalogo_2"
            Begin Extent = 
               Top = 43
               Left = 1063
               Bottom = 172
               Right = 1272
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 308
               Left = 916
               Bottom = 437
               Right = 1146
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Af_Encargado"
            Begin Extent = 
               Top = 105
               Left = 31
               Bottom = 234
               Right = 240
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 35
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2280
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
         Alias = 4380
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAf_Activo_fijo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAf_Activo_fijo';

