CREATE view [dbo].[vwCXP_NATU_Rpt002]
as

SELECT        dbo.cp_orden_giro.IdEmpresa, NULL AS IdOrdenPago, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, 
                         dbo.cp_orden_giro.IdOrden_giro_Tipo, 'FACT' AS cod_tipo_doc, 'Factura' AS tipo_doc, 'FAC#' + cast(cast(dbo.cp_orden_giro.co_factura AS numeric) AS varchar(20)) 
                         AS Documento, dbo.cp_orden_giro.co_fechaOg AS Fecha, dbo.cp_orden_giro.co_FechaFactura_vct, dbo.cp_orden_giro.co_observacion AS Observacion, 
                         dbo.cp_proveedor.IdPersona, dbo.cp_proveedor.IdProveedor, pe_nombreCompleto AS Nom_Proveedor, dbo.cp_orden_giro.co_baseImponible AS SubTotal, 
                         dbo.cp_orden_giro.co_valoriva AS Iva, dbo.cp_orden_giro.co_total AS Total, dbo.cp_orden_giro.co_valorpagar AS Total_a_Pagar, 
                         ROUND(dbo.vwcp_orden_giro_total_saldo.SaldoOG,2) AS Saldo_x_pagar, dbo.cp_proveedor_clase.IdClaseProveedor, dbo.cp_proveedor_clase.descripcion_clas_prove
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.tb_sucursal ON dbo.cp_orden_giro.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_orden_giro.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor INNER JOIN
                         dbo.vwcp_orden_giro_total_saldo ON dbo.cp_orden_giro.IdEmpresa = dbo.vwcp_orden_giro_total_saldo.IdEmpresa AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.vwcp_orden_giro_total_saldo.IdCbteCble_Ogiro AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.vwcp_orden_giro_total_saldo.IdTipoCbte_Ogiro AND 
                         dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.vwcp_orden_giro_total_saldo.IdOrden_giro_Tipo AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.vwcp_orden_giro_total_saldo.IdProveedor
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
WHERE        dbo.cp_orden_giro.Estado = 'A'
UNION
SELECT        dbo.cp_nota_DebCre.IdEmpresa, NULL AS IdOrdenPago, dbo.cp_nota_DebCre.IdCbteCble_Nota, dbo.cp_nota_DebCre.IdTipoCbte_Nota, '05', 'ND' AS cod_tipo_doc, 
                         'Nota de débito' AS tipo_doc, CASE WHEN cp_nota_DebCre.cn_serie1 IS NULL THEN 'ND#' + cast(cast(dbo.cp_nota_DebCre.cod_nota AS numeric) AS varchar(20)) 
                         ELSE 'ND' + cast(cast(cp_nota_DebCre.cn_Nota AS numeric) AS varchar(20)) END AS Documento, dbo.cp_nota_DebCre.cn_fecha AS Fecha, 
                         dbo.cp_nota_DebCre.cn_Fecha_vcto, dbo.cp_nota_DebCre.cn_observacion AS Observacion, dbo.cp_proveedor.IdPersona, dbo.cp_proveedor.IdProveedor, 
                         ltrim(rtrim(pe_nombreCompleto)) AS Nom_Proveedor, dbo.cp_nota_DebCre.cn_baseImponible AS SubTotal, dbo.cp_nota_DebCre.cn_valoriva AS Iva, 
                         dbo.cp_nota_DebCre.cn_total AS Total, vwcp_nota_DebCre_total_saldo.valorpagar AS Total_a_pagar, round(dbo.vwcp_nota_DebCre_total_saldo.SaldoOG, 2) 
                         AS Saldo_x_pagar, dbo.cp_proveedor_clase.IdClaseProveedor, dbo.cp_proveedor_clase.descripcion_clas_prove
FROM            dbo.cp_nota_DebCre INNER JOIN
                         dbo.tb_sucursal ON dbo.cp_nota_DebCre.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.cp_nota_DebCre.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.cp_proveedor_clase ON dbo.cp_proveedor.IdEmpresa = dbo.cp_proveedor_clase.IdEmpresa AND 
                         dbo.cp_proveedor.IdClaseProveedor = dbo.cp_proveedor_clase.IdClaseProveedor INNER JOIN
                         dbo.vwcp_nota_DebCre_total_saldo ON dbo.cp_nota_DebCre.IdEmpresa = dbo.vwcp_nota_DebCre_total_saldo.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdCbteCble_Nota = dbo.vwcp_nota_DebCre_total_saldo.IdCbteCble_Nota AND 
                         dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.vwcp_nota_DebCre_total_saldo.IdTipoCbte_Nota AND 
                         dbo.cp_nota_DebCre.IdProveedor = dbo.vwcp_nota_DebCre_total_saldo.IdProveedor
						 inner join tb_persona as per on cp_proveedor.IdPersona = per.IdPersona
WHERE        dbo.cp_nota_DebCre.Estado = 'A' AND dbo.cp_nota_DebCre.DebCre = 'D'
UNION
SELECT        A.IdEmpresa, A.IdOrdenPago, NULL AS IdCbteCble_Ogiro, NULL AS IdTipoCbte_Ogiro, NULL AS IdOrden_giro_Tipo, A.IdTipo_op, A.IdTipo_op, 
                         'OP#:' + cast(A.IdOrdenPago AS varchar(20)), A.Fecha, A.Fecha_Pago, A.Observacion, A.IdPersona, A.IdEntidad, ltrim(rtrim(A.pe_nombreCompleto)) 
                         pe_nombreCompleto, A.Total_OP, 0 AS Iva, A.Total_OP, A.Total_cancelado, A.Saldo, 0 AS IdClaseProveedor, '' AS descr
FROM            vwcp_orden_pago A
WHERE        A.IdTipo_op <> 'FACT_PROVEE' AND A.Estado = 'A'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[12] 4[4] 2[53] 3) )"
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
      Begin ColumnWidths = 26
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_NATU_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_NATU_Rpt002';

