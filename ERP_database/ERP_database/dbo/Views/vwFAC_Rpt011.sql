CREATE VIEW [dbo].[vwFAC_Rpt011]
AS
SELECT        devol.IdEmpresa, devol.IdSucursal, devol.IdBodega, devol.IdDevolucion, devol.CodDevolucion, devol.IdNota, devol.IdCbteVta, 
                         dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + dbo.fa_factura.vt_NumFactura + '/' + CAST(dbo.fa_factura.IdCbteVta AS varchar(20)) AS numDocumento, 
                         devol.IdCliente, devol.IdVendedor, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, null pe_telefonoCasa, 
                         dbo.tb_persona.pe_direccion, dbo.fa_Vendedor.Ve_Vendedor, devol.dv_fecha, devol.dv_Observacion, devol.dv_interes, devolDet.dv_cantidad, devolDet.dv_valor, 
                         devolDet.dv_subtotal, devolDet.dv_iva, devolDet.dv_total, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_descripcion AS nombreProducto, 
                         dbo.tb_bodega.bo_Descripcion, devol.IdUsuario, dbo.tb_sucursal.Su_Descripcion, 
                         devol.dv_OtroValor1 + devol.dv_OtroValor2 + devol.dv_flete + devol.dv_seguro AS valorFlete
FROM            dbo.fa_devol_venta AS devol INNER JOIN
                         dbo.fa_devol_venta_det AS devolDet ON devol.IdEmpresa = devolDet.IdEmpresa AND devol.IdSucursal = devolDet.IdSucursal AND 
                         devol.IdBodega = devolDet.IdBodega AND devol.IdDevolucion = devolDet.IdDevolucion INNER JOIN
                         dbo.fa_cliente ON dbo.fa_cliente.IdEmpresa = devol.IdEmpresa AND dbo.fa_cliente.IdCliente = devol.IdCliente INNER JOIN
                         dbo.fa_Vendedor ON devol.IdVendedor = dbo.fa_Vendedor.IdVendedor AND devol.IdEmpresa = dbo.fa_Vendedor.IdEmpresa INNER JOIN
                         dbo.tb_sucursal ON devol.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND devol.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_bodega ON devol.IdEmpresa = dbo.tb_bodega.IdEmpresa AND devol.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         devol.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.tb_persona ON dbo.tb_persona.IdPersona = dbo.fa_cliente.IdPersona INNER JOIN
                         dbo.fa_factura ON devol.IdEmpresa = dbo.fa_factura.IdEmpresa AND devol.IdSucursal = dbo.fa_factura.IdSucursal AND 
                         devol.IdBodega = dbo.fa_factura.IdBodega AND devol.IdCbteVta = dbo.fa_factura.IdCbteVta INNER JOIN
                         dbo.in_Producto ON devolDet.IdEmpresa = dbo.in_Producto.IdEmpresa AND devolDet.IdProducto = dbo.in_Producto.IdProducto
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
         Begin Table = "devol"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "devolDet"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 247
            End
            Displa', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'yFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 267
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt011';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt011';

