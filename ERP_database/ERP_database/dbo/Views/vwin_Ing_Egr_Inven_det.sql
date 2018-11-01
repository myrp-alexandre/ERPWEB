/*RETURN
*****************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************/
CREATE VIEW dbo.vwin_Ing_Egr_Inven_det
AS
SELECT        dbo.in_Ing_Egr_Inven_det.Secuencia, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdProducto, dbo.in_Ing_Egr_Inven_det.dm_cantidad, 0 dm_stock_ante, 
                         0 dm_stock_actu, dbo.in_Ing_Egr_Inven_det.dm_observacion, 0 dm_precio, dbo.in_Ing_Egr_Inven_det.mv_costo, 0 dm_peso, 
                         dbo.in_Ing_Egr_Inven_det.IdCentroCosto, dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo, dbo.in_Ing_Egr_Inven_det.IdEstadoAproba, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida, 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc, dbo.in_Ing_Egr_Inven_det.IdSucursal_oc, dbo.in_Ing_Egr_Inven_det.IdOrdenCompra, dbo.in_Ing_Egr_Inven_det.Secuencia_oc, 
                         dbo.in_Ing_Egr_Inven_det.IdPunto_cargo, dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         consu.Descripcion AS nom_medida, dbo.ct_punto_cargo.nom_punto_cargo, dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv, dbo.in_Ing_Egr_Inven_det.IdSucursal_inv, dbo.in_Ing_Egr_Inven_det.IdBodega_inv, 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv, dbo.in_Ing_Egr_Inven_det.secuencia_inv, dbo.in_Ing_Egr_Inven_det.Motivo_Aprobacion, 
                         '' IdNaturaleza, dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, uni.Descripcion AS nom_medida_sinConversion, 
                         dbo.com_ordencompra_local.IdProveedor, pe_nombreCompleto AS nom_proveedor, dbo.com_ordencompra_local_det.do_descuento, dbo.com_ordencompra_local_det.do_subtotal, 
                         dbo.com_ordencompra_local_det.do_iva, dbo.com_ordencompra_local_det.do_total, dbo.in_Ing_Egr_Inven.signo, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.in_Motivo_Inven.Desc_mov_inv AS nom_motivo, dbo.in_movi_inven_tipo.tm_descripcion AS nom_tipo_inv, dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo, 
                         dbo.in_Ing_Egr_Inven_det.IdPunto_cargo_grupo, dbo.in_Ing_Egr_Inven_det.IdMotivo_Inv, dbo.in_Producto.pr_codigo, dbo.in_Ing_Egr_Inven.Estado, DATEDIFF(dd, 0, dbo.in_Ing_Egr_Inven.cm_fecha) 
                         + CONVERT(DATETIME, CAST(dbo.in_Ing_Egr_Inven.Fecha_Transac AS time)) AS Fecha_registro, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, dbo.in_subgrupo.IdCategoria, dbo.in_subgrupo.IdLinea, dbo.in_subgrupo.IdGrupo, dbo.in_subgrupo.IdSubgrupo, 
                         dbo.in_categorias.ca_Categoria, dbo.in_linea.nom_linea, dbo.in_grupo.nom_grupo, dbo.in_subgrupo.nom_subgrupo, dbo.in_Ing_Egr_Inven_det.mv_costo_sinConversion, 
                         dbo.in_Ing_Egr_Inven.CodMoviInven
FROM            dbo.in_UnidadMedida AS uni RIGHT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo RIGHT OUTER JOIN
                         dbo.ct_centro_costo RIGHT OUTER JOIN
                         dbo.tb_sucursal INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.tb_sucursal.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo RIGHT OUTER JOIN
                         dbo.in_Producto INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.in_Producto.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND dbo.in_Producto.IdProducto = dbo.in_Ing_Egr_Inven_det.IdProducto INNER JOIN
                         dbo.in_UnidadMedida AS consu ON consu.IdUnidadMedida = dbo.in_Ing_Egr_Inven_det.IdUnidadMedida LEFT OUTER JOIN
                         dbo.tb_bodega ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.tb_bodega.IdBodega ON dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi LEFT OUTER JOIN
                         dbo.in_grupo INNER JOIN
                         dbo.in_subgrupo ON dbo.in_grupo.IdEmpresa = dbo.in_subgrupo.IdEmpresa AND dbo.in_grupo.IdCategoria = dbo.in_subgrupo.IdCategoria AND dbo.in_grupo.IdLinea = dbo.in_subgrupo.IdLinea AND 
                         dbo.in_grupo.IdGrupo = dbo.in_subgrupo.IdGrupo INNER JOIN
                         dbo.in_linea ON dbo.in_grupo.IdEmpresa = dbo.in_linea.IdEmpresa AND dbo.in_grupo.IdCategoria = dbo.in_linea.IdCategoria AND dbo.in_grupo.IdLinea = dbo.in_linea.IdLinea INNER JOIN
                         dbo.in_categorias ON dbo.in_linea.IdEmpresa = dbo.in_categorias.IdEmpresa AND dbo.in_linea.IdCategoria = dbo.in_categorias.IdCategoria ON dbo.in_Producto.IdCategoria = dbo.in_subgrupo.IdCategoria AND 
                         dbo.in_Producto.IdLinea = dbo.in_subgrupo.IdLinea AND dbo.in_Producto.IdGrupo = dbo.in_subgrupo.IdGrupo AND dbo.in_Producto.IdSubGrupo = dbo.in_subgrupo.IdSubgrupo AND 
                         dbo.in_Producto.IdEmpresa = dbo.in_subgrupo.IdEmpresa ON dbo.ct_centro_costo.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                         dbo.ct_centro_costo.IdCentroCosto = dbo.in_Ing_Egr_Inven_det.IdCentroCosto ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.in_Ing_Egr_Inven_det.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.com_ordencompra_local_det ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia AND dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.com_ordencompra_local_det.IdProducto LEFT OUTER JOIN
                         dbo.in_Motivo_Inven ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv ON 
                         uni.IdUnidadMedida = dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.com_ordencompra_local ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND dbo.com_ordencompra_local_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra LEFT OUTER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[5] 2[5] 3) )"
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
         Top = -382
         Left = 0
      End
      Begin Tables = 
         Begin Table = "uni"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 792
               Left = 695
               Bottom = 1138
               Right = 958
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "consu"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_grupo"
            Begin Extent = 
               Top = 596
               Left = 94
               Bottom = 726
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_subgrupo"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1455
               Right = 328
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_linea"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1060
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_categorias"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1324
               Right = 267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local_det"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1587
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 495
               Left = 729
               Bottom = 624
               Right = 938
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1323
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 1590
               Left = 38
               Bottom = 1719
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 1722
               Left = 38
               Bottom = 1851
               Right = 270
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
      Begin ColumnWidths = 9
         Width = 284
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
      Begin C', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'olumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det';

