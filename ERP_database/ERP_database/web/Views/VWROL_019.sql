CREATE VIEW web.VWROL_019
AS
SELECT        rol_det.IdEmpresa, rol_det.IdNominaTipo, rol_det.IdNominaTipoLiqui, rol_det.IdPeriodo, rol_det.IdEmpleado, rol_det.IdRubro, rol_det.Orden, rol_det.Valor, rol_det.Observacion, per.pe_anio, per.pe_mes, 
                         div.Descripcion AS Division, dep.de_descripcion AS Departamento, carg.ca_descripcion AS Cargo, dbo.ro_rubro_tipo.ru_descripcion AS Rubro, dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina AS NominaTipo, 
                         dbo.ro_Nomina_Tipo.Descripcion AS Nomina, pers.pe_cedulaRuc AS Cedula, pers.pe_nombreCompleto AS Empleado, dbo.ro_rubro_tipo.ru_tipo, CAST(per.pe_FechaIni AS date) AS FechaIni, CAST(per.pe_FechaFin AS date) 
                         AS FechaFin, dbo.ro_rubro_tipo.ru_codRolGen
FROM            dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.ro_rol_detalle AS rol_det ON dbo.ro_empleado.IdEmpresa = rol_det.IdEmpresa AND dbo.ro_empleado.IdEmpleado = rol_det.IdEmpleado INNER JOIN
                         dbo.tb_persona AS pers ON dbo.ro_empleado.IdPersona = pers.IdPersona INNER JOIN
                         dbo.ro_cargo AS carg ON dbo.ro_empleado.IdEmpresa = carg.IdEmpresa AND dbo.ro_empleado.IdCargo = carg.IdCargo INNER JOIN
                         dbo.ro_Division AS div ON dbo.ro_empleado.IdEmpresa = div.IdEmpresa AND dbo.ro_empleado.IdDivision = div.IdDivision INNER JOIN
                         dbo.ro_Departamento AS dep ON dbo.ro_empleado.IdEmpresa = dep.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dep.IdDepartamento INNER JOIN
                         dbo.ro_area ON div.IdEmpresa = dbo.ro_area.IdEmpresa AND div.IdDivision = dbo.ro_area.IdDivision ON dbo.ro_rubro_tipo.IdEmpresa = rol_det.IdEmpresa AND dbo.ro_rubro_tipo.IdRubro = rol_det.IdRubro LEFT OUTER JOIN
                         dbo.ro_Nomina_Tipoliqui INNER JOIN
                         dbo.ro_rol AS rol INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS ro_per_x_nom ON rol.IdEmpresa = ro_per_x_nom.IdEmpresa AND rol.IdNominaTipo = ro_per_x_nom.IdNomina_Tipo AND 
                         rol.IdNominaTipoLiqui = ro_per_x_nom.IdNomina_TipoLiqui AND rol.IdPeriodo = ro_per_x_nom.IdPeriodo INNER JOIN
                         dbo.ro_periodo AS per ON ro_per_x_nom.IdEmpresa = per.IdEmpresa AND ro_per_x_nom.IdPeriodo = per.IdPeriodo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = rol.IdEmpresa AND 
                         dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = rol.IdNominaTipo AND dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui = rol.IdNominaTipoLiqui INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo ON rol_det.IdEmpresa = rol.IdEmpresa AND 
                         rol_det.IdNominaTipo = rol.IdNominaTipo AND rol_det.IdNominaTipoLiqui = rol.IdNominaTipoLiqui AND rol_det.IdPeriodo = rol.IdPeriodo


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_019';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            TopColumn = 0
         End
         Begin Table = "ro_area"
            Begin Extent = 
               Top = 381
               Left = 816
               Bottom = 511
               Right = 995
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Nomina_Tipoliqui"
            Begin Extent = 
               Top = 146
               Left = 625
               Bottom = 366
               Right = 861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rol"
            Begin Extent = 
               Top = 38
               Left = 0
               Bottom = 168
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_per_x_nom"
            Begin Extent = 
               Top = 0
               Left = 1138
               Bottom = 130
               Right = 1335
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "per"
            Begin Extent = 
               Top = 84
               Left = 86
               Bottom = 382
               Right = 307
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Nomina_Tipo"
            Begin Extent = 
               Top = 81
               Left = 1079
               Bottom = 211
               Right = 1261
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
      Begin ColumnWidths = 20
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
', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_019';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[5] 2[62] 3) )"
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
         Left = -27
      End
      Begin Tables = 
         Begin Table = "ro_rubro_tipo"
            Begin Extent = 
               Top = 265
               Left = 364
               Bottom = 566
               Right = 603
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 290
               Left = 847
               Bottom = 420
               Right = 1136
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rol_det"
            Begin Extent = 
               Top = 300
               Left = 753
               Bottom = 674
               Right = 1016
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pers"
            Begin Extent = 
               Top = 224
               Left = 0
               Bottom = 528
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "carg"
            Begin Extent = 
               Top = 255
               Left = 454
               Bottom = 385
               Right = 671
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "div"
            Begin Extent = 
               Top = 4
               Left = 252
               Bottom = 134
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dep"
            Begin Extent = 
               Top = 176
               Left = 15
               Bottom = 306
               Right = 194
            End
            DisplayFlags = 280', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_019';

