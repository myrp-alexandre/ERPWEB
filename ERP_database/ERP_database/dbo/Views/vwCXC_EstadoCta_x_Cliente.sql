CREATE VIEW [dbo].[vwCXC_EstadoCta_x_Cliente]
AS
SELECT        A.IdEmpresa, A.IdSucursal, A.Su_Descripcion, A.IdCliente, A.vt_tipoDoc, CONVERT(varchar(3), vt_serie1) + '-' + CONVERT(varchar(3), vt_serie2) 
                         + '-' + CONVERT(varchar(20), vt_NumFactura) AS numDocumento, a.IdCbteVta, a.vt_fecha, a.vt_fech_venc, a.vt_plazo, a.vt_total, '' AS Estado, NULL 
                         AS Valor_x_Pagar, NULL AS Valor_Vencido, NULL Saldo,0 as IdReg
FROM            vwfa_factura A
UNION
SELECT        A.IdEmpresa, A.IdSucursal, S.Su_Descripcion, A.IdCliente, a.IdCobro_tipo, a.cr_NumDocumento, b.IdCbte_vta_nota, a.cr_fecha, a.cr_fechaCobro, 0 AS Plazo, 
                         sum(dc_ValorPago) AS Monto, '' AS Estado, NULL AS Valor_x_Pagar, NULL AS Valor_Vencido, NULL Saldo
,1 as IdReg
FROM            cxc_cobro A, cxc_cobro_det B, tb_sucursal S
WHERE        A.IdEmpresa = B.IdEmpresa AND A.IdCobro = B.IdCobro AND A.IdSucursal = S.IdSucursal AND B.IdSucursal = S.IdSucursal AND A.IdEmpresa = S.IdEmpresa AND 
                         B.IdEmpresa = S.IdEmpresa
GROUP BY A.IdEmpresa, A.IdSucursal, S.Su_Descripcion, A.IdCliente, a.IdCobro_tipo, a.cr_NumDocumento, b.IdCbte_vta_nota, a.cr_fecha, a.cr_fechaCobro
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[4] 2[63] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_EstadoCta_x_Cliente';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXC_EstadoCta_x_Cliente';

