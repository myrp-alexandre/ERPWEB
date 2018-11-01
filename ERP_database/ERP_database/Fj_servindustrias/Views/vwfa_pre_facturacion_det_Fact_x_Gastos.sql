CREATE VIEW Fj_servindustrias.vwfa_pre_facturacion_det_Fact_x_Gastos
AS
SELECT Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdPreFacturacion, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.secuencia, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentro_Costo, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentroCosto_sub_centro_costo, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdPunto_cargo, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa_ct, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTipoCbte_ct, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCbteCble_ct, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.secuencia_ct, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCuota, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.secuencia_cuota, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Cantidad, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Costo_Uni, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Subtotal, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Por_Iva, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Valor_Iva, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Total, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Valor_a_cobrar, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Facturar, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTarifario, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Porc_ganancia, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.num_documento, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.nom_proveedor, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, 
                  dbo.ct_punto_cargo.nom_punto_cargo, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Fecha_documento, Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.Observacion, 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTipoMovi_grupo, dbo.caj_Caja_Movimiento_Tipo_grupo.tg_descripcion
FROM     Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos LEFT OUTER JOIN
                  dbo.caj_Caja_Movimiento_Tipo_grupo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdTipoMovi_grupo = dbo.caj_Caja_Movimiento_Tipo_grupo.IdTipoMovi_grupo LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                  dbo.ct_centro_costo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentro_Costo = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentro_Costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_pre_facturacion_det_Fact_x_Gastos.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[49] 2[3] 3) )"
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
         Begin Table = "fa_pre_facturacion_det_Fact_x_Gastos (Fj_servindustrias)"
            Begin Extent = 
               Top = 0
               Left = 435
               Bottom = 375
               Right = 698
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento_Tipo_grupo"
            Begin Extent = 
               Top = 213
               Left = 816
               Bottom = 354
               Right = 1033
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1191
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo_sub_centro_costo"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1059
               Right = 301
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
      Begin ColumnWidths = 36
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width ', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_pre_facturacion_det_Fact_x_Gastos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 1500
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
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_pre_facturacion_det_Fact_x_Gastos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_pre_facturacion_det_Fact_x_Gastos';

