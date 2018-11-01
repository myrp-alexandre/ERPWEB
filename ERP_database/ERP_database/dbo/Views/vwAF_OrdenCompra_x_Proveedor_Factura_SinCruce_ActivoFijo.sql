CREATE VIEW [dbo].[vwAF_OrdenCompra_x_Proveedor_Factura_SinCruce_ActivoFijo]
AS
SELECT        IdEmpresa, IdSucursal, IdNumMovi, Secuencia, IdBodega, IdProducto, nom_producto, dm_cantidad, mv_costo, dm_precio, dm_observacion, Fecha_Ing_Bod, 
                         nom_bodega, IdEmpresa_oc, IdSucursal_oc, IdOrdenCompra, Secuencia_oc, IdProveedor, nom_proveedor, IdAprobacion, numDocumento, Fecha_Factura, Cantidad, 
                         Costo_uni, SubTotal, PorIva, valor_Iva, Total, IdEmpresa_Ogiro, IdCbteCble_Ogiro, IdTipoCbte_Ogiro, IdOrden_giro_Tipo, IdCtaCble_Gasto, IdCtaCble_IVA, 
                         IdNaturaleza, Total -
                             (SELECT        ISNULL(SUM(Af_costo_compra), 0) AS Af_costo_compra
                               FROM            dbo.Af_Activo_fijo AS af
                               WHERE        (IdEmpresa_oc = vwAF_Orden.IdEmpresa_oc) AND (IdSucursal_oc = vwAF_Orden.IdSucursal_oc) AND (IdOrdenCompra = vwAF_Orden.IdOrdenCompra) 
                                                         AND (Secuencia_oc = vwAF_Orden.Secuencia_oc) AND (IdProducto = vwAF_Orden.IdProducto) AND (Estado = 'A')) AS Saldo_Factu
FROM            dbo.vwAF_OrdenCompra_x_Proveedor_Factura_ActivoFijo AS vwAF_Orden
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[19] 2[38] 3) )"
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
         Begin Table = "vwAF_Orden"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAF_OrdenCompra_x_Proveedor_Factura_SinCruce_ActivoFijo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAF_OrdenCompra_x_Proveedor_Factura_SinCruce_ActivoFijo';

