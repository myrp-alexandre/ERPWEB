--select * from [dbo].[vwcp_Cbte_x_pagar_OG]

CREATE VIEW [dbo].[vwcp_Cbte_x_pagar_OG] AS
SELECT     A.IdEmpresa, EM.em_nombre, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, A.IdProveedor, pe_nombreCompleto AS NomProveedor, A.co_fechaOg, A.co_factura, 
                         A.co_observacion, A.co_serie, AVG(A.co_total) AS co_total, AVG(A.co_valorpagar) AS co_valorpagar, ISNULL(SUM(Pg.Valor_a_pagar), 0) AS Valor_Respaldado, 
                         ROUND(AVG(A.co_valorpagar) - ISNULL(SUM(Pg.Valor_a_pagar), 0), 2) AS SaldoPendiente, 'FACT_PROVEE' AS TipoReg, TD.Descripcion, 
                         TD.Codigo AS CodTipoDocumento, SUBSTRING(TD.Descripcion, 1, 5) + '-' + A.co_serie + '-' + A.co_factura AS Referencia, 
                         ISNULL(dbo.vwcp_Retencion_valor_total_x_cbte_cxp.Total_Retencion, 0) AS Total_Retencion
FROM            dbo.cp_orden_giro AS A INNER JOIN
                         dbo.cp_proveedor AS P ON A.IdEmpresa = P.IdEmpresa AND A.IdProveedor = P.IdProveedor INNER JOIN
                         dbo.tb_empresa AS EM ON A.IdEmpresa = EM.IdEmpresa INNER JOIN
                         dbo.cp_TipoDocumento AS TD ON A.IdOrden_giro_Tipo = TD.CodTipoDocumento LEFT OUTER JOIN
                         dbo.vwcp_Retencion_valor_total_x_cbte_cxp ON A.IdCbteCble_Ogiro = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdCbteCble_Ogiro AND 
                         A.IdEmpresa = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdEmpresa_Ogiro AND 
                         A.IdTipoCbte_Ogiro = dbo.vwcp_Retencion_valor_total_x_cbte_cxp.IdTipoCbte_Ogiro LEFT OUTER JOIN
                         dbo.vwcp_orden_pago_det_activa AS Pg ON A.IdEmpresa = Pg.IdEmpresa AND A.IdEmpresa = Pg.IdEmpresa_cxp AND A.IdCbteCble_Ogiro = Pg.IdCbteCble_cxp AND 
                         A.IdTipoCbte_Ogiro = Pg.IdTipoCbte_cxp
						 inner join tb_persona as per on per.IdPersona = p.IdPersona
GROUP BY A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, A.IdProveedor, A.co_fechaOg, A.co_factura, A.co_observacion, A.co_serie, pe_nombreCompleto, EM.em_nombre, 
                         TD.Descripcion, dbo.vwcp_Retencion_valor_total_x_cbte_cxp.Total_Retencion, TD.Codigo
union


SELECT     cp_nota_DebCre.IdEmpresa, EM.em_nombre, cp_nota_DebCre.IdCbteCble_Nota

						, cp_nota_DebCre.IdTipoCbte_Nota

						, cp_nota_DebCre.IdProveedor, 
                         pe_nombreCompleto AS NomProveedor, cp_nota_DebCre.cn_fecha
						 ,case 
							when cp_nota_DebCre.cn_Nota is null or  cp_nota_DebCre.cn_Nota='' then cast(cp_nota_DebCre.IdCbteCble_Nota as varchar(20))
						   else cp_nota_DebCre.cn_Nota 
						   end   as cn_Nota
						 ,cp_nota_DebCre.cn_observacion, 
                         isnull(cp_nota_DebCre.cn_serie1,'') + '-' + isnull(cp_nota_DebCre.cn_serie2,'') AS serie, AVG(cp_nota_DebCre.cn_total) AS total, AVG(cp_nota_DebCre.cn_total) AS Valor_pagar, 
                         AVG(cp_nota_DebCre.cn_total) AS Valor_respaldo
						  ,ROUND(AVG(cp_nota_DebCre.cn_total) - ISNULL(SUM(Pg.Valor_a_pagar), 0), 2) AS SaldoPendiente
						  , 'FACT_PROVEE' AS TipoReg, cp_TipoDocumento.Descripcion ,cp_TipoDocumento.Codigo
						 , case 
						 when cp_nota_DebCre.cn_Nota is null or cp_nota_DebCre.cn_serie1 is null or cp_nota_DebCre.cn_serie2 is null then cp_TipoDocumento.Codigo +'#:' + cast( cp_nota_DebCre.IdCbteCble_Nota as varchar(20))
						 else  cp_TipoDocumento.Codigo +'#:' + CAST( cp_nota_DebCre.cn_Nota as varchar(20)) + '/' + CAST( cp_nota_DebCre.IdCbteCble_Nota as varchar(20))
						 end as  referencia
						 ,0 total_reten
FROM            tb_empresa AS EM INNER JOIN
                         cp_nota_DebCre INNER JOIN
                         cp_proveedor AS P ON cp_nota_DebCre.IdEmpresa = P.IdEmpresa AND cp_nota_DebCre.IdProveedor = P.IdProveedor ON 
                         EM.IdEmpresa = cp_nota_DebCre.IdEmpresa LEFT OUTER JOIN
                         vwcp_orden_pago_det_activa AS Pg ON cp_nota_DebCre.IdEmpresa = Pg.IdEmpresa AND cp_nota_DebCre.IdEmpresa = Pg.IdEmpresa_cxp AND 
                         cp_nota_DebCre.IdCbteCble_Nota = Pg.IdCbteCble_cxp AND cp_nota_DebCre.IdTipoCbte_Nota = Pg.IdTipoCbte_cxp CROSS JOIN
                         cp_TipoDocumento inner join tb_persona as per on p.IdPersona = per.IdPersona
GROUP BY pe_nombreCompleto, EM.em_nombre, cp_nota_DebCre.IdEmpresa, cp_nota_DebCre.IdCbteCble_Nota, cp_nota_DebCre.IdTipoCbte_Nota, cp_nota_DebCre.IdProveedor, 
                         cp_nota_DebCre.cn_fecha, cp_nota_DebCre.cn_serie1, cp_nota_DebCre.cn_serie2, cp_nota_DebCre.cn_Nota, cp_nota_DebCre.cn_observacion, 
                         cp_TipoDocumento.CodTipoDocumento, cp_TipoDocumento.Codigo, cp_TipoDocumento.Descripcion
HAVING        (cp_TipoDocumento.CodTipoDocumento = '05')




--select * from cp_nota_DebCre
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[16] 2[4] 3) )"
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
               Bottom = 328
               Right = 295
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 385
               Left = 163
               Bottom = 514
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EM"
            Begin Extent = 
               Top = 250
               Left = 355
               Bottom = 379
               Right = 590
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TD"
            Begin Extent = 
               Top = 386
               Left = 350
               Bottom = 515
               Right = 635
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pg"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcp_Retencion_valor_total_x_cbte_cxp"
            Begin Extent = 
               Top = 0
               Left = 724
               Bottom = 236
               Right = 949
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
      Begin ColumnWidths = 20
         Width = 284
         Width = 1500
         Width = 1500
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Cbte_x_pagar_OG';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Width = 1500
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
      Begin ColumnWidths = 12
         Column = 3000
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Cbte_x_pagar_OG';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_Cbte_x_pagar_OG';

