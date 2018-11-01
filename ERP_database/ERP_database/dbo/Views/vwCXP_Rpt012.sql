CREATE view [dbo].vwCXP_Rpt012
as
/* original*/ 
SELECT		dbo.cp_orden_giro.IdEmpresa, dbo.cp_orden_giro.IdCbteCble_Ogiro, dbo.cp_orden_giro.IdTipoCbte_Ogiro, dbo.cp_orden_giro.IdOrden_giro_Tipo, 
                         dbo.cp_TipoDocumento.Codigo + '#:' + CAST(dbo.cp_orden_giro.IdCbteCble_Ogiro AS VARCHAR(20)) 
                         + '/' + dbo.cp_orden_giro.co_serie + '-' + dbo.cp_orden_giro.co_factura AS Documento, dbo.cp_TipoDocumento.Descripcion AS nom_tipo_doc, 
                         dbo.cp_TipoDocumento.Codigo AS cod_tipo_doc
						 , dbo.cp_orden_giro.co_fechaOg AS Fecha, dbo.cp_proveedor.IdProveedor, 
                         pe_nombreCompleto AS nom_proveedor, dbo.cp_orden_giro.co_observacion AS Observacion, 
                         dbo.vwcp_orden_giro_total_saldo.co_valorpagar AS ValorAPagar, dbo.vwcp_orden_giro_total_saldo.TotalPagado, 
                         dbo.vwcp_orden_giro_total_saldo.SaldoOG AS Saldo, 'FAxPG' AS TipoRegistro, dbo.tb_Calendario.IdCalendario, dbo.tb_Calendario.NombreCortoFecha, 
                         '[' + RIGHT(CAST(dbo.tb_Calendario.IdMes AS varchar(6)), 2) + ']-' + LEFT(dbo.tb_Calendario.NombreMes, 3) AS NombreMes, dbo.tb_Calendario.IdMes, 
                         dbo.tb_Calendario.AnioFiscal, dbo.cp_orden_giro.co_FechaFactura_vct
FROM            dbo.cp_orden_giro INNER JOIN
                         dbo.cp_TipoDocumento ON dbo.cp_orden_giro.IdOrden_giro_Tipo = dbo.cp_TipoDocumento.CodTipoDocumento INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_orden_giro.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND 
                         dbo.cp_orden_giro.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.vwcp_orden_giro_total_saldo ON dbo.cp_orden_giro.IdEmpresa = dbo.vwcp_orden_giro_total_saldo.IdEmpresa AND 
                         dbo.cp_orden_giro.IdCbteCble_Ogiro = dbo.vwcp_orden_giro_total_saldo.IdCbteCble_Ogiro AND 
                         dbo.cp_orden_giro.IdTipoCbte_Ogiro = dbo.vwcp_orden_giro_total_saldo.IdTipoCbte_Ogiro INNER JOIN
                         dbo.tb_Calendario ON dbo.cp_orden_giro.co_fechaOg = dbo.tb_Calendario.fecha
--where cp_orden_giro.IdProveedor = 2335
/* cambio de notas de debitos*/ 

UNION
SELECT dbo.cp_nota_DebCre.IdEmpresa, dbo.cp_nota_DebCre.IdCbteCble_Nota, dbo.cp_nota_DebCre.IdTipoCbte_Nota, dbo.cp_nota_DebCre.DebCre,
 dbo.ct_cbtecble_tipo.CodTipoCbte, case when dbo.cp_nota_DebCre.IdCbteCble_Nota=null then dbo.cp_nota_DebCre.cn_Nota else cast(dbo.cp_nota_DebCre.IdCbteCble_Nota as varchar) end AS cn_Nota, dbo.ct_cbtecble_tipo.tc_TipoCbte,  
                         dbo.cp_nota_DebCre.cn_fecha, dbo.cp_proveedor.IdProveedor, dbo.tb_persona.pe_nombreCompleto, dbo.cp_nota_DebCre.cn_observacion, 
                         dbo.cp_nota_DebCre.cn_total AS ValorPagar, dbo.cp_nota_DebCre.cn_total AS TotalPagado, dbo.cp_nota_DebCre.cn_total AS Saldo, 'Nota_Debito' AS TipoRegistro, 
                         dbo.tb_Calendario.IdCalendario, dbo.tb_Calendario.NombreCortoFecha, dbo.tb_Calendario.NombreMes, dbo.tb_Calendario.IdMes, dbo.tb_Calendario.AnioFiscal, 
                         dbo.cp_nota_DebCre.cn_Fecha_vcto
FROM            dbo.cp_nota_DebCre INNER JOIN
                         dbo.tb_empresa ON dbo.cp_nota_DebCre.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_nota_DebCre.IdProveedor = dbo.cp_proveedor.IdProveedor AND 
                         dbo.tb_empresa.IdEmpresa = dbo.cp_proveedor.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_nota_DebCre.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.tb_Calendario ON dbo.cp_nota_DebCre.cn_fecha = dbo.tb_Calendario.fecha
where cp_nota_DebCre.DebCre='D'
--AND cp_nota_DebCre.IdProveedor = 2335
union
SELECT dbo.cp_nota_DebCre.IdEmpresa, dbo.cp_nota_DebCre.IdCbteCble_Nota, dbo.cp_nota_DebCre.IdTipoCbte_Nota, dbo.cp_nota_DebCre.DebCre,
 dbo.ct_cbtecble_tipo.CodTipoCbte, case when dbo.cp_nota_DebCre.IdCbteCble_Nota=null then dbo.cp_nota_DebCre.cn_Nota else cast(dbo.cp_nota_DebCre.IdCbteCble_Nota as varchar) end AS cn_Nota, dbo.ct_cbtecble_tipo.tc_TipoCbte,  
                         dbo.cp_nota_DebCre.cn_fecha, dbo.cp_proveedor.IdProveedor, dbo.tb_persona.pe_nombreCompleto, dbo.cp_nota_DebCre.cn_observacion, 
                         dbo.cp_nota_DebCre.cn_total*-1 AS ValorPagar, dbo.cp_nota_DebCre.cn_total*-1 AS TotalPagado, dbo.cp_nota_DebCre.cn_total*-1 AS Saldo, 'Nota_Credito' AS TipoRegistro, 
                         dbo.tb_Calendario.IdCalendario, dbo.tb_Calendario.NombreCortoFecha, dbo.tb_Calendario.NombreMes, dbo.tb_Calendario.IdMes, dbo.tb_Calendario.AnioFiscal, 
                         dbo.cp_nota_DebCre.cn_Fecha_vcto
FROM            dbo.cp_nota_DebCre INNER JOIN
                         dbo.tb_empresa ON dbo.cp_nota_DebCre.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.cp_proveedor ON dbo.cp_nota_DebCre.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.cp_nota_DebCre.IdProveedor = dbo.cp_proveedor.IdProveedor AND 
                         dbo.tb_empresa.IdEmpresa = dbo.cp_proveedor.IdEmpresa INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ct_cbtecble_tipo ON dbo.cp_nota_DebCre.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa AND 
                         dbo.cp_nota_DebCre.IdTipoCbte_Nota = dbo.ct_cbtecble_tipo.IdTipoCbte INNER JOIN
                         dbo.tb_Calendario ON dbo.cp_nota_DebCre.cn_fecha = dbo.tb_Calendario.fecha
WHERE        (cp_nota_DebCre.DebCre = 'C') --AND cp_nota_DebCre.IdProveedor = 2335

--select * from tb_sis_Documento_Tipo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[49] 2[12] 3) )"
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
               Top = 11
               Left = 33
               Bottom = 140
               Right = 274
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "cp_TipoDocumento"
            Begin Extent = 
               Top = 6
               Left = 317
               Bottom = 135
               Right = 586
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 6
               Left = 624
               Bottom = 135
               Right = 845
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 6
               Left = 883
               Bottom = 135
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwcp_orden_giro_total_saldo"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Calendario"
            Begin Extent = 
               Top = 179
               Left = 547
               Bottom = 308
               Right = 756
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt012';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt012';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCXP_Rpt012';

