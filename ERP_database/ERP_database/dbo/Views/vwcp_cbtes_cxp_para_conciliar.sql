CREATE VIEW [dbo].[vwcp_cbtes_cxp_para_conciliar]
AS
SELECT        cp_orden_giro.IdEmpresa, tb_sucursal.Su_Descripcion, 'FP - ' + cp_TipoDocumento.Descripcion AS Tipo, cp_orden_giro.IdCbteCble_Ogiro AS IdCbte_cxp, 
                         cp_orden_giro.IdProveedor, pe_nombreCompleto pr_nombre, cp_orden_giro.co_fechaOg, SUBSTRING(cp_TipoDocumento.Descripcion, 1, 5) 
                         + '-' + cp_orden_giro.co_serie + '-' + cp_orden_giro.co_factura AS Referencia, cp_orden_giro.co_FechaFactura, cp_orden_giro.co_FechaFactura_vct, 
                         cp_orden_giro.co_observacion, cp_orden_giro.IdEmpresa AS IdEmpresa_cxp, cp_orden_giro.IdTipoCbte_Ogiro AS IdTipoCbte_cxp, 
                         cp_orden_giro.IdCbteCble_Ogiro AS IdCbteCble_cxp, ISNULL(vwcp_Total_cancelado_x_cbte_cxp.Total_Cancelado, 0) AS Total_Cancelado, cp_orden_giro.co_total, 
                         cp_orden_giro.co_valorpagar, cp_orden_giro.co_valorpagar - ISNULL(vwcp_Total_cancelado_x_cbte_cxp.Total_Cancelado, 0) AS Saldo, cp_proveedor.IdPersona, 
                         'PROVEE' AS IdTipoPersona, cp_proveedor.IdCtaCble_CXP, cp_proveedor.IdCtaCble_Anticipo
FROM            cp_orden_giro INNER JOIN
                         cp_proveedor ON cp_orden_giro.IdEmpresa = cp_proveedor.IdEmpresa AND cp_orden_giro.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                         tb_sucursal ON cp_orden_giro.IdEmpresa = tb_sucursal.IdEmpresa AND cp_orden_giro.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         cp_TipoDocumento ON cp_orden_giro.IdOrden_giro_Tipo = cp_TipoDocumento.CodTipoDocumento LEFT OUTER JOIN
                         vwcp_Total_cancelado_x_cbte_cxp ON cp_orden_giro.IdEmpresa = vwcp_Total_cancelado_x_cbte_cxp.IdEmpresa_cxp AND 
                         cp_orden_giro.IdCbteCble_Ogiro = vwcp_Total_cancelado_x_cbte_cxp.IdCbteCble_cxp AND 
                         cp_orden_giro.IdTipoCbte_Ogiro = vwcp_Total_cancelado_x_cbte_cxp.IdTipoCbte_cxp inner join
						 tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
UNION
SELECT        cp_nota_DebCre.IdEmpresa, tb_sucursal.Su_Descripcion, 'Nota de debito x Proveedor ' AS Tipo, cp_nota_DebCre.IdCbteCble_Nota, cp_nota_DebCre.IdProveedor, 
                         pe_nombreCompleto pr_nombre, cp_nota_DebCre.cn_fecha, 
                         'N/D Prove# ' + cp_nota_DebCre.cn_serie1 + '-' + cp_nota_DebCre.cn_serie2 + '-' + cp_nota_DebCre.cn_Nota + '/' + CAST(cp_nota_DebCre.IdCbteCble_Nota AS varchar(20))
                          AS Referencia, cp_nota_DebCre.cn_fecha AS Expr1, cp_nota_DebCre.cn_fecha AS Expr2, cp_nota_DebCre.cn_observacion, cp_nota_DebCre.IdEmpresa AS Expr3, 
                         cp_nota_DebCre.IdTipoCbte_Nota, cp_nota_DebCre.IdCbteCble_Nota AS Expr4, ISNULL(vwcp_Total_cancelado_x_cbte_cxp.Total_Cancelado, 0) AS Total_Cancelado, 
                         cp_nota_DebCre.cn_total, cp_nota_DebCre.cn_total AS Valor_a_Pagar, cp_nota_DebCre.cn_total - ISNULL(vwcp_Total_cancelado_x_cbte_cxp.Total_Cancelado, 0) 
                         AS Saldo, cp_proveedor.IdPersona, 'PROVEE' AS IdTipoPersona, cp_proveedor.IdCtaCble_CXP, cp_proveedor.IdCtaCble_Anticipo
FROM            cp_nota_DebCre INNER JOIN
                         cp_proveedor ON cp_nota_DebCre.IdEmpresa = cp_proveedor.IdEmpresa AND cp_nota_DebCre.IdProveedor = cp_proveedor.IdProveedor INNER JOIN
                         tb_sucursal ON cp_nota_DebCre.IdEmpresa = tb_sucursal.IdEmpresa AND cp_nota_DebCre.IdSucursal = tb_sucursal.IdSucursal LEFT OUTER JOIN
                         vwcp_Total_cancelado_x_cbte_cxp ON cp_nota_DebCre.IdEmpresa = vwcp_Total_cancelado_x_cbte_cxp.IdEmpresa_cxp AND 
                         cp_nota_DebCre.IdCbteCble_Nota = vwcp_Total_cancelado_x_cbte_cxp.IdTipoCbte_cxp AND 
                         cp_nota_DebCre.IdTipoCbte_Nota = vwcp_Total_cancelado_x_cbte_cxp.IdCbteCble_cxp inner join
						 tb_persona as per on per.IdPersona = cp_proveedor.IdPersona
WHERE        (cp_nota_DebCre.DebCre = 'D')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[4] 2[80] 3) )"
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1065
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_cbtes_cxp_para_conciliar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_cbtes_cxp_para_conciliar';

