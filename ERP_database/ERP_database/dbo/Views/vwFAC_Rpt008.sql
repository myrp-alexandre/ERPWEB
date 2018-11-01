CREATE VIEW [dbo].[vwFAC_Rpt008]
AS
SELECT dbo.fa_factura_det.IdEmpresa, dbo.fa_factura_det.IdSucursal, dbo.fa_factura_det.IdBodega, dbo.fa_factura_det.IdCbteVta, dbo.fa_factura_det.Secuencia, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, 
                  dbo.fa_factura.vt_NumFactura, dbo.fa_factura.vt_fecha, dbo.fa_factura.Estado, dbo.fa_factura_det.IdProducto, dbo.in_Producto.pr_descripcion + ' - ' + pre.nom_presentacion AS pr_descripcion, dbo.fa_factura_det.vt_cantidad, 
                  dbo.fa_factura_det.vt_Precio, dbo.fa_factura_det.vt_Subtotal, dbo.fa_factura_det.vt_detallexItems AS Observacion_x_item, dbo.fa_factura.IdCliente, con.Nombres AS pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 
                  con.Direccion AS pe_direccion, con.Telefono AS pe_telefonoOfic, dbo.fa_factura.vt_Observacion AS Observacion_central, DAY(dbo.fa_factura.vt_fecha) AS dia, MONTH(dbo.fa_factura.vt_fecha) AS mes, YEAR(dbo.fa_factura.vt_fecha) 
                  AS anio, dbo.fa_factura_det.vt_iva, CASE WHEN dbo.fa_factura_det.vt_iva = 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_0, 
                  CASE WHEN dbo.fa_factura_det.vt_iva <> 0 THEN dbo.fa_factura_det.vt_Subtotal ELSE 0 END AS subtotal_iva, dbo.fa_factura_det.vt_total, 
                  CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '01' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_EFECTIVO, 
                  CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '17' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_DINERO_ELECTRONICO, CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago = '16' OR
                  dbo.fa_factura_x_formaPago.IdFormaPago = '19' THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_TARJETA_CRE_DEB, CASE WHEN dbo.fa_factura_x_formaPago.IdFormaPago NOT IN ('01', '17', '16', '19') 
                  THEN dbo.fa_factura_det.vt_total ELSE 0 END AS forma_pago_CHEQUE_TRANSFERENCIA, dbo.fa_factura_det.vt_DescUnitario * dbo.fa_factura_det.vt_cantidad AS descto, dbo.in_Producto.pr_descripcion_2, 
                  dbo.fa_factura_det.IdCod_Impuesto_Iva + ' %' AS vt_por_iva, dbo.tb_ciudad.Descripcion_Ciudad, dbo.fa_Vendedor.Codigo, dbo.fa_factura_det.vt_PorDescUnitario, dbo.fa_factura_det.vt_DescUnitario, dbo.fa_factura_det.vt_PrecioFinal, 
                  dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_fech_venc, dbo.in_Producto.lote_fecha_fab, dbo.in_Producto.lote_fecha_vcto, dbo.in_Producto.lote_num_lote, dbo.tb_persona.pe_razonSocial
FROM     dbo.fa_factura INNER JOIN
                  dbo.fa_factura_det ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_det.IdSucursal AND dbo.fa_factura.IdBodega = dbo.fa_factura_det.IdBodega AND 
                  dbo.fa_factura.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                  dbo.in_Producto ON dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto AND dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND 
                  dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                  dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                  dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                  dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona AND dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                  dbo.tb_sis_Impuesto ON dbo.fa_factura_det.IdCod_Impuesto_Iva = dbo.tb_sis_Impuesto.IdCod_Impuesto INNER JOIN
                  dbo.fa_cliente_contactos AS con ON con.IdEmpresa = dbo.fa_cliente.IdEmpresa AND con.IdCliente = dbo.fa_cliente.IdCliente AND dbo.fa_factura.IdEmpresa = con.IdEmpresa AND dbo.fa_factura.IdCliente = con.IdCliente AND 
                  dbo.fa_factura.IdContacto = con.IdContacto INNER JOIN
                  dbo.tb_ciudad ON con.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                  dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor LEFT OUTER JOIN
                  dbo.fa_factura_x_formaPago ON dbo.fa_factura.IdEmpresa = dbo.fa_factura_x_formaPago.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.fa_factura_x_formaPago.IdSucursal AND 
                  dbo.fa_factura.IdBodega = dbo.fa_factura_x_formaPago.IdBodega AND dbo.fa_factura.IdCbteVta = dbo.fa_factura_x_formaPago.IdCbteVta INNER JOIN
                  dbo.in_presentacion AS pre ON pre.IdEmpresa = dbo.in_Producto.IdEmpresa AND pre.IdPresentacion = dbo.in_Producto.IdPresentacion
UNION ALL
select c.IdEmpresa, c.IdSucursal, c.IdBodega, c.IdCbteVta, 99, c.vt_tipoDoc, c.vt_serie1, c.vt_serie2, c.vt_NumFactura, c.vt_fecha,
c.Estado, 0, c.vt_Observacion,0,0,0,'', c.IdCliente, con.Nombres, per.pe_cedulaRuc, con.Direccion, con.Telefono, c.vt_Observacion,
day(c.vt_fecha), month(c.vt_fecha), year(c.vt_fecha), 0, 0, 0, 0, 0, 0, 0, 0, 0, c.vt_Observacion, '',ciu.Descripcion_Ciudad,'',0,0,0,
ve.Ve_Vendedor, c.vt_fech_venc,NULL,NULL,NULL,PER.pe_razonSocial
from fa_factura as c inner join fa_cliente as cli on cli.IdEmpresa = c.IdEmpresa and cli.IdCliente = c.IdCliente
inner join fa_cliente_contactos as con on con.IdEmpresa = c.IdEmpresa and con.IdCliente = c.IdCliente and con.IdContacto = c.IdContacto
inner join tb_persona as per on cli.IdPersona = per.IdPersona inner join tb_ciudad as ciu on con.IdCiudad = ciu.IdCiudad
inner join fa_Vendedor as ve on ve.IdEmpresa = c.IdEmpresa and ve.IdVendedor = c.IdVendedor
where c.vt_Observacion is not null and c.vt_Observacion <> ''
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
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[86] 2[3] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
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
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 267
               Left = 580
               Bottom = 566
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura_det"
            Begin Extent = 
               Top = 395
               Left = 945
               Bottom = 638
               Right = 1208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 155
               Left = 1281
               Bottom = 636
               Right = 1515
            End
            DisplayFlags = 280
            TopColumn = 26
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 223
               Left = 2
               Bottom = 450
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 169
               Left = 1256
               Bottom = 420
               Right = 1488
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sis_Impuesto"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "con"
            Begin Extent = 
               Top = 370
               Left = 321
               Bottom = 585
               Right = 491
            End
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt008';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_ciudad"
            Begin Extent = 
               Top = 6
               Left = 548
               Bottom = 136
               Right = 742
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 70
               Left = 882
               Bottom = 348
               Right = 1086
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura_x_formaPago"
            Begin Extent = 
               Top = 154
               Left = 790
               Bottom = 283
               Right = 999
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pre"
            Begin Extent = 
               Top = 420
               Left = 38
               Bottom = 550
               Right = 225
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
      Begin ColumnWidths = 49
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
         Width = 4515
         Width = 1500
         Width = 2055
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
         Width = 75
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt008';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt008';

