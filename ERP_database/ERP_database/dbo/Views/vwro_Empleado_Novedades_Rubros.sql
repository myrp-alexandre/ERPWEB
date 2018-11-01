/*GROUP BY IdEmpresa, IdNovedad, IdRubro*/
CREATE VIEW [dbo].[vwro_Empleado_Novedades_Rubros]
AS
SELECT        cab.IdEmpresa, cab.IdNovedad, cab.IdNomina_Tipo, cab.IdNomina_TipoLiqui, det.IdRubro, CAST(cab.Fecha AS date) AS Fecha, Proce.DescripcionProcesoNomina, 
                         Nom.Descripcion, Rub.ru_descripcion, cab.IdEmpleado, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, det.Observacion, det.Valor, det.EstadoCobro, 
                         det.Estado
FROM            dbo.ro_Nomina_Tipoliqui AS Proce INNER JOIN
                         dbo.ro_Nomina_Tipo AS Nom ON Proce.IdEmpresa = Nom.IdEmpresa AND Proce.IdNomina_Tipo = Nom.IdNomina_Tipo INNER JOIN
                         dbo.ro_empleado_Novedad AS cab INNER JOIN
                         dbo.ro_empleado_novedad_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdNovedad = det.IdNovedad AND cab.IdEmpleado = det.IdEmpleado ON 
                         Proce.IdNomina_Tipo = cab.IdNomina_Tipo AND Proce.IdEmpresa = cab.IdEmpresa AND Proce.IdNomina_TipoLiqui = cab.IdNomina_TipoLiqui INNER JOIN
                         dbo.ro_rubro_tipo AS Rub ON det.IdRubro = Rub.IdRubro INNER JOIN
                         dbo.ro_empleado ON cab.IdEmpresa = dbo.ro_empleado.IdEmpresa AND cab.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona
GROUP BY cab.IdEmpresa, cab.IdNovedad, cab.IdNomina_Tipo, cab.IdNomina_TipoLiqui, det.IdRubro, CAST(cab.Fecha AS date), Proce.DescripcionProcesoNomina, 
                         Nom.Descripcion, Rub.ru_descripcion, cab.IdEmpleado, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, det.Observacion, det.Valor, det.EstadoCobro, 
                         det.Estado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[57] 4[17] 2[22] 3) )"
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
         Begin Table = "Proce"
            Begin Extent = 
               Top = 56
               Left = 876
               Bottom = 223
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Nom"
            Begin Extent = 
               Top = 47
               Left = 1206
               Bottom = 166
               Right = 1376
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cab"
            Begin Extent = 
               Top = 28
               Left = 587
               Bottom = 343
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "det"
            Begin Extent = 
               Top = 15
               Left = 314
               Bottom = 296
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Rub"
            Begin Extent = 
               Top = 175
               Left = 71
               Bottom = 294
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 227
               Left = 1040
               Bottom = 443
               Right = 1268
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 253
               Left = 796
               Bottom = 466
               Right = 1004
            End
            DisplayFlags = 280
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_Empleado_Novedades_Rubros';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 32
         Width = 284
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2925
         Alias = 2520
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 915
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_Empleado_Novedades_Rubros';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_Empleado_Novedades_Rubros';

