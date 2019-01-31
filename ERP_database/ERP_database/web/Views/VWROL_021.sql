CREATE view web. VWROL_021 as 
SELECT        ing_comp.IdEmpresa, ing_comp.IdSucursal, ing_comp.IdNominaTipo, ing_comp.IdNominaTipoLiqui, ing_comp.IdEmpleado, ing_comp.IdArea, ing_comp.IDividion AS IdDivision, ing_comp.IdAreaEmpleado, 
                         area.Descripcion AS AreaEmpleado, ing_comp.IdPeriodo, ing_comp.IdRubro, ing_comp.se_distribuye, ing_comp.Orden, ing_comp.Porcentaje, ing_comp.Valor, ing_comp.rub_visible_reporte, ing_comp.Observacion, 
                         ing_comp.ru_descripcion, ing_comp.pe_FechaIni, pe_FechaFin, ing_comp.ru_tipo, ing_comp.rub_codigo, ing_comp.ru_codRolGen, ing_comp.ca_descripcion, ing_comp.em_codigo, ing_comp.pe_cedulaRuc, 
                         ing_comp.pe_nombreCompleto, ing_comp.IdRol, ing_comp.Descripcion, ing_comp.rub_grupo, ing_comp.Dias
FROM            (SELECT        rol_det.IdEmpresa, rol.IdSucursal, rol.IdNominaTipo, rol.IdNominaTipoLiqui, rol_det.IdEmpleado, emp_div.IdArea, emp_div.IDividion, dbo.ro_empleado.IdArea AS IdAreaEmpleado, rol.IdPeriodo, rol_det.IdRubro, 
                                                    rubr.se_distribuye, rubr.ru_orden AS Orden, emp_div.Porcentaje, 
													
													 CASE WHEN rubr.se_distribuye = 1 THEN case when rubr.ru_tipo='I' then (rol_det.Valor * emp_div.Porcentaje) / 100  else rol_det.Valor end  ELSE   rol_det.Valor END AS Valor, 
													
													rol_det.rub_visible_reporte, 
                                                    rol_det.Observacion, CASE WHEN (rubr.se_distribuye = 1 AND (rub_cal.IdRubro_sueldo = rol_det.IdRubro OR
                                                    rub_cal.IdRubro_horas_matutina = rol_det.IdRubro OR
                                                    rub_cal.IdRubro_horas_vespertina = rol_det.IdRubro)) THEN 'SUELDOS POR HORA' ELSE rubr.ru_descripcion END AS ru_descripcion, perid.pe_FechaIni, perid.pe_FechaFin, rubr.ru_tipo, rubr.rub_codigo, 
                                                    rubr.ru_codRolGen, CASE WHEN ru_tipo = 'A' THEN '3 - TOTALES' WHEN ru_tipo = 'I' THEN '1 - INGRESOS' ELSE '2 - EGRESOS' END AS ca_descripcion, dbo.ro_empleado.em_codigo, 
                                                    dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_nombreCompleto, rol_det.IdRol, 
													
													 CASe when rubr.ru_tipo='I' then dbo.ro_area.Descripcion + '-' + CAST(emp_div.Porcentaje AS varchar) else '' end  Descripcion, 
													
													cat.ca_descripcion AS rub_grupo, d .Dias
                          FROM            dbo.ro_area INNER JOIN
                                                    dbo.ro_empleado_division_area_x_rol AS emp_div ON dbo.ro_area.IdEmpresa = emp_div.IdEmpresa AND dbo.ro_area.IdArea = emp_div.IdArea RIGHT OUTER JOIN
                                                    dbo.ro_rol AS rol INNER JOIN
                                                    dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON rol.IdEmpresa = pe_x_nom.IdEmpresa AND rol.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND rol.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND
                                                     rol.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                                                    dbo.ro_periodo AS perid ON pe_x_nom.IdEmpresa = perid.IdEmpresa AND pe_x_nom.IdPeriodo = perid.IdPeriodo INNER JOIN
                                                    dbo.ro_rubro_tipo AS rubr INNER JOIN
                                                    dbo.ro_rol_detalle AS rol_det ON rubr.IdEmpresa = rol_det.IdEmpresa AND rubr.IdRubro = rol_det.IdRubro ON rol.IdEmpresa = rol_det.IdEmpresa AND rol.IdRol = rol_det.IdRol LEFT OUTER JOIN
                                                    dbo.ro_empleado INNER JOIN
                                                    dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona ON rol_det.IdEmpresa = dbo.ro_empleado.IdEmpresa AND rol_det.IdEmpleado = dbo.ro_empleado.IdEmpleado ON 
                                                    emp_div.IdEmpresa = rol_det.IdEmpresa AND emp_div.IdEmpleado = rol_det.IdEmpleado AND emp_div.IdRol = rol_det.IdRol INNER JOIN
                                                    dbo.ro_catalogo AS cat ON rubr.rub_grupo = cat.CodCatalogo LEFT OUTER JOIN
                                                    ro_rubros_calculados rub_cal ON rub_cal.IdEmpresa = dbo.ro_area.IdEmpresa LEFT OUTER JOIN
                                                        (SELECT        det.IdEmpresa, det.IdRol, det.IdEmpleado, det.Valor AS Dias
                                                          FROM            dbo.ro_rol_detalle AS det INNER JOIN
                                                                                    dbo.ro_rubros_calculados AS p ON p.IdEmpresa = det.IdEmpresa AND det.IdRubro = p.IdRubro_dias_trabajados) AS d ON d .IdEmpresa = rol_det.IdEmpresa AND d .IdRol = rol_det.IdRol AND 
                                                    d .IdEmpleado = rol_det.IdEmpleado
                          WHERE        ro_empleado.Tiene_ingresos_compartidos = 1) AS ing_comp LEFT OUTER JOIN
                         ro_area area ON area.IdEmpresa = ing_comp.IdEmpresa AND area.IdArea = ing_comp.IdAreaEmpleado
UNION ALL
SELECT        rol_det.IdEmpresa, rol.IdSucursal, rol.IdNominaTipo, rol.IdNominaTipoLiqui, rol_det.IdEmpleado, dbo.ro_empleado.IdArea, dbo.ro_empleado.IdDivision, dbo.ro_empleado.IdArea, dbo.ro_area.Descripcion, rol.IdPeriodo, 
                         rol_det.IdRubro, rubr.se_distribuye, rubr.ru_orden AS Orden, 0 AS Expr1, rol_det.Valor, rol_det.rub_visible_reporte, rol_det.Observacion, rubr.ru_descripcion, perid.pe_FechaIni, perid.pe_FechaFin, rubr.ru_tipo, rubr.rub_codigo, 
                         rubr.ru_codRolGen, CASE WHEN ru_tipo = 'A' THEN '3 - TOTALES' WHEN ru_tipo = 'I' THEN '1 - INGRESOS' ELSE '2 - EGRESOS' END AS ca_descripcion, dbo.ro_empleado.em_codigo, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_nombreCompleto, rol_det.IdRol, '' Descripcion, cat.ca_descripcion AS rub_grupo, d .Dias
FROM            dbo.ro_rol AS rol INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON rol.IdEmpresa = pe_x_nom.IdEmpresa AND rol.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND rol.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND 
                         rol.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                         dbo.ro_periodo AS perid ON pe_x_nom.IdEmpresa = perid.IdEmpresa AND pe_x_nom.IdPeriodo = perid.IdPeriodo INNER JOIN
                         dbo.ro_rubro_tipo AS rubr INNER JOIN
                         dbo.ro_rol_detalle AS rol_det ON rubr.IdEmpresa = rol_det.IdEmpresa AND rubr.IdRubro = rol_det.IdRubro ON rol.IdEmpresa = rol_det.IdEmpresa AND rol.IdRol = rol_det.IdRol LEFT OUTER JOIN
                         dbo.ro_area INNER JOIN
                         dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona ON dbo.ro_area.IdArea = dbo.ro_empleado.IdArea AND dbo.ro_area.IdEmpresa = dbo.ro_empleado.IdEmpresa ON 
                         rol_det.IdEmpresa = dbo.ro_empleado.IdEmpresa AND rol_det.IdEmpleado = dbo.ro_empleado.IdEmpleado LEFT OUTER JOIN
                         dbo.ro_catalogo AS cat ON rubr.rub_grupo = cat.CodCatalogo LEFT OUTER JOIN
                             (SELECT        det.IdEmpresa, det.IdRol, det.IdEmpleado, det.Valor AS Dias
                               FROM            dbo.ro_rol_detalle AS det INNER JOIN
                                                         dbo.ro_rubros_calculados AS p ON p.IdEmpresa = det.IdEmpresa AND det.IdRubro = p.IdRubro_dias_trabajados) AS d ON d .IdEmpresa = rol_det.IdEmpresa AND d .IdRol = rol_det.IdRol AND 
                         d .IdEmpleado = rol_det.IdEmpleado
WHERE        (dbo.ro_empleado.Tiene_ingresos_compartidos = 0)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_021';




GO



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[5] 2[46] 3) )"
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
         Top = -511
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
      Begin ColumnWidths = 31
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
         Width = 1380
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



