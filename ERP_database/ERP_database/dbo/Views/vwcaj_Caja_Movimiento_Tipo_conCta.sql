CREATE VIEW vwcaj_Caja_Movimiento_Tipo_conCta
AS
SELECT        tabla.IdEmpresa, tabla.IdTipoMovi, tabla.tm_descripcion, tabla.Estado, tabla.tm_Signo, c.IdCtaCble, tabla.SeDeposita, dbo.ct_plancta.pc_clave_corta, 
                         dbo.ct_plancta.pc_Cuenta
FROM            dbo.ct_plancta INNER JOIN
                         dbo.caj_Caja_Movimiento_Tipo_x_CtaCble AS c ON dbo.ct_plancta.IdEmpresa = c.IdEmpresa AND dbo.ct_plancta.IdCtaCble = c.IdCtaCble RIGHT OUTER JOIN
                             (SELECT        e.IdEmpresa, e.em_nombre, e.em_ruc, e.em_gerente, e.em_contador, e.em_rucContador, e.em_telefonos, e.em_fax, e.em_notificacion, 
                                                         e.em_direccion, e.em_tel_int, e.em_logo, e.em_fondo, e.em_fechaInicioContable, t.IdTipoMovi, t.tm_descripcion, t.Estado, t.tm_Signo, t.IdUsuario, 
                                                         t.Fecha_Transac, t.IdUsuarioUltMod, t.Fecha_UltMod, t.IdUsuarioUltAnu, t.Fecha_UltAnu, t.nom_pc, t.ip, t.MotivoAnulacion, t.SeDeposita
                               FROM            dbo.tb_empresa AS e CROSS JOIN
                                                         dbo.caj_Caja_Movimiento_Tipo AS t) AS tabla ON c.IdEmpresa = tabla.IdEmpresa AND c.IdTipoMovi = tabla.IdTipoMovi
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[4] 2[47] 3) )"
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
         Begin Table = "c"
            Begin Extent = 
               Top = 0
               Left = 558
               Bottom = 164
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tabla"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 255
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
      Begin ColumnWidths = 31
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcaj_Caja_Movimiento_Tipo_conCta';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcaj_Caja_Movimiento_Tipo_conCta';

