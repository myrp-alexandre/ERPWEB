CREATE VIEW Fj_servindustrias.vwACTF_FJ_Rpt002
AS
SELECT        dbo.Af_Activo_fijo.IdEmpresa, dbo.Af_Activo_fijo.IdActivoFijo, dbo.Af_Activo_fijo.IdCategoriaAF, dbo.Af_Catalogo.Descripcion AS Marca, 0 Af_Capacidad, tb_modelo.Descripcion AS Modelo, 
                         dbo.Af_Activo_fijo.Af_NumSerie_Motor AS Num_Serie_Motor, dbo.Af_Activo_fijo.Af_Anio_fabrica AS Anio_Fabricacion, dbo.cp_orden_giro.co_serie AS Factura_Serie, dbo.cp_orden_giro.co_factura AS Num_Factura, 
                         dbo.cp_orden_giro.co_fechaOg AS Fecha_compra, dbo.Af_Activo_fijo.Af_costo_compra AS Costo_Compra, dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.Garantia_Bancaria, 
                         dbo.ba_prestamo_detalle_cancelacion.Monto_Canc, dbo.ba_prestamo.MontoSol, dbo.ba_prestamo.NumCuotas, dbo.ba_prestamo.Pago_contado, CASE WHEN dbo.tb_banco.ba_descripcion IS NULL 
                         THEN 'LIBRE' ELSE dbo.tb_banco.ba_descripcion END AS Institucion_prendada, dbo.ba_prestamo.Fecha_Transac AS Fecha_Avaluo, dbo.tb_banco.IdBanco, dbo.Af_Activo_fijo_Categoria.Descripcion AS Categoria, 
                         dbo.ba_prestamo.Observacion AS Operacion, dbo.Af_Activo_fijo.Af_NumSerie_Chasis, dbo.ba_prestamo.Fecha, dbo.Af_Activo_fijo.Af_DescripcionCorta
FROM            dbo.cp_orden_giro RIGHT OUTER JOIN
                         dbo.Af_Activo_fijo INNER JOIN
                         dbo.Af_Catalogo ON dbo.Af_Activo_fijo.IdCatalogo_Marca = dbo.Af_Catalogo.IdCatalogo INNER JOIN
                         dbo.Af_Catalogo AS tb_modelo ON dbo.Af_Activo_fijo.IdCatalogo_Modelo = tb_modelo.IdCatalogo INNER JOIN
                         dbo.Af_Activo_fijo_Categoria ON dbo.Af_Activo_fijo.IdEmpresa = dbo.Af_Activo_fijo_Categoria.IdEmpresa AND dbo.Af_Activo_fijo.IdCategoriaAF = dbo.Af_Activo_fijo_Categoria.IdCategoriaAF ON 
                         dbo.cp_orden_giro.IdEmpresa = 0 AND dbo.cp_orden_giro.IdCbteCble_Ogiro = 0 AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = 0 LEFT OUTER JOIN
                         dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados INNER JOIN
                         dbo.ba_prestamo ON dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdEmpresa = dbo.ba_prestamo.IdEmpresa AND 
                         dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdPrestamo = dbo.ba_prestamo.IdPrestamo INNER JOIN
                         dbo.tb_banco ON dbo.ba_prestamo.IdBanco = dbo.tb_banco.IdBanco INNER JOIN
                         dbo.ba_prestamo_detalle_cancelacion ON dbo.ba_prestamo.IdEmpresa = dbo.ba_prestamo_detalle_cancelacion.IdEmpresa AND dbo.ba_prestamo.IdPrestamo = dbo.ba_prestamo_detalle_cancelacion.IdPrestamo ON 
                         dbo.Af_Activo_fijo.IdEmpresa = dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdEmpresa AND dbo.Af_Activo_fijo.IdActivoFijo = dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdActivoFijo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[53] 4[5] 2[5] 3) )"
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
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 198
               Left = 0
               Bottom = 327
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo"
            Begin Extent = 
               Top = 34
               Left = 512
               Bottom = 394
               Right = 775
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "Af_Catalogo"
            Begin Extent = 
               Top = 50
               Left = 650
               Bottom = 179
               Right = 859
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_modelo"
            Begin Extent = 
               Top = 0
               Left = 298
               Bottom = 129
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Af_Activo_fijo_Categoria"
            Begin Extent = 
               Top = 136
               Left = 236
               Bottom = 376
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_prestamo_detalle_x_af_activo_fijo_Prendados"
            Begin Extent = 
               Top = 88
               Left = 386
               Bottom = 240
               Right = 783
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_prestamo"
            Begin Extent = 
               Top = 198
               Left = 580
               Bottom = 436', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwACTF_FJ_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_banco"
            Begin Extent = 
               Top = 25
               Left = 1046
               Bottom = 226
               Right = 1280
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_prestamo_detalle_cancelacion"
            Begin Extent = 
               Top = 181
               Left = 1064
               Bottom = 413
               Right = 1307
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
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2445
         Width = 1665
         Width = 2175
         Width = 1500
         Width = 1500
         Width = 855
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 645
         Width = 705
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 75
         Width = 1230
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2415
         Alias = 2535
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwACTF_FJ_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwACTF_FJ_Rpt002';

