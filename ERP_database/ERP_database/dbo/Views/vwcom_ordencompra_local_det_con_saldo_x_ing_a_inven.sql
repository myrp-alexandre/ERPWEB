CREATE VIEW [dbo].[vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven]
AS
SELECT        dbo.com_ordencompra_local.IdEmpresa, dbo.com_ordencompra_local.IdSucursal, dbo.com_ordencompra_local.IdOrdenCompra, 
                         dbo.com_ordencompra_local_det.Secuencia AS secuencia_oc_det, dbo.tb_sucursal.Su_Descripcion AS nom_sucu, dbo.com_ordencompra_local.IdProveedor, 
                         per.pe_nombreCompleto AS nom_proveedor,  dbo.com_ordencompra_local.oc_fecha, 
                         dbo.com_ordencompra_local.oc_observacion, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         dbo.com_ordencompra_local_det.IdProducto, CASE WHEN dbo.com_ordencompra_local_det.do_precioFinal = 0 OR
                         dbo.com_ordencompra_local_det.do_precioFinal = NULL 
                         THEN dbo.com_ordencompra_local_det.do_precioCompra ELSE dbo.com_ordencompra_local_det.do_precioFinal END AS oc_precio, 
                         dbo.in_movi_inve_detalle.Secuencia AS secuencia_inv_det, dbo.com_ordencompra_local_det.do_Cantidad AS cantidad_pedida_OC, 
                         ISNULL(dbo.vwin_Producto_Stock_x_Sucursal.Stock, 0) AS pr_stock,
                         dbo.com_ordencompra_local.Estado, dbo.com_ordencompra_local.IdEstadoAprobacion_cat, 
                         CASE WHEN dbo.com_ordencompra_local_det.do_Cantidad - ISNULL(dbo.in_movi_inve_detalle.dm_cantidad_sinConversion, 0) 
                         = 0 THEN 'ING_TOTAL' WHEN dbo.com_ordencompra_local_det.do_Cantidad - ISNULL(in_Ing_Egr_Inven_det.dm_cantidad_sinConversion, 0) 
                         < dbo.com_ordencompra_local_det.do_Cantidad THEN 'ING_PARCIAL' WHEN dbo.com_ordencompra_local_det.do_Cantidad - ISNULL(in_Ing_Egr_Inven_det.dm_cantidad_sinConversion,
                          0) = dbo.com_ordencompra_local_det.do_Cantidad THEN 'PEN_X_RECI' ELSE 'PEN_X_RECI' END AS IdEstadoRecepcion, 
                         dbo.com_ordencompra_local_det.IdCentroCosto, dbo.com_ordencompra_local_det.IdCentroCosto_sub_centro_costo, 
                         dbo.com_ordencompra_local_det.IdPunto_cargo_grupo, dbo.com_ordencompra_local_det.IdPunto_cargo, 
                         dbo.com_Motivo_Orden_Compra.Descripcion AS Nom_Motivo, NULL AS Referencia, 0 IdMotivo_oc, 
                         dbo.in_Ing_Egr_Inven.cm_fecha AS Fecha_ing_bod, dbo.in_Ing_Egr_Inven.cm_observacion AS Observacion, 
                         dbo.in_movi_inve_detalle.dm_cantidad_sinConversion AS cantidad_ing_a_Inven, dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion AS cantidad_ingresada, 
                         dbo.com_ordencompra_local.IdEstado_cierre, dbo.com_estado_cierre.Descripcion AS nom_estado_cierre, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Nomsub_centro_costo, dbo.com_ordencompra_local_det.do_descuento, 
                         dbo.com_ordencompra_local_det.do_precioFinal, dbo.com_ordencompra_local_det.do_subtotal, dbo.com_ordencompra_local_det.do_iva, 
                         dbo.com_ordencompra_local_det.do_total, dbo.in_Producto.IdUnidadMedida_Consumo, dbo.in_UnidadMedida.Descripcion, 
                         dbo.com_ordencompra_local_det.IdUnidadMedida, dbo.com_ordencompra_local.oc_NumDocumento
FROM            dbo.in_Ing_Egr_Inven INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi AND 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo RIGHT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo RIGHT OUTER JOIN
                         dbo.vwin_Producto_Stock_x_Sucursal RIGHT OUTER JOIN
                         dbo.com_ordencompra_local_det INNER JOIN
                         dbo.in_Producto ON dbo.com_ordencompra_local_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdProducto = dbo.in_Producto.IdProducto ON 
                         dbo.vwin_Producto_Stock_x_Sucursal.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.vwin_Producto_Stock_x_Sucursal.IdSucursal = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.vwin_Producto_Stock_x_Sucursal.IdProducto = dbo.com_ordencompra_local_det.IdProducto LEFT OUTER JOIN
                         dbo.in_UnidadMedida ON dbo.com_ordencompra_local_det.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = dbo.com_ordencompra_local_det.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = dbo.com_ordencompra_local_det.IdCentroCosto_sub_centro_costo AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = dbo.com_ordencompra_local_det.IdEmpresa ON 
                         dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc = dbo.com_ordencompra_local_det.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_oc = dbo.com_ordencompra_local_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdOrdenCompra = dbo.com_ordencompra_local_det.IdOrdenCompra AND 
                         dbo.in_Ing_Egr_Inven_det.Secuencia_oc = dbo.com_ordencompra_local_det.Secuencia LEFT OUTER JOIN
                         dbo.tb_sucursal INNER JOIN
                         dbo.cp_proveedor INNER JOIN
                         dbo.com_ordencompra_local ON dbo.cp_proveedor.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                         dbo.cp_proveedor.IdProveedor = dbo.com_ordencompra_local.IdProveedor ON dbo.tb_sucursal.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                         dbo.tb_sucursal.IdSucursal = dbo.com_ordencompra_local.IdSucursal LEFT OUTER JOIN
                         dbo.com_Motivo_Orden_Compra ON dbo.com_ordencompra_local.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND 
                         dbo.com_ordencompra_local.IdMotivo = dbo.com_Motivo_Orden_Compra.IdMotivo LEFT OUTER JOIN
                         dbo.com_estado_cierre ON dbo.com_ordencompra_local.IdEstado_cierre = dbo.com_estado_cierre.IdEstado_cierre ON 
                         dbo.com_ordencompra_local_det.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND 
                         dbo.com_ordencompra_local_det.IdSucursal = dbo.com_ordencompra_local.IdSucursal AND 
                         dbo.com_ordencompra_local_det.IdOrdenCompra = dbo.com_ordencompra_local.IdOrdenCompra FULL OUTER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal_inv = dbo.in_movi_inve_detalle.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega_inv = dbo.in_movi_inve_detalle.IdBodega AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv = dbo.in_movi_inve_detalle.IdNumMovi AND 
                         dbo.in_Ing_Egr_Inven_det.secuencia_inv = dbo.in_movi_inve_detalle.Secuencia INNER JOIN
						 tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[8] 4[4] 2[55] 3) )"
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
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
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
         Configuration = "(H (1[18] 4[69] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[5] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[47] 2) )"
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
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 10
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 50
               Left = 1036
               Bottom = 179
               Right = 1299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 116
               Left = 707
               Bottom = 245
               Right = 970
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 1122
               Left = 59
               Bottom = 1251
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_Producto_Stock_x_Sucursal"
            Begin Extent = 
               Top = 208
               Left = 1038
               Bottom = 337
               Right = 1247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local_det"
            Begin Extent = 
               Top = 279
               Left = 217
               Bottom = 487
               Right = 480
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 197
               Left = 759
               Bottom = 576
               Right = 993
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 930
               Lef', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N't = 38
               Bottom = 1059
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_Motivo_Orden_Compra"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 34
               Left = 306
               Bottom = 163
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 34
               Left = 781
               Bottom = 163
               Right = 1011
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_estado_cierre"
            Begin Extent = 
               Top = 167
               Left = 589
               Bottom = 296
               Right = 798
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve_detalle"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1587
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 46
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
         Width = 2805
         Width = 1905
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
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 3375
         Alias = 3180
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven';

