CREATE VIEW [dbo].[vwin_movi_inve_x_despachar]
AS
SELECT        dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi AS num_Trans, dbo.in_Ing_Egr_Inven.signo, dbo.in_Ing_Egr_Inven.CodMoviInven, dbo.in_movi_inve.IdEstadoDespacho_cat, dbo.in_Ing_Egr_Inven.cm_fecha, 
                         dbo.in_Ing_Egr_Inven.Estado, dbo.tb_bodega.bo_Descripcion, dbo.tb_sucursal.Su_Descripcion, dbo.in_movi_inve.cm_observacion, dbo.in_movi_inven_tipo.tm_descripcion AS nom_TipoMovi, 
                         dbo.in_Catalogo.Nombre AS nom_EstadoDespacho, dbo.in_movi_inve.IdNumMovi
FROM            dbo.tb_bodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_Ing_Egr_Inven INNER JOIN
                         dbo.in_Ing_Egr_Inven_det ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo AND dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal_inv = dbo.in_movi_inve_detalle.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega_inv = dbo.in_movi_inve_detalle.IdBodega AND dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv = dbo.in_movi_inve_detalle.IdNumMovi AND dbo.in_Ing_Egr_Inven_det.secuencia_inv = dbo.in_movi_inve_detalle.Secuencia INNER JOIN
                         dbo.in_movi_inve ON dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_movi_inve.IdEmpresa AND dbo.in_movi_inve_detalle.IdSucursal = dbo.in_movi_inve.IdSucursal AND 
                         dbo.in_movi_inve_detalle.IdBodega = dbo.in_movi_inve.IdBodega AND dbo.in_movi_inve_detalle.IdMovi_inven_tipo = dbo.in_movi_inve.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve_detalle.IdNumMovi = dbo.in_movi_inve.IdNumMovi ON dbo.tb_bodega.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.tb_bodega.IdBodega = dbo.in_Ing_Egr_Inven.IdBodega INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo LEFT OUTER JOIN
                         dbo.in_Catalogo ON dbo.in_movi_inve.IdEstadoDespacho_cat = dbo.in_Catalogo.IdCatalogo
GROUP BY dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Ing_Egr_Inven.signo, 
                         dbo.in_Ing_Egr_Inven.CodMoviInven, dbo.in_movi_inve.IdEstadoDespacho_cat, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.in_Ing_Egr_Inven.Estado, dbo.tb_bodega.bo_Descripcion, dbo.tb_sucursal.Su_Descripcion, 
                         dbo.in_movi_inve.cm_observacion, dbo.in_movi_inven_tipo.tm_descripcion, dbo.in_Catalogo.Nombre, dbo.in_Ing_Egr_Inven_det.IdBodega, dbo.in_movi_inve.IdNumMovi
HAVING        (dbo.in_Ing_Egr_Inven.Estado = 'A') AND (dbo.in_Ing_Egr_Inven.signo = '-') AND (dbo.in_movi_inve.IdEstadoDespacho_cat <> 'EST_DES_DES' OR dbo.in_movi_inve.IdEstadoDespacho_cat IS NULL) 
                         and max(dbo.in_Ing_Egr_Inven_det.IdEstadoAproba) = 'APRO'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[18] 4[3] 2[40] 3) )"
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
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 315
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve_detalle"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inve"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_despachar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Catalogo"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 263
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
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_despachar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_movi_inve_x_despachar';

