CREATE VIEW [dbo].[vwFAC_Rpt003]
AS
SELECT        cabfac.IdEmpresa, cabfac.IdSucursal, cabfac.IdBodega, cabfac.vt_tipoDoc, SUBSTRING(cabfac.vt_tipoDoc, 1, 2) 
                         + '-' + cabfac.vt_serie1 + '-' + cabfac.vt_serie2 + '-' + cabfac.vt_NumFactura + '/' + CAST(cabfac.IdCbteVta AS varchar(100)) AS vt_NunDocumento, 
                         cabfac.vt_Observacion AS Referencia, cabfac.IdCbteVta AS IdComprobante, cabfac.CodCbteVta AS CodComprobante, Sucu.Su_Descripcion, cabfac.IdCliente, 
                         dbo.tb_persona.pe_nombreCompleto AS nombreCliente, cabfac.vt_fecha, ROUND(SUM(detfac.vt_total), 2) AS vt_total, ROUND(SUM(detfac.vt_total), 2) - ROUND(ISNULL(AVG(dbo.vwcxc_total_cobros_x_Docu.dc_ValorPago), 0), 2) AS Saldo, 
                         ISNULL(AVG(dbo.vwcxc_total_cobros_x_Docu.dc_ValorPago), 0) AS TotalCobrado, ROUND(SUM(detfac.vt_Subtotal), 2) AS vt_Subtotal, ROUND(SUM(detfac.vt_iva), 2) 
                         AS vt_iva, cabfac.vt_fech_venc, cabfac.vt_plazo, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_descripcion AS nombreProducto, ROUND(SUM(detfac.vt_cantidad), 
                         2) AS sc_cantidad, ROUND(SUM(detfac.vt_PrecioFinal), 2) AS sc_precioFinal, cabfac.IdUsuario
FROM            dbo.fa_factura_det AS detfac INNER JOIN
                         dbo.fa_factura AS cabfac ON detfac.IdBodega = cabfac.IdBodega AND detfac.IdSucursal = cabfac.IdSucursal AND detfac.IdEmpresa = cabfac.IdEmpresa AND 
                         detfac.IdCbteVta = cabfac.IdCbteVta INNER JOIN
                         dbo.tb_sucursal AS Sucu ON cabfac.IdEmpresa = Sucu.IdEmpresa AND cabfac.IdSucursal = Sucu.IdSucursal INNER JOIN
                         dbo.tb_bodega AS Bod ON cabfac.IdEmpresa = Bod.IdEmpresa AND cabfac.IdSucursal = Bod.IdSucursal AND cabfac.IdBodega = Bod.IdBodega AND 
                         Sucu.IdEmpresa = Bod.IdEmpresa AND Sucu.IdSucursal = Bod.IdSucursal INNER JOIN
                         dbo.fa_cliente AS Cli ON cabfac.IdEmpresa = Cli.IdEmpresa AND cabfac.IdCliente = Cli.IdCliente INNER JOIN
                         dbo.tb_persona ON Cli.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.in_Producto ON detfac.IdEmpresa = dbo.in_Producto.IdEmpresa AND detfac.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.tb_empresa ON cabfac.IdEmpresa = dbo.tb_empresa.IdEmpresa LEFT OUTER JOIN
                         dbo.vwcxc_cobros_x_vta_nota_x_RetIVA_Sumatoria AS Cob_RtIVA ON cabfac.IdEmpresa = Cob_RtIVA.IdEmpresa AND cabfac.IdSucursal = Cob_RtIVA.IdSucursal AND
                          cabfac.IdBodega = Cob_RtIVA.IdBodega_Cbte AND cabfac.IdCbteVta = Cob_RtIVA.IdCbte_vta_nota LEFT OUTER JOIN
                         dbo.vwcxc_cobros_x_vta_nota_x_RetFuente_Sumatoria AS Cob_RtFu ON cabfac.IdEmpresa = Cob_RtFu.IdEmpresa AND 
                         cabfac.IdSucursal = Cob_RtFu.IdSucursal AND cabfac.IdBodega = Cob_RtFu.IdBodega_Cbte AND cabfac.IdCbteVta = Cob_RtFu.IdCbte_vta_nota LEFT OUTER JOIN
                         dbo.vwcxc_total_cobros_x_Docu ON cabfac.IdEmpresa = dbo.vwcxc_total_cobros_x_Docu.IdEmpresa AND 
                         cabfac.IdSucursal = dbo.vwcxc_total_cobros_x_Docu.IdSucursal AND cabfac.IdBodega = dbo.vwcxc_total_cobros_x_Docu.IdBodega_Cbte AND 
                         cabfac.vt_tipoDoc = dbo.vwcxc_total_cobros_x_Docu.dc_TipoDocumento AND cabfac.IdCbteVta = dbo.vwcxc_total_cobros_x_Docu.IdCbte_vta_nota
GROUP BY SUBSTRING(cabfac.vt_tipoDoc, 1, 2) + '-' + cabfac.vt_serie1 + '-' + cabfac.vt_serie2 + '-' + cabfac.vt_NumFactura + '/' + CAST(cabfac.IdCbteVta AS varchar(100)), 
                         cabfac.IdEmpresa, cabfac.IdSucursal, cabfac.IdBodega, cabfac.IdCbteVta, cabfac.CodCbteVta, Sucu.Su_Descripcion, cabfac.vt_tipoDoc, cabfac.IdCliente, 
                         cabfac.vt_fecha, cabfac.vt_Observacion, Bod.bo_Descripcion, cabfac.vt_fech_venc, Cli.Codigo, dbo.tb_persona.pe_nombreCompleto, dbo.tb_empresa.em_nombre, 
                         cabfac.vt_plazo, dbo.in_Producto.IdProducto, dbo.in_Producto.pr_descripcion, cabfac.IdUsuario
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[10] 2[31] 3) )"
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
         Begin Table = "detfac"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cabfac"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sucu"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Bod"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cli"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 283
            End
            DisplayFlags = 280
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cob_RtIVA"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cob_RtFu"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1323
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcxc_total_cobros_x_Docu"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1455
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt003';

