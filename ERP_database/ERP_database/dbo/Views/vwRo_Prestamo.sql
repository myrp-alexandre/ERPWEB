CREATE VIEW dbo.vwRo_Prestamo
AS
SELECT        pres.IdEmpresa, pres.IdPrestamo, pres.IdEmpleado, per_emp.pe_nombre, per_emp.pe_apellido, pres.IdRubro, rub.ru_descripcion, pres.IdEmpleado_Aprueba, per_apru.pe_nombre AS pe_nombre_apru, 
                         per_apru.pe_apellido AS pe_apellido_apru, pres.Estado, pres.Fecha, pres.MontoSol, ISNULL(estado_can.TotalCobrado, 0) AS TotalCobrado, ISNULL(pres.MontoSol - estado_can.TotalCobrado, 0) AS Valor_pendiente, 
                         pres.TasaInteres, pres.NumCuotas, pres.Fecha_PriPago, pres.Observacion, pres.Tipo_Calculo, pres.MotiAnula, per_emp.pe_cedulaRuc, 0 AS IdTipoPersona, per_emp.IdPersona, pres.IdTipoCbte, pres.IdCbteCble, 
                         pres.IdOrdenPago, pres.descuento_mensual, pres.descuento_quincena, pres.descuento_men_quin
FROM            dbo.tb_persona AS per_apru INNER JOIN
                         dbo.ro_empleado AS emp_apru ON per_apru.IdPersona = emp_apru.IdPersona RIGHT OUTER JOIN
                         dbo.ro_prestamo AS pres INNER JOIN
                         dbo.ro_empleado AS emp ON pres.IdEmpresa = emp.IdEmpresa AND pres.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS per_emp ON emp.IdPersona = per_emp.IdPersona INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON pres.IdRubro = rub.IdRubro AND pres.IdEmpresa = rub.IdEmpresa ON emp_apru.IdEmpleado = pres.IdEmpleado_Aprueba AND emp_apru.IdEmpresa = pres.IdEmpresa LEFT OUTER JOIN
                         dbo.vwRo_Prestamo_TotalCobrado AS estado_can ON pres.IdEmpresa = estado_can.IdEmpresa AND pres.IdPrestamo = estado_can.IdPrestamo

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[65] 4[5] 2[5] 3) )"
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
         Begin Table = "pres"
            Begin Extent = 
               Top = 83
               Left = 486
               Bottom = 420
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp"
            Begin Extent = 
               Top = 44
               Left = 948
               Bottom = 269
               Right = 1176
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "per_emp"
            Begin Extent = 
               Top = 20
               Left = 1050
               Bottom = 303
               Right = 1258
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "rub"
            Begin Extent = 
               Top = 23
               Left = 619
               Bottom = 268
               Right = 806
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp_apru"
            Begin Extent = 
               Top = 27
               Left = 45
               Bottom = 220
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "per_apru"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 696
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "estado_can"
            Begin Extent = 
               Top = 261
               Left = 62
               Bottom = 395
               Right = 238
            End
            DisplayFlags = 280
     ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Prestamo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       TopColumn = 0
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Prestamo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Prestamo';

