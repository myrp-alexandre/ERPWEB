CREATE VIEW [dbo].[vwINV_Rpt015]
AS 
SELECT dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Ing_Egr_Inven_det.Secuencia, 
                  dbo.in_Ing_Egr_Inven_det.IdProducto, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.tb_bodega.cod_bodega, 
                  dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.tb_sucursal.codigo AS cod_sucursal, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, dbo.cp_proveedor.IdProveedor, dbo.cp_proveedor.pr_codigo AS cod_proveedor, 
                  pe_nombreCompleto AS nom_proveedor, dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro, 
                  dbo.ct_centro_costo.Centro_costo AS nom_centro, dbo.ct_centro_costo.IdCentroCosto, dbo.cp_orden_giro.co_factura, dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc, dbo.in_Ing_Egr_Inven_det.IdSucursal_oc, 
                  dbo.in_Ing_Egr_Inven_det.IdOrdenCompra, dbo.in_Ing_Egr_Inven_det.Secuencia_oc, dbo.in_Ing_Egr_Inven_det.IdUnidadMedida_sinConversion, ABS(dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion) 
                  AS dm_cantidad_sinConversion, dbo.in_Ing_Egr_Inven_det.mv_costo_sinConversion, ABS(dbo.in_Ing_Egr_Inven_det.dm_cantidad_sinConversion) * dbo.in_Ing_Egr_Inven_det.mv_costo_sinConversion AS Total_sinConversion, 
                  dbo.in_Ing_Egr_Inven_det.IdUnidadMedida, ABS(dbo.in_Ing_Egr_Inven_det.dm_cantidad) AS dm_cantidad, dbo.in_Ing_Egr_Inven_det.mv_costo, ABS(dbo.in_Ing_Egr_Inven_det.dm_cantidad) 
                  * dbo.in_Ing_Egr_Inven_det.mv_costo AS Total_convertido, dbo.in_Ing_Egr_Inven.signo, dbo.in_Ing_Egr_Inven_det.IdEstadoAproba, dbo.in_Ing_Egr_Inven.cm_observacion, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.in_Ing_Egr_Inven.Estado, 
                  dbo.in_movi_inven_tipo.tm_descripcion, dbo.in_movi_inven_tipo.Codigo, dbo.in_movi_inven_tipo.cm_descripcionCorta, dbo.ct_punto_cargo.nom_punto_cargo, isnull(dbo.ct_punto_cargo.IdPunto_cargo,0)IdPunto_cargo
FROM     dbo.ct_centro_costo RIGHT OUTER JOIN
                  dbo.cp_proveedor INNER JOIN
                  dbo.com_ordencompra_local ON dbo.cp_proveedor.IdEmpresa = dbo.com_ordencompra_local.IdEmpresa AND dbo.cp_proveedor.IdProveedor = dbo.com_ordencompra_local.IdProveedor RIGHT OUTER JOIN
                  dbo.in_movi_inven_tipo INNER JOIN
                  dbo.in_Ing_Egr_Inven_det INNER JOIN
                  dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                  dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi INNER JOIN
                  dbo.in_Producto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                  dbo.in_Motivo_Inven ON dbo.in_Ing_Egr_Inven.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv AND dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa ON 
                  dbo.in_movi_inven_tipo.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND dbo.in_movi_inven_tipo.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo ON 
                  dbo.com_ordencompra_local.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc AND dbo.com_ordencompra_local.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_oc AND 
                  dbo.com_ordencompra_local.IdOrdenCompra = dbo.in_Ing_Egr_Inven_det.IdOrdenCompra ON dbo.ct_centro_costo.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND 
                  dbo.ct_centro_costo.IdCentroCosto = dbo.in_Ing_Egr_Inven_det.IdCentroCosto LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON dbo.in_Ing_Egr_Inven_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AND 
                  dbo.in_Ing_Egr_Inven_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa LEFT OUTER JOIN
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det INNER JOIN
                  dbo.cp_Aprobacion_Ing_Bod_x_OC ON dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa = dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa AND 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion = dbo.cp_Aprobacion_Ing_Bod_x_OC.IdAprobacion INNER JOIN
                  dbo.cp_orden_giro ON dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa_Ogiro = dbo.cp_orden_giro.IdEmpresa AND dbo.cp_Aprobacion_Ing_Bod_x_OC.IdTipoCbte_Ogiro = dbo.cp_orden_giro.IdTipoCbte_Ogiro AND 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC.IdCbteCble_Ogiro = dbo.cp_orden_giro.IdCbteCble_Ogiro ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv AND 
                  dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv AND dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv AND 
                  dbo.in_Ing_Egr_Inven_det.Secuencia = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv AND 
                  dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdMovi_inven_tipo_Ing_Egr_Inv LEFT OUTER JOIN
                  dbo.tb_bodega INNER JOIN
                  dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.tb_bodega.IdEmpresa AND 
                  dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.tb_bodega.IdSucursal AND dbo.in_Ing_Egr_Inven_det.IdBodega = dbo.tb_bodega.IdBodega
				  inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
WHERE  (dbo.in_Motivo_Inven.Genera_Movi_Inven = 'N')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[70] 4[4] 2[4] 3) )"
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
         Top = -1826
         Left = 0
      End
      Begin Tables = 
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 1064
               Left = 38
               Bottom = 1193
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 1196
               Left = 38
               Bottom = 1325
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_Aprobacion_Ing_Bod_x_OC_det"
            Begin Extent = 
               Top = 1328
               Left = 38
               Bottom = 1457
               Right = 324
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_Aprobacion_Ing_Bod_x_OC"
            Begin Extent = 
               Top = 1460
               Left = 38
               Bottom = 1589
               Right = 267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 1592
               Left = 38
               Bottom = 1721
               Right = 297
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 1724
               Left = 38
               Bottom = 1853
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 1856
               Left = 38
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt015';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'             Bottom = 1985
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 1903
               Left = 737
               Bottom = 2177
               Right = 1000
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 2120
               Left = 38
               Bottom = 2249
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 2252
               Left = 38
               Bottom = 2381
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 2384
               Left = 38
               Bottom = 2513
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 2516
               Left = 38
               Bottom = 2645
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 2648
               Left = 38
               Bottom = 2777
               Right = 268
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt015';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt015';

