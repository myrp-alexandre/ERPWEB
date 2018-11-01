CREATE VIEW [dbo].[vwAf_ActivoFijo]
AS
SELECT act.IdEmpresa, act.IdActivoFijo, 1 IdTipoDepreciacion, '' cod_tipo_depreciacion, LTRIM(RTRIM(act.Af_Nombre)) AS Af_Nombre, ISNULL(act.Af_costo_compra, 0) - ISNULL(act.Af_ValorResidual, 0) AS Af_costo_compra, 
                  ISNULL(act.Af_ValorSalvamento, 0) AS Af_ValorSalvamento, act.Af_Vida_Util, act.Af_Vida_Util * per.Valor_Ciclo_Anual AS Af_Vida_TipDepre, act.Af_fecha_ini_depre, act.Af_fecha_fin_depre, 
                  act.Af_Meses_depreciar AS Af_Meses_depreciar, act.Af_porcentaje_deprec, ROUND((ISNULL(act.Af_costo_compra, 0) - ISNULL(act.Af_ValorResidual, 0) 
                  - ISNULL(act.Af_ValorSalvamento, 0)) / IIF((act.Af_Vida_Util * per.Valor_Ciclo_Anual)=0,1,(act.Af_Vida_Util * per.Valor_Ciclo_Anual)), 2) AS Valor_Depre,  (ISNULL(act.Af_costo_compra, 0) 
                  - ISNULL(act.Af_ValorResidual, 0)) + ROUND((ISNULL(act.Af_costo_compra, 0) - ISNULL(act.Af_ValorResidual, 0) - ISNULL(act.Af_ValorSalvamento, 0)) 
                  / IIF((act.Af_Vida_Util * per.Valor_Ciclo_Anual)=0,1,(act.Af_Vida_Util * per.Valor_Ciclo_Anual)), 2) AS Valor_Importe, act.Estado_Proceso, 0 AS Es_Activo_x_Mejora, '' IdCentroCosto_sub_centro_costo
FROM     dbo.Af_Activo_fijo AS act INNER JOIN
                  dbo.Af_PeriodoDepreciacion AS per ON 0 = per.IdPeriodoDeprec 
GROUP BY act.IdEmpresa, act.IdActivoFijo, act.Af_Nombre, ISNULL(act.Af_costo_compra, 0) - ISNULL(act.Af_ValorResidual, 0), ISNULL(act.Af_ValorSalvamento, 0), act.Af_Vida_Util, 
                  act.Af_Vida_Util * per.Valor_Ciclo_Anual, act.Af_fecha_ini_depre, act.Af_fecha_fin_depre, act.Af_Meses_depreciar, act.Af_porcentaje_deprec, act.Estado_Proceso
UNION ALL
SELECT mej.IdEmpresa, mej.IdActivoFijo, tip.IdTipoDepreciacion, tip.cod_tipo_depreciacion, LTRIM(RTRIM(act.Af_Nombre)) AS Af_Nombre, ISNULL(mej.Valor_Mej_Baj_Activo, 0) AS Af_costo_compra, 0 AS Af_ValorSalvamento, act.Af_Vida_Util, 
                  act.Af_Vida_Util * per.Valor_Ciclo_Anual AS Af_Vida_TipDepre, mej.Fecha_Transac AS Af_fecha_ini_depre, DATEADD(MONTH, act.Af_Meses_depreciar, mej.Fecha_Transac) AS Af_fecha_fin_depre, 
                  act.Af_Meses_depreciar  AS Af_Meses_depreciar, act.Af_porcentaje_deprec, ROUND((ISNULL(mej.Valor_Mej_Baj_Activo, 0)) 
                  / (act.Af_Vida_Util * per.Valor_Ciclo_Anual), 2) AS Valor_Depre,  (ISNULL(mej.Valor_Mej_Baj_Activo, 0)) 
                   + ROUND((ISNULL(mej.Valor_Mej_Baj_Activo, 0)) / (act.Af_Vida_Util * per.Valor_Ciclo_Anual), 2) AS Valor_Importe, act.Estado_Proceso, 1 AS Es_Activo_x_Mejora,
				  ''IdCentroCosto_sub_centro_costo
FROM     Af_Mej_Baj_Activo mej INNER JOIN
                  dbo.Af_Activo_fijo AS act ON act.IdEmpresa = mej.IdEmpresa AND act.IdActivoFijo = mej.IdActivoFijo AND mej.Id_Tipo = 'Mejo_Acti' INNER JOIN
                  dbo.Af_Tipo_Depreciacion AS tip ON tip.IdTipoDepreciacion = 1 INNER JOIN
                  dbo.Af_PeriodoDepreciacion AS per ON 0 = per.IdPeriodoDeprec 
GROUP BY mej.IdEmpresa, mej.IdActivoFijo, tip.IdTipoDepreciacion, tip.cod_tipo_depreciacion, act.Af_Nombre, ISNULL(mej.Valor_Mej_Baj_Activo, 0), act.Af_Vida_Util, act.Af_Vida_Util * per.Valor_Ciclo_Anual, mej.Fecha_Transac, 
                  act.Af_fecha_fin_depre, act.Af_Meses_depreciar, act.Af_porcentaje_deprec, act.Estado_Proceso

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAf_ActivoFijo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwAf_ActivoFijo';

