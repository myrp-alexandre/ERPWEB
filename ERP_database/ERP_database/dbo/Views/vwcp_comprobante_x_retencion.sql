CREATE VIEW [dbo].[vwcp_comprobante_x_retencion]
AS
SELECT        gir.IdEmpresa, gir.IdCbteCble_Ogiro, gir.IdTipoCbte_Ogiro, gir.IdOrden_giro_Tipo, gir.IdProveedor, gir.co_fechaOg, gir.co_serie, gir.co_factura, gir.co_FechaFactura, 
                         gir.co_FechaContabilizacion, gir.co_FechaFactura_vct, gir.co_plazo, gir.co_observacion, gir.co_subtotal_iva, gir.co_subtotal_siniva, gir.co_baseImponible, 
                         gir.co_Por_iva, gir.co_valoriva, gir.IdCod_ICE, 0 co_Ice_base, 0 co_Ice_por, 0 co_Ice_valor, 0 co_Serv_por,  0 co_Serv_valor, 0 co_OtroValor_a_descontar, 
                         0 co_OtroValor_a_Sumar, 0 co_BaseSeguro, gir.co_total, gir.co_valorpagar, gir.co_vaCoa, gir.IdIden_credito, gir.IdCod_101, gir.IdTipoFlujo, gir.IdTipoServicio, 
                         0 IdCtaCble_Gasto, '' IdCtaCble_IVA, gir.IdUsuario, gir.Fecha_Transac, gir.Estado AS gir_Estado, gir.IdUsuarioUltMod, gir.Fecha_UltMod, gir.IdUsuarioUltAnu, 
                         gir.MotivoAnu, '' nom_pc, gir.Fecha_UltAnu, '' ip, 'N' co_retencionManual, 0 IdCbteCble_Anulacion, 0 IdTipoCbte_Anulacion, '' IdCentroCosto, gir.IdSucursal, 
                         gir.PagoLocExt, gir.PaisPago, gir.ConvenioTributacion, gir.PagoSujetoRetencion, gir.BseImpNoObjDeIva, ret.IdRetencion, ret.re_Tiene_RTiva, ret.re_Tiene_RFuente, 
                         ret.observacion, ret.fecha, ret.serie1 + '' + ret.serie2 as serie, ret.NumRetencion, ret.ct_IdEmpresa_Anu, ret.ct_IdTipoCbte_Anu, ret.ct_IdCbteCble_Anu, ret.re_EstaImpresa, 
                         ret.Estado AS ret_estado, det.Idsecuencia, det.re_tipoRet, det.re_baseRetencion, det.IdCodigo_SRI, det.re_Codigo_impuesto, det.re_Porcen_retencion, 
                         det.re_valor_retencion, det.re_estado
FROM            dbo.cp_orden_giro AS gir INNER JOIN
                         dbo.cp_retencion AS ret ON gir.IdEmpresa = ret.IdEmpresa AND gir.IdCbteCble_Ogiro = ret.IdCbteCble_Ogiro AND 
                         gir.IdTipoCbte_Ogiro = ret.IdTipoCbte_Ogiro INNER JOIN
                         dbo.cp_retencion_det AS det ON ret.IdEmpresa = det.IdEmpresa AND ret.IdRetencion = det.IdRetencion
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[4] 2[56] 3) )"
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
         Begin Table = "gir"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 177
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 50
         End
         Begin Table = "ret"
            Begin Extent = 
               Top = 6
               Left = 294
               Bottom = 207
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "det"
            Begin Extent = 
               Top = 7
               Left = 621
               Bottom = 126
               Right = 810
            End
            DisplayFlags = 280
            TopColumn = 13
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 77
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
         Width = 1500
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_comprobante_x_retencion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_comprobante_x_retencion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_comprobante_x_retencion';

