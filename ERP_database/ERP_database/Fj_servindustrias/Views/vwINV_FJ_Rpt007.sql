CREATE view [Fj_servindustrias].[vwINV_FJ_Rpt007]
as
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY dbo.in_Ing_Egr_Inven.IdEmpresa),0) AS IdFila,
dbo.in_Ing_Egr_Inven.IdEmpresa, dbo.in_Ing_Egr_Inven.IdSucursal, dbo.in_Ing_Egr_Inven.IdNumMovi, dbo.in_Ing_Egr_Inven.IdBodega, 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven.CodMoviInven, dbo.in_movi_inven_tipo.tm_descripcion AS Tipo_Movimiento, 
                         dbo.tb_empresa.em_nombre AS Empresa, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.tb_bodega.bo_Descripcion AS nom_bodega, in_UnidadMedida_1.Descripcion AS UnidadMedida, 
                         dbo.in_Ing_Egr_Inven.cm_observacion AS observacion, dbo.in_Ing_Egr_Inven.cm_fecha AS fecha, dbo.in_Ing_Egr_Inven_det.IdProducto, 
                         dbo.in_Ing_Egr_Inven_det.dm_cantidad AS cantidad, 0 AS stock_ant, 0 AS stock_act,
                          dbo.in_Ing_Egr_Inven_det.dm_observacion AS observacion_det, dbo.in_Ing_Egr_Inven_det.IdCentroCosto, 
                         dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo, dbo.in_Ing_Egr_Inven_det.IdEstadoAproba, dbo.in_Ing_Egr_Inven_det.IdPunto_cargo, 
                         dbo.in_Ing_Egr_Inven_det.IdUnidadMedida, dbo.in_movi_inve.IdEstadoDespacho_cat, dbo.in_movi_inve.Fecha_despacho, 
                         dbo.in_Ing_Egr_Inven.Fecha_Transac AS Fecha_registro, dbo.in_movi_inve.Fecha_Transac AS Fecha_ingreso, 
                         dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, 
                         dbo.in_UnidadMedida.Descripcion AS UnidadMedida_sinConversion, dbo.in_Ing_Egr_Inven_det.mv_costo_sinConversion, 
                         ct_punto_cargo.nom_punto_cargo Af_DescripcionCorta
FROM            dbo.in_UnidadMedida INNER JOIN
                         dbo.in_Producto INNER JOIN
                         dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.in_Ing_Egr_Inven INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo ON 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo ON dbo.in_Producto.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND
                          dbo.in_Producto.IdProducto = dbo.in_Ing_Egr_Inven_det.IdProducto ON 
                         dbo.in_UnidadMedida.IdUnidadMedida = dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa LEFT OUTER JOIN
                         dbo.Af_Activo_fijo INNER JOIN
                         Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo ON dbo.Af_Activo_fijo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_AF AND 
                         dbo.Af_Activo_fijo.IdActivoFijo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdActivoFijo_AF ON 
                         dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC AND 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_PC LEFT OUTER JOIN
                         dbo.tb_sucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal INNER JOIN
                         dbo.tb_empresa ON dbo.tb_sucursal.IdEmpresa = dbo.tb_empresa.IdEmpresa ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.tb_bodega.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.tb_bodega.IdSucursal AND dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.tb_bodega.IdBodega LEFT OUTER JOIN
                         dbo.in_movi_inve ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv = dbo.in_movi_inve.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_inv = dbo.in_movi_inve.IdSucursal AND dbo.in_Ing_Egr_Inven_det.IdBodega_inv = dbo.in_movi_inve.IdBodega AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv = dbo.in_movi_inve.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv = dbo.in_movi_inve.IdNumMovi LEFT OUTER JOIN
                         dbo.in_UnidadMedida AS in_UnidadMedida_1 ON dbo.in_Ing_Egr_Inven_det.IdUnidadMedida = in_UnidadMedida_1.IdUnidadMedida
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[5] 2[37] 3) )"
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
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 301
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
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_x_ct_punto_cargo (Fj_servindustrias)"
            Begin Extent = 
               Top = 798
               Left = 38
            ', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwINV_FJ_Rpt007';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Bottom = 927
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1323
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1455
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida_1"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1587
               Right = 248
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwINV_FJ_Rpt007';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwINV_FJ_Rpt007';

