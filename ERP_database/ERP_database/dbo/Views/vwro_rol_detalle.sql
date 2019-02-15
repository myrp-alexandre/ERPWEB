CREATE VIEW [dbo].[vwro_rol_detalle]
AS
SELECT        r.IdEmpresa, r.IdRol, r.IdSucursal, r.IdNominaTipo, r.IdNominaTipoLiqui, r.IdPeriodo, r_det.IdEmpleado, r_det.IdRubro, r_det.Valor, rub.ru_tipo, rub.rub_ctacon, emp.IdCtaCble_Emplea, emp.IdDivision, emp.IdArea, 
                         emp.IdDepartamento, rub.ru_descripcion, per.pe_nombreCompleto, rub.rub_provision, rub.rub_ContPorEmpleado
FROM            dbo.ro_rol AS r INNER JOIN
                         dbo.ro_rol_detalle AS r_det ON r.IdEmpresa = r_det.IdEmpresa AND r.IdRol = r_det.IdRol INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON r_det.IdEmpresa = rub.IdEmpresa AND r_det.IdRubro = rub.IdRubro INNER JOIN
                         dbo.ro_empleado AS emp ON r_det.IdEmpresa = emp.IdEmpresa AND r_det.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona
WHERE        (rub.rub_nocontab = 1) AND emp.Tiene_ingresos_compartidos = 0
UNION ALL
/* empleados que tienen sueldos compartidos y rubros que se distribuyen*/ SELECT rol.IdEmpresa, rol.IdRol, rol.IdSucursal, rol.IdNominaTipo, rol.IdNominaTipoLiqui, rol.IdPeriodo, rol.IdEmpleado, rol.IdRubro, (rol.Valor) 
                         * (ing_comp.Porcentaje / 100) Valor, rol.ru_tipo, rol.rub_ctacon, rol.IdCtaCble_Emplea, rol.IdDivision, ing_comp.IdArea, rol.IdDepartamento, rol.ru_descripcion, rol.pe_nombreCompleto, rol.rub_provision, 
                         rol.rub_ContPorEmpleado
FROM            (SELECT        r.IdEmpresa, r.IdRol, r.IdSucursal, r.IdNominaTipo, r.IdNominaTipoLiqui, r.IdPeriodo, r_det.IdEmpleado, r_det.IdRubro, r_det.Valor, rub.ru_tipo, rub.rub_ctacon, emp.IdCtaCble_Emplea, emp.IdDivision, emp.IdArea, 
                                                    emp.IdDepartamento, rub.ru_descripcion, per.pe_nombreCompleto, rub.rub_provision, rub.rub_ContPorEmpleado, rub.se_distribuye
                          FROM            dbo.ro_rol AS r INNER JOIN
                                                    dbo.ro_rol_detalle AS r_det ON r.IdEmpresa = r_det.IdEmpresa AND r.IdRol = r_det.IdRol INNER JOIN
                                                    dbo.ro_rubro_tipo AS rub ON r_det.IdEmpresa = rub.IdEmpresa AND r_det.IdRubro = rub.IdRubro INNER JOIN
                                                    dbo.ro_empleado AS emp ON r_det.IdEmpresa = emp.IdEmpresa AND r_det.IdEmpleado = emp.IdEmpleado INNER JOIN
                                                    dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona
                          WHERE        (rub.rub_nocontab = 1) AND emp.Tiene_ingresos_compartidos = 1 AND rub.se_distribuye = 1) rol INNER JOIN
                             (SELECT        emp_x_are_xrol.IdEmpresa, emp_x_are_xrol.IdRol, emp_x_are_xrol.Secuencia, emp_x_are_xrol.IdEmpleado, emp_x_are_xrol.IDividion, emp_x_are_xrol.IdArea, emp_x_are_xrol.Porcentaje, area.Descripcion, 
                                                         ro_empleado_x_division_x_area.CargaGasto
                               FROM            ro_empleado_division_area_x_rol AS emp_x_are_xrol INNER JOIN
                                                         ro_area AS area ON emp_x_are_xrol.IdEmpresa = area.IdEmpresa AND emp_x_are_xrol.IDividion = area.IdDivision AND emp_x_are_xrol.IdArea = area.IdArea INNER JOIN
                                                         ro_empleado_x_division_x_area ON area.IdEmpresa = ro_empleado_x_division_x_area.IdEmpresa AND area.IdDivision = ro_empleado_x_division_x_area.IDividion AND 
                                                         area.IdArea = ro_empleado_x_division_x_area.IdArea AND emp_x_are_xrol.IdEmpleado = ro_empleado_x_division_x_area.IdEmpleado) ing_comp ON rol.IdEmpresa = ing_comp.IdEmpresa AND 
                         rol.IdRol = ing_comp.IdRol AND rol.IdEmpleado = ing_comp.IdEmpleado
UNION ALL
/* empleados que tienen sueldos compartidos y rubros que no se distribuyen*/ SELECT r.IdEmpresa, r.IdRol, r.IdSucursal, r.IdNominaTipo, r.IdNominaTipoLiqui, r.IdPeriodo, r_det.IdEmpleado, r_det.IdRubro, r_det.Valor, rub.ru_tipo, 
                         rub.rub_ctacon, emp.IdCtaCble_Emplea, emp.IdDivision, emp.IdArea, emp.IdDepartamento, rub.ru_descripcion, per.pe_nombreCompleto, rub.rub_provision, rub.rub_ContPorEmpleado
FROM            dbo.ro_rol AS r INNER JOIN
                         dbo.ro_rol_detalle AS r_det ON r.IdEmpresa = r_det.IdEmpresa AND r.IdRol = r_det.IdRol INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON r_det.IdEmpresa = rub.IdEmpresa AND r_det.IdRubro = rub.IdRubro INNER JOIN
                         dbo.ro_empleado AS emp ON r_det.IdEmpresa = emp.IdEmpresa AND r_det.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona
WHERE        (rub.rub_nocontab = 1) AND emp.Tiene_ingresos_compartidos = 1 AND rub.se_distribuye = 0
UNION ALL
/*Rubros acumulados*/SELECT        ro_rol_detalle_x_rubro_acumulado.IdEmpresa, ro_rol_detalle_x_rubro_acumulado.IdRol, ro_rol.IdSucursal, ro_rol.IdNominaTipo, ro_rol.IdNominaTipoLiqui, ro_rol.IdPeriodo, ro_rol_detalle_x_rubro_acumulado.IdEmpleado, 
                         ro_rol_detalle_x_rubro_acumulado.IdRubro, ro_rol_detalle_x_rubro_acumulado.Valor, ro_rubro_tipo.ru_tipo, ro_Config_Param_contable.IdCtaCble, ro_Config_Param_contable.IdCtaCble_Haber, ro_empleado.IdDivision, 
                         ro_empleado.IdArea, ro_empleado.IdDepartamento, ro_rubro_tipo.ru_descripcion, tb_persona.pe_nombreCompleto, ro_rubro_tipo.rub_provision, ro_rubro_tipo.rub_ContPorEmpleado
FROM            ro_rol_detalle_x_rubro_acumulado INNER JOIN
                         ro_rol ON ro_rol_detalle_x_rubro_acumulado.IdEmpresa = ro_rol.IdEmpresa AND ro_rol_detalle_x_rubro_acumulado.IdRol = ro_rol.IdRol INNER JOIN
                         ro_rubro_tipo ON ro_rol_detalle_x_rubro_acumulado.IdEmpresa = ro_rubro_tipo.IdEmpresa AND ro_rol_detalle_x_rubro_acumulado.IdRubro = ro_rubro_tipo.IdRubro INNER JOIN
                         ro_empleado ON ro_rol_detalle_x_rubro_acumulado.IdEmpresa = ro_empleado.IdEmpresa AND ro_rol_detalle_x_rubro_acumulado.IdEmpleado = ro_empleado.IdEmpleado INNER JOIN
                         tb_persona ON ro_empleado.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
                         ro_Config_Param_contable ON ro_empleado.IdEmpresa = ro_Config_Param_contable.IdEmpresa AND ro_empleado.IdDepartamento = ro_Config_Param_contable.IdDepartamento AND 
                         ro_empleado.IdDivision = ro_Config_Param_contable.IdDivision AND ro_empleado.IdArea = ro_Config_Param_contable.IdArea AND ro_rol_detalle_x_rubro_acumulado.IdEmpresa = ro_Config_Param_contable.IdEmpresa AND 
                         ro_rol_detalle_x_rubro_acumulado.IdRubro = ro_Config_Param_contable.IdRubro
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_rol_detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'd
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_rol_detalle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[86] 4[5] 2[5] 3) )"
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
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r_det"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 136
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rub"
            Begin Extent = 
               Top = 56
               Left = 731
               Bottom = 460
               Right = 949
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 327
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "per"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
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
En', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwro_rol_detalle';

