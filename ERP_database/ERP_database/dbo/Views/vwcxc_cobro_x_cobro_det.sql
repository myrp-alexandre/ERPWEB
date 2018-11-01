CREATE VIEW [dbo].[vwcxc_cobro_x_cobro_det]
AS
SELECT        dbo.cxc_cobro_det.dc_ValorPago, dbo.cxc_cobro_det.dc_TipoDocumento, dbo.cxc_cobro_det.IdCbte_vta_nota, dbo.cxc_cobro_det.IdBodega_Cbte, 
                         dbo.vwcxc_cobro.IdPersona, dbo.vwcxc_cobro.IdCobro, dbo.vwcxc_cobro.IdSucursal, dbo.vwcxc_cobro.IdCobro_tipo, dbo.vwcxc_cobro.IdCliente, 
                         dbo.vwcxc_cobro.cr_TotalCobro, dbo.vwcxc_cobro.cr_fecha, dbo.vwcxc_cobro.cr_fechaCobro, dbo.vwcxc_cobro.cr_fechaDocu, dbo.vwcxc_cobro.cr_observacion, 
                         dbo.vwcxc_cobro.cr_Banco, dbo.vwcxc_cobro.cr_cuenta, dbo.vwcxc_cobro.cr_Tarjeta, dbo.vwcxc_cobro.cr_NumDocumento, dbo.vwcxc_cobro.cr_estado, 
                         dbo.vwcxc_cobro.cr_recibo, dbo.vwcxc_cobro.Fecha_Transac, dbo.vwcxc_cobro.IdUsuario, dbo.vwcxc_cobro.IdUsuarioUltMod, dbo.vwcxc_cobro.Fecha_UltMod, 
                         dbo.vwcxc_cobro.IdUsuarioUltAnu, dbo.vwcxc_cobro.Fecha_UltAnu, dbo.vwcxc_cobro.nom_pc, dbo.vwcxc_cobro.nSucursal, dbo.vwcxc_cobro.nCliente, 
                         dbo.vwcxc_cobro.cr_NumCheque, dbo.vwcxc_cobro.ip, dbo.vwcxc_cobro.cr_Codigo, dbo.vwcxc_cobro.IdVendedorCliente, 
                         ISNULL(dbo.cxc_cobro_x_tarjeta.IdCobro_tipo, 'PORC') AS IdEstadoCobro, dbo.vwcxc_cobro.IdEmpresa, dbo.vwcxc_cobro.IdCaja
FROM            dbo.vwcxc_cobro INNER JOIN
                         dbo.cxc_cobro_det ON dbo.vwcxc_cobro.IdEmpresa = dbo.cxc_cobro_det.IdEmpresa AND dbo.vwcxc_cobro.IdSucursal = dbo.cxc_cobro_det.IdSucursal AND 
                         dbo.vwcxc_cobro.IdCobro = dbo.cxc_cobro_det.IdCobro LEFT OUTER JOIN
                         dbo.cxc_cobro_x_tarjeta ON dbo.vwcxc_cobro.IdEmpresa = dbo.cxc_cobro_x_tarjeta.IdEmpresa AND 
                         dbo.cxc_cobro_det.IdCbte_vta_nota = dbo.cxc_cobro_x_tarjeta.IdCbte_vta_aplicado AND dbo.vwcxc_cobro.IdSucursal = dbo.cxc_cobro_x_tarjeta.IdSucursal AND 
                         dbo.vwcxc_cobro.IdCobro = dbo.cxc_cobro_x_tarjeta.IdCobro_Aplicado AND dbo.vwcxc_cobro.IdCobro_tipo = dbo.cxc_cobro_x_tarjeta.IdCobro_tipo_Aplicado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[32] 3) )"
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
         Begin Table = "vwcxc_cobro"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cxc_cobro_det"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cxc_cobro_x_tarjeta"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 248
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_cobro_det';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cobro_x_cobro_det';

