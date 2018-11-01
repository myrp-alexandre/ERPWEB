CREATE VIEW [dbo].[vwcp_OrdenGiroRetencionReport]
AS
SELECT        A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, A.IdRetencion, D.Idsecuencia, A.fecha AS [A.re_fecha], A.serie1 + '' + A.serie2   AS [A.SerieRetencion], A.NumRetencion, 
                         A.re_Tiene_RTiva, A.re_Tiene_RFuente, D.re_tipoRet, D.re_baseRetencion, D.IdCodigo_SRI, D.re_Codigo_impuesto, D.re_Porcen_retencion, D.re_valor_retencion, 
                         A.re_EstaImpresa, D.re_estado, D.IdUsuario, D.Fecha_Transac, D.IdUsuarioUltMod, D.Fecha_UltMod, D.IdUsuarioUltAnu, D.Fecha_UltAnu, D.nom_pc, D.ip, 
                         B.codigoSRI + ' - ' + B.co_descripcion AS nRetencionSRI, CONVERT(varchar(50), B.co_f_valides_desde, 101) + ' - ' + CONVERT(varchar(50), B.co_f_valides_hasta, 
                         101) AS FVigCoSRI, B.codigoSRI, A.NAutorizacion, A.IdEmpresa_Ogiro
FROM            dbo.cp_retencion AS A INNER JOIN
                         dbo.cp_retencion_det AS D ON A.IdEmpresa = D.IdEmpresa AND A.IdRetencion = D.IdRetencion INNER JOIN
                         dbo.cp_codigo_SRI AS B ON D.IdCodigo_SRI = B.IdCodigo_SRI
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[14] 3) )"
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
         Top = -22
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 0
               Left = 619
               Bottom = 221
               Right = 828
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 101
               Left = 273
               Bottom = 230
               Right = 482
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
      Begin ColumnWidths = 32
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4095
         Alias = 2970
         Table = 30', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_OrdenGiroRetencionReport';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'15
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_OrdenGiroRetencionReport';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_OrdenGiroRetencionReport';

