CREATE VIEW dbo.vwRo_Empleado_Rol_Detalle
AS
SELECT        dbo.ro_empleado.IdEmpleado, dbo.tb_persona.pe_cedulaRuc AS CedulaRuc, dbo.tb_persona.pe_nombreCompleto AS NombreCompleto, dbo.ro_rol_detalle.IdRubro, dbo.ro_rubro_tipo.ru_codRolGen AS Tag, 
                         dbo.ro_rubro_tipo.ru_descripcion AS DescRubroLargo, dbo.ro_rubro_tipo.NombreCorto AS DescNombreRubroCorto, dbo.ro_rol_detalle.Orden, dbo.ro_rol_detalle.Valor, 
                         dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina AS NominaLiqui, dbo.ro_Nomina_Tipo.Descripcion AS Nomina, dbo.tb_empresa.em_nombre AS Empresa, dbo.tb_empresa.IdEmpresa, 
                         dbo.ro_Departamento.de_descripcion AS Departamento, dbo.ro_rol.IdNominaTipo, dbo.ro_rol.IdNominaTipoLiqui, dbo.ro_rol.FechaIngresa, dbo.ro_rol_detalle.rub_visible_reporte, dbo.ro_rol_detalle.Observacion, 
                         dbo.ro_rol_detalle.TipoMovimiento, dbo.ro_rol.Cerrado AS EstadoRol, dbo.ro_rol.IdCentroCosto, dbo.ro_periodo.IdPeriodo, dbo.ro_periodo.pe_anio, dbo.ro_periodo.pe_mes, 
                         dbo.ro_periodo.pe_FechaIni AS FechaIni, dbo.ro_periodo.pe_FechaFin AS FechaFin, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Cerrado, dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Procesado, 
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui.Contabilizado, dbo.ro_empleado.em_tipoCta AS TipoCuenta, dbo.ro_empleado.em_NumCta AS NumCuenta, dbo.ro_empleado.IdBanco, 
                         dbo.tb_persona.IdTipoDocumento AS TipoIdentificacion, dbo.ro_empleado.IdDivision, dbo.ro_Division.Descripcion AS DivisionDescripcion, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, 
                         dbo.tb_banco.CodigoLegal, dbo.ro_Departamento.IdDepartamento, dbo.tb_banco.ba_descripcion
FROM            dbo.ro_rubro_tipo INNER JOIN
                         dbo.ro_rol_detalle INNER JOIN
                         dbo.ro_Nomina_Tipoliqui INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_Nomina_Tipo.IdNomina_Tipo INNER JOIN
                         dbo.ro_rol ON dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_rol.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_rol.IdNominaTipo AND 
                         dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui = dbo.ro_rol.IdNominaTipoLiqui ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_rol.IdEmpresa AND dbo.ro_rol_detalle.IdNominaTipo = dbo.ro_rol.IdNominaTipo AND 
                         dbo.ro_rol_detalle.IdNominaTipoLiqui = dbo.ro_rol.IdNominaTipoLiqui AND dbo.ro_rol_detalle.IdPeriodo = dbo.ro_rol.IdPeriodo INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona ON dbo.ro_rol_detalle.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         dbo.ro_rol_detalle.IdEmpresa = dbo.ro_empleado.IdEmpresa ON dbo.ro_rubro_tipo.IdRubro = dbo.ro_rol_detalle.IdRubro INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui ON dbo.ro_rol.IdEmpresa = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa AND 
                         dbo.ro_rol.IdNominaTipo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_Tipo AND dbo.ro_rol.IdNominaTipoLiqui = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdNomina_TipoLiqui AND 
                         dbo.ro_rol.IdPeriodo = dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo INNER JOIN
                         dbo.ro_periodo ON dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdPeriodo = dbo.ro_periodo.IdPeriodo AND dbo.ro_periodo_x_ro_Nomina_TipoLiqui.IdEmpresa = dbo.ro_periodo.IdEmpresa INNER JOIN
                         dbo.tb_empresa ON dbo.ro_Departamento.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ro_Division ON dbo.ro_empleado.IdEmpresa = dbo.ro_Division.IdEmpresa AND dbo.ro_empleado.IdDivision = dbo.ro_Division.IdDivision INNER JOIN
                         dbo.tb_banco ON dbo.ro_empleado.IdBanco = dbo.tb_banco.IdBanco
WHERE        (dbo.ro_rol_detalle.IdRubro = '950')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[4] 2[43] 3) )"
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
         Configuration = "(H (1[9] 4[65] 2) )"
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
         Top = -1437
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ro_rubro_tipo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_rol_detalle"
            Begin Extent = 
               Top = 0
               Left = 539
               Bottom = 130
               Right = 748
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Nomina_Tipoliqui"
            Begin Extent = 
               Top = 103
               Left = 796
               Bottom = 233
               Right = 1032
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Nomina_Tipo"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_rol"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 796
               Right = 327
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 928
               Right = 270
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Empleado_Rol_Detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Departamento"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1060
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_periodo_x_ro_Nomina_TipoLiqui"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1192
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_periodo"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1324
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1456
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Division"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1588
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_banco"
            Begin Extent = 
               Top = 1582
               Left = 729
               Bottom = 1747
               Right = 963
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
      Begin ColumnWidths = 42
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2325
         Width = 2085
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Empleado_Rol_Detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Empleado_Rol_Detalle';

