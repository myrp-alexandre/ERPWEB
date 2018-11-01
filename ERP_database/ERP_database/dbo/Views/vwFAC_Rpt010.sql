/*select * from vwFAC_Rpt007*/
CREATE VIEW [dbo].[vwFAC_Rpt010]
AS
SELECT        dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_notaCreDeb.IdNota, dbo.fa_notaCreDeb_det.Secuencia, 
                         dbo.fa_TipoNota.CodTipoNota, (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END) AS IdTipoDocumento, 
                         dbo.fa_notaCreDeb.Serie1 + '-' + dbo.fa_notaCreDeb.Serie2 + '-' + dbo.fa_notaCreDeb.NumNota_Impresa + '/' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) 
                         AS numDocumento, dbo.fa_notaCreDeb.IdCliente,dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_cedulaRuc, 
                         null pe_telefonoCasa, dbo.tb_persona.pe_direccion, dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.no_fecha_venc, 
                         DATEDIFF(day, dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.no_fecha_venc) AS Plazo, dbo.fa_notaCreDeb.IdTipoNota, dbo.fa_notaCreDeb.sc_observacion,  dbo.fa_notaCreDeb_det.sc_cantidad, dbo.fa_notaCreDeb_det.sc_Precio, 
                         dbo.fa_notaCreDeb_det.sc_subtotal, dbo.fa_notaCreDeb_det.sc_iva, dbo.fa_notaCreDeb_det.sc_total, dbo.in_Producto.IdProducto, 
                         dbo.in_Producto.pr_descripcion AS nombreProducto, dbo.tb_bodega.bo_Descripcion, dbo.fa_notaCreDeb.IdUsuario, dbo.tb_sucursal.Su_Descripcion
FROM            dbo.fa_notaCreDeb INNER JOIN
                         dbo.fa_notaCreDeb_det ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_notaCreDeb_det.IdEmpresa AND 
                         dbo.fa_notaCreDeb.IdSucursal = dbo.fa_notaCreDeb_det.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = dbo.fa_notaCreDeb_det.IdBodega AND 
                         dbo.fa_notaCreDeb.IdNota = dbo.fa_notaCreDeb_det.IdNota INNER JOIN
                         dbo.fa_cliente ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_notaCreDeb.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.tb_bodega ON dbo.fa_notaCreDeb.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.fa_notaCreDeb.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.fa_TipoNota ON dbo.fa_notaCreDeb.IdTipoNota = dbo.fa_TipoNota.IdTipoNota INNER JOIN
                         dbo.in_Producto ON dbo.fa_notaCreDeb_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_notaCreDeb_det.IdProducto = dbo.in_Producto.IdProducto
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
         Begin Table = "fa_notaCreDeb"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_notaCreDeb_det"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
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
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 268
            End
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt010';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_TipoNota"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1323
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt010';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt010';

