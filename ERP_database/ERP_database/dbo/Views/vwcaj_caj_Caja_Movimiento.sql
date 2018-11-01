CREATE VIEW [dbo].[vwcaj_caj_Caja_Movimiento]
AS
SELECT        CM.IdEmpresa, CM.IdCbteCble, CM.IdTipocbte, CM.cm_Signo, per.pe_nombreCompleto cm_beneficiario, CM.cm_valor, CM.IdTipoMovi, CM.cm_observacion, CM.IdCaja, CM.IdPeriodo, CM.cm_fecha, CM.IdUsuario, CM.IdUsuario_Anu, 
                         CM.FechaAnulacion, CM.Fecha_Transac, CM.Fecha_UltMod, CM.IdUsuarioUltMod, CM.Estado, CM.MotivoAnulacion, TM.tm_descripcion AS NTipoMov, 
                         CM.CodMoviCaja, C.ca_Descripcion, '' AS ResponsableCaja, CM.IdTipoFlujo, dbo.ba_TipoFlujo.Descricion AS nom_tipoFlujo, CM.IdTipo_Persona, 
                         CM.IdEntidad, dbo.vwtb_persona_beneficiario.Nombre AS nom_Beneficiario, CM.IdPersona
FROM            dbo.caj_Caja_Movimiento AS CM INNER JOIN
                         dbo.caj_Caja_Movimiento_Tipo AS TM ON CM.IdTipoMovi = TM.IdTipoMovi INNER JOIN
                         dbo.vwcaj_caj_Caja AS C ON CM.IdEmpresa = C.IdEmpresa AND CM.IdCaja = C.IdCaja LEFT OUTER JOIN
                         dbo.vwtb_persona_beneficiario ON CM.IdEmpresa = dbo.vwtb_persona_beneficiario.IdEmpresa AND CM.IdTipo_Persona = dbo.vwtb_persona_beneficiario.IdTipo_Persona AND 
                         CM.IdEntidad = dbo.vwtb_persona_beneficiario.IdEntidad LEFT OUTER JOIN
                         dbo.ba_TipoFlujo ON CM.IdEmpresa = dbo.ba_TipoFlujo.IdEmpresa AND CM.IdTipoFlujo = dbo.ba_TipoFlujo.IdTipoFlujo
						 inner join tb_persona per on CM.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[4] 3[38] 2) )"
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
         Begin Table = "CM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 397
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "TM"
            Begin Extent = 
               Top = 399
               Left = 263
               Bottom = 518
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 439
               Left = 791
               Bottom = 558
               Right = 993
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "S"
            Begin Extent = 
               Top = 434
               Left = 697
               Bottom = 543
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwtb_persona_beneficiario"
            Begin Extent = 
               Top = 12
               Left = 735
               Bottom = 202
               Right = 944
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_TipoFlujo"
            Begin Extent = 
               Top = 436
               Left = 422
               Bottom = 500
               Right = 631
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
      Begin ColumnWidths = 35
         Width = 284
         Width = 1500
         Width = 1500
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcaj_caj_Caja_Movimiento';


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
         Column = 2610
         Alias = 3330
         Table = 2310
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcaj_caj_Caja_Movimiento';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcaj_caj_Caja_Movimiento';

