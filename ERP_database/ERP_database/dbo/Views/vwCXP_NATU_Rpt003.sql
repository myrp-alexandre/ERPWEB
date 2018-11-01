CREATE view [dbo].[vwCXP_NATU_Rpt003]
as
SELECT        dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_TipoDocumento.Codigo + '#:' + CAST(dbo.cp_orden_giro.IdCbteCble_Ogiro AS VARCHAR(20)) 
                         + '/' + dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura AS Documento, dbo.cp_TipoDocumento.Descripcion AS nom_tipo_doc, 
                         dbo.cp_TipoDocumento.Codigo AS cod_tipo_doc, dbo.cp_orden_giro.co_fechaOg, 'PROVEE' AS Tipo_persona, dbo.cp_proveedor.IdProveedor, 
                         cp_proveedor.IdPersona, pe_nombreCompleto AS nom_proveedor, dbo.cp_orden_giro.co_valorpagar AS Valor_a_pagar, 0 AS Valor_debe, 
                         dbo.cp_orden_giro.co_total AS Valor_Haber, dbo.cp_orden_giro.co_observacion AS Observacion
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_sucursal ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_orden_giro.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor 
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
UNION
SELECT        A.IdEmpresa, cp_orden_pago_det.IdCbteCble_cxp, cp_orden_pago_det.IdTipoCbte_cxp, A.IdTipo_op, 'OP#' + cast(A.IdOrdenPago AS varchar(20)) AS Documento, 
                         'OP' AS nom_tipo_doc, 'OP' AS cod_tipo_doc, A.Fecha, A.IdTipo_Persona, A.IdEntidad, A.IdPersona, tb_persona.pe_apellido + ' ' + tb_persona.pe_nombre, 
                         cp_orden_pago_det.Valor_a_pagar, 0 AS Valor_debe, cp_orden_pago_det.Valor_a_pagar AS Valor_Haber, A.Observacion
FROM            cp_orden_pago AS A INNER JOIN
                         cp_orden_pago_det ON A.IdEmpresa = cp_orden_pago_det.IdEmpresa AND A.IdOrdenPago = cp_orden_pago_det.IdOrdenPago INNER JOIN
                         tb_persona ON A.IdPersona = tb_persona.IdPersona
WHERE        (A.IdTipo_op <> 'FACT_PROVEE')
UNION
SELECT        A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, OG.IdOrden_giro_Tipo, 'Ret#' + cast(A.IdRetencion AS varchar(20)) + '/' + isnull(A.NumRetencion, '') 
                         Documento, 'Retencion' nom_tipo_doc, 'RET' cod_tipo_doc, A.fecha, 'PROVEE' AS Tipo_Persona, OG.IdProveedor, Prov.IdPersona, pe_nombreCompleto, 
                         SUM(B.re_valor_retencion) AS re_valor_retencion, SUM(B.re_valor_retencion) AS Valor_debe, 0 Valor_Haber, A.observacion
FROM            cp_retencion AS A INNER JOIN
                         cp_retencion_det AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdRetencion = B.IdRetencion INNER JOIN
                         cp_orden_giro AS OG ON A.IdEmpresa_Ogiro = OG.IdEmpresa AND A.IdCbteCble_Ogiro = OG.IdCbteCble_Ogiro AND 
                         A.IdTipoCbte_Ogiro = OG.IdTipoCbte_Ogiro INNER JOIN
                         cp_TipoDocumento AS TipDoc ON OG.IdOrden_giro_Tipo = TipDoc.CodTipoDocumento INNER JOIN
                         cp_proveedor AS Prov ON OG.IdEmpresa = Prov.IdEmpresa AND OG.IdProveedor = Prov.IdProveedor INNER JOIN
                         cp_proveedor_clase AS prov_cla ON Prov.IdEmpresa = prov_cla.IdEmpresa AND Prov.IdClaseProveedor = prov_cla.IdClaseProveedor LEFT OUTER JOIN
                         tb_sucursal AS Suc ON OG.IdEmpresa = Suc.IdEmpresa AND OG.IdSucursal = Suc.IdSucursal
						 inner join tb_persona as per on prov.IdPersona = per.IdPersona
GROUP BY A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, OG.IdOrden_giro_Tipo, TipDoc.Codigo, OG.co_factura, A.NumRetencion, TipDoc.Descripcion, A.fecha, 
                         OG.IdProveedor, Prov.IdPersona, pe_nombreCompleto, A.observacion, Prov.IdClaseProveedor, prov_cla.descripcion_clas_prove, Suc.IdSucursal, Suc.Su_Descripcion, 
                         Suc.codigo, A.IdRetencion
/*select * from tb_persona_tipo*/ UNION
SELECT        cp_orden_pago_cancelaciones.IdEmpresa, cp_orden_pago_det.IdCbteCble_cxp, cp_orden_pago_det.IdTipoCbte_cxp, 'PAGO', 
                         rtrim(LTRIM(ct_cbtecble_tipo.CodTipoCbte)) + ' #' + CAST(ba_Cbte_Ban.IdCbteCble AS varchar(20)) + '/' + isnull(ba_Cbte_Ban.cb_Cheque, '') AS Documento, 
                         ct_cbtecble_tipo.tc_TipoCbte, ct_cbtecble_tipo.CodTipoCbte, ct_cbtecble.cb_Fecha, cp_orden_pago.IdTipo_Persona, cp_orden_pago.IdEntidad, 
                         cp_orden_pago.IdPersona, tb_persona.pe_apellido + ' ' + tb_persona.pe_nombre, cp_orden_pago_cancelaciones.MontoAplicado, 
                         cp_orden_pago_cancelaciones.MontoAplicado AS Valor_debe, 0 Valor_haber, ct_cbtecble.cb_Observacion
FROM            cp_orden_pago INNER JOIN
                         cp_orden_pago_det ON cp_orden_pago.IdEmpresa = cp_orden_pago_det.IdEmpresa AND 
                         cp_orden_pago.IdOrdenPago = cp_orden_pago_det.IdOrdenPago INNER JOIN
                         cp_orden_pago_cancelaciones INNER JOIN
                         ct_cbtecble ON cp_orden_pago_cancelaciones.IdEmpresa_pago = ct_cbtecble.IdEmpresa AND 
                         cp_orden_pago_cancelaciones.IdCbteCble_pago = ct_cbtecble.IdCbteCble AND cp_orden_pago_cancelaciones.IdTipoCbte_pago = ct_cbtecble.IdTipoCbte ON 
                         cp_orden_pago_det.IdEmpresa = cp_orden_pago_cancelaciones.IdEmpresa_op AND 
                         cp_orden_pago_det.IdOrdenPago = cp_orden_pago_cancelaciones.IdOrdenPago_op AND 
                         cp_orden_pago_det.Secuencia = cp_orden_pago_cancelaciones.Secuencia_op INNER JOIN
                         tb_persona ON cp_orden_pago.IdPersona = tb_persona.IdPersona INNER JOIN
                         ct_cbtecble_tipo ON ct_cbtecble.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte LEFT OUTER JOIN
                         ba_Cbte_Ban ON ct_cbtecble.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND ct_cbtecble.IdTipoCbte = ba_Cbte_Ban.IdTipocbte AND 
                         ct_cbtecble.IdCbteCble = ba_Cbte_Ban.IdCbteCble
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[57] 4[4] 2[8] 3) )"
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
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 18
               Left = 25
               Bottom = 147
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 20
               Left = 364
               Bottom = 149
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 4
               Left = 666
               Bottom = 256
               Right = 887
            End
            DisplayFlags = 280
            TopColumn = 21
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_NATU_Rpt003';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_NATU_Rpt003';

