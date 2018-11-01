CREATE VIEW [dbo].[vwin_movi_inve_x_cbteCble_Datos]
AS
SELECT        dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Ing_Egr_Inven.cm_observacion, dbo.in_movi_inve.cm_observacion AS cm_observacion_inv, 
                         dbo.in_movi_inve.cm_fecha, dbo.vwtb_bodega_x_tb_sucursal.Su_Descripcion, dbo.vwtb_bodega_x_tb_sucursal.bo_Descripcion, dbo.in_movi_inven_tipo.cm_tipo_movi, dbo.in_movi_inven_tipo.cm_descripcionCorta, 
                         CAST(dbo.in_Ing_Egr_Inven_det.Secuencia AS int) AS Secuencia, dbo.in_movi_inve_detalle.IdProducto, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, 
                         dbo.in_movi_inve_detalle.dm_observacion, dbo.in_movi_inve_detalle.dm_cantidad, dbo.in_movi_inve_detalle.mv_costo, dbo.in_movi_inve_detalle.IdCentroCosto, 
                         dbo.in_movi_inve_detalle.IdPunto_cargo_grupo, dbo.in_movi_inve_detalle.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_cbtecble_tipo.tc_TipoCbte, 
                         dbo.ct_cbtecble.cb_Fecha, dbo.in_movi_inve_x_ct_cbteCble.IdEmpresa_ct, dbo.in_movi_inve_x_ct_cbteCble.IdTipoCbte, 
                         dbo.in_movi_inve_x_ct_cbteCble.IdCbteCble, CASE WHEN dbo.in_movi_inve_x_ct_cbteCble.IdCbteCble IS NULL 
                         THEN 'NO CONTABILIZADO' ELSE 'CONTABILIZADO' END AS Tipo_Contabilizado, dbo.in_movi_inve.IdEmpresa AS IdEmpresa_inv, 
                         dbo.in_movi_inve.IdSucursal AS IdSucursal_inv, dbo.in_movi_inve.IdBodega AS IdBodega_inv, dbo.in_movi_inve.IdMovi_inven_tipo AS IdMovi_inven_tipo_inv, 
                         dbo.in_movi_inve.IdNumMovi AS IdNumMovi_inv, dbo.in_movi_inven_tipo.tm_descripcion
                         
FROM            dbo.in_movi_inve INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND 
                         dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi INNER JOIN
                         dbo.in_Producto ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.in_movi_inve_detalle.IdProducto = dbo.in_Producto.IdProducto LEFT OUTER JOIN
                         dbo.vwtb_bodega_x_tb_sucursal ON dbo.in_movi_inve.IdEmpresa = dbo.vwtb_bodega_x_tb_sucursal.IdEmpresa AND 
                         dbo.in_movi_inve.IdSucursal = dbo.vwtb_bodega_x_tb_sucursal.IdSucursal AND 
                         dbo.in_movi_inve.IdBodega = dbo.vwtb_bodega_x_tb_sucursal.IdBodega LEFT OUTER JOIN
                         dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND 
                         dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND
                          dbo.in_movi_inve_detalle.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         dbo.in_movi_inve_detalle.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND 
                         dbo.in_movi_inve_detalle.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         dbo.in_movi_inve_detalle.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND 
                         dbo.in_movi_inve_detalle.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.in_movi_inve_detalle.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                         dbo.in_movi_inve_detalle.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa LEFT OUTER JOIN
                         dbo.ct_cbtecble INNER JOIN
                         dbo.in_movi_inve_x_ct_cbteCble ON dbo.ct_cbtecble.IdEmpresa = dbo.in_movi_inve_x_ct_cbteCble.IdEmpresa_ct AND 
                         dbo.ct_cbtecble.IdTipoCbte = dbo.in_movi_inve_x_ct_cbteCble.IdTipoCbte AND dbo.ct_cbtecble.IdCbteCble = dbo.in_movi_inve_x_ct_cbteCble.IdCbteCble INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.ct_cbtecble.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND dbo.ct_cbtecble.IdTipoCbte = dbo.ct_cbtecble_tipo.IdTipoCbte ON 
                         dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_x_ct_cbteCble.IdEmpresa AND dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_x_ct_cbteCble.IdSucursal AND 
                         dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_x_ct_cbteCble.IdBodega AND 
                         dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_x_ct_cbteCble.IdNumMovi
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[77] 2[4] 3) )"
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
         Configuration = "(H (1[56] 4[29] 2) )"
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
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 0
               Left = 544
               Bottom = 334
               Right = 807
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve"
            Begin Extent = 
               Top = 347
               Left = 791
               Bottom = 620
               Right = 1054
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve_detalle"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_cbteCble_Datos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 272
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
         Begin Table = "ct_cbtecble"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve_x_ct_cbteCble"
            Begin Extent = 
               Top = 47
               Left = 376
               Bottom = 176
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 9
               Left = 1017
               Bottom = 254
               Right = 1280
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
      Begin ColumnWidths = 29
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
         Width = 2175
         Width = 1485
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
         Column = 5250
         Alias = 2355
         Table = 4440
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_cbteCble_Datos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_cbteCble_Datos';

