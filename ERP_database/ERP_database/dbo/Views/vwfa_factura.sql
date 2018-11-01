CREATE VIEW vwfa_factura
AS
SELECT        dbo.fa_factura.IdEmpresa, dbo.fa_factura.IdBodega, dbo.fa_factura.IdCbteVta, dbo.fa_factura.IdSucursal, dbo.fa_factura.CodCbteVta, dbo.fa_factura.vt_tipoDoc, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, 
                         dbo.fa_factura.vt_NumFactura, dbo.fa_factura.IdCliente, dbo.fa_factura.IdVendedor, dbo.fa_factura.vt_fecha, dbo.fa_factura.vt_plazo, dbo.fa_factura.vt_fech_venc, dbo.fa_factura.vt_tipo_venta, 
                         dbo.fa_factura.vt_Observacion, dbo.fa_factura.IdPeriodo, dbo.fa_factura.vt_anio, dbo.fa_factura.vt_mes, dbo.fa_factura.IdUsuario, dbo.fa_factura.Fecha_Transaccion, dbo.fa_factura.IdUsuarioUltModi, 
                         dbo.fa_factura.Fecha_UltMod, dbo.fa_factura.IdUsuarioUltAnu, dbo.fa_factura.Fecha_UltAnu, dbo.fa_factura.MotivoAnulacion, dbo.fa_factura.Estado, dbo.tb_sucursal.Su_Descripcion, 
                         dbo.tb_bodega.bo_Descripcion, 0 AS Secuencia, dbo.fa_Vendedor.Ve_Vendedor, con.Nombres AS pe_nombreCompleto, dbo.fa_factura.vt_autorizacion, dbo.tb_persona.IdTipoDocumento, 
                         dbo.tb_persona.pe_cedulaRuc, dbo.fa_factura.IdCaja, ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.SubTotal_0, 0) + ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.SubTotal_Iva, 0) AS vt_Subtotal, 
                         ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.vt_iva, 0) AS vt_iva, ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.SubTotal_0, 0) AS SubTotal_0, 
                         ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.SubTotal_Iva, 0) AS SubTotal_Iva, ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.vt_total, 0) AS vt_total, dbo.fa_factura.IdPuntoVta, ct.cbte, 
                         ISNULL(cobro.valor_cobro, 0) AS valor_cobro, ROUND(ROUND(ISNULL(dbo.vwfa_factura_subtotal_iva_0_totales.vt_total, 0), 2) - ROUND(ISNULL(cobro.valor_cobro, 0), 2), 2) AS vt_saldo, 
                         formas_pago.IdFormaPago, dbo.fa_formaPago.nom_FormaPago, formas_pago.cant_forma_pago, dbo.fa_factura.esta_impresa, dbo.fa_factura.IdContacto, dbo.fa_factura.fecha_primera_cuota, 
                         dbo.fa_factura.valor_abono
FROM            dbo.fa_formaPago INNER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega, IdCbteVta, MAX(IdFormaPago) AS IdFormaPago, COUNT(IdFormaPago) AS cant_forma_pago
                               FROM            dbo.fa_factura_x_formaPago
                               GROUP BY IdEmpresa, IdSucursal, IdBodega, IdCbteVta) AS formas_pago ON dbo.fa_formaPago.IdFormaPago = formas_pago.IdFormaPago RIGHT OUTER JOIN
                         dbo.fa_factura INNER JOIN
                         dbo.tb_bodega ON dbo.fa_factura.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.fa_factura.IdSucursal = dbo.tb_bodega.IdSucursal AND dbo.fa_factura.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_factura.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_factura.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                         dbo.fa_cliente ON dbo.fa_factura.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_factura.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         dbo.vwfa_factura_subtotal_iva_0_totales ON dbo.fa_factura.IdEmpresa = dbo.vwfa_factura_subtotal_iva_0_totales.IdEmpresa AND 
                         dbo.fa_factura.IdSucursal = dbo.vwfa_factura_subtotal_iva_0_totales.IdSucursal AND dbo.fa_factura.IdBodega = dbo.vwfa_factura_subtotal_iva_0_totales.IdBodega AND 
                         dbo.fa_factura.IdCbteVta = dbo.vwfa_factura_subtotal_iva_0_totales.IdCbteVta LEFT OUTER JOIN
                             (SELECT        f.vt_IdEmpresa, f.vt_IdSucursal, f.vt_IdBodega, f.vt_IdCbteVta, MAX(f.ct_IdCbteCble) AS cbte
                               FROM            dbo.fa_factura_x_ct_cbtecble AS f INNER JOIN
                                                         dbo.ct_cbtecble_det AS d ON f.ct_IdEmpresa = d.IdEmpresa AND f.ct_IdTipoCbte = d.IdTipoCbte AND f.ct_IdCbteCble = d.IdCbteCble
                               GROUP BY f.vt_IdEmpresa, f.vt_IdSucursal, f.vt_IdBodega, f.vt_IdCbteVta) AS ct ON dbo.fa_factura.IdEmpresa = ct.vt_IdEmpresa AND dbo.fa_factura.IdSucursal = ct.vt_IdSucursal AND 
                         dbo.fa_factura.IdBodega = ct.vt_IdBodega AND dbo.fa_factura.IdCbteVta = ct.vt_IdCbteVta LEFT OUTER JOIN
                             (SELECT        IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento, SUM(dc_ValorPago) AS valor_cobro
                               FROM            dbo.cxc_cobro_det AS c
                               GROUP BY IdEmpresa, IdSucursal, IdBodega_Cbte, IdCbte_vta_nota, dc_TipoDocumento) AS cobro ON dbo.fa_factura.IdEmpresa = cobro.IdEmpresa AND dbo.fa_factura.IdSucursal = cobro.IdSucursal AND 
                         dbo.fa_factura.IdBodega = cobro.IdBodega_Cbte AND dbo.fa_factura.IdCbteVta = cobro.IdCbte_vta_nota AND dbo.fa_factura.vt_tipoDoc = cobro.dc_TipoDocumento ON 
                         formas_pago.IdEmpresa = dbo.fa_factura.IdEmpresa AND formas_pago.IdSucursal = dbo.fa_factura.IdSucursal AND formas_pago.IdBodega = dbo.fa_factura.IdBodega AND 
                         formas_pago.IdCbteVta = dbo.fa_factura.IdCbteVta INNER JOIN
                         dbo.fa_cliente_contactos AS con ON con.IdEmpresa = dbo.fa_factura.IdEmpresa AND con.IdCliente = dbo.fa_factura.IdCliente AND con.IdContacto = dbo.fa_factura.IdContacto

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[3] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[30] 2[35] 3) )"
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
         Begin Table = "fa_formaPago"
            Begin Extent = 
               Top = 46
               Left = 48
               Bottom = 165
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "formas_pago"
            Begin Extent = 
               Top = 43
               Left = 554
               Bottom = 263
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 55
               Left = 965
               Bottom = 218
               Right = 1188
            End
            DisplayFlags = 280
            TopColumn = 29
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 78
               Left = 1440
               Bottom = 241
               Right = 1752
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 570
               Left = 1469
               Bottom = 733
               Right = 1741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 837
               Left = 48
               Bottom = 1000
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 900
               Left = 1052
               Bottom = 1063
               Right = 1330
            End', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_factura';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 1173
               Left = 48
               Bottom = 1336
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "vwfa_factura_subtotal_iva_0_totales"
            Begin Extent = 
               Top = 1277
               Left = 633
               Bottom = 1440
               Right = 827
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct"
            Begin Extent = 
               Top = 1509
               Left = 48
               Bottom = 1672
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cobro"
            Begin Extent = 
               Top = 1677
               Left = 48
               Bottom = 1840
               Right = 273
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
      Begin ColumnWidths = 54
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4935
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2280
         Alias = 990
         Table = 1080
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1305
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_factura';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_factura';

