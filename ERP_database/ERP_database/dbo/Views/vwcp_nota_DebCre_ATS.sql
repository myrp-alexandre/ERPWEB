CREATE VIEW dbo.vwcp_nota_DebCre_ATS
AS
SELECT        Nota_Cred.IdEmpresa, Nota_Cred.IdCbteCble_Nota, Nota_Cred.IdTipoCbte_Nota, Nota_Cred.IdProveedor, Nota_Cred.cn_fecha, Nota_Cred.cn_serie1, Nota_Cred.cn_serie2, Nota_Cred.cn_Nota, 
                         Nota_Cred.cn_observacion, Nota_Cred.cn_subtotal_iva, Nota_Cred.cn_subtotal_siniva, Nota_Cred.cn_baseImponible, Nota_Cred.cn_Por_iva, Nota_Cred.cn_valoriva, Nota_Cred.IdCod_ICE, 
                         Nota_Cred.cn_Ice_base, Nota_Cred.cn_Ice_por, Nota_Cred.cn_Ice_valor, Nota_Cred.cn_Serv_por, Nota_Cred.cn_Serv_valor, Nota_Cred.cn_BaseSeguro, Nota_Cred.cn_total, Nota_Cred.cn_vaCoa, 
                         Nota_Cred.cn_Autorizacion, Nota_Cred.IdTipoServicio, Nota_Cred.IdCtaCble_Acre, Nota_Cred.IdCtaCble_IVA, Nota_Cred.IdUsuario, Nota_Cred.Fecha_Transac, Nota_Cred.Estado, Nota_Cred.IdUsuarioUltMod, 
                         Nota_Cred.Fecha_UltMod, Nota_Cred.IdUsuarioUltAnu, Nota_Cred.MotivoAnu, Nota_Cred.nom_pc, Nota_Cred.ip, Nota_Cred.Fecha_UltAnu, Nota_Cred.IdCbteCble_Anulacion, Nota_Cred.IdTipoCbte_Anulacion, 
                         Nota_Cred.cn_tipoLocacion, Nota_Cred.IdCentroCosto, Nota_Cred.IdSucursal, Nota_Cred.IdTipoFlujo, Nota_Cred.DebCre, Nota_Cred.IdIden_credito, Nota_Cred.PagoLocExt, Nota_Cred.PaisPago, 
                         Nota_Cred.ConvenioTributacion, Nota_Cred.PagoSujetoRetencion, Nota_Cred.cn_Fecha_vcto, Nota_Cred.IdTipoNota, Nota_Cred.fecha_autorizacion, dbo.tb_persona.IdTipoDocumento, 
                         dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_Naturaleza, dbo.tb_persona.pe_razonSocial, dbo.cp_proveedor.es_empresa_relacionada
FROM            dbo.cp_proveedor INNER JOIN
                         dbo.cp_nota_DebCre AS Nota_Cred ON dbo.cp_proveedor.IdEmpresa = Nota_Cred.IdEmpresa AND dbo.cp_proveedor.IdProveedor = Nota_Cred.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona
WHERE        (Nota_Cred.IdTipoNota = 'T_TIP_NOTA_SRI')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[5] 2[5] 3) )"
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
         Begin Table = "Nota_Cred"
            Begin Extent = 
               Top = 10
               Left = 539
               Bottom = 175
               Right = 766
            End
            DisplayFlags = 280
            TopColumn = 27
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 13
               Left = 882
               Bottom = 87
               Right = 1114
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 99
               Left = 1106
               Bottom = 178
               Right = 1278
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
         Width = 150', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_nota_DebCre_ATS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'0
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
         Width = 2265
         Width = 2205
         Width = 1500
         Width = 1500
         Width = 3120
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
         Column = 2745
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_nota_DebCre_ATS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_nota_DebCre_ATS';

