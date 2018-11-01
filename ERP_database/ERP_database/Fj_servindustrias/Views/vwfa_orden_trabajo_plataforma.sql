CREATE VIEW Fj_servindustrias.vwfa_orden_trabajo_plataforma
AS
SELECT Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa, Fj_servindustrias.fa_orden_trabajo_plataforma.IdOrdenTrabajo_Pla, Fj_servindustrias.fa_orden_trabajo_plataforma.codOrdenTrabajo_Pla, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdCliente, Fj_servindustrias.fa_orden_trabajo_plataforma.Descripcion, Fj_servindustrias.fa_orden_trabajo_plataforma.Equipo, Fj_servindustrias.fa_orden_trabajo_plataforma.serie, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.km_salida, Fj_servindustrias.fa_orden_trabajo_plataforma.km_llegada, Fj_servindustrias.fa_orden_trabajo_plataforma.con_atencion_a, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdUsuarioUltMod, Fj_servindustrias.fa_orden_trabajo_plataforma.Fecha_UltMod, Fj_servindustrias.fa_orden_trabajo_plataforma.IdUsuarioUltAnu, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.Fecha_UltAnu, Fj_servindustrias.fa_orden_trabajo_plataforma.MotiAnula, Fj_servindustrias.fa_orden_trabajo_plataforma.nom_pc, Fj_servindustrias.fa_orden_trabajo_plataforma.ip, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.Estado, dbo.tb_persona.pe_nombreCompleto AS nom_Cliente, Fj_servindustrias.fa_orden_trabajo_plataforma.Fecha, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma_det.descrip_equipo_movi, Fj_servindustrias.fa_orden_trabajo_plataforma_det.punto_partida, Fj_servindustrias.fa_orden_trabajo_plataforma_det.punto_llegada, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma_det.hora_ini, Fj_servindustrias.fa_orden_trabajo_plataforma_det.hora_fin, Fj_servindustrias.fa_orden_trabajo_plataforma_det.Valor, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.vt_num_factura, Fj_servindustrias.fa_orden_trabajo_plataforma.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, Fj_servindustrias.fa_orden_trabajo_plataforma.IdTransportista, 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdVendedor, dbo.tb_transportista.Nombre, dbo.fa_Vendedor.Ve_Vendedor
FROM     Fj_servindustrias.fa_orden_trabajo_plataforma_det INNER JOIN
                  Fj_servindustrias.fa_orden_trabajo_plataforma ON Fj_servindustrias.fa_orden_trabajo_plataforma_det.IdEmpresa = Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa AND 
                  Fj_servindustrias.fa_orden_trabajo_plataforma_det.IdOrdenTrabajo_Pla = Fj_servindustrias.fa_orden_trabajo_plataforma.IdOrdenTrabajo_Pla LEFT OUTER JOIN
                  dbo.ct_punto_cargo ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo AND 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                  dbo.fa_Vendedor ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdVendedor = dbo.fa_Vendedor.IdVendedor AND 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdVendedor = dbo.fa_Vendedor.IdVendedor LEFT OUTER JOIN
                  dbo.tb_transportista ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.tb_transportista.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdTransportista = dbo.tb_transportista.IdTransportista AND 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.tb_transportista.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdTransportista = dbo.tb_transportista.IdTransportista LEFT OUTER JOIN
                  dbo.fa_cliente INNER JOIN
                  dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = dbo.fa_cliente.IdEmpresa AND 
                  Fj_servindustrias.fa_orden_trabajo_plataforma.IdCliente = dbo.fa_cliente.IdCliente
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[83] 4[3] 2[3] 3) )"
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
         Begin Table = "fa_orden_trabajo_plataforma_det (Fj_servindustrias)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_orden_trabajo_plataforma (Fj_servindustrias)"
            Begin Extent = 
               Top = 17
               Left = 523
               Bottom = 280
               Right = 761
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "ct_punto_cargo"
            Begin Extent = 
               Top = 57
               Left = 960
               Bottom = 220
               Right = 1196
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 343
               Left = 48
               Bottom = 506
               Right = 326
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 511
               Left = 48
               Bottom = 674
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_transportista"
            Begin Extent = 
               Top = 257
               Left = 1109
               Bottom = 420
               Right = 1326
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_Vendedor"
            Begin Extent = 
               Top = 7
               Left = ', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_orden_trabajo_plataforma';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'1357
               Bottom = 247
               Right = 1566
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_orden_trabajo_plataforma';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwfa_orden_trabajo_plataforma';

