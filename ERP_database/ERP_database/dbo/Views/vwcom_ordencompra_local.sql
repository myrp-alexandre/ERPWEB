CREATE VIEW [dbo].[vwcom_ordencompra_local]
AS
SELECT        OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_NumDocumento, OC.IdTerminoPago, OC.oc_plazo, OC.oc_fecha,  
                         OC.oc_observacion, OC.Estado, OC.IdEstadoAprobacion_cat, OC.co_fecha_aprobacion, OC.IdUsuario_Aprueba, OC.IdUsuario_Reprue, OC.co_fechaReproba, 
                         OC.Fecha_Transac, OC.Fecha_UltMod, OC.IdUsuarioUltMod, OC.FechaHoraAnul, OC.IdUsuarioUltAnu,  
                         OC.MotivoReprobacion, SUM(OCDet.do_subtotal) AS subtotal, SUM(OCDet.do_iva) AS iva, SUM(OCDet.do_total) AS total, 
                         Apr.descripcion AS ap_descripcion, REc.descripcion AS rec_descripcion, per.pe_nombreCompleto pr_nombre, dbo.tb_sucursal.Su_Descripcion, OC.IdDepartamento,  
                          OC.IdComprador, OC.MotivoAnulacion, dbo.ro_Departamento.de_descripcion AS SDepartamento, OC.IdMotivo, OC.oc_fechaVencimiento, 
                         dbo.com_comprador.Descripcion AS Nom_Comprador, OC.IdEstado_cierre, dbo.com_Motivo_Orden_Compra.Descripcion AS nom_motivo_OC, 
                         dbo.com_solicitante.nom_solicitante AS Nom_Solicita, dbo.com_TerminoPago.Descripcion AS tp_descripcion, 
                         dbo.com_estado_cierre.Descripcion AS nom_EstadoCerrado, A.En_guia
FROM            dbo.com_ordencompra_local AS OC INNER JOIN
                         dbo.com_ordencompra_local_det AS OCDet ON OC.IdEmpresa = OCDet.IdEmpresa AND OC.IdSucursal = OCDet.IdSucursal AND 
                         OC.IdOrdenCompra = OCDet.IdOrdenCompra INNER JOIN
                         dbo.cp_proveedor AS Prov ON OC.IdEmpresa = Prov.IdEmpresa AND OC.IdProveedor = Prov.IdProveedor INNER JOIN
						 tb_persona as per on prov.IdPersona = per.IdPersona inner join

                         dbo.tb_sucursal ON OC.IdSucursal = dbo.tb_sucursal.IdSucursal AND OC.IdEmpresa = dbo.tb_sucursal.IdEmpresa INNER JOIN
                         dbo.vwcom_EstadoRecibido AS REc ON 1 = REc.Id INNER JOIN
                         dbo.vwcom_EstadoAprobacion AS Apr ON OC.IdEstadoAprobacion_cat = Apr.Id INNER JOIN
                         dbo.com_comprador ON OC.IdEmpresa = dbo.com_comprador.IdEmpresa AND OC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_estado_cierre ON OC.IdEstado_cierre = dbo.com_estado_cierre.IdEstado_cierre LEFT OUTER JOIN
                         dbo.com_Motivo_Orden_Compra ON OC.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND 
                         OC.IdMotivo = dbo.com_Motivo_Orden_Compra.IdMotivo LEFT OUTER JOIN
                             (
								SELECT        oc.IdEmpresa, oc.IdSucursal, oc.IdOrdenCompra, 'TIENE GUIA' AS En_guia
								FROM            in_Guia_x_traspaso_bodega_det AS guia INNER JOIN
								com_ordencompra_local_det AS oc ON guia.IdEmpresa_OC = oc.IdEmpresa AND guia.IdSucursal_OC = oc.IdSucursal AND 
								guia.IdOrdenCompra_OC = oc.IdOrdenCompra AND guia.Secuencia_OC = oc.Secuencia
								GROUP BY oc.IdEmpresa, oc.IdSucursal, oc.IdOrdenCompra
							) AS A ON OC.IdOrdenCompra = A.IdOrdenCompra AND A.IdEmpresa = OC.IdEmpresa AND 
                         A.IdSucursal = OC.IdSucursal LEFT OUTER JOIN
                         dbo.com_TerminoPago ON OC.IdTerminoPago = dbo.com_TerminoPago.IdTerminoPago LEFT OUTER JOIN
                         dbo.com_solicitante ON OC.IdEmpresa = dbo.com_solicitante.IdEmpresa AND 1 = dbo.com_solicitante.IdSolicitante LEFT OUTER JOIN
                         dbo.ro_Departamento ON OC.IdDepartamento = dbo.ro_Departamento.IdDepartamento AND OC.IdEmpresa = dbo.ro_Departamento.IdEmpresa
GROUP BY OC.IdEmpresa, OC.IdSucursal, OC.IdOrdenCompra, OC.IdProveedor, OC.oc_NumDocumento, OC.IdTerminoPago, OC.oc_plazo, OC.oc_fecha,  
                         OC.oc_observacion, OC.Estado, OC.IdEstadoAprobacion_cat, OC.co_fecha_aprobacion, OC.IdUsuario_Aprueba, OC.IdUsuario_Reprue, OC.co_fechaReproba, 
                         OC.Fecha_Transac, OC.Fecha_UltMod, OC.IdUsuarioUltMod, OC.FechaHoraAnul, OC.IdUsuarioUltAnu,  
                         OC.MotivoReprobacion, Apr.descripcion, REc.descripcion, per.pe_nombreCompleto, dbo.tb_sucursal.Su_Descripcion, OC.IdDepartamento, 
                         OC.IdComprador, OC.MotivoAnulacion, dbo.ro_Departamento.de_descripcion, OC.IdMotivo, OC.oc_fechaVencimiento, dbo.com_comprador.Descripcion, 
                         OC.IdEstado_cierre, dbo.com_Motivo_Orden_Compra.Descripcion, dbo.com_solicitante.nom_solicitante, dbo.com_TerminoPago.Descripcion, 
                         dbo.com_estado_cierre.Descripcion, A.En_guia
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
         Top = -1344
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC"
            Begin Extent = 
               Top = 0
               Left = 755
               Bottom = 649
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OCDet"
            Begin Extent = 
               Top = 0
               Left = 1029
               Bottom = 129
               Right = 1308
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Prov"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 129
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "REc"
            Begin Extent = 
               Top = 331
               Left = 8
               Bottom = 460
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Apr"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_comprador"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 927
               Right = 263
            End
            DisplayFlags = 280
            ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'TopColumn = 0
         End
         Begin Table = "com_Motivo_Orden_Compra"
            Begin Extent = 
               Top = 998
               Left = 748
               Bottom = 1127
               Right = 973
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_estado_cierre"
            Begin Extent = 
               Top = 910
               Left = 714
               Bottom = 1039
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 897
               Left = 27
               Bottom = 1026
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_TerminoPago"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1455
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_solicitante"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1587
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_Departamento"
            Begin Extent = 
               Top = 1590
               Left = 38
               Bottom = 1719
               Right = 263
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcom_ordencompra_local';

