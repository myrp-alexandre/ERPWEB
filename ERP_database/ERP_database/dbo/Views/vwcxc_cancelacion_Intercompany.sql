
CREATE VIEW [dbo].[vwcxc_cancelacion_Intercompany]
AS
SELECT     dbo.cxc_cancelacion_Intercompany.IdCliente, dbo.fa_cliente.IdPersona, dbo.tb_persona.pe_nombreCompleto, dbo.cxc_cancelacion_Intercompany.IdCobro_tipo, 
                      dbo.cxc_cancelacion_Intercompany.IdCancelacion, dbo.cxc_cancelacion_Intercompany.IdBanco_Deposito, dbo.cxc_cancelacion_Intercompany.Observacion, 
                      dbo.cxc_cancelacion_Intercompany.PapeletaDeposito, dbo.cxc_cancelacion_Intercompany.cbteban_IdEmpresa, 
                      dbo.cxc_cancelacion_Intercompany.cbteban_IdCbteCble, dbo.cxc_cancelacion_Intercompany.cbteban_IdTipocbte, dbo.cxc_cancelacion_Intercompany.cr_TotalCobro, 
                      dbo.cxc_cancelacion_Intercompany.cr_fecha, dbo.cxc_cancelacion_Intercompany.cr_fechaDocu, dbo.cxc_cancelacion_Intercompany.cr_observacion, 
                      dbo.cxc_cancelacion_Intercompany.cr_fechaCobro, dbo.cxc_cancelacion_Intercompany.cr_Banco, dbo.cxc_cancelacion_Intercompany.cr_cuenta, 
                      dbo.cxc_cancelacion_Intercompany.cr_NumDocumento, dbo.cxc_cancelacion_Intercompany.cr_Tarjeta, dbo.cxc_cancelacion_Intercompany.cr_propietarioCta, 
                      dbo.cxc_cancelacion_Intercompany.cr_estado, dbo.cxc_cancelacion_Intercompany.Fecha_Transac, dbo.cxc_cancelacion_Intercompany.IdUsuario, 
                      dbo.cxc_cancelacion_Intercompany.IdUsuarioUltMod, dbo.cxc_cancelacion_Intercompany.Fecha_UltMod, dbo.cxc_cancelacion_Intercompany.IdUsuarioUltAnu, 
                      dbo.cxc_cancelacion_Intercompany.Fecha_UltAnu, dbo.cxc_cancelacion_Intercompany.nom_pc, dbo.cxc_cancelacion_Intercompany.ip, 
                      dbo.cxc_cancelacion_Intercompany.IdSucursal, dbo.cxc_cancelacion_Intercompany.GeneraDeps, dbo.cxc_cobro_tipo.tc_descripcion, 
                      dbo.tb_sucursal.Su_Descripcion, dbo.cxc_cancelacion_Intercompany.IdCaja, dbo.cxc_cancelacion_Intercompany.IdTipoNotaCredito, dbo.tb_empresa.em_nombre, 
                      dbo.cxc_cancelacion_Intercompany.IdEmpresa
FROM         dbo.fa_cliente INNER JOIN
                      dbo.cxc_cancelacion_Intercompany ON dbo.fa_cliente.IdEmpresa = dbo.cxc_cancelacion_Intercompany.IdEmpresa AND 
                      dbo.fa_cliente.IdCliente = dbo.cxc_cancelacion_Intercompany.IdCliente INNER JOIN
                      dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                      dbo.cxc_cobro_tipo ON dbo.cxc_cancelacion_Intercompany.IdCobro_tipo = dbo.cxc_cobro_tipo.IdCobro_tipo INNER JOIN
                      dbo.tb_sucursal ON dbo.cxc_cancelacion_Intercompany.IdSucursal = dbo.tb_sucursal.IdSucursal AND 
                      dbo.cxc_cancelacion_Intercompany.IdEmpresa = dbo.tb_sucursal.IdEmpresa INNER JOIN
                      dbo.tb_empresa ON dbo.cxc_cancelacion_Intercompany.IdEmpresa = dbo.tb_empresa.IdEmpresa
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
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cxc_cancelacion_Intercompany"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 125
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cxc_cobro_tipo"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 6
               Left = 512
               Bottom = 125
               Right = 716
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
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cancelacion_Intercompany';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Column = 1440
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cancelacion_Intercompany';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcxc_cancelacion_Intercompany';

