CREATE VIEW dbo.vwin_producto
AS
SELECT        tip.tp_descripcion, cat.ca_Categoria, pr.IdEmpresa, pr.IdProducto, pr.pr_codigo, pr.pr_codigo_barra, pr.IdProductoTipo, pr.IdPresentacion, pr.IdCategoria, pr.pr_descripcion, pr.pr_observacion, pr.IdUnidadMedida, 
                         0 AS pr_pedidos, pr.IdMarca, pr.IdUsuario, pr.Fecha_Transac, pr.IdUsuarioUltMod, pr.Fecha_UltMod, pr.IdUsuarioUltAnu, pr.Fecha_UltAnu, pr.pr_motivoAnulacion, pr.nom_pc, pr.ip, pr.Estado, pr.pr_descripcion_2, pr.IdLinea, 
                         pr.IdGrupo, pr.IdSubGrupo, '' IdNaturaleza, 0 IdMotivo_Vta, pr.IdUnidadMedida_Consumo, dbo.in_linea.nom_linea, dbo.in_grupo.nom_grupo, dbo.in_subgrupo.nom_subgrupo, pr.IdCod_Impuesto_Iva, pr.Aparece_modu_Ventas, 
                         pr.Aparece_modu_Compras, pr.Aparece_modu_Inventario, pr.Aparece_modu_Activo_F, tip.tp_ManejaInven, pr.IdProducto_padre, pr.lote_fecha_fab, pr.lote_fecha_vcto, pr.lote_num_lote, 
                         dbo.in_Producto.pr_descripcion AS pr_descripcion_padre, tip.tp_ManejaLote, tip.tp_EsCombo, pr.se_distribuye, pr.precio_1,  pr.precio_2, pr.signo_2, pr.porcentaje_2, pr.precio_3, pr.signo_3, 
                         pr.porcentaje_3, pr.precio_4, pr.signo_4, pr.porcentaje_4, pr.precio_5, pr.signo_5, pr.porcentaje_5, pr.pr_codigo2, dbo.in_presentacion.nom_presentacion
FROM            dbo.in_Producto AS pr INNER JOIN
                         dbo.in_ProductoTipo AS tip ON pr.IdEmpresa = tip.IdEmpresa AND pr.IdProductoTipo = tip.IdProductoTipo INNER JOIN
                         dbo.in_presentacion ON pr.IdEmpresa = dbo.in_presentacion.IdEmpresa AND pr.IdPresentacion = dbo.in_presentacion.IdPresentacion LEFT OUTER JOIN
                         dbo.in_Producto ON pr.IdProducto_padre = dbo.in_Producto.IdProducto AND pr.IdEmpresa = dbo.in_Producto.IdEmpresa LEFT OUTER JOIN
                         dbo.in_subgrupo INNER JOIN
                         dbo.in_categorias AS cat INNER JOIN
                         dbo.in_linea ON cat.IdEmpresa = dbo.in_linea.IdEmpresa AND cat.IdCategoria = dbo.in_linea.IdCategoria INNER JOIN
                         dbo.in_grupo ON dbo.in_linea.IdEmpresa = dbo.in_grupo.IdEmpresa AND dbo.in_linea.IdCategoria = dbo.in_grupo.IdCategoria AND dbo.in_linea.IdLinea = dbo.in_grupo.IdLinea ON 
                         dbo.in_subgrupo.IdEmpresa = dbo.in_grupo.IdEmpresa AND dbo.in_subgrupo.IdCategoria = dbo.in_grupo.IdCategoria AND dbo.in_subgrupo.IdLinea = dbo.in_grupo.IdLinea AND 
                         dbo.in_subgrupo.IdGrupo = dbo.in_grupo.IdGrupo ON pr.IdEmpresa = dbo.in_subgrupo.IdEmpresa AND pr.IdCategoria = dbo.in_subgrupo.IdCategoria AND pr.IdLinea = dbo.in_subgrupo.IdLinea AND 
                         pr.IdGrupo = dbo.in_subgrupo.IdGrupo AND pr.IdSubGrupo = dbo.in_subgrupo.IdSubgrupo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[89] 4[3] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[62] 3) )"
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
         Begin Table = "pr"
            Begin Extent = 
               Top = 1
               Left = 123
               Bottom = 304
               Right = 357
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tip"
            Begin Extent = 
               Top = 294
               Left = 1132
               Bottom = 553
               Right = 1341
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 297
               Left = 552
               Bottom = 460
               Right = 827
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_subgrupo"
            Begin Extent = 
               Top = 10
               Left = 543
               Bottom = 272
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cat"
            Begin Extent = 
               Top = 0
               Left = 1516
               Bottom = 175
               Right = 1745
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_linea"
            Begin Extent = 
               Top = 3
               Left = 1205
               Bottom = 204
               Right = 1414
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "in_grupo"
            Begin Extent = 
               Top = 0
               Left = 900
               Bottom = 229
               Right = 1109
            End
            DisplayFlags = 280
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'            TopColumn = 0
         End
         Begin Table = "in_presentacion"
            Begin Extent = 
               Top = 468
               Left = 703
               Bottom = 598
               Right = 890
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
      Begin ColumnWidths = 69
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
         Column = 3015
         Alias = 3630
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_producto';

