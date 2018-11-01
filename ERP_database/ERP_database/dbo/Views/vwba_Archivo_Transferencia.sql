CREATE view [dbo].[vwba_Archivo_Transferencia]
as
SELECT        dbo.ba_Archivo_Transferencia.IdEmpresa, dbo.tb_empresa.em_nombre AS nom_empresa, dbo.ba_Archivo_Transferencia.IdArchivo, 
                         dbo.ba_Archivo_Transferencia.IdBanco, dbo.tb_banco.ba_descripcion AS nom_banco, dbo.ba_Archivo_Transferencia.Origen_Archivo, 
                         dbo.ba_Archivo_Transferencia.Cod_Empresa, dbo.ba_Archivo_Transferencia.Nom_Archivo, dbo.ba_Archivo_Transferencia.Fecha, 
                         dbo.ba_Archivo_Transferencia.IdEstadoArchivo_cat, dbo.ba_Catalogo.ca_descripcion AS nom_EstadoArchivo, dbo.ba_Archivo_Transferencia.Observacion, 
                         dbo.ba_Archivo_Transferencia.Estado, dbo.tb_banco.CodigoLegal, dbo.ba_Archivo_Transferencia.IdOrden_Bancaria, dbo.ba_Archivo_Transferencia.cod_archivo, 
                         dbo.vwba_Archivo_Transferencia_Det_sum_valores.Valor_Enviado, dbo.vwba_Archivo_Transferencia_Det_sum_valores.Valor_cobrado, 
                         dbo.vwba_Archivo_Transferencia_Det_sum_valores.Saldo_x_Cobrar, dbo.ba_Archivo_Transferencia.IdMotivoArchivo_cat, 
                         ba_Catalogo_1.ca_descripcion AS nom_MotivoArchivo, dbo.vwtb_tb_banco_procesos_bancarios.nom_proceso_bancario, 
                         dbo.ba_Archivo_Transferencia.Fecha_Proceso, dbo.vwtb_tb_banco_procesos_bancarios.IdProceso_bancario_tipo, 
                         dbo.ba_Archivo_Transferencia.Contabilizado
FROM            dbo.tb_banco INNER JOIN
                         dbo.ba_Banco_Cuenta ON dbo.tb_banco.IdBanco = dbo.ba_Banco_Cuenta.IdBanco_Financiero INNER JOIN
                         dbo.ba_Archivo_Transferencia INNER JOIN
                         dbo.tb_empresa ON dbo.ba_Archivo_Transferencia.IdEmpresa = dbo.tb_empresa.IdEmpresa INNER JOIN
                         dbo.ba_Catalogo ON dbo.ba_Archivo_Transferencia.IdEstadoArchivo_cat = dbo.ba_Catalogo.IdCatalogo INNER JOIN
                         dbo.vwba_Archivo_Transferencia_Det_sum_valores ON 
                         dbo.ba_Archivo_Transferencia.IdEmpresa = dbo.vwba_Archivo_Transferencia_Det_sum_valores.IdEmpresa AND 
                         dbo.ba_Archivo_Transferencia.IdArchivo = dbo.vwba_Archivo_Transferencia_Det_sum_valores.IdArchivo INNER JOIN
                         dbo.vwtb_tb_banco_procesos_bancarios ON dbo.ba_Archivo_Transferencia.IdEmpresa = dbo.vwtb_tb_banco_procesos_bancarios.IdEmpresa AND 
                         dbo.ba_Archivo_Transferencia.IdProceso_bancario = dbo.vwtb_tb_banco_procesos_bancarios.IdProceso_bancario_tipo ON 
                         dbo.ba_Banco_Cuenta.IdEmpresa = dbo.ba_Archivo_Transferencia.IdEmpresa AND 
                         dbo.ba_Banco_Cuenta.IdBanco = dbo.ba_Archivo_Transferencia.IdBanco LEFT OUTER JOIN
                         dbo.ba_Catalogo AS ba_Catalogo_1 ON dbo.ba_Archivo_Transferencia.IdMotivoArchivo_cat = ba_Catalogo_1.IdCatalogo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[85] 4[4] 2[4] 3) )"
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
         Begin Table = "ba_Archivo_Transferencia"
            Begin Extent = 
               Top = 0
               Left = 44
               Bottom = 361
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "tb_empresa"
            Begin Extent = 
               Top = 69
               Left = 1037
               Bottom = 484
               Right = 1256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_banco"
            Begin Extent = 
               Top = 206
               Left = 883
               Bottom = 404
               Right = 1117
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Catalogo"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwba_Archivo_Transferencia_Det_sum_valores"
            Begin Extent = 
               Top = 0
               Left = 704
               Bottom = 195
               Right = 980
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwtb_tb_banco_procesos_bancarios"
            Begin Extent = 
               Top = 183
               Left = 322
               Bottom = 477
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ba_Catalogo_1"
            Begin Extent = 
               Top = 280
               Left = 642
             ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Bottom = 377
               Right = 851
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
      Begin ColumnWidths = 24
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2535
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwba_Archivo_Transferencia';

