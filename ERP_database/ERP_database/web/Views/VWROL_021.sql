CREATE VIEW [web].[VWROL_021]
AS
SELECT rol.IdSucursal, rol.IdNominaTipo, rol.IdNominaTipoLiqui, rol.IdPeriodo, rol_det.IdRubro, rubr.ru_orden AS Orden, rol_det.Valor, rol_det.rub_visible_reporte, rol_det.Observacion, rubr.ru_descripcion, perid.pe_FechaIni, perid.pe_FechaFin, 
                  rubr.ru_tipo, rubr.rub_codigo, rubr.ru_codRolGen, CASE WHEN ru_tipo = 'A' THEN '3 - TOTALES' WHEN ru_tipo = 'I' THEN '1 - INGRESOS' ELSE '2 - EGRESOS' END AS ca_descripcion, dbo.ro_empleado.em_codigo, 
                  rol_det.IdEmpleado, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_nombreCompleto, dbo.ro_empleado.IdArea, dbo.ro_empleado.IdDivision, rol_det.IdRol, rol_det.IdEmpresa, dbo.ro_area.Descripcion, CAT.ca_descripcion rub_grupo,
				  Dias
FROM     dbo.ro_area INNER JOIN
                  dbo.ro_empleado INNER JOIN
                  dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona ON dbo.ro_area.IdEmpresa = dbo.ro_empleado.IdEmpresa AND dbo.ro_area.IdArea = dbo.ro_empleado.IdArea RIGHT OUTER JOIN
                  dbo.ro_rol AS rol INNER JOIN
                  dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON rol.IdEmpresa = pe_x_nom.IdEmpresa AND rol.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND rol.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND 
                  rol.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                  dbo.ro_periodo AS perid ON pe_x_nom.IdEmpresa = perid.IdEmpresa AND pe_x_nom.IdPeriodo = perid.IdPeriodo INNER JOIN
                  dbo.ro_rubro_tipo AS rubr INNER JOIN
                  dbo.ro_rol_detalle AS rol_det ON rubr.IdEmpresa = rol_det.IdEmpresa AND rubr.IdRubro = rol_det.IdRubro ON rol.IdEmpresa = rol_det.IdEmpresa AND rol.IdRol = rol_det.IdRol ON dbo.ro_empleado.IdEmpresa = rol_det.IdEmpresa AND 
                  dbo.ro_empleado.IdEmpleado = rol_det.IdEmpleado LEFT OUTER JOIN
                  dbo.ro_catalogo AS cat ON rubr.rub_grupo = cat.CodCatalogo
				  
				  left join (
				  select det.IdEmpresa, det.IdRol, det.IdEmpleado, det.Valor AS Dias
				  from ro_rol_detalle as det 
				  inner join ro_rubros_calculados as p on p.IdEmpresa = det.IdEmpresa
				  and det.IdRubro = p.IdRubro_dias_trabajados
				  ) as d on d.IdEmpresa = rol_det.IdEmpresa
				  and d.IdRol = rol_det.IdRol
				  AND D.IdEmpleado = rol_det.IdEmpleado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_021';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 280
            TopColumn = 4
         End
         Begin Table = "rol_det"
            Begin Extent = 
               Top = 1183
               Left = 48
               Bottom = 1346
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cat"
            Begin Extent = 
               Top = 1351
               Left = 48
               Bottom = 1514
               Right = 256
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
', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_021';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[80] 4[3] 2[3] 3) )"
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
         Top = -960
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ro_area"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 363
               Left = 708
               Bottom = 526
               Right = 1055
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 451
               Left = 1171
               Bottom = 614
               Right = 1445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rol"
            Begin Extent = 
               Top = 511
               Left = 48
               Bottom = 674
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pe_x_nom"
            Begin Extent = 
               Top = 679
               Left = 48
               Bottom = 842
               Right = 277
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "perid"
            Begin Extent = 
               Top = 847
               Left = 48
               Bottom = 1010
               Right = 309
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rubr"
            Begin Extent = 
               Top = 1017
               Left = 717
               Bottom = 1531
               Right = 970
            End
            DisplayFlags', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_021';

