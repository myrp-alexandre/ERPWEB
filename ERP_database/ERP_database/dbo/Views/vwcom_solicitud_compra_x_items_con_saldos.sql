CREATE VIEW [dbo].[vwcom_solicitud_compra_x_items_con_saldos]
AS
SELECT        isnull(ROW_NUMBER() OVER(Order by SC.IdEmpresa),0) IdRow, SC.IdEmpresa, SC.IdSucursal, SC.IdSolicitudCompra, SC.NumDocumento, SC.IdSolicitante AS IdPersona_Solicita, SC.IdDepartamento, SC.fecha, SC.plazo, 
                         SC.fecha_vtc, SC.observacion, SC.Estado, sucu.Su_Descripcion AS Sucursal, dbo.vwcom_EstadoAprobacion_sol_compra.descripcion AS nom_EstadoAprobacion, 
                         SC.IdUsuarioAprobo, SC.MotivoAprobacion, dbo.com_solicitud_compra_det.Secuencia, dbo.com_solicitud_compra_det.IdProducto, 
                         dbo.com_solicitud_compra_det.NomProducto, dbo.in_Producto.pr_codigo AS cod_producto, dbo.in_Producto.pr_descripcion AS nom_producto, 
                         dbo.com_solicitud_compra_det.IdCentroCosto, dbo.com_solicitud_compra_det.IdCentroCosto_sub_centro_costo, 
                         dbo.com_solicitud_compra_det.IdPunto_cargo_grupo, dbo.com_solicitud_compra_det.IdPunto_cargo, dbo.com_solicitud_compra_det.do_Cantidad AS cant_solicitada,
                          dbo.com_solicitud_compra_det_aprobacion.Cantidad_aprobada, ISNULL(dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.do_CantidadPedida_Oc, 
                         0) AS cant_aprobada_OC, dbo.com_solicitud_compra_det.do_Cantidad - ISNULL(dbo.com_solicitud_compra_det_aprobacion.Cantidad_aprobada, 0) 
                         AS Saldo_can_SolCom, dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.IdProveedor, 
                         dbo.com_solicitud_compra_det_aprobacion.IdEstadoAprobacion, dbo.com_solicitud_compra_det_aprobacion.IdUsuarioAprueba, 
                         dbo.com_solicitud_compra_det_aprobacion.FechaHoraAprobacion, dbo.com_solicitud_compra_det_aprobacion.observacion AS observacion_Aprob, 
                         dbo.com_solicitud_compra_det_aprobacion.IdProveedor_SC, dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.IdMotivo, 
                         dbo.com_solicitud_compra_det.IdUnidadMedida, SC.IdComprador, dbo.com_comprador.Descripcion AS Comprador, 
                         dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS Nomsub_centro_costo, dbo.com_solicitud_compra_det_aprobacion.do_precioCompra, 
                         dbo.com_solicitud_compra_det_aprobacion.do_porc_des, dbo.com_solicitud_compra_det_aprobacion.do_descuento, 
                         dbo.com_solicitud_compra_det_aprobacion.do_subtotal, dbo.com_solicitud_compra_det_aprobacion.do_iva, dbo.com_solicitud_compra_det_aprobacion.do_total, 
                         dbo.com_solicitud_compra_det_aprobacion.do_ManejaIva, dbo.com_solicitud_compra_det_aprobacion.do_observacion, 
                         dbo.vwcom_solicitud_compra_det_x_Orden_Compra.ocd_IdEmpresa, dbo.vwcom_solicitud_compra_det_x_Orden_Compra.ocd_IdSucursal, 
                         dbo.vwcom_solicitud_compra_det_x_Orden_Compra.ocd_IdOrdenCompra, 
                         dbo.com_solicitud_compra_det_pre_aprobacion.IdEstadoAprobacion AS IdEstadoPreAprobacion, dbo.com_solicitante.nom_solicitante AS Solicitante, 
                         dbo.ct_centro_costo.Centro_costo AS Nom_Centro_costo, dbo.com_departamento.nom_departamento AS departamento, 
                         dbo.vwin_Producto_Stock_x_Sucursal.Stock, in_producto_precio_minimo.precio_minimo
FROM            dbo.com_solicitante INNER JOIN
                         dbo.com_solicitud_compra AS SC INNER JOIN
                         dbo.tb_sucursal AS sucu ON SC.IdEmpresa = sucu.IdEmpresa AND SC.IdSucursal = sucu.IdSucursal INNER JOIN
                         dbo.com_solicitud_compra_det ON SC.IdEmpresa = dbo.com_solicitud_compra_det.IdEmpresa AND SC.IdSucursal = dbo.com_solicitud_compra_det.IdSucursal AND 
                         SC.IdSolicitudCompra = dbo.com_solicitud_compra_det.IdSolicitudCompra INNER JOIN
                         dbo.com_comprador ON SC.IdEmpresa = dbo.com_comprador.IdEmpresa AND SC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.vwcom_EstadoAprobacion_sol_compra INNER JOIN
                         dbo.com_solicitud_compra_det_aprobacion ON dbo.vwcom_EstadoAprobacion_sol_compra.Id = dbo.com_solicitud_compra_det_aprobacion.IdEstadoAprobacion ON 
                         dbo.com_solicitud_compra_det.IdEmpresa = dbo.com_solicitud_compra_det_aprobacion.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdSucursal = dbo.com_solicitud_compra_det_aprobacion.IdSucursal_SC AND 
                         dbo.com_solicitud_compra_det.IdSolicitudCompra = dbo.com_solicitud_compra_det_aprobacion.IdSolicitudCompra AND 
                         dbo.com_solicitud_compra_det.Secuencia = dbo.com_solicitud_compra_det_aprobacion.Secuencia_SC ON dbo.com_solicitante.IdEmpresa = SC.IdEmpresa AND 
                         dbo.com_solicitante.IdSolicitante = SC.IdSolicitante INNER JOIN
                         dbo.com_departamento ON SC.IdDepartamento = dbo.com_departamento.IdDepartamento AND SC.IdEmpresa = dbo.com_departamento.IdEmpresa LEFT OUTER JOIN
                         dbo.vwin_Producto_Stock_x_Sucursal ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.vwin_Producto_Stock_x_Sucursal.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdSucursal = dbo.vwin_Producto_Stock_x_Sucursal.IdSucursal AND 
                         dbo.com_solicitud_compra_det.IdProducto = dbo.vwin_Producto_Stock_x_Sucursal.IdProducto LEFT OUTER JOIN
                         dbo.ct_centro_costo ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.com_solicitud_compra_det_pre_aprobacion ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.com_solicitud_compra_det_pre_aprobacion.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdSucursal = dbo.com_solicitud_compra_det_pre_aprobacion.IdSucursal_SC AND 
                         dbo.com_solicitud_compra_det.IdSolicitudCompra = dbo.com_solicitud_compra_det_pre_aprobacion.IdSolicitudCompra AND 
                         dbo.com_solicitud_compra_det.Secuencia = dbo.com_solicitud_compra_det_pre_aprobacion.Secuencia_SC LEFT OUTER JOIN
                         dbo.vwcom_solicitud_compra_det_x_Orden_Compra ON 
                         dbo.com_solicitud_compra_det.IdEmpresa = dbo.vwcom_solicitud_compra_det_x_Orden_Compra.scd_IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdSucursal = dbo.vwcom_solicitud_compra_det_x_Orden_Compra.scd_IdSucursal AND 
                         dbo.com_solicitud_compra_det.IdSolicitudCompra = dbo.vwcom_solicitud_compra_det_x_Orden_Compra.scd_IdSolicitudCompra AND 
                         dbo.com_solicitud_compra_det.Secuencia = dbo.vwcom_solicitud_compra_det_x_Orden_Compra.scd_Secuencia LEFT OUTER JOIN
                         dbo.in_Producto ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdProducto = dbo.in_Producto.IdProducto LEFT OUTER JOIN
                         dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra ON 
                         dbo.com_solicitud_compra_det.IdEmpresa = dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.scd_IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdSucursal = dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.scd_IdSucursal AND 
                         dbo.com_solicitud_compra_det.IdSolicitudCompra = dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.scd_IdSolicitudCompra AND 
                         dbo.com_solicitud_compra_det.Secuencia = dbo.vwcom_ordencompra_local_det_x_cant_pedida_solic_compra.scd_Secuencia LEFT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo ON dbo.com_solicitud_compra_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                         dbo.com_solicitud_compra_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                         dbo.com_solicitud_compra_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
						 LEFT JOIN (
							SELECT        IdEmpresa, IdProducto, MIN(do_precioCompra) AS precio_minimo
							FROM            dbo.com_ordencompra_local_det
							GROUP BY IdEmpresa, IdProducto
						 ) in_producto_precio_minimo on in_producto_precio_minimo.IdEmpresa = com_solicitud_compra_det.IdEmpresa
						 and in_producto_precio_minimo.IdProducto = com_solicitud_compra_det.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[4] 2[5] 3) )"
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
         Configuration = "(H (1[74] 4[16] 2) )"
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
         Begin Table = "com_solicitante"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SC"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sucu"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_solicitud_compra_det"
            Begin Extent = 
               Top = 21
               Left = 451
               Bottom = 204
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "com_comprador"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcom_EstadoAprobacion_sol_compra"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 796
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_solicitud_compra_det_aprobacion"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 928
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_solicitud_compra_x_items_con_saldos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'            Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_departamento"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1060
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1192
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_solicitud_compra_det_pre_aprobacion"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1324
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcom_solicitud_compra_det_x_Orden_Compra"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1456
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1588
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "vwcom_ordencompra_local_det_x_cant_pedida_solic_compra"
            Begin Extent = 
               Top = 1590
               Left = 38
               Bottom = 1720
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 1722
               Left = 38
               Bottom = 1852
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_Producto_Stock_x_Sucursal"
            Begin Extent = 
               Top = 85
               Left = 862
               Bottom = 265
               Right = 1071
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
         Column = 5955
         Alias = 900
         Table = 3330
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_solicitud_compra_x_items_con_saldos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_solicitud_compra_x_items_con_saldos';

