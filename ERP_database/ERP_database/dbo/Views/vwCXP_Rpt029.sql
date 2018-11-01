CREATE VIEW [dbo].[vwCXP_Rpt029]
AS
SELECT        IdEmpresa, em_nombre, pr_codigo, pr_nombre, Factura, NumRetencion, AVG(co_Por_iva) AS co_Por_iva, AVG(co_valoriva) AS co_valoriva, AVG(co_subtotal_iva) AS co_subtotal_iva, AVG(co_subtotal_siniva) 
                         AS co_subtotal_siniva, fecha, CASE WHEN Tiene_retencion = 'FACTURAS CON RETENCION/VALIDAS' THEN
						 SUM(Base_Fuente) 						 
						 ELSE 0 END AS Base_Fuente, 
						 CASE WHEN Tiene_retencion = 'FACTURAS CON RETENCION/VALIDAS' THEN
						 AVG(co_subtotal_iva) + AVG(co_subtotal_siniva) - SUM(Base_Fuente) 						 
						 ELSE SUM(Base_Fuente) END AS Diferencia, 						 
						 Tiene_retencion, 						 
						 re_tipoRet
FROM            (SELECT        dbo.tb_empresa.IdEmpresa, dbo.tb_empresa.em_nombre, dbo.cp_proveedor.pr_codigo, pe_nombreCompleto pr_nombre, dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura AS Factura, 
                                                    dbo.cp_retencion.NumRetencion, dbo.cp_orden_giro.co_Por_iva, dbo.cp_orden_giro.co_valoriva, dbo.cp_orden_giro.co_subtotal_iva, dbo.cp_orden_giro.co_subtotal_siniva, 
                                                    CASE WHEN dbo.cp_retencion.fecha IS NOT NULL THEN dbo.cp_retencion.fecha ELSE dbo.cp_orden_giro.co_FechaContabilizacion END AS fecha, 
                                                    CASE WHEN dbo.cp_retencion_det.re_baseRetencion IS NOT NULL AND dbo.cp_retencion_det.re_tipoRet = 'RTF' THEN dbo.cp_retencion_det.re_baseRetencion ELSE 0 END AS Base_Fuente, 
                                                    dbo.cp_orden_giro.co_subtotal_iva + dbo.cp_orden_giro.co_subtotal_siniva - IIF(dbo.cp_retencion_det.re_baseRetencion IS NOT NULL AND dbo.cp_retencion_det.re_tipoRet = 'RTF', 
                                                    dbo.cp_retencion_det.re_baseRetencion, 0) AS Diferencia, CASE WHEN dbo.cp_retencion.NumRetencion IS NOT NULL AND dbo.cp_retencion_det.re_Porcen_retencion <> 0 AND 
                                                    dbo.cp_retencion_det.re_tipoRet = 'RTF' AND 
                                                    dbo.cp_retencion_det.re_Codigo_impuesto <> '332' THEN 'FACTURAS CON RETENCION/VALIDAS' ELSE 'FACTURAS SIN RETENCION' END AS Tiene_retencion, dbo.cp_retencion_det.re_tipoRet
                          FROM            dbo.tb_empresa INNER JOIN
                                                    dbo.cp_orden_giro ON dbo.tb_empresa.IdEmpresa = dbo.cp_orden_giro.IdEmpresa INNER JOIN
                                                    dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor LEFT OUTER JOIN
                                                    dbo.cp_retencion_det INNER JOIN
                                                    dbo.cp_retencion ON dbo.cp_retencion_det.IdEmpresa = dbo.cp_retencion.IdEmpresa AND dbo.cp_retencion_det.IdRetencion = dbo.cp_retencion.IdRetencion ON 
                                                    dbo.cp_orden_giro.IdEmpresa = dbo.cp_retencion.IdEmpresa_Ogiro AND dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.cp_retencion.IdCbteCble_Ogiro AND 
                                                    dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.cp_retencion.IdTipoCbte_Ogiro
													inner join tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
                          WHERE        (dbo.cp_orden_giro.co_vaCoa = 'S') AND (dbo.cp_retencion_det.re_tipoRet = 'RTF')/*OR (dbo.cp_retencion_det.re_tipoRet = 'IVA' AND dbo.cp_retencion.re_Tiene_RFuente = 'N'))*/ ) AS Data
GROUP BY IdEmpresa, em_nombre, pr_codigo, pr_nombre, Factura, NumRetencion, fecha, Tiene_retencion, re_tipoRet
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[7] 4[6] 2[37] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[48] 4[27] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[15] 2[50] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[49] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
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
         Configuration = "(H (1[74] 4) )"
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
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
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
      Begin ColumnWidths = 16
         Width = 284
         Width = 1200
         Width = 990
         Width = 2955
         Width = 3840
         Width = 2625
         Width = 1260
         Width = 1635
         Width = 1635
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
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2535
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 3045
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt029';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt029';

