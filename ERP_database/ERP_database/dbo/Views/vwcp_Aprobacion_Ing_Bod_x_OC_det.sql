CREATE VIEW dbo.vwcp_Aprobacion_Ing_Bod_x_OC_det
AS
SELECT dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Secuencia, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv, 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Secuencia_Ing_Egr_Inv, 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Cantidad, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Costo_uni, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Descuento, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.SubTotal, 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.PorIva, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.valor_Iva, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Total, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCtaCble_Gasto, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCtaCble_IVA, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCentro_Costo_x_Gasto_x_cxp, 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCentroCosto_sub_centro_costo_cxp, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdMovi_inven_tipo_Ing_Egr_Inv, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.por_descuento, 
                  dbo.cp_Aprobacion_Ing_Bod_x_OC_det.Cost_uni_final, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdCod_Impuesto_Iva, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdProducto, dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdUnidadMedida
FROM     dbo.cp_Aprobacion_Ing_Bod_x_OC_det INNER JOIN
                  dbo.tb_sucursal ON dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv = dbo.tb_sucursal.IdSucursal
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[83] 4[3] 2[3] 3) )"
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
         Begin Table = "cp_Aprobacion_Ing_Bod_x_OC_det"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 578
               Right = 386
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 9
               Left = 579
               Bottom = 172
               Right = 851
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Aprobacion_Ing_Bod_x_OC_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Aprobacion_Ing_Bod_x_OC_det';

