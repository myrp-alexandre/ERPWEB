CREATE VIEW Fj_servindustrias.vwFAC_FJ_Rpt014
AS
SELECT        dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.Secuencia, 
                         dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, 
                         dbo.fa_factura_det.IdProducto, dbo.in_Producto.pr_descripcion, dbo.fa_factura_det.vt_cantidad, dbo.fa_factura_det.vt_Precio AS vt_PrecioFinal, 
                         dbo.fa_factura_det.vt_Subtotal, Fj_servindustrias.fa_factura_fj.Atencion_a, Fj_servindustrias.fa_factura_fj.num_oc, dbo.fa_factura_det.IdPunto_Cargo, 
                         dbo.ct_punto_cargo.nom_punto_cargo, dbo.fa_factura_det.vt_detallexItems AS Observacion_x_item, dbo.fa_factura.IdCliente, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, null pe_telefonoOfic, dbo.fa_factura.vt_Observacion AS Observacion_central, 
                         DAY(dbo.fa_factura.vt_fecha) AS dia, MONTH(dbo.fa_factura.vt_fecha) AS mes, YEAR(dbo.fa_factura.vt_fecha) AS anio, dbo.fa_factura_det.vt_iva, 
                         CASE WHEN dbo.fa_factura_det.vt_iva = 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_0, 
                         CASE WHEN dbo.fa_factura_det.vt_iva <> 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_iva, dbo.fa_factura_det.vt_total, 
                         CASE WHEN dbo.ct_punto_cargo.nom_punto_cargo IS NULL 
                         THEN dbo.in_Producto.pr_descripcion ELSE dbo.in_Producto.pr_descripcion + ' ' + dbo.ct_punto_cargo.nom_punto_cargo END AS nom_producto, 
                         CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '01' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_EFECTIVO, 
                         CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '17' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_DINERO_ELECTRONICO, 
                         CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '16' OR
                         dbo.fa_factura_x_formaPago.IdFormaPago = '19' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_TARJETA_CRE_DEB, 
                         CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago NOT IN ('01', '17', '16', '19') 
                         THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_CHEQUE_TRANSFERENCIA, 
                         dbo.fa_factura_det.vt_DescUnitario * dbo.fa_factura_det.vt_cantidad AS descto, dbo.in_Producto.pr_descripcion_2, 
                         dbo.fa_factura_det.IdCod_Impuesto_Iva + ' %' AS vt_por_iva
FROM            dbo.fa_factura INNER JOIN
                         dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND 
                         dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                         dbo.in_Producto ON dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto AND 
                         dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND 
                         dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona AND dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_sis_Impuesto ON dbo.fa_factura_det.IdCod_Impuesto_Iva = dbo.tb_sis_Impuesto.IdCod_Impuesto LEFT OUTER JOIN
                         dbo.fa_factura_x_formaPago ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_x_formaPago.IdEmpresa AND 
                         dbo.fa_factura.IdSucursal = dbo.fa_factura_x_formaPago.IdSucursal AND dbo.fa_factura.IdBodega = dbo.fa_factura_x_formaPago.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = dbo.fa_factura_x_formaPago.IdCbteVta LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON dbo.fa_factura_det.IdPunto_Cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                         dbo.fa_factura_det.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa LEFT OUTER JOIN
                         Fj_servindustrias.fa_factura_fj ON dbo.fa_factura.IdEmpresa = Fj_servindustrias.fa_factura_fj.IdEmpresa AND 
                         dbo.fa_factura.IdSucursal = Fj_servindustrias.fa_factura_fj.IdSucursal AND dbo.fa_factura.IdBodega = Fj_servindustrias.fa_factura_fj.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = Fj_servindustrias.fa_factura_fj.IdCbteVta
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[75] 4[4] 2[3] 3) )"
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
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura_det"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 57
               Left = 518
               Bottom = 300
               Right = 752
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura_x_formaPago"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 247
          ', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwFAC_FJ_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura_fj (Fj_servindustrias)"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
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
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwFAC_FJ_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwFAC_FJ_Rpt014';

