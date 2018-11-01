CREATE VIEW Fj_servindustrias.vwaf_Af_Poliza_x_AF
AS
SELECT        Fj_servindustrias.Af_Poliza_x_AF.IdEmpresa, Fj_servindustrias.Af_Poliza_x_AF.IdPoliza, Fj_servindustrias.Af_Poliza_x_AF.IdProveedor, 
                         Fj_servindustrias.Af_Poliza_x_AF.cod_poliza, Fj_servindustrias.Af_Poliza_x_AF.fecha, Fj_servindustrias.Af_Poliza_x_AF.observacion, 
                         Fj_servindustrias.Af_Poliza_x_AF.fecha_vigencia_desde, Fj_servindustrias.Af_Poliza_x_AF.fecha_vigencia_hasta, Fj_servindustrias.Af_Poliza_x_AF.num_cuotas, 
                         Fj_servindustrias.Af_Poliza_x_AF.valor_cuota, Fj_servindustrias.Af_Poliza_x_AF.fecha_1era_cuota, Fj_servindustrias.Af_Poliza_x_AF.suma_asegurada, 
                         Fj_servindustrias.Af_Poliza_x_AF.total_meses, Fj_servindustrias.Af_Poliza_x_AF.subtotal, Fj_servindustrias.Af_Poliza_x_AF.porc_iva, 
                         Fj_servindustrias.Af_Poliza_x_AF.iva, Fj_servindustrias.Af_Poliza_x_AF.Total, Fj_servindustrias.Af_Poliza_x_AF.Estado, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, Fj_servindustrias.Af_Poliza_x_AF.subtotal_noIva, 
                         Fj_servindustrias.Af_Poliza_x_AF.pago_contado, Fj_servindustrias.Af_Poliza_x_AF.IdCentroCosto, 
                         Fj_servindustrias.Af_Poliza_x_AF.IdCentroCosto_sub_centro_costo
FROM            Fj_servindustrias.Af_Poliza_x_AF INNER JOIN
                         dbo.cp_proveedor ON Fj_servindustrias.Af_Poliza_x_AF.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         Fj_servindustrias.Af_Poliza_x_AF.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[84] 4[5] 2[5] 3) )"
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
         Begin Table = "Af_Poliza_x_AF (Fj_servindustrias)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 236
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 270
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwaf_Af_Poliza_x_AF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwaf_Af_Poliza_x_AF';

