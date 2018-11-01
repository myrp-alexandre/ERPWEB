CREATE VIEW dbo.vwCOMP_Rpt001
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_NumDocumento,  OC.IdTerminoPago, OC.oc_plazo AS Plazo, 
                         OC.oc_fecha AS Fecha, OC.oc_observacion AS Observacion, OC.Estado,  OC.IdComprador, OC.IdDepartamento, 
                         OC_det.Secuencia, OC_det.IdProducto, OC_det.do_Cantidad AS cantidad, OC_det.do_precioCompra AS precio, OC_det.do_porc_des AS por_desc, 
                         OC_det.do_descuento AS valor_descuento, OC_det.do_subtotal AS subtotal, OC_det.do_iva AS iva, OC_det.do_total AS total,
                         Prod.pr_codigo AS cod_producto, Prod.pr_descripcion AS nom_producto, sucu.Su_Descripcion AS sucursal, empr.em_nombre AS empresa, 
                         empr.em_ruc AS ruc_empresa, empr.em_logo AS logo_empresa, per_prov.pe_nombreCompleto AS nom_proveedor, per_prov.pe_cedulaRuc AS ced_ruc_provee, 
                         per_prov.pe_direccion AS direc_provee, null AS telef_provee, dbo.in_UnidadMedida.Descripcion AS NomUnidad, 
                         dbo.com_comprador.Descripcion AS Nom_comprador, OC_det.IdCentroCosto, OC_det.IdCentroCosto_sub_centro_costo, 
                         dbo.ct_centro_costo.Centro_costo AS nom_centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_sub_centro_costo, 
                         OC_det.do_observacion AS Detalle_x_Items, OC_det.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, empr.em_direccion, 
                         dbo.com_solicitante.nom_solicitante, dbo.com_Motivo_Orden_Compra.Descripcion, dbo.com_TerminoPago.Descripcion AS Nom_TerminoPago, 
                         dbo.com_departamento.nom_departamento AS departamento, dbo.com_estado_cierre.Descripcion AS nom_EstadoCierre
FROM            dbo.ct_centro_costo_sub_centro_costo RIGHT OUTER JOIN
                         dbo.com_Motivo_Orden_Compra RIGHT OUTER JOIN
                         dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.com_ordencompra_local_det AS OC_det ON OC.IdEmpresa = OC_det.IdEmpresa AND OC.IdSucursal = OC_det.IdSucursal AND 
                         OC.IdOrdenCompra = OC_det.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor AS prove ON OC.IdEmpresa = prove.IdEmpresa AND OC.IdProveedor = prove.IdProveedor INNER JOIN
                         dbo.tb_sucursal AS sucu ON OC.IdEmpresa = sucu.IdEmpresa AND OC.IdSucursal = sucu.IdSucursal INNER JOIN
                         dbo.tb_empresa AS empr ON sucu.IdEmpresa = empr.IdEmpresa INNER JOIN
                         dbo.in_Producto AS Prod ON OC_det.IdEmpresa = Prod.IdEmpresa AND OC_det.IdProducto = Prod.IdProducto INNER JOIN
                         dbo.tb_persona AS per_prov ON prove.IdPersona = per_prov.IdPersona INNER JOIN
                         dbo.com_comprador ON OC.IdEmpresa = dbo.com_comprador.IdEmpresa AND OC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_TerminoPago ON OC.IdTerminoPago = dbo.com_TerminoPago.IdTerminoPago INNER JOIN
                         dbo.com_departamento ON OC.IdEmpresa = dbo.com_departamento.IdEmpresa AND OC.IdDepartamento = dbo.com_departamento.IdDepartamento INNER JOIN
                         dbo.com_estado_cierre ON OC.IdEstado_cierre = dbo.com_estado_cierre.IdEstado_cierre ON dbo.com_Motivo_Orden_Compra.IdEmpresa = OC.IdEmpresa AND 
                         dbo.com_Motivo_Orden_Compra.IdMotivo = OC.IdMotivo ON dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = OC_det.IdEmpresa AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = OC_det.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.in_UnidadMedida ON OC_det.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida LEFT OUTER JOIN
                         dbo.com_solicitante ON OC.IdEmpresa = dbo.com_solicitante.IdEmpresa AND 1 = dbo.com_solicitante.IdSolicitante LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON OC_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND OC_det.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON OC_det.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND OC_det.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[79] 4[4] 2[4] 3) )"
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
         Top = -480
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 1722
               Left = 38
               Bottom = 1851
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_estado_cierre"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC_det"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "prove"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sucu"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "empr"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 257
            End
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prod"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "per_prov"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1323
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_comprador"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1455
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_Motivo_Orden_Compra"
            Begin Extent = 
               Top = 1318
               Left = 810
               Bottom = 1447
               Right = 1019
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_TerminoPago"
            Begin Extent = 
               Top = 1590
               Left = 38
               Bottom = 1719
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_departamento"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 135
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_UnidadMedida"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_solicitante"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 1854
               Left = 38
               Bottom = 1983
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 1986
               Left = 38
               Bottom = 2115
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt001';

