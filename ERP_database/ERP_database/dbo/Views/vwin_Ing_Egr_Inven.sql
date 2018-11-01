CREATE VIEW dbo.vwin_Ing_Egr_Inven
AS
SELECT        dbo.in_Ing_Egr_Inven.IdEmpresa, dbo.in_Ing_Egr_Inven.IdSucursal, dbo.in_Ing_Egr_Inven.IdNumMovi, dbo.in_Ing_Egr_Inven.IdBodega, dbo.in_Ing_Egr_Inven.signo, dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo, 
                         dbo.in_Ing_Egr_Inven.CodMoviInven, dbo.in_Ing_Egr_Inven.cm_observacion, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.in_Ing_Egr_Inven.IdUsuario, dbo.in_Ing_Egr_Inven.Estado, null IdCentroCosto, 
                         null IdCentroCosto_sub_centro_costo, dbo.in_Ing_Egr_Inven.MotivoAnulacion, 0 IdMotivo_oc, dbo.in_Ing_Egr_Inven.Fecha_Transac, dbo.in_Ing_Egr_Inven.IdUsuarioUltModi, 
                         dbo.in_Ing_Egr_Inven.Fecha_UltMod, dbo.in_Ing_Egr_Inven.IdusuarioUltAnu, dbo.in_Ing_Egr_Inven.Fecha_UltAnu, dbo.in_Ing_Egr_Inven.nom_pc, dbo.in_Ing_Egr_Inven.ip, dbo.tb_sucursal.Su_Descripcion AS nom_sucursal, 
                         dbo.tb_bodega.bo_Descripcion AS nom_bodega, dbo.in_movi_inven_tipo.Codigo AS cod_tipo_inv, dbo.in_movi_inven_tipo.tm_descripcion AS nom_tipo_inv, dbo.in_movi_inven_tipo.cm_tipo_movi AS signo_tipo_inv, 
                         dbo.com_Motivo_Orden_Compra.Descripcion AS nom_motivo, dbo.in_Ing_Egr_Inven.IdMotivo_Inv, dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdEstadoAproba, 
                         dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.Descripcion AS nom_EstadoAproba, dbo.in_Motivo_Inven.Desc_mov_inv, dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdEstadoDespacho_cat, 
                         dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdOrdenCompra, DATEDIFF(dd, 0, dbo.in_Ing_Egr_Inven.cm_fecha) + CONVERT(DATETIME, CAST(dbo.in_Ing_Egr_Inven.Fecha_Transac AS time)) AS Fecha_registro, 
                         dbo.in_Ing_Egr_Inven.IdResponsable, dbo.cp_orden_giro.co_factura, dbo.cp_proveedor.IdProveedor, tb_persona.pe_nombreCompleto pr_nombre, dbo.com_ordencompra_local.IdEstado_cierre, dbo.com_estado_cierre.Descripcion, 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre
FROM            dbo.com_ordencompra_local INNER JOIN
                         dbo.cp_proveedor ON dbo.com_ordencompra_local.IdEmpresa = dbo.cp_proveedor.IdEmpresa AND dbo.com_ordencompra_local.IdProveedor = dbo.cp_proveedor.IdProveedor INNER JOIN
                         dbo.com_estado_cierre ON dbo.com_ordencompra_local.IdEstado_cierre = dbo.com_estado_cierre.IdEstado_cierre RIGHT OUTER JOIN
                         Fj_servindustrias.in_Ing_Egr_Inven_fj INNER JOIN
                         dbo.ro_empleado ON Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.ro_empleado.IdEmpresa AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado = dbo.ro_empleado.IdEmpleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona AND dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona RIGHT OUTER JOIN
                         dbo.in_Ing_Egr_Inven INNER JOIN
                         dbo.tb_sucursal ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.tb_sucursal.IdSucursal INNER JOIN
                         dbo.in_movi_inven_tipo ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_movi_inven_tipo.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.in_movi_inven_tipo.IdMovi_inven_tipo INNER JOIN
                         dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob ON dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdMovi_inven_tipo AND 
                         dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdSucursal AND 
                         dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdNumMovi ON Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpresa = dbo.in_Ing_Egr_Inven.IdEmpresa AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdSucursal = dbo.in_Ing_Egr_Inven.IdSucursal AND Fj_servindustrias.in_Ing_Egr_Inven_fj.IdMovi_inven_tipo = dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo AND 
                         Fj_servindustrias.in_Ing_Egr_Inven_fj.IdNumMovi = dbo.in_Ing_Egr_Inven.IdNumMovi ON dbo.com_ordencompra_local.IdOrdenCompra = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdOrdenCompra AND 
                         dbo.com_ordencompra_local.IdEmpresa = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdEmpresa_oc AND 
                         dbo.com_ordencompra_local.IdSucursal = dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdSucursal_oc LEFT OUTER JOIN
                         dbo.cp_Aprobacion_Ing_Bod_x_OC INNER JOIN
                         dbo.cp_Aprobacion_Ing_Bod_x_OC_det ON dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdAprobacion = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdAprobacion INNER JOIN
                         dbo.cp_orden_giro ON dbo.cp_Aprobacion_Ing_Bod_x_OC.IdEmpresa_Ogiro = dbo.cp_orden_giro.IdEmpresa AND dbo.cp_Aprobacion_Ing_Bod_x_OC.IdCbteCble_Ogiro = dbo.cp_orden_giro.IdCbteCble_Ogiro AND 
                         dbo.cp_Aprobacion_Ing_Bod_x_OC.IdTipoCbte_Ogiro = dbo.cp_orden_giro.IdTipoCbte_Ogiro ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdEmpresa_Ing_Egr_Inv AND 
                         dbo.in_Ing_Egr_Inven.IdSucursal = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdSucursal_Ing_Egr_Inv AND dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdMovi_inven_tipo_Ing_Egr_Inv AND 
                         dbo.in_Ing_Egr_Inven.IdNumMovi = dbo.cp_Aprobacion_Ing_Bod_x_OC_det.IdNumMovi_Ing_Egr_Inv LEFT OUTER JOIN
                         dbo.com_Motivo_Orden_Compra ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.com_Motivo_Orden_Compra.IdEmpresa AND null = dbo.com_Motivo_Orden_Compra.IdMotivo LEFT OUTER JOIN
                         dbo.in_Motivo_Inven ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.in_Motivo_Inven.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdMotivo_Inv = dbo.in_Motivo_Inven.IdMotivo_Inv LEFT OUTER JOIN
                         dbo.tb_bodega ON dbo.in_Ing_Egr_Inven.IdEmpresa = dbo.tb_bodega.IdEmpresa AND dbo.in_Ing_Egr_Inven.IdSucursal = dbo.tb_bodega.IdSucursal AND dbo.in_Ing_Egr_Inven.IdBodega = dbo.tb_bodega.IdBodega
GROUP BY dbo.in_Ing_Egr_Inven.IdEmpresa, dbo.in_Ing_Egr_Inven.IdSucursal, dbo.in_Ing_Egr_Inven.IdNumMovi, dbo.in_Ing_Egr_Inven.IdBodega, dbo.in_Ing_Egr_Inven.signo, dbo.in_Ing_Egr_Inven.IdMovi_inven_tipo, 
                         dbo.in_Ing_Egr_Inven.CodMoviInven, dbo.in_Ing_Egr_Inven.cm_observacion, dbo.in_Ing_Egr_Inven.cm_fecha, dbo.in_Ing_Egr_Inven.IdUsuario, dbo.in_Ing_Egr_Inven.Estado,  
                         dbo.in_Ing_Egr_Inven.MotivoAnulacion, dbo.in_Ing_Egr_Inven.Fecha_Transac, dbo.in_Ing_Egr_Inven.IdUsuarioUltModi, 
                         dbo.in_Ing_Egr_Inven.Fecha_UltMod, dbo.in_Ing_Egr_Inven.IdusuarioUltAnu, dbo.in_Ing_Egr_Inven.Fecha_UltAnu, dbo.in_Ing_Egr_Inven.nom_pc, dbo.in_Ing_Egr_Inven.ip, dbo.tb_sucursal.Su_Descripcion, 
                         dbo.tb_bodega.bo_Descripcion, dbo.in_movi_inven_tipo.Codigo, dbo.in_movi_inven_tipo.tm_descripcion, dbo.in_movi_inven_tipo.cm_tipo_movi, dbo.com_Motivo_Orden_Compra.Descripcion, 
                         dbo.in_Ing_Egr_Inven.IdMotivo_Inv, dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdEstadoAproba, dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.Descripcion, dbo.in_Motivo_Inven.Desc_mov_inv, 
                         dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdEstadoDespacho_cat, dbo.vwin_Ing_Egr_Inven_det_x_estado_aprob.IdOrdenCompra, DATEDIFF(dd, 0, dbo.in_Ing_Egr_Inven.cm_fecha) + CONVERT(DATETIME, 
                         CAST(dbo.in_Ing_Egr_Inven.Fecha_Transac AS time)), dbo.in_Ing_Egr_Inven.IdResponsable, dbo.cp_orden_giro.co_factura, dbo.cp_proveedor.IdProveedor, tb_persona.pe_nombreCompleto, 
                         dbo.com_ordencompra_local.IdEstado_cierre, dbo.com_estado_cierre.Descripcion, Fj_servindustrias.in_Ing_Egr_Inven_fj.IdEmpleado, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[5] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[10] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
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
         Begin Table = "in_Motivo_Inven"
            Begin Extent = 
               Top = 78
               Left = 0
               Bottom = 139
               Right = 131
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_ordencompra_local"
            Begin Extent = 
               Top = 0
               Left = 282
               Bottom = 240
               Right = 515
            End
            DisplayFlags = 280
            TopColumn = 22
         End
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 300
               Left = 388
               Bottom = 450
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_estado_cierre"
            Begin Extent = 
               Top = 358
               Left = 1548
               Bottom = 488
               Right = 1773
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven"
            Begin Extent = 
               Top = 16
               Left = 405
               Bottom = 556
               Right = 668
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_sucursal"
            Begin Extent = 
               Top = 170
               Left = 0
               Bottom = 231
               Right = 131
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_movi_inven_tipo"
            Begin Extent = 
               Top = 1
               Left = 14
               Bottom = 62
               Right', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 145
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwin_Ing_Egr_Inven_det_x_estado_aprob"
            Begin Extent = 
               Top = 8
               Left = 912
               Bottom = 249
               Right = 1274
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_Aprobacion_Ing_Bod_x_OC"
            Begin Extent = 
               Top = 192
               Left = 38
               Bottom = 322
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_Aprobacion_Ing_Bod_x_OC_det"
            Begin Extent = 
               Top = 324
               Left = 38
               Bottom = 454
               Right = 340
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp_orden_giro"
            Begin Extent = 
               Top = 456
               Left = 38
               Bottom = 586
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "com_Motivo_Orden_Compra"
            Begin Extent = 
               Top = 110
               Left = 0
               Bottom = 171
               Right = 131
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_bodega"
            Begin Extent = 
               Top = 126
               Left = 0
               Bottom = 211
               Right = 131
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "in_Ing_Egr_Inven_fj (Fj_servindustrias)"
            Begin Extent = 
               Top = 153
               Left = 537
               Bottom = 353
               Right = 785
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ro_empleado"
            Begin Extent = 
               Top = 207
               Left = 773
               Bottom = 337
               Right = 1078
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 124
               Left = 828
               Bottom = 458
               Right = 1076
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
      Begin ColumnWidths = 46
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
         Width = 15', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'00
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwin_Ing_Egr_Inven';

