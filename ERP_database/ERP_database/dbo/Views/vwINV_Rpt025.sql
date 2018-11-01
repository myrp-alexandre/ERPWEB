CREATE VIEW dbo.vwINV_Rpt025
AS
SELECT        dbo.in_movi_inve_detalle.IdEmpresa, dbo.in_movi_inve_detalle.IdSucursal, dbo.in_movi_inve_detalle.IdBodega, dbo.in_movi_inve_detalle.IdMovi_inven_tipo, dbo.in_Ing_Egr_Inven_det.IdNumMovi, 
                         dbo.in_Ing_Egr_Inven_det.Secuencia, dbo.in_movi_inve_detalle.IdProducto, dbo.in_movi_inve_detalle.dm_cantidad, dbo.in_movi_inve_detalle.dm_observacion, dbo.in_Ing_Egr_Inven.cm_observacion, 
                         dbo.in_movi_inve_detalle.mv_costo, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.in_Ing_Egr_Inven.Estado, dbo.in_Ing_Egr_Inven_det.IdEstadoAproba as IdEstadoAproba, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.tb_bodega.bo_Descripcion, 
                         dbo.tb_sucursal.Su_Descripcion, dbo.in_movi_inven_tipo.tm_descripcion, dbo.in_movi_inve_detalle.dm_cantidad * dbo.in_movi_inve_detalle.mv_costo AS total, dbo.in_Ing_Egr_Inven.CodMoviInven, 
                         IIF(dbo.in_movi_inve_detalle.dm_cantidad > 0, '+', '-') signo
FROM            dbo.in_Ing_Egr_Inven_det INNER JOIN
                         dbo.in_Ing_Egr_Inven ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND dbo.in_Ing_Egr_Inven_det.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi INNER JOIN
                         dbo.in_Producto ON dbo.in_Ing_Egr_Inven_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.tb_bodega ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
                         dbo.in_movi_inve_detalle ON dbo.in_Ing_Egr_Inven_det.IdEmpresa_inv = dbo.in_movi_inve_detalle.IdEmpresa AND dbo.in_Ing_Egr_Inven_det.IdSucursal_inv = dbo.in_movi_inve_detalle.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven_det.IdBodega_inv = dbo.in_movi_inve_detalle.IdBodega AND dbo.in_Ing_Egr_Inven_det.IdMovi_inven_tipo_inv = dbo.in_movi_inve_detalle.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven_det.IdNumMovi_inv = dbo.in_movi_inve_detalle.IdNumMovi AND dbo.in_Ing_Egr_Inven_det.secuencia_inv = dbo.in_movi_inve_detalle.Secuencia
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 14
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt025';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwINV_Rpt025';

