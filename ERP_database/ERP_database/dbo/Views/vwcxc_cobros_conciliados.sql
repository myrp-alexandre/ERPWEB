CREATE VIEW [dbo].[vwcxc_cobros_conciliados]
AS
SELECT        IdEmpresa, IdSucursal, IdBodega, IdConciliacion, Tipo, IdCobro, IdNota, CreDeb, Serie1, Serie2, NumNota_Impresa, IdCliente, NomSucursal, Nom_Bodega, 
                         no_fecha, no_fecha_venc, sc_observacion, Nom_Cliente, Motivo_Nota, Referencia, sc_total, Saldo, IdTipoConciliacion, 
                         CASE [Tipo] WHEN 'NTCR' THEN 'NTCR' WHEN 'NTDB' THEN 'NTDE' END AS IdCobro_Tipo, IdTipoNota, 0 as IdCaja
FROM            dbo.vwcxc_conciliacion_Det_CreDeb
UNION
SELECT        a.IdEmpresa AS IdEmpresa, a.IdSucursal AS IdSucursal, NULL AS IdBodega, IdConciliacion, a.IdCobro_tipo, a.IdCobro_cobro, NULL AS idnota, NULL 
                         AS creddeb, NULL AS serie1, NULL AS serie2, NULL AS numnota, a.IdCliente, su.Su_Descripcion, NULL AS Nom_bodega, a.Fecha, a.Fecha, a.Observacion, 
                         a.pe_apellido + ' ' + a.pe_nombre, NULL MotivoNota, 'Anticipo/Cliente#' + cast(a.IdAnticipo AS varchar(10)) + 'en ' + a.IdCobro_tipo + ' banco' + isnull(a.cr_Banco, '') 
                         + ' Doc#' + isnull(a.cr_NumDocumento, '') AS Referencia, a.cr_TotalCobro, a.Saldo_Pendiente, 'ANT_CLI' AS TipoConciliacion, a.IdCobro_tipo, NULL AS TipoNota, 
                         a.IdCaja
FROM            vwcxc_conciliacion_Det_Anticipo AS a INNER JOIN
                         tb_sucursal AS su ON a.IdEmpresa = su.IdEmpresa AND a.IdSucursal = su.IdSucursal
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_conciliados';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_conciliados';

