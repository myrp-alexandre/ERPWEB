CREATE VIEW [dbo].[vwcp_orden_giro_sin_retenciones]
AS
SELECT        A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, A.IdOrden_giro_Tipo, A.IdProveedor, A.co_fechaOg, A.co_serie, A.co_factura, A.co_FechaFactura, 
                         A.co_FechaFactura_vct, A.co_plazo, A.co_observacion, A.co_subtotal_iva, A.co_subtotal_siniva, A.co_baseImponible, A.co_Por_iva, A.co_valoriva, A.IdCod_ICE, 
                          A.co_total, 
                         A.co_valorpagar, A.co_vaCoa, A.IdIden_credito, A.IdCod_101, A.IdTipoServicio,  A.IdUsuario, A.Fecha_Transac, A.Estado, 
                         A.IdUsuarioUltMod, A.Fecha_UltMod, A.IdUsuarioUltAnu, A.MotivoAnu,  A.Fecha_UltAnu,  
                          A.SaldoOG, A.em_nombre, A.tc_TipoCbte, A.IdSucursal, A.Sucursal, A.IdTipoFlujo, A.TipoFlujo, A.PagoLocExt, A.PaisPago, 
                         A.PagoSujetoRetencion, A.ConvenioTributacion, A.co_FechaContabilizacion, A.BseImpNoObjDeIva, pe_nombreCompleto pr_nombre, 
                         dbo.cp_TipoDocumento.Descripcion AS Tipo_Documento, dbo.cp_proveedor.IdCtaCble_CXP
FROM            dbo.vwcp_orden_giro_x_Pagos_saldo AS A INNER JOIN
                         dbo.cp_proveedor ON A.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND A.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_TipoDocumento ON A.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento inner join tb_persona as per
						 on per.IdPersona = cp_proveedor.IdPersona
WHERE        (NOT EXISTS
                             (SELECT        A.IdEmpresa
                               FROM            dbo.cp_orden_giro AS og INNER JOIN
                                                         dbo.cp_retencion AS ret ON og.IdEmpresa = ret.IdEmpresa_Ogiro AND og.IdCbteCble_Ogiro = ret.IdCbteCble_Ogiro AND 
                                                         og.IdTipoCbte_Ogiro = ret.IdTipoCbte_Ogiro
                               WHERE        (A.IdEmpresa = og.IdEmpresa) AND (A.IdTipoCbte_Ogiro = og.IdTipoCbte_Ogiro) AND (A.IdCbteCble_Ogiro = og.IdCbteCble_Ogiro)))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[8] 2[37] 3) )"
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
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 210
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 0
               Left = 405
               Bottom = 176
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 307
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
      Begin ColumnWidths = 65
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_giro_sin_retenciones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_giro_sin_retenciones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_orden_giro_sin_retenciones';

