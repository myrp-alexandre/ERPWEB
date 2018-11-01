CREATE VIEW [dbo].[vwCAJ_Rpt002]
AS
SELECT dbo.caj_Caja_Movimiento.IdEmpresa, dbo.caj_Caja_Movimiento.IdCbteCble, dbo.caj_Caja_Movimiento.IdTipocbte, dbo.ct_cbtecble_tipo.CodTipoCbte AS Tipo_Cbte, dbo.caj_Caja_Movimiento.cm_fecha, dbo.caj_Caja_Movimiento.cm_Signo, 
                  dbo.tb_persona.pe_nombreCompleto, dbo.caj_Caja_Movimiento.cm_observacion, dbo.caj_Caja_Movimiento.Estado, dbo.caj_Caja.IdCaja, dbo.caj_Caja.ca_Descripcion AS nom_caja, 
                   dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi, dbo.caj_Caja_Movimiento_Tipo.tm_descripcion AS nom_TipoMovi, dbo.tb_empresa.em_nombre AS nom_empresa, 
                  dbo.caj_Caja_Movimiento_det.IdCobro_tipo, 
				  
				  case when dbo.caj_Caja_Movimiento.cm_Signo = '-' then dbo.caj_Caja_Movimiento_det.cr_Valor*-1 else dbo.caj_Caja_Movimiento_det.cr_Valor end as cr_Valor,
				  
				   '' cr_NumDocumento, dbo.ba_TipoFlujo.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_TipoFlujo, 
                  dbo.caj_Caja_Movimiento.IdPersona, dbo.caj_Caja_Movimiento.IdTipo_Persona, dbo.caj_Caja_Movimiento.IdEntidad
FROM     dbo.caj_Caja_Movimiento INNER JOIN
                  dbo.caj_Caja_Movimiento_det ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.caj_Caja_Movimiento_det.IdEmpresa AND dbo.caj_Caja_Movimiento.IdCbteCble = dbo.caj_Caja_Movimiento_det.IdCbteCble AND 
                  dbo.caj_Caja_Movimiento.IdTipocbte = dbo.caj_Caja_Movimiento_det.IdTipocbte INNER JOIN
                  dbo.tb_empresa ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                  dbo.caj_Caja ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.caj_Caja.IdEmpresa AND dbo.caj_Caja_Movimiento.IdCaja = dbo.caj_Caja.IdCaja INNER JOIN
                  dbo.caj_Caja_Movimiento_Tipo ON dbo.caj_Caja_Movimiento.IdTipoMovi = dbo.caj_Caja_Movimiento_Tipo.IdTipoMovi INNER JOIN
                  dbo.ct_cbtecble_tipo ON dbo.caj_Caja_Movimiento.IdTipocbte = dbo.ct_cbtecble_tipo.IdTipoCbte AND dbo.caj_Caja_Movimiento.IdEmpresa = dbo.ct_cbtecble_tipo.IdEmpresa INNER JOIN
                  dbo.tb_persona ON dbo.caj_Caja_Movimiento.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                  dbo.ba_TipoFlujo ON dbo.caj_Caja_Movimiento.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND dbo.caj_Caja_Movimiento.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo
WHERE  (dbo.caj_Caja_Movimiento.Estado = 'A')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[3] 2[74] 3) )"
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
         Begin Table = "caj_Caja_Movimiento"
            Begin Extent = 
               Top = 27
               Left = 13
               Bottom = 341
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento_det"
            Begin Extent = 
               Top = 406
               Left = 1152
               Bottom = 535
               Right = 1361
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 88
               Left = 1137
               Bottom = 217
               Right = 1356
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja"
            Begin Extent = 
               Top = 282
               Left = 1044
               Bottom = 411
               Right = 1254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "caj_Caja_Movimiento_Tipo"
            Begin Extent = 
               Top = 243
               Left = 722
               Bottom = 372
               Right = 931
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 677
               Left = 735
               Bottom = 806
               Right = 965
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_TipoFlujo"
            Begin Extent = 
               Top = 684
               Left = 438
               Bottom = 813
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Right = 647
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ct_cbtecble_tipo"
            Begin Extent = 
               Top = 313
               Left = 618
               Bottom = 442
               Right = 827
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwtb_persona_beneficiario"
            Begin Extent = 
               Top = 0
               Left = 820
               Bottom = 267
               Right = 1029
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
      Begin ColumnWidths = 25
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1932
         Table = 2100
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCAJ_Rpt002';

