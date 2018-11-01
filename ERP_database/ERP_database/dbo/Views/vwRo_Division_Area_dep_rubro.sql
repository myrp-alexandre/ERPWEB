CREATE view vwRo_Division_Area_dep_rubro as 
SELECT       ROW_NUMBER() OVER (ORDER BY dbo.ro_rubro_tipo.idempresa) AS IdFila, dbo.ro_Division.IdEmpresa, dbo.ro_Division.IdDivision, dbo.ro_Division.Descripcion AS DescripcionDiv, dbo.ro_area.IdArea, dbo.ro_area.Descripcion AS DescripcionArea, dbo.ro_Departamento.IdDepartamento, 
                         dbo.ro_Departamento.de_descripcion, dbo.ro_rubro_tipo.IdRubro, dbo.ro_rubro_tipo.rub_codigo, dbo.ro_rubro_tipo.ru_descripcion, dbo.ro_rubro_tipo.ru_estado, dbo.ro_rubro_tipo.ru_tipo, dbo.ro_rubro_tipo.rub_concep, 
                         dbo.ro_rubro_tipo.rub_tipcal, dbo.ro_rubro_tipo.rub_ctacon, dbo.ro_rubro_tipo.rub_nocontab, dbo.ro_rubro_tipo.rub_guarda_rol, dbo.ro_rubro_tipo.rub_provision, dbo.ro_Config_Param_contable.IdCtaCble, 
                         dbo.ro_Config_Param_contable.IdCtaCble_Haber, dbo.ro_Config_Param_contable.DebCre as DebCre_rrhh, dbo.ro_Config_Param_contable.IdCentroCosto, dbo.ro_rubro_tipo.rub_noafecta, dbo.ro_rubro_tipo.rub_Acuerdo_Descuento, 
                         dbo.ro_rubro_tipo.rub_Contabiliza_x_empleado, dbo.ro_rubro_tipo.rub_aplica_IESS, dbo.ro_rubro_tipo.rub_grupo, dbo.ct_plancta.pc_Naturaleza as DebCre
FROM            dbo.ro_Config_Param_contable INNER JOIN
                         dbo.ct_plancta ON dbo.ro_Config_Param_contable.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.ro_Config_Param_contable.IdCtaCble = dbo.ct_plancta.IdCtaCble FULL OUTER JOIN
                         dbo.ro_area RIGHT OUTER JOIN
                         dbo.ro_Departamento INNER JOIN
                         dbo.ro_Division INNER JOIN
                         dbo.ro_area_x_departamento ON dbo.ro_Division.IdEmpresa = dbo.ro_area_x_departamento.IdEmpresa AND dbo.ro_Division.IdDivision = dbo.ro_area_x_departamento.IdDivision ON 
                         dbo.ro_Departamento.IdEmpresa = dbo.ro_area_x_departamento.IdEmpresa AND dbo.ro_Departamento.IdDepartamento = dbo.ro_area_x_departamento.IdDepartamento LEFT OUTER JOIN
                         dbo.ro_rubro_tipo ON dbo.ro_area_x_departamento.IdEmpresa = dbo.ro_rubro_tipo.IdEmpresa ON dbo.ro_area.IdEmpresa = dbo.ro_area_x_departamento.IdEmpresa AND 
                         dbo.ro_area.IdDivision = dbo.ro_area_x_departamento.IdDivision AND dbo.ro_area.IdArea = dbo.ro_area_x_departamento.IdArea ON dbo.ro_Config_Param_contable.IdRubro = dbo.ro_rubro_tipo.IdRubro AND 
                         dbo.ro_Config_Param_contable.IdEmpresa = dbo.ro_area_x_departamento.IdEmpresa AND dbo.ro_Config_Param_contable.IdDivision = dbo.ro_area_x_departamento.IdDivision AND 
                         dbo.ro_Config_Param_contable.IdArea = dbo.ro_area_x_departamento.IdArea AND dbo.ro_Config_Param_contable.IdDepartamento = dbo.ro_area_x_departamento.IdDepartamento
WHERE        (dbo.ro_rubro_tipo.rub_nocontab = 1)

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[5] 2[43] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Division_Area_dep_rubro';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Division_Area_dep_rubro';

