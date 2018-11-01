CREATE VIEW [dbo].[vwfa_movimientos_x_bodega_x_cat]
AS
SELECT     detmov.cm_fecha, detmov.cm_observacion, detmov.TipoMoviInvent, detmov.ca_Categoria, detmov.IdCategoria, detmov.Descripcion, detmov.pr_descripcion, 
                      detmov.bo_Descripcion, detmov.pr_codigo, detmov.Su_Descripcion, detmov.dm_cantidad, detmov.IdProducto, detmov.IdNumMovi, detmov.IdMovi_inven_tipo, 
                      detmov.IdBodega, detmov.IdSucursal, detmov.IdEmpresa, fa.IdCliente, fa.pe_nombreCompleto, fa.IdCbteVta, fa.vt_NumFactura, fa.vt_Observacion, 
                      guia.CodGuiaRemision, guia.NumGuia_Preimpresa, guia.NUAutorizacion, prod.Estado
FROM         dbo.in_Producto AS prod INNER JOIN
                      dbo.vwin_movi_inve_detalle AS detmov INNER JOIN
                      dbo.fa_factura_x_in_movi_inve AS ti ON detmov.IdEmpresa = ti.inv_IdEmpresa AND detmov.IdSucursal = ti.inv_IdSucursal AND 
                      detmov.IdBodega = ti.inv_IdBodega AND detmov.IdMovi_inven_tipo = ti.inv_IdMovi_inven_tipo AND detmov.IdNumMovi = ti.inv_IdNumMovi INNER JOIN
                      dbo.vwfa_factura AS fa ON ti.fa_IdEmpresa = fa.IdEmpresa AND ti.fa_IdBodega = fa.IdBodega AND ti.fa_IdSucursal = fa.IdSucursal AND ti.fa_IdCbteVta = fa.IdCbteVta ON
                       prod.IdProducto = detmov.IdProducto AND prod.IdEmpresa = detmov.IdEmpresa LEFT OUTER JOIN
                      dbo.fa_guia_remision AS guia INNER JOIN
                      dbo.fa_factura_x_fa_guia_remision AS fa_gui ON guia.IdEmpresa = fa_gui.gi_IdEmpresa AND guia.IdSucursal = fa_gui.gi_IdSucursal AND 
                      guia.IdBodega = fa_gui.gi_IdBodega AND guia.IdGuiaRemision = fa_gui.gi_IdGuiaRemision ON fa.IdBodega = fa_gui.fa_IdBodega AND 
                      fa.IdCbteVta = fa_gui.fa_IdCbteVta AND fa.IdSucursal = fa_gui.fa_IdSucursal AND fa.IdEmpresa = fa_gui.fa_IdEmpresa
GROUP BY detmov.cm_fecha, detmov.cm_observacion, detmov.TipoMoviInvent, detmov.ca_Categoria, detmov.IdCategoria, detmov.Descripcion, detmov.pr_descripcion, 
                      detmov.bo_Descripcion, detmov.pr_codigo, detmov.Su_Descripcion, detmov.dm_cantidad, detmov.IdProducto, detmov.IdNumMovi, detmov.IdMovi_inven_tipo, 
                      detmov.IdBodega, detmov.IdSucursal, detmov.IdEmpresa, fa.IdCliente, fa.pe_nombreCompleto, fa.IdCbteVta, fa.vt_NumFactura, fa.vt_Observacion, 
                      guia.CodGuiaRemision, guia.NumGuia_Preimpresa, guia.NUAutorizacion, prod.Estado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[22] 2[13] 3) )"
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
         Begin Table = "detmov"
            Begin Extent = 
               Top = 12
               Left = 36
               Bottom = 221
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "fa"
            Begin Extent = 
               Top = 16
               Left = 550
               Bottom = 263
               Right = 749
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ti"
            Begin Extent = 
               Top = 32
               Left = 289
               Bottom = 232
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_gui"
            Begin Extent = 
               Top = 14
               Left = 831
               Bottom = 203
               Right = 1007
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "guia"
            Begin Extent = 
               Top = 56
               Left = 1101
               Bottom = 175
               Right = 1291
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "prod"
            Begin Extent = 
               Top = 264
               Left = 253
               Bottom = 383
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 35
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 31
         Width = 284
         Width = 2700
         Width = 2775
         Width = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_movimientos_x_bodega_x_cat';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_movimientos_x_bodega_x_cat';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwfa_movimientos_x_bodega_x_cat';

