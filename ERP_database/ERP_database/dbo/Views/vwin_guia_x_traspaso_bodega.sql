CREATE VIEW dbo.vwin_guia_x_traspaso_bodega
AS
SELECT        dbo.in_Guia_x_traspaso_bodega.IdEmpresa, dbo.in_Guia_x_traspaso_bodega.IdGuia, dbo.in_Guia_x_traspaso_bodega.NumGuia, 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Partida, [Sucursal Llegada].Su_Descripcion, dbo.in_Guia_x_traspaso_bodega.IdSucursal_Llegada, 
                         [Sucursal Partida].Su_Descripcion AS Su_Descripcion_Llegada, dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Partida, 
                         dbo.in_Guia_x_traspaso_bodega.Direc_sucu_Llegada, dbo.in_Guia_x_traspaso_bodega.IdTransportista, dbo.in_Guia_x_traspaso_bodega.Fecha, 
                         dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado, dbo.in_Guia_x_traspaso_bodega.Estado, dbo.in_Guia_x_traspaso_bodega.Fecha_Traslado, 
                         dbo.in_Guia_x_traspaso_bodega.Fecha_llegada, dbo.in_Guia_x_traspaso_bodega.Hora_Traslado, dbo.in_Guia_x_traspaso_bodega.Hora_Llegada, 
                         dbo.in_Guia_x_traspaso_bodega.CodDocumentoTipo, dbo.in_Guia_x_traspaso_bodega.IdEstablecimiento, dbo.in_Guia_x_traspaso_bodega.IdPuntoEmision, 
                         dbo.in_Guia_x_traspaso_bodega.NumDocumento_Guia, dbo.in_Guia_x_traspaso_bodega.IdUsuario, dbo.in_Guia_x_traspaso_bodega.Fecha_Transac, 
                         dbo.tb_transportista.Cedula AS ced_transportista, dbo.tb_transportista.Nombre AS nom_transportista, dbo.in_Catalogo.Nombre AS nom_Motivo_Traslado, 
                         [Sucursal Llegada].Su_CodigoEstablecimiento AS cod_estable_llegada, [Sucursal Partida].Su_CodigoEstablecimiento AS cod_estable_partida, 
                         dbo.tb_empresa.RazonSocial AS razon_social_empresa, dbo.tb_empresa.NombreComercial AS nom_comercial_empresa, 
                         dbo.tb_empresa.ContribuyenteEspecial AS contrib_especial_empresa, dbo.tb_empresa.ObligadoAllevarConta AS obligado_conta_empresa, 
                         dbo.tb_empresa.em_ruc AS ruc_empresa, dbo.tb_empresa.em_nombre AS nom_empresa, dbo.tb_empresa.em_direccion AS direc_empresa, 
                         dbo.tb_transportista.Placa
FROM            dbo.in_Guia_x_traspaso_bodega INNER JOIN
                         dbo.tb_sucursal AS [Sucursal Llegada] ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = [Sucursal Llegada].IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Partida = [Sucursal Llegada].IdSucursal INNER JOIN
                         dbo.tb_sucursal AS [Sucursal Partida] ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = [Sucursal Partida].IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdSucursal_Llegada = [Sucursal Partida].IdSucursal INNER JOIN
                         dbo.tb_transportista ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_transportista.IdEmpresa AND 
                         dbo.in_Guia_x_traspaso_bodega.IdTransportista = dbo.tb_transportista.IdTransportista INNER JOIN
                         dbo.in_Catalogo ON dbo.in_Guia_x_traspaso_bodega.IdMotivo_Traslado = dbo.in_Catalogo.IdCatalogo INNER JOIN
                         dbo.tb_empresa ON dbo.in_Guia_x_traspaso_bodega.IdEmpresa = dbo.tb_empresa.IdEmpresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[3] 2[28] 3) )"
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
         Begin Table = "in_Guia_x_traspaso_bodega"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sucursal Llegada"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 135
               Right = 515
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sucursal Partida"
            Begin Extent = 
               Top = 6
               Left = 553
               Bottom = 135
               Right = 783
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_transportista"
            Begin Extent = 
               Top = 28
               Left = 840
               Bottom = 315
               Right = 1049
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Catalogo"
            Begin Extent = 
               Top = 6
               Left = 1068
               Bottom = 135
               Right = 1277
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 257
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
      Begin ColumnWidths = 37
         Width = 284
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_guia_x_traspaso_bodega';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Width = 1500
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
         Width = 2415
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
         Column = 3150
         Alias = 5430
         Table = 6420
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_guia_x_traspaso_bodega';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_guia_x_traspaso_bodega';

