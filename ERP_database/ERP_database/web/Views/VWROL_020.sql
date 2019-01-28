CREATE view web.VWROL_020 as
SELECT           ROW_NUMBER() OVER (ORDER BY archiv.IdEmpresa DESC) AS Secuancia,archiv.IdEmpresa, archiv.IdArchivo, archiv.IdNomina, archiv.IdNominaTipo, archiv.IdPeriodo, emp.IdDivision, emp.IdArea, archiv.IdCuentaBancaria, archiv.IdProceso, archv_det.Valor, 
                         CASE WHEN emp.em_tipoCta = 'AHO' THEN 'A' WHEN emp.em_tipoCta = 'COR' THEN 'C' ELSE 'E' END AS em_tipoCta, emp.em_NumCta, per.pe_apellido + ' ' + per.pe_nombre AS Nombres, per.pe_cedulaRuc, emp.em_codigo, 
                         nom_tip.DescripcionProcesoNomina, nom.Descripcion, periodo.pe_FechaIni, periodo.pe_FechaFin, archv_det.IdSucursal, emp.em_tipoCta AS TipoCuenta, dbo.ro_area.Descripcion AS Area, 
                         dbo.ro_Division.Descripcion AS Division
FROM            dbo.ro_area INNER JOIN
                         dbo.tb_persona AS per INNER JOIN
                         dbo.ro_empleado AS emp ON per.IdPersona = emp.IdPersona ON dbo.ro_area.IdEmpresa = emp.IdEmpresa AND dbo.ro_area.IdArea = emp.IdArea INNER JOIN
                         dbo.ro_Division ON emp.IdEmpresa = dbo.ro_Division.IdEmpresa AND emp.IdDivision = dbo.ro_Division.IdDivision RIGHT OUTER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom INNER JOIN
                         dbo.ro_archivos_bancos_generacion AS archiv INNER JOIN
                         dbo.ro_archivos_bancos_generacion_x_empleado AS archv_det ON archiv.IdEmpresa = archv_det.IdEmpresa AND archiv.IdArchivo = archv_det.IdArchivo ON pe_x_nom.IdEmpresa = archiv.IdEmpresa AND 
                         pe_x_nom.IdNomina_Tipo = archiv.IdNomina AND pe_x_nom.IdNomina_TipoLiqui = archiv.IdNominaTipo AND pe_x_nom.IdPeriodo = archiv.IdPeriodo INNER JOIN
                         dbo.ro_periodo AS periodo ON pe_x_nom.IdEmpresa = periodo.IdEmpresa AND pe_x_nom.IdPeriodo = periodo.IdPeriodo INNER JOIN
                         dbo.ro_Nomina_Tipoliqui AS nom_tip ON pe_x_nom.IdEmpresa = nom_tip.IdEmpresa AND pe_x_nom.IdNomina_Tipo = nom_tip.IdNomina_Tipo AND pe_x_nom.IdNomina_TipoLiqui = nom_tip.IdNomina_TipoLiqui INNER JOIN
                         dbo.ro_Nomina_Tipo AS nom ON nom_tip.IdEmpresa = nom.IdEmpresa AND nom_tip.IdNomina_Tipo = nom.IdNomina_Tipo ON emp.IdEmpresa = archv_det.IdEmpresa AND emp.IdEmpleado = archv_det.IdEmpleado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_020';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[5] 2[58] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'web', @level1type = N'VIEW', @level1name = N'VWROL_020';

