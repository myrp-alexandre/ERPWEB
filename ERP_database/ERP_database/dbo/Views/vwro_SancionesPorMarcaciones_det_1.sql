CREATE VIEW dbo.vwro_SancionesPorMarcaciones_det
AS
SELECT        dbo.ro_SancionesPorMarcaciones_det.IdEmpresa, dbo.ro_SancionesPorMarcaciones_det.IdAjuste, dbo.ro_SancionesPorMarcaciones_det.Secuencia, dbo.ro_SancionesPorMarcaciones_det.IdCalendario, 
                         dbo.ro_SancionesPorMarcaciones_det.IdEmpleado, dbo.ro_SancionesPorMarcaciones_det.IdSucursal, dbo.ro_SancionesPorMarcaciones_det.IdTipoMarcaciones, dbo.ro_SancionesPorMarcaciones_det.EsHoraHorario, 
                         dbo.ro_SancionesPorMarcaciones_det.EsHoraMarcacion, dbo.ro_SancionesPorMarcaciones_det.Minutos, dbo.ro_SancionesPorMarcaciones_det.IdRegistro, dbo.ro_SancionesPorMarcaciones_det.Observacion, 
                         dbo.ro_marcaciones_x_empleado.es_fechaRegistro, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_cedulaRuc, dbo.ro_empleado.em_codigo
FROM            dbo.ro_SancionesPorMarcaciones_det INNER JOIN
                         dbo.ro_marcaciones_x_empleado ON dbo.ro_SancionesPorMarcaciones_det.IdEmpresa = dbo.ro_marcaciones_x_empleado.IdEmpresa AND 
                         dbo.ro_SancionesPorMarcaciones_det.IdRegistro = dbo.ro_marcaciones_x_empleado.IdRegistro INNER JOIN
                         dbo.ro_empleado ON dbo.ro_marcaciones_x_empleado.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_marcaciones_x_empleado.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_SancionesPorMarcaciones_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_SancionesPorMarcaciones_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[78] 4[5] 2[5] 3) )"
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
         Begin Table = "ro_SancionesPorMarcaciones_det"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 327
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 30
               Left = 381
               Bottom = 310
               Right = 670
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_marcaciones_x_empleado"
            Begin Extent = 
               Top = 47
               Left = 211
               Bottom = 369
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 53
               Left = 685
               Bottom = 335
               Right = 917
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
      Begin ColumnWidths = 9
         Width = 284
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
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_SancionesPorMarcaciones_det';

