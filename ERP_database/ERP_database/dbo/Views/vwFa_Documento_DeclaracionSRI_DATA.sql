CREATE view [dbo].[vwFa_Documento_DeclaracionSRI_DATA]
as
SELECT        isnull(ROW_NUMBER() OVER (ORDER BY T1.IdEmpresa DESC), 0) AS IdFila, CASE WHEN RTRIM(LTRIM(T1.IdTipoDocumento)) 
= 'RUC' THEN '04' WHEN RTRIM(LTRIM(T1.IdTipoDocumento)) = 'CED' THEN '05' WHEN RTRIM(LTRIM(T1.IdTipoDocumento)) = 'PAS' THEN '06' ELSE '07' END tpIdCliente, 
RTRIM(LTRIM(T1.pe_cedulaRuc)) AS idCliente, CASE WHEN RTRIM(LTRIM(T1.vt_tipoDoc)) = 'FACT' THEN '18' WHEN RTRIM(LTRIM(T1.vt_tipoDoc)) 
= 'C' THEN '04' WHEN RTRIM(LTRIM(T1.vt_tipoDoc)) = 'D' THEN '05' END AS tipoComprobante, cast(T2.NumDocXCli AS varchar(50)) AS numeroComprobantes, 
CONVERT(decimal(18, 2), T1.baseNoGraIva) AS baseNoGraIva, CONVERT(decimal(18, 2), T1.baseImponible) AS baseImponible, CONVERT(decimal(18, 2), T1.baseImpGrav) 
AS baseImpGrav, CONVERT(decimal(18, 2), T1.montoIva) AS montoIva, T1.IdEmpresa, T1.anio, T1.mes, T1.Razon_Social
FROM            (SELECT        IdTipoDocumento, pe_cedulaRuc, vt_tipoDoc, SUM(baseNoGraIva) AS baseNoGraIva, SUM(baseImpGrav) AS baseImpGrav, SUM(baseImponible) 
                                                    AS baseImponible, SUM(montoIva) AS montoIva,  idempresa, Year(vt_fecha) anio, month(vt_fecha) mes, Razon_Social
                          FROM            vwFa_Documento_DeclaracionSRI
                          GROUP BY pe_cedulaRuc, IdTipoDocumento, vt_tipoDoc,  idempresa, Year(vt_fecha), month(vt_fecha), Razon_Social) T1 INNER JOIN
                             (SELECT        count(T .pe_cedulaRuc) AS NumDocXCli, T .pe_cedulaRuc, T .vt_tipoDoc, anio, mes, IdEmpresa
                               FROM            (SELECT        IdCbteVta, pe_cedulaRuc, vt_tipoDoc, idempresa, Year(vt_fecha) anio, month(vt_fecha) mes
                                                         FROM            vwFa_Documento_DeclaracionSRI
                                                         GROUP BY IdCbteVta, pe_cedulaRuc, vt_tipoDoc, idempresa, Year(vt_fecha), month(vt_fecha)) T
                               GROUP BY pe_cedulaRuc, vt_tipoDoc, anio, mes, IdEmpresa) T2 ON T1.pe_cedulaRuc = T2.pe_cedulaRuc AND T1.vt_tipoDoc = T2.vt_tipoDoc AND 
                         T1.IdEmpresa = T2.IdEmpresa AND T1.anio = T2.anio AND T1.mes = T2.mes
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_Documento_DeclaracionSRI_DATA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_Documento_DeclaracionSRI_DATA';

