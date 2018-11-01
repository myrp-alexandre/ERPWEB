CREATE view [dbo].[vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det]
as
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY dbo.in_Ing_Egr_Inven_det.IdEmpresa), 0) AS IdRow, 
dbo.in_Ing_Egr_Inven_det.IdEmpresa, 
dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Ing_Egr_Inven_det.Secuencia, 
dbo.in_Ing_Egr_Inven_det.IdProducto, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.com_ordencompra_local_det.do_porc_des,  
dbo.com_ordencompra_local.IdProveedor, pe_nombreCompleto AS nom_proveedor, dbo.com_ordencompra_local_det.Por_Iva, com_ordencompra_local.oc_plazo Dias, 
dbo.com_TerminoPago.IdTerminoPago, dbo.com_TerminoPago.Descripcion, dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion dm_cantidad, 
0 dm_stock_ante, 0 dm_stock_actu, dbo.in_Ing_Egr_Inven_det.dm_observacion, 0 dm_precio, 
dbo.in_Ing_Egr_Inven_det.mv_costo_sinConversion mv_costo, 0 dm_peso, dbo.in_Ing_Egr_Inven_det.IdEstadoAproba, 
dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion IdUnidadMedida, dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc, dbo.in_Ing_Egr_Inven_det.IdSucursal_oc, 
dbo.in_Ing_Egr_Inven_det.IdOrdenCompra, dbo.in_Ing_Egr_Inven_det.Secuencia_oc, dbo.in_Ing_Egr_Inven_det.IdPunto_cargo, dbo.in_Ing_Egr_Inven_det.IdPunto_cargo_grupo, 
dbo.in_Producto.pr_descripcion AS nom_producto, dbo.ct_punto_cargo.nom_punto_cargo, dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv, dbo.in_Ing_Egr_Inven_det.IdSucursal_inv, 
dbo.in_Ing_Egr_Inven_det.IdBodega_inv, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv, dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv, 
dbo.in_Ing_Egr_Inven_det.secuencia_inv, dbo.in_Ing_Egr_Inven.signo, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.tb_bodega.bo_Descripcion AS nom_bodega, 
dbo.in_movi_inven_tipo.tm_descripcion AS nom_tipo_inv, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, '' IdNaturaleza, 
dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, dbo.in_UnidadMedida.Descripcion AS nom_medida, 
in_UnidadMedida_1.Descripcion AS nom_medida_sinConversion, dbo.in_Motivo_Inven.Desc_mov_inv AS nom_motivo, dbo.in_Ing_Egr_Inven.IdMotivo_Inv, 
dbo.in_producto_x_tb_bodega.IdCtaCble_Gasto_x_cxp, '' es_Inven_o_Consumo, 
dbo.in_producto_x_tb_bodega.IdCtaCble_Inven AS IdCtaCble_Inven_x_Produc, dbo.tb_bodega.IdCtaCtble_Inve AS IdCtaCtble_Inve_x_Bodega, 
NULL AS IdCtaCble_Inven_x_Motivo, NULL AS IdCtaCble_Costo_x_Motivo, dbo.in_Producto.IdCategoria, 
dbo.in_Producto.IdLinea, dbo.in_Producto.IdGrupo, dbo.in_Producto.IdSubGrupo, dbo.in_Ing_Egr_Inven_det.IdCentroCosto, 
dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo, dbo.in_movi_inve.cm_fecha AS Fecha_Ing_Bod
FROM            dbo.in_movi_inve RIGHT OUTER JOIN
                         dbo.tb_bodega INNER JOIN
                         dbo.com_ordencompra_local INNER JOIN
                         dbo.com_ordencompra_local_det ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.com_ordencompra_local.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.com_TerminoPago ON dbo.com_ordencompra_local.IdTerminoPago = dbo.com_TerminoPago.IdTerminoPago INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc AND 
                         dbo.com_ordencompra_local_det.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_oc AND 
                         dbo.com_ordencompra_local_det.IdOrdenCompra = dbo.in_Ing_Egr_Inven_det.IdOrdenCompra AND 
                         dbo.com_ordencompra_local_det.Secuencia = dbo.in_Ing_Egr_Inven_det.Secuencia_oc INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi INNER JOIN
                         dbo.in_Producto INNER JOIN
                         dbo.in_producto_x_tb_bodega ON dbo.in_Producto.IdEmpresa = dbo.in_producto_x_tb_bodega.IdEmpresa AND 
                         dbo.in_Producto.IdProducto = dbo.in_producto_x_tb_bodega.IdProducto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto AND dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_producto_x_tb_bodega.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_producto_x_tb_bodega.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.in_producto_x_tb_bodega.IdBodega AND 
                         dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_producto_x_tb_bodega.IdProducto ON dbo.tb_bodega.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                         dbo.tb_bodega.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND dbo.tb_bodega.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo ON 
                         dbo.in_movi_inve.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND dbo.in_movi_inve.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         dbo.in_movi_inve.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv LEFT OUTER JOIN
                         dbo.in_Motivo_Inven ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv LEFT OUTER JOIN
                         dbo.in_UnidadMedida AS in_UnidadMedida_1 ON 
                         dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion = in_UnidadMedida_1.IdUnidadMedida LEFT OUTER JOIN
                         dbo.in_UnidadMedida ON dbo.in_Ing_Egr_Inven_det.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo
						 inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[14] 4[50] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[45] 2[9] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
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
         Begin Table = "in_movi_inve"
            Begin Extent = 
               Top = 230
               Left = 0
               Bottom = 419
               Right = 263
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 192
               Left = 0
               Bottom = 321
               Right = 261
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 217
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local_det"
            Begin Extent = 
               Top = 0
               Left = 958
               Bottom = 194
               Right = 1220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_TerminoPago"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 209
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 12
               Left = 431
               Bottom = 451
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 304
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 263
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 4
               Left = 0
               Bottom = 133
               Right = 234
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 230
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 250
               Left = 0
               Bottom = 379
               Right = 215
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 257
               Left = 0
               Bottom = 492
               Right = 209
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida_1"
            Begin Extent = 
               Top = 272
               Left = 0
               Bottom = 772
               Right = 210
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 211
               Left = 0
               Bottom = 340
               Right = 210
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 204
               Left = 0
               Bottom = 333
               Right = 209
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "in_producto_x_tb_bodega"
            Begin Extent = 
               Top = 223
               Left = 0
               Bottom = 352
               Right = 290
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 232
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
      Begin ColumnWidths = 64
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
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'Width = 1500
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
         Column = 3435
         Alias = 1860
         Table = 2520
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_com_ordencompra_local_det';

