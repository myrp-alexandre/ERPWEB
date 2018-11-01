CREATE VIEW [dbo].[vwin_Guia_x_traspaso_bodega_det]
AS
SELECT        Guia.IdEmpresa, Guia.IdGuia, 'con_oc' AS TipoDetalle, Guia.secuencia, Guia.IdEmpresa_OC, Guia.IdSucursal_OC, Guia.IdOrdenCompra_OC, Guia.Secuencia_OC, Guia.observacion, oc_det.IdProducto, 
                         Guia.Cantidad_enviar, prod.pr_descripcion, oc_det.do_Cantidad CantOC, oc_det.do_observacion AS Observacion_OC, NULL Num_Fact, NULL IdProveedor, NULL nom_proveedor, Referencia
FROM            in_Guia_x_traspaso_bodega_det AS Guia INNER JOIN
                         com_ordencompra_local_det AS oc_det ON Guia.IdEmpresa_OC = oc_det.IdEmpresa AND Guia.IdSucursal_OC = oc_det.IdSucursal AND Guia.IdOrdenCompra_OC = oc_det.IdOrdenCompra AND 
                         Guia.Secuencia_OC = oc_det.Secuencia INNER JOIN
                         in_Producto AS prod ON oc_det.IdEmpresa = prod.IdEmpresa AND oc_det.IdProducto = prod.IdProducto
UNION
SELECT        IdEmpresa, IdGuia, 'sin_oc' AS TipoDetalle, secuencia, NULL, NULL, NULL, NULL, observacion, IdProducto, Cantidad_enviar, nom_producto, NULL, NULL, Num_Fact, IdProveedor, nom_proveedor, null
FROM            in_Guia_x_traspaso_bodega_det_sin_oc
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Guia_x_traspaso_bodega_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Guia_x_traspaso_bodega_det';

