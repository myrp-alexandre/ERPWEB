/*select * from tb_sis_reporte*/
CREATE VIEW [dbo].[vwCAJ_Rpt001]
AS
SELECT        caj.IdEmpresa, caj.IdCbteCble, caj.IdTipocbte, tip_cbt_cbl.tc_TipoCbte AS Tipo_Cbte, caj_1.ca_Codigo AS cod_caja, caj_1.ca_Descripcion AS Caja, 
                          CASE caj.cm_Signo WHEN '+' THEN 'INGRESO' WHEN '-' THEN 'EGRESO' END AS Tipo, per.pe_nombreCompleto AS Beneficiario, 
                         caj_d.cr_Valor AS Valor, caj.cm_fecha AS Fecha, caj_tip_mov.tm_descripcion AS Tipo_Movi_Caja, caj_d.IdCobro_tipo,  
                         '' AS Num_Documento, caj.cm_observacion AS Observacion, dbo.tb_Calendario.IdCalendario, dbo.tb_Calendario.AnioFiscal, 
                         dbo.tb_Calendario.IdMes, dbo.tb_Calendario.NombreMes AS Mes, dbo.tb_Calendario.NombreCortoFecha AS Dia
FROM            dbo.caj_Caja AS caj_1 INNER JOIN
                         dbo.caj_Caja_Movimiento AS caj ON caj_1.IdEmpresa = caj.IdEmpresa AND caj_1.IdCaja = caj.IdCaja INNER JOIN
                         dbo.caj_Caja_Movimiento_Tipo AS caj_tip_mov ON caj.IdTipoMovi = caj_tip_mov.IdTipoMovi INNER JOIN
                         dbo.ct_cbtecble_tipo AS tip_cbt_cbl ON caj.IdTipocbte = tip_cbt_cbl.IdTipoCbte INNER JOIN
                         dbo.tb_Calendario ON caj.cm_fecha = dbo.tb_Calendario.fecha LEFT OUTER JOIN
                         dbo.caj_Caja_Movimiento_det AS caj_d ON caj.IdEmpresa = caj_d.IdEmpresa AND caj.IdCbteCble = caj_d.IdCbteCble AND 
                         caj.IdTipocbte = caj_d.IdTipocbte 
						 inner join tb_persona as per on per.IdPersona = caj.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[13] 4[39] 2[4] 3) )"
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
         Begin Table = "caj_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj"
            Begin Extent = 
               Top = 24
               Left = 20
               Bottom = 223
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "caj_tip_mov"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tip_cbt_cbl"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_d"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sucu"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Calendario"
            Begin Extent = 
               Top = 0
               Left = 419
               Bottom = 187
               Right = 628
            End
            DisplayFlags = 280
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 22
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt001';

