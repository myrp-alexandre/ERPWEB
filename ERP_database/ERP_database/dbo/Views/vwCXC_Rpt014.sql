CREATE VIEW [dbo].[vwCXC_Rpt014]
AS
SELECT        A.IdEmpresa, dbo.tb_empresa.em_nombre, A.IdSucursal, A.IdCbteVta, A.vt_serie1 + '-' + A.vt_serie2 + '-' + A.vt_NumFactura AS vt_NumFactura, dbo.tb_persona.pe_nombreCompleto, 
                         dbo.fa_factura_det.vt_cantidad, dbo.fa_factura_det.vt_total, A.vt_fecha, dbo.in_Producto.pr_codigo, dbo.in_Producto.pr_descripcion, dbo.fa_Vendedor.IdVendedor, dbo.fa_Vendedor.Ve_Vendedor
FROM            dbo.fa_factura AS A INNER JOIN
                         dbo.fa_factura_det ON A.IdEmpresa = dbo.fa_factura_det.IdEmpresa AND A.IdSucursal = dbo.fa_factura_det.IdSucursal AND A.IdBodega = dbo.fa_factura_det.IdBodega AND 
                         A.IdCbteVta = dbo.fa_factura_det.IdCbteVta INNER JOIN
                         dbo.fa_cliente ON A.IdEmpresa = dbo.fa_cliente.IdEmpresa AND A.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.fa_Vendedor ON A.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND A.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                         dbo.in_Producto ON dbo.fa_factura_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_factura_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_empresa ON A.IdEmpresa = dbo.tb_empresa.IdEmpresa
WHERE A.Estado = 'A'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[42] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[59] 2[16] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[68] 3) )"
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
               Top = 0
               Left = 518
               Bottom = 313
               Right = 727
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_factura_det"
            Begin Extent = 
               Top = 0
               Left = 760
               Bottom = 303
               Right = 969
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 132
               Left = 0
               Bottom = 261
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 20
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 0
               Left = 130
               Bottom = 129
               Right = 339
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 0
               Left = 1055
               Bottom = 129
               Right = 1289
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 185
               Left = 267
               Bottom = 314
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 132
               Left = 1007
               Bottom = 261
               Right = 1226
            End
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
         Width = 284
         Width = 1020
         Width = 1515
         Width = 975
         Width = 870
         Width = 870
         Width = 1410
         Width = 1500
         Width = 1080
         Width = 885
         Width = 1500
         Width = 990
         Width = 1350
         Width = 9840
         Width = 3030
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 8130
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt014';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_Rpt014';

