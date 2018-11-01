CREATE VIEW [dbo].[vwin_Ing_Egr_Inven_det_x_estado_aprob]
AS
SELECT        dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi, 
                         MAX(dbo.in_Ing_Egr_Inven_det.IdEstadoAproba) AS IdEstadoAproba, MAX(dbo.in_Ing_Egr_Inven_det.IdEstadoAproba) AS Descripcion, MAX(ISNULL(dbo.in_movi_inve.IdEstadoDespacho_cat, 'EST_DES_PEN')) 
                         AS IdEstadoDespacho_cat, MAX(dbo.in_Ing_Egr_Inven_det.IdEmpresa_oc) IdEmpresa_oc, MAX(dbo.in_Ing_Egr_Inven_det.IdSucursal_oc) IdSucursal_oc, MAX(dbo.in_Ing_Egr_Inven_det.IdOrdenCompra) IdOrdenCompra
FROM            dbo.in_movi_inve INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_movi_inve.IdEmpresa = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_movi_inve.IdSucursal = dbo.in_movi_inve_detalle.IdSucursal AND 
                         dbo.in_movi_inve.IdBodega = dbo.in_movi_inve_detalle.IdBodega AND dbo.in_movi_inve.IdMovi_inven_tipo = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_movi_inve.IdNumMovi = dbo.in_movi_inve_detalle.IdNumMovi RIGHT OUTER JOIN
                         dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.in_Ing_Egr_Inven_estado_apro ON dbo.in_Ing_Egr_Inven_det.IdEstadoAproba = dbo.in_Ing_Egr_Inven_estado_apro.IdEstadoAproba ON 
                         dbo.in_movi_inve_detalle.IdEmpresa = dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv AND dbo.in_movi_inve_detalle.IdSucursal = dbo.in_Ing_Egr_Inven_det.IdSucursal_inv AND 
                         dbo.in_movi_inve_detalle.IdBodega = dbo.in_Ing_Egr_Inven_det.IdBodega_inv AND dbo.in_movi_inve_detalle.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv AND 
                         dbo.in_movi_inve_detalle.IdNumMovi = dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv AND dbo.in_movi_inve_detalle.Secuencia = dbo.in_Ing_Egr_Inven_det.secuencia_inv
GROUP BY dbo.in_Ing_Egr_Inven_det.IdEmpresa, dbo.in_Ing_Egr_Inven_det.IdSucursal, dbo.in_Ing_Egr_Inven_det.IdNumMovi, dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[68] 4[5] 2[5] 3) )"
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
         Begin Table = "in_Ing_Egr_Inven_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 238
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "in_Ing_Egr_Inven_estado_apro"
            Begin Extent = 
               Top = 9
               Left = 601
               Bottom = 121
               Right = 826
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
         Column = 2940
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_estado_aprob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven_det_x_estado_aprob';

