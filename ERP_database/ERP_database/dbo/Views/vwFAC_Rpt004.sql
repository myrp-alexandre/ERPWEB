CREATE view [dbo].[vwFAC_Rpt004]
as
SELECT        dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END)
                          AS IdTipoDocumento, CASE WHEN dbo.fa_notaCreDeb.NumNota_Impresa IS NULL THEN SUBSTRING(dbo.fa_TipoNota.CodTipoNota, 1, 2) 
                         + '#' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) ELSE SUBSTRING(dbo.fa_TipoNota.CodTipoNota, 1, 2) + '-' + isnull(dbo.fa_notaCreDeb.Serie1, '') 
                         + '-' + isnull(dbo.fa_notaCreDeb.Serie2, '') + '-' + isnull(dbo.fa_notaCreDeb.NumNota_Impresa, '') + '/' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) 
                         END AS numDocumento, dbo.fa_notaCreDeb.sc_observacion AS Referencia, CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) AS IdComprobante, 
                         dbo.fa_notaCreDeb.CodNota AS CodComprobante, dbo.tb_sucursal.Su_Descripcion, dbo.fa_notaCreDeb.IdCliente, 
                         dbo.tb_persona.pe_nombreCompleto AS nombreCliente, dbo.tb_persona.pe_cedulaRuc, dbo.fa_notaCreDeb.no_fecha, ROUND(SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.sc_total), 2) AS vt_total, 
                         ROUND(SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.sc_total), 2) - (CASE WHEN AVG(notCxc.Valor_cobro) IS NULL THEN 0 ELSE AVG(notCxc.Valor_cobro) END) AS Saldo, 
                         (CASE WHEN AVG(notCxc.Valor_cobro) IS NULL THEN 0 ELSE AVG(notCxc.Valor_cobro) END) AS TotalCobrado, ROUND(SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.SubTotal_0), 2) 
                         AS SubTotal_0,ROUND(SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.SubTotal_Iva), 2) 
                         AS SubTotal_Iva, ROUND(SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.sc_iva), 2) AS vt_iva,SUM(dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.sc_total) as total, dbo.fa_notaCreDeb.no_fecha_venc, dbo.fa_TipoNota.IdTipoNota, 
                         dbo.fa_TipoNota.CodTipoNota, dbo.fa_TipoNota.No_Descripcion, DATEDIFF(day, dbo.fa_notaCreDeb.no_fecha, dbo.fa_notaCreDeb.no_fecha_venc) AS Plazo, 
                         dbo.fa_notaCreDeb.IdUsuario, dbo.tb_empresa.em_nombre, dbo.fa_notaCreDeb.NaturalezaNota
FROM            dbo.fa_notaCreDeb INNER JOIN
                         dbo.tb_bodega ON dbo.fa_notaCreDeb.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.fa_notaCreDeb.IdSucursal = dbo.tb_bodega.IdSucursal AND 
                         dbo.fa_notaCreDeb.IdBodega = dbo.tb_bodega.IdBodega INNER JOIN
                         dbo.tb_sucursal ON dbo.tb_bodega.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.tb_bodega.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.fa_cliente ON dbo.fa_notaCreDeb.IdEmpresa = dbo.fa_cliente.IdEmpresa AND dbo.fa_notaCreDeb.IdCliente = dbo.fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales ON dbo.fa_notaCreDeb.IdEmpresa = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdEmpresa AND 
                         dbo.fa_notaCreDeb.IdSucursal = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdSucursal AND dbo.fa_notaCreDeb.IdBodega = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdBodega AND 
                         dbo.fa_notaCreDeb.IdNota = dbo.vwfa_notaCreDeb_det_subtotal_iva_0_totales.IdNota INNER JOIN
                         dbo.fa_TipoNota ON dbo.fa_notaCreDeb.IdTipoNota = dbo.fa_TipoNota.IdTipoNota INNER JOIN
                         dbo.tb_empresa ON dbo.fa_notaCreDeb.IdEmpresa = dbo.tb_empresa.IdEmpresa LEFT OUTER JOIN
                         dbo.fa_notaCreDeb_x_cxc_cobro AS notCxc ON notCxc.IdEmpresa_nt = dbo.fa_notaCreDeb.IdEmpresa AND 
                         notCxc.IdSucursal_nt = dbo.fa_notaCreDeb.IdSucursal AND notCxc.IdNota_nt = dbo.fa_notaCreDeb.IdNota AND 
                         notCxc.IdBodega_nt = dbo.fa_notaCreDeb.IdBodega
WHERE        (dbo.fa_notaCreDeb.Estado = 'A')
GROUP BY dbo.fa_notaCreDeb.IdEmpresa, dbo.fa_notaCreDeb.IdSucursal, dbo.fa_notaCreDeb.IdBodega, dbo.fa_TipoNota.Tipo, dbo.fa_notaCreDeb.IdNota, 
                         dbo.fa_TipoNota.CodTipoNota, dbo.fa_notaCreDeb.Serie1, dbo.fa_notaCreDeb.Serie2, dbo.fa_notaCreDeb.NumNota_Impresa, dbo.fa_notaCreDeb.sc_observacion, 
                         dbo.fa_notaCreDeb.CodNota, dbo.tb_sucursal.Su_Descripcion, dbo.fa_notaCreDeb.IdCliente, dbo.tb_persona.pe_nombreCompleto, dbo.fa_notaCreDeb.no_fecha, 
                         dbo.fa_notaCreDeb.no_fecha_venc, dbo.fa_TipoNota.IdTipoNota, dbo.fa_TipoNota.CodTipoNota, SUBSTRING(dbo.fa_TipoNota.CodTipoNota, 1, 2) 
                         + '-' + dbo.fa_notaCreDeb.Serie1 + '-' + dbo.fa_notaCreDeb.Serie2 + '-' + dbo.fa_notaCreDeb.NumNota_Impresa + '/' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)),
                          dbo.fa_notaCreDeb.IdUsuario, dbo.tb_persona.pe_cedulaRuc, dbo.fa_TipoNota.No_Descripcion, dbo.tb_empresa.em_nombre, dbo.fa_notaCreDeb.NaturalezaNota
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[4] 2[33] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
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
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
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
         Configuration = "(H (1[21] 4) )"
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
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
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
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 36
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 8
               Left = 703
               Bottom = 137
               Right = 928
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 1
               Left = 1048
               Bottom = 130
               Right = 1294
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 141
               Left = 694
               Bottom = 270
               Right = 929
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 135
               Left = 1069
               Bottom = 264
               Right = 1294
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "fa_notaCreDeb_det"
            Begin Extent = 
               Top = 280
               Left = 708
               Bottom = 409
               Right = 933
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Producto"
            Begin Extent = 
               Top = 272
               Left = 1054
               Bottom = 401
               Right = 1299
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_TipoNota"
            Begin Extent = 
               Top = 367
               Left = 328
               Bottom = 496
               Right = 553
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "notCxc"
            Begin Extent = 
               Top = 223
               Left = 356
               Bottom = 352
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 230
               Left = 0
               Bottom = 359
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 26
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2325
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
         Column = 17430
         Alias = 900
         Table = 1995
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt004';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt004';

