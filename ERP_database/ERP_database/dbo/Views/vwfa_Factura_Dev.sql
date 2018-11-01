CREATE VIEW [dbo].[vwfa_Factura_Dev]
AS
SELECT        dbo.vwfa_factura.IdEmpresa, dbo.vwfa_factura.IdBodega, dbo.vwfa_factura.IdCbteVta, dbo.vwfa_factura.IdSucursal, dbo.vwfa_factura.CodCbteVta, 
                         dbo.vwfa_factura.vt_tipoDoc, dbo.vwfa_factura.vt_serie1, dbo.vwfa_factura.vt_serie2, dbo.vwfa_factura.vt_NumFactura, dbo.vwfa_factura.IdCliente, 
                         dbo.vwfa_factura.IdVendedor, dbo.vwfa_factura.vt_fecha, dbo.vwfa_factura.vt_plazo, dbo.vwfa_factura.vt_fech_venc, dbo.vwfa_factura.vt_tipo_venta, 
                         dbo.vwfa_factura.vt_Observacion, dbo.vwfa_factura.IdPeriodo, dbo.vwfa_factura.vt_anio, dbo.vwfa_factura.vt_mes,  
                         dbo.vwfa_factura.IdUsuario, dbo.vwfa_factura.Fecha_Transaccion, 
                         dbo.vwfa_factura.IdUsuarioUltModi, dbo.vwfa_factura.Fecha_UltMod, dbo.vwfa_factura.IdUsuarioUltAnu, dbo.vwfa_factura.Fecha_UltAnu, 
                         dbo.vwfa_factura.MotivoAnulacion, dbo.vwfa_factura.Estado, dbo.vwfa_factura.Su_Descripcion, 
                         dbo.vwfa_factura.bo_Descripcion, dbo.vwfa_factura.vt_Subtotal, dbo.vwfa_factura.vt_iva, dbo.vwfa_factura.vt_total, 0 AS Expr1, 
                         '' as vt_detallexItems, 0 as vt_PrecioFinal, 0 as vt_DescUnitario, 0 as vt_PorDescUnitario, 
                         0 as vt_Precio, 0 as vt_cantidad, 0 as IdProducto, 0 as Secuencia, dbo.vwfa_factura.pe_nombreCompleto, 
                         dbo.vwfa_factura.vt_autorizacion, dbo.vwfa_factura.Ve_Vendedor, dbo.vwFa_FacturasConDevolucionxItemSaldos.dv_saldo, dbo.vwfa_factura.IdCaja
FROM            dbo.vwfa_factura INNER JOIN
                         dbo.vwFa_FacturasConDevolucionxItemSaldos ON dbo.vwfa_factura.IdEmpresa = dbo.vwFa_FacturasConDevolucionxItemSaldos.IdEmpresa AND 
                         dbo.vwfa_factura.IdBodega = dbo.vwFa_FacturasConDevolucionxItemSaldos.IdBodega AND 
                         dbo.vwfa_factura.IdSucursal = dbo.vwFa_FacturasConDevolucionxItemSaldos.IdSucursal AND 
                         dbo.vwfa_factura.IdCbteVta = dbo.vwFa_FacturasConDevolucionxItemSaldos.IdCbteVta
WHERE        (dbo.vwFa_FacturasConDevolucionxItemSaldos.dv_saldo > 0)
GROUP BY dbo.vwfa_factura.IdEmpresa, dbo.vwfa_factura.IdBodega, dbo.vwfa_factura.IdCbteVta, dbo.vwfa_factura.IdSucursal, dbo.vwfa_factura.CodCbteVta, 
                         dbo.vwfa_factura.vt_tipoDoc, dbo.vwfa_factura.vt_serie1, dbo.vwfa_factura.vt_serie2, dbo.vwfa_factura.vt_NumFactura, dbo.vwfa_factura.IdCliente, 
                         dbo.vwfa_factura.IdVendedor, dbo.vwfa_factura.vt_fecha, dbo.vwfa_factura.vt_plazo, dbo.vwfa_factura.vt_fech_venc, dbo.vwfa_factura.vt_tipo_venta, 
                         dbo.vwfa_factura.vt_Observacion, dbo.vwfa_factura.IdPeriodo, dbo.vwfa_factura.vt_anio, dbo.vwfa_factura.vt_mes, 
                         dbo.vwfa_factura.IdUsuario, dbo.vwfa_factura.Fecha_Transaccion, 
                         dbo.vwfa_factura.IdUsuarioUltModi, dbo.vwfa_factura.Fecha_UltMod, dbo.vwfa_factura.IdUsuarioUltAnu, dbo.vwfa_factura.Fecha_UltAnu, 
                         dbo.vwfa_factura.MotivoAnulacion, dbo.vwfa_factura.Estado, dbo.vwfa_factura.Su_Descripcion, 
                         dbo.vwfa_factura.bo_Descripcion, dbo.vwfa_factura.vt_Subtotal, dbo.vwfa_factura.vt_iva, dbo.vwfa_factura.vt_total, 
                         dbo.vwfa_factura.Secuencia, dbo.vwfa_factura.pe_nombreCompleto, 
                         dbo.vwfa_factura.vt_autorizacion, dbo.vwfa_factura.Ve_Vendedor, dbo.vwFa_FacturasConDevolucionxItemSaldos.dv_saldo, dbo.vwfa_factura.IdCaja
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[4] 3[4] 2) )"
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
         Begin Table = "vwfa_factura"
            Begin Extent = 
               Top = 19
               Left = 126
               Bottom = 199
               Right = 330
            End
            DisplayFlags = 280
            TopColumn = 51
         End
         Begin Table = "vwFa_FacturasConDevolucionxItemSaldos"
            Begin Extent = 
               Top = 59
               Left = 584
               Bottom = 178
               Right = 781
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 53
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
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_Factura_Dev';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_Factura_Dev';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_Factura_Dev';

