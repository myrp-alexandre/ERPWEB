CREATE view [dbo].[vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven_con_saldo]
as
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY IdEmpresa),0) AS fila, IdEmpresa, IdSucursal, IdOrdenCompra, secuencia_oc_det, nom_sucu, IdProveedor, nom_proveedor,  
oc_fecha, oc_observacion, cod_producto, nom_producto, IdProducto, AVG(oc_precio) AS oc_precio, AVG(cantidad_pedida_OC) AS cantidad_pedida_OC, 
SUM(ISNULL(cantidad_ing_a_Inven, 0)) AS cantidad_ing_a_Inven, SUM(ISNULL(cantidad_ingresada, 0)) AS cantidad_ingresada, AVG(cantidad_pedida_OC) 
- SUM(ISNULL(cantidad_ingresada, 0)) AS Saldo_OC_x_Ing, AVG(pr_stock) AS pr_stock, 0 AS pr_peso, 0 AS CostoProducto, Estado, 
IdEstadoAprobacion_cat, CASE WHEN AVG(cantidad_pedida_OC) - SUM(cantidad_ing_a_Inven) = 0 THEN 'ING_TOTAL' WHEN AVG(cantidad_pedida_OC) 
- SUM(cantidad_ing_a_Inven) < SUM(cantidad_ing_a_Inven) THEN 'ING_PARCIAL' WHEN AVG(cantidad_pedida_OC) - SUM(cantidad_ing_a_Inven) = SUM(cantidad_ing_a_Inven) 
THEN 'PEN_X_RECI' ELSE 'PEN_X_RECI' END AS IdEstadoRecepcion, IdCentroCosto, IdCentroCosto_sub_centro_costo, IdPunto_cargo_grupo, IdPunto_cargo, IdUnidadMedida, 
IdMotivo_oc, Nom_Motivo, IdEstado_cierre, nom_estado_cierre, Nomsub_centro_costo, SUM(do_descuento) AS do_descuento, SUM(do_subtotal) AS do_subtotal, SUM(do_iva) 
AS do_iva, SUM(do_total) AS do_total, IdUnidadMedida_Consumo, Descripcion, oc_NumDocumento
FROM            dbo.vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven
GROUP BY IdEmpresa, IdSucursal, IdOrdenCompra, secuencia_oc_det, nom_sucu, IdProveedor, nom_proveedor,  oc_fecha, oc_observacion, cod_producto, nom_producto, 
                         IdProducto, Estado, IdEstadoAprobacion_cat, IdCentroCosto, IdCentroCosto_sub_centro_costo, IdPunto_cargo_grupo, IdPunto_cargo, IdUnidadMedida, IdMotivo_oc, 
                         Nom_Motivo, IdEstado_cierre, nom_estado_cierre, Nomsub_centro_costo, IdUnidadMedida_Consumo, Descripcion, oc_NumDocumento
HAVING        (IdEmpresa IS NOT NULL)
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
         Configuration = "(H (1[30] 2[45] 3) )"
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
      ActivePaneConfig = 2
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
      Begin ColumnWidths = 42
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven_con_saldo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det_con_saldo_x_ing_a_inven_con_saldo';

