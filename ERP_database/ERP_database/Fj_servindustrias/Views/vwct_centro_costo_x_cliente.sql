CREATE VIEW Fj_servindustrias.vwct_centro_costo_x_cliente
AS
SELECT        dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, null pe_telefonoOfic, null pe_telefonoCasa, 
                         dbo.tb_persona.pe_correo, dbo.tb_persona.pe_Naturaleza, dbo.tb_persona.pe_estado, dbo.tb_persona.IdTipoDocumento, 
                         fa_cliente_x_ct_centro_costo_1.IdCliente_cli, fa_cliente_x_ct_centro_costo_1.IdEmpresa_cli,  dbo.fa_cliente.Estado, 
                         dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, 
                         dbo.tb_persona.pe_nombreCompleto AS nom_Cliente, dbo.tb_persona.pe_celular, dbo.tb_persona.num_cta_acreditacion, dbo.ct_centro_costo.pc_Estado, 
                         dbo.ct_centro_costo.CodCentroCosto, dbo.ct_centro_costo.IdCentroCostoPadre, dbo.ct_centro_costo.IdCentroCosto AS IdCentroCosto_cc, 
                         dbo.ct_centro_costo.IdEmpresa AS IdEmpresa_cc
FROM            dbo.fa_cliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona  INNER JOIN
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo AS fa_cliente_x_ct_centro_costo_1 ON 
                         dbo.fa_cliente.IdEmpresa = fa_cliente_x_ct_centro_costo_1.IdEmpresa_cli AND 
                         dbo.fa_cliente.IdCliente = fa_cliente_x_ct_centro_costo_1.IdCliente_cli RIGHT OUTER JOIN
                         dbo.ct_centro_costo ON fa_cliente_x_ct_centro_costo_1.IdEmpresa_cc = dbo.ct_centro_costo.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_1.IdCentroCosto_cc = dbo.ct_centro_costo.IdCentroCosto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[5] 2[37] 3) )"
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
         Begin Table = "fa_cliente"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 43
               Left = 570
               Bottom = 172
               Right = 802
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwtb_Ciudad"
            Begin Extent = 
               Top = 20
               Left = 606
               Bottom = 149
               Right = 815
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fa_cliente_x_ct_centro_costo_1"
            Begin Extent = 
               Top = 33
               Left = 334
               Bottom = 162
               Right = 543
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ct_centro_costo"
            Begin Extent = 
               Top = 47
               Left = 955
               Bottom = 176
               Right = 1164
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
         Colum', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwct_centro_costo_x_cliente';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n = 3450
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
', @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwct_centro_costo_x_cliente';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Fj_servindustrias', @level1type = N'VIEW', @level1name = N'vwct_centro_costo_x_cliente';

