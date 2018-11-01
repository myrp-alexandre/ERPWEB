CREATE VIEW dbo.vwRo_Archivos_Bancos_Generacion
AS
SELECT        dbo.ro_Nomina_Tipo.Descripcion, dbo.ro_Nomina_Tipoliqui.DescripcionProcesoNomina, dbo.ro_Division.Descripcion AS Descripcion_Division, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, 
                         dbo.ro_archivos_bancos_generacion.IdEmpresa, dbo.ro_archivos_bancos_generacion.IdArchivo, dbo.ro_archivos_bancos_generacion.IdNomina, dbo.ro_archivos_bancos_generacion.IdNominaTipo, 
                         dbo.ro_archivos_bancos_generacion.IdPeriodo, dbo.ro_archivos_bancos_generacion.IdBanco, dbo.ro_archivos_bancos_generacion.IdDivision, dbo.ro_archivos_bancos_generacion.Cod_Empresa, 
                         dbo.ro_archivos_bancos_generacion.Nom_Archivo, dbo.ro_archivos_bancos_generacion.archivo, dbo.ro_archivos_bancos_generacion.estado, dbo.ro_archivos_bancos_generacion.IdUsuario, 
                         dbo.ro_archivos_bancos_generacion.Fecha_Transac, dbo.ro_archivos_bancos_generacion.MotiAnula, dbo.tb_banco.ba_descripcion, dbo.tb_banco.CodigoLegal, dbo.ro_archivos_bancos_generacion.IdBanco_Acredita, 
                         dbo.ro_archivos_bancos_generacion.IdProceso_Bancario, dbo.vwRo_Archivos_Bancos_Generacion_total_archivo.Valor, dbo.ro_archivos_bancos_generacion.IdEmpesa_mod_banco, 
                         dbo.ro_archivos_bancos_generacion.IdArchivo_mod_banco
FROM            dbo.ro_Nomina_Tipo INNER JOIN
                         dbo.ro_Nomina_Tipoliqui ON dbo.ro_Nomina_Tipo.IdEmpresa = dbo.ro_Nomina_Tipoliqui.IdEmpresa AND dbo.ro_Nomina_Tipo.IdNomina_Tipo = dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo INNER JOIN
                         dbo.ro_archivos_bancos_generacion ON dbo.ro_Nomina_Tipoliqui.IdNomina_TipoLiqui = dbo.ro_archivos_bancos_generacion.IdNominaTipo AND 
                         dbo.ro_Nomina_Tipoliqui.IdEmpresa = dbo.ro_archivos_bancos_generacion.IdEmpresa AND dbo.ro_Nomina_Tipoliqui.IdNomina_Tipo = dbo.ro_archivos_bancos_generacion.IdNomina INNER JOIN
                         dbo.ro_periodo ON dbo.ro_archivos_bancos_generacion.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_archivos_bancos_generacion.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.tb_banco ON dbo.ro_archivos_bancos_generacion.IdBanco = dbo.tb_banco.IdBanco INNER JOIN
                         dbo.vwRo_Archivos_Bancos_Generacion_total_archivo ON dbo.ro_archivos_bancos_generacion.IdEmpresa = dbo.vwRo_Archivos_Bancos_Generacion_total_archivo.IdEmpresa AND 
                         dbo.ro_archivos_bancos_generacion.IdArchivo = dbo.vwRo_Archivos_Bancos_Generacion_total_archivo.IdArchivo LEFT OUTER JOIN
                         dbo.ro_Division ON dbo.ro_archivos_bancos_generacion.IdDivision = dbo.ro_Division.IdDivision AND dbo.ro_archivos_bancos_generacion.IdEmpresa = dbo.ro_Division.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[85] 4[5] 2[5] 3) )"
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
         Begin Table = "ro_Nomina_Tipo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Nomina_Tipoliqui"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 274
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_archivos_bancos_generacion"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 324
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "ro_periodo"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_banco"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwRo_Archivos_Bancos_Generacion_total_archivo"
            Begin Extent = 
               Top = 283
               Left = 755
               Bottom = 396
               Right = 925
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Division"
            Begin Extent = 
               Top = 384
               Left = 297
               Bottom', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Archivos_Bancos_Generacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 514
               Right = 476
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Archivos_Bancos_Generacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwRo_Archivos_Bancos_Generacion';

