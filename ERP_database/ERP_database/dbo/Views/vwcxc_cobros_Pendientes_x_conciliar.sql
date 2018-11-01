CREATE VIEW [dbo].[vwcxc_cobros_Pendientes_x_conciliar]
AS
SELECT        creDeb.IdEmpresa, creDeb.IdSucursal, creDeb.IdBodega, Tipo, NULL AS IdCobro, IdNota, CreDeb, Serie1, Serie2, NumNota_Impresa, creDeb.IdCliente, NomSucursal,
                          Nom_Bodega, no_fecha, no_fecha_venc, sc_observacion, Nom_Cliente, Motivo_Nota, Referencia, ROUND(sc_total, 2) AS sc_total , ROUND(Saldo, 2) AS Saldo, IdTipoConciliacion, 
                         CASE [Tipo] WHEN 'NTCR' THEN 'NTCR' WHEN 'NTDB' THEN 'NTDE' END AS IdCobro_Tipo, IdTipoNota, 0 as IdCaja,  faCli.IdCtaCble_cxc, faCli.IdCtaCble_Anti
FROM            dbo.vwfa_creditos_debitos_con_saldo creDeb INNER JOIN
                         fa_cliente AS faCli ON faCli.IdEmpresa = creDeb.IdEmpresa AND faCli.IdCliente = creDeb.IdCliente
UNION
SELECT        a.IdEmpresa_Cobro AS IdEmpresa, a.IdSucursal_cobro AS IdSucursal, NULL AS IdBodega, a.IdCobro_tipo, a.IdCobro_cobro, NULL AS idnota, NULL AS creddeb, NULL
                          AS serie1, NULL AS serie2, NULL AS numnota, a.IdCliente, su.Su_Descripcion, NULL AS Nom_bodega, a.Fecha, a.Fecha, a.Observacion, 
                         a.pe_apellido + ' ' + a.pe_nombre, NULL MotivoNota, 'Anticipo/Cliente#' + cast(a.IdAnticipo AS varchar(10)) + 'en ' + a.IdCobro_tipo + ' banco' + isnull(a.cr_Banco, '') 
                         + ' Doc#' + isnull(a.cr_NumDocumento, '') AS Referencia, ROUND(a.cr_TotalCobro, 2)  AS sc_total , ROUND(a.Saldo_Pendiente, 2) AS Saldo, 'ANT_CLI' AS TipoConciliacion, a.IdCobro_tipo, NULL AS TipoNota, 
                         a.IdCaja, IIF((ISNULL(faCli.IdCtaCble_cxc, '') = ''), cobroTipo.IdCtaCble, faCli.IdCtaCble_cxc) AS IdCtaCble_cxc, IIF((ISNULL(faCli.IdCtaCble_Anti, '') = ''), 
                         cobroTipo.IdCtaCble_Anticipo, faCli.IdCtaCble_Anti) AS IdCtaCble_Anti
FROM            vwcxc_anticipos_x_cruzar AS a INNER JOIN
                         tb_sucursal AS su ON a.IdEmpresa = su.IdEmpresa AND a.IdSucursal = su.IdSucursal INNER JOIN
                         fa_cliente AS faCli ON a.IdEmpresa_Cobro = faCli.IdEmpresa AND a.IdCliente = faCli.IdCliente INNER JOIN
                         cxc_cobro_tipo_Param_conta_x_sucursal cobroTipo ON cobroTipo.IdEmpresa = a.IdEmpresa_Cobro AND cobroTipo.IdSucursal = a.IdSucursal_cobro AND 
                         cobroTipo.IdCobro_tipo = a.IdCobro_tipo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[14] 2[46] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_Pendientes_x_conciliar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobros_Pendientes_x_conciliar';

