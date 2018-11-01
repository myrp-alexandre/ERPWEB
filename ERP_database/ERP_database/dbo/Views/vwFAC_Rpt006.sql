CREATE VIEW [dbo].[vwFAC_Rpt006]
AS
SELECT        dbo.fa_devol_venta.IdEmpresa, dbo.fa_devol_venta.IdSucursal, dbo.fa_devol_venta.IdBodega, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.fa_devol_venta.IdDevolucion, dbo.fa_devol_venta.CodDevolucion, dbo.fa_devol_venta.IdNota, dbo.fa_devol_venta.IdCliente, dbo.fa_devol_venta.IdVendedor, 
                         dbo.fa_devol_venta.IdCbteVta, dbo.fa_devol_venta.dv_fecha, dbo.fa_devol_venta.Estado, dbo.fa_devol_venta.dv_Observacion, dbo.fa_devol_venta.IdUsuario, 
                         dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion, ROUND(SUM(dbo.fa_devol_venta_det.dv_total) + AVG(dbo.fa_devol_venta.dv_OtroValor2) 
                         + AVG(dbo.fa_devol_venta.dv_OtroValor1) + AVG(dbo.fa_devol_venta.dv_interes) + AVG(dbo.fa_devol_venta.dv_flete) + AVG(dbo.fa_devol_venta.dv_seguro), 2) 
                         AS dv_total, ROUND(SUM(dbo.fa_devol_venta_det.dv_iva), 2) AS dv_iva, ROUND(SUM(dbo.fa_devol_venta_det.dv_subtotal), 2) AS dv_subtotal, 
                         dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_serie1 + '-' + dbo.fa_factura.vt_serie2 + '-' + dbo.fa_factura.vt_NumFactura AS vt_NumFactura
FROM            dbo.tb_persona INNER JOIN
                         dbo.fa_cliente INNER JOIN
                         dbo.fa_devol_venta ON dbo.fa_cliente.IdEmpresa = dbo.fa_devol_venta.IdEmpresa AND dbo.fa_cliente.IdCliente = dbo.fa_devol_venta.IdCliente INNER JOIN
                         dbo.fa_devol_venta_det ON dbo.fa_devol_venta.IdEmpresa = dbo.fa_devol_venta_det.IdEmpresa AND 
                         dbo.fa_devol_venta.IdSucursal = dbo.fa_devol_venta_det.IdSucursal AND dbo.fa_devol_venta.IdBodega = dbo.fa_devol_venta_det.IdBodega AND 
                         dbo.fa_devol_venta.IdDevolucion = dbo.fa_devol_venta_det.IdDevolucion INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_devol_venta.IdVendedor = dbo.fa_Vendedor.IdVendedor AND dbo.fa_devol_venta.IdEmpresa = dbo.fa_Vendedor.IdEmpresa INNER JOIN
                         dbo.tb_sucursal ON dbo.fa_devol_venta.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.fa_devol_venta.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.tb_bodega ON dbo.tb_sucursal.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.tb_sucursal.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.fa_devol_venta.IdBodega = dbo.tb_bodega.IdBodega ON dbo.tb_persona.IdPersona = dbo.fa_cliente.IdPersona INNER JOIN
                         dbo.fa_factura ON dbo.fa_devol_venta.IdEmpresa = dbo.fa_factura.IdEmpresa AND dbo.fa_devol_venta.IdSucursal = dbo.fa_factura.IdSucursal AND 
                         dbo.fa_devol_venta.IdBodega = dbo.fa_factura.IdBodega AND dbo.fa_devol_venta.IdCbteVta = dbo.fa_factura.IdCbteVta
GROUP BY dbo.tb_persona.pe_nombreCompleto, dbo.fa_devol_venta.IdEmpresa, dbo.fa_devol_venta.IdSucursal, dbo.fa_devol_venta.IdBodega, 
                         dbo.fa_devol_venta.IdDevolucion, dbo.fa_devol_venta.CodDevolucion, dbo.fa_devol_venta.IdNota, dbo.fa_devol_venta.IdCliente, dbo.fa_devol_venta.IdVendedor, 
                         dbo.fa_devol_venta.IdCbteVta, dbo.fa_devol_venta.dv_fecha, dbo.fa_devol_venta.Estado, dbo.fa_devol_venta.dv_Observacion, dbo.fa_devol_venta.IdUsuario, 
                         dbo.tb_sucursal.Su_Descripcion, dbo.tb_bodega.bo_Descripcion, dbo.fa_Vendedor.Ve_Vendedor, dbo.fa_factura.vt_serie1, dbo.fa_factura.vt_serie2, 
                         dbo.fa_factura.vt_NumFactura
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
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_devol_venta"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 315
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_devol_venta_det"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 263
            End', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 263
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt006';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt006';

