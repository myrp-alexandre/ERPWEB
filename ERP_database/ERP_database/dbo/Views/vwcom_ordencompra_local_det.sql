CREATE view [dbo].[vwcom_ordencompra_local_det]
as
SELECT        IdEmpresa, IdSucursal, IdOrdenCompra, Secuencia, IdProducto, do_Cantidad, do_precioCompra, do_porc_des, do_descuento, do_precioFinal, do_subtotal, do_iva, 
                         do_total, do_observacion, Tiene_Movi_Inven, IdCentroCosto, IdCentroCosto_sub_centro_costo, IdPunto_cargo_grupo, 
                         IdPunto_cargo, IdUnidadMedida, nom_sub_centro_costo, oc_fecha, oc_observacion, Su_Descripcion, IdMotivo, nom_motivo_OC, pr_descripcion, nom_medida, 
                         IdUnidadMedida_Consumo, Por_Iva, IdCod_Impuesto
FROM            (SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.Secuencia, OC.IdProducto, OC.do_Cantidad, OC.do_precioCompra, OC.do_porc_des, 
                                                    OC.do_descuento, OC.do_precioFinal, OC.do_subtotal, OC.do_iva, OC.do_total,  OC.do_observacion, 
                                                    CASE WHEN OC_x_MOVI.mi_IdEmpresa IS NULL THEN 'N' ELSE 'S' END AS Tiene_Movi_Inven, OC.IdCentroCosto, OC.IdCentroCosto_sub_centro_costo, 
                                                    OC.IdPunto_cargo_grupo, OC.IdPunto_cargo, OC.IdUnidadMedida, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_sub_centro_costo, 
                                                    dbo.vwcom_ordencompra_local.oc_fecha, dbo.vwcom_ordencompra_local.oc_observacion, dbo.vwcom_ordencompra_local.Su_Descripcion, 
                                                    dbo.vwcom_ordencompra_local.IdMotivo, dbo.vwcom_ordencompra_local.nom_motivo_OC, dbo.in_Producto.pr_descripcion, 
                                                    dbo.in_UnidadMedida.Descripcion AS nom_medida, dbo.in_Producto.IdUnidadMedida_Consumo, OC.Por_Iva, OC.IdCod_Impuesto
                          FROM            dbo.com_ordencompra_local_det AS OC INNER JOIN
                                                    dbo.vwcom_ordencompra_local ON OC.IdEmpresa = dbo.vwcom_ordencompra_local.IdEmpresa AND 
                                                    OC.IdSucursal = dbo.vwcom_ordencompra_local.IdSucursal AND OC.IdOrdenCompra = dbo.vwcom_ordencompra_local.IdOrdenCompra INNER JOIN
                                                    dbo.in_Producto ON OC.IdEmpresa = dbo.in_Producto.IdEmpresa AND OC.IdProducto = dbo.in_Producto.IdProducto LEFT OUTER JOIN
                                                    dbo.in_UnidadMedida ON OC.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida LEFT OUTER JOIN
                                                    dbo.ct_centro_costo_sub_centro_costo ON OC.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                                                    OC.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                                                    OC.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                                                    dbo.in_movi_inve_detalle_x_com_ordencompra_local_det AS OC_x_MOVI ON OC.IdEmpresa = OC_x_MOVI.ocd_IdEmpresa AND 
                                                    OC.IdSucursal = OC_x_MOVI.ocd_IdSucursal AND OC.IdOrdenCompra = OC_x_MOVI.ocd_IdOrdenCompra AND 
                                                    OC.Secuencia = OC_x_MOVI.ocd_Secuencia) AS a
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[26] 2[15] 3) )"
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
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 10
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
               Left = 436
               Bottom = 355
               Right = 699
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 0
               Left = 39
               Bottom = 324
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 11
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 37
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
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2460
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local_det';

