CREATE view [dbo].[vwCOMP_Rpt002]
as
SELECT     isnull(ROW_NUMBER() OVER(ORDER BY SC_OC.IdEmpresa),0) AS IdRow,   SC_OC.IdEmpresa, SC_OC.IdSucursal, SC_OC.IdSolicitudCompra, SC_OC.IdSolicitante AS IdPersona_Solicita, ROW_NUMBER() OVER (ORDER BY SC_OC.IdEmpresa)
 AS IdFila, SC_OC.IdDepartamento, emp.em_nombre AS nom_empresa, sucu.Su_Descripcion AS nom_sucursal, SC_OC.fecha, SC_OC.observacion, sc_dt_oc.IdProducto, 
CASE WHEN sc_dt_oc.IdProducto IS NULL THEN sc_dt_oc.NomProducto ELSE prod.pr_descripcion END AS nom_producto, sc_dt_oc.do_Cantidad, emp.em_ruc, 
emp.em_direccion, emp.em_telefonos, dbo.com_comprador.IdComprador AS IdPersona_comprador, dbo.com_comprador.Descripcion AS nom_personaComp, 
dbo.ct_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_centro_costo.IdCentroCosto, dbo.ct_centro_costo.Centro_costo AS nom_Centro_Costo, 
dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo AS IdSubCentroCosto, dbo.ct_centro_costo_sub_centro_costo.Centro_costo AS nom_SubCentroCosto, 
sc_dt_oc.IdUnidadMedida, dbo.in_UnidadMedida.Descripcion AS nom_unidad, dbo.com_solicitante.nom_solicitante AS nom_personaSol, 
dbo.com_departamento.nom_departamento, prod.pr_codigo
FROM            dbo.ct_centro_costo_sub_centro_costo RIGHT OUTER JOIN
                         dbo.com_solicitud_compra AS SC_OC INNER JOIN
                         dbo.com_solicitud_compra_det AS sc_dt_oc ON SC_OC.IdEmpresa = sc_dt_oc.IdEmpresa AND SC_OC.IdSucursal = sc_dt_oc.IdSucursal AND 
                         SC_OC.IdSolicitudCompra = sc_dt_oc.IdSolicitudCompra INNER JOIN
                         dbo.tb_empresa AS emp ON SC_OC.IdEmpresa = emp.IdEmpresa INNER JOIN
                         dbo.tb_sucursal AS sucu ON SC_OC.IdEmpresa = sucu.IdEmpresa AND SC_OC.IdSucursal = sucu.IdSucursal INNER JOIN
                         dbo.com_comprador ON SC_OC.IdEmpresa = dbo.com_comprador.IdEmpresa AND SC_OC.IdComprador = dbo.com_comprador.IdComprador INNER JOIN
                         dbo.com_solicitante ON SC_OC.IdEmpresa = dbo.com_solicitante.IdEmpresa AND SC_OC.IdSolicitante = dbo.com_solicitante.IdSolicitante INNER JOIN
                         dbo.com_departamento ON SC_OC.IdEmpresa = dbo.com_departamento.IdEmpresa AND 
                         SC_OC.IdDepartamento = dbo.com_departamento.IdDepartamento LEFT OUTER JOIN
                         dbo.in_UnidadMedida ON sc_dt_oc.IdUnidadMedida = dbo.in_UnidadMedida.IdUnidadMedida ON 
                         dbo.ct_centro_costo_sub_centro_costo.IdEmpresa = sc_dt_oc.IdEmpresa AND dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto = sc_dt_oc.IdCentroCosto AND 
                         dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = sc_dt_oc.IdCentroCosto_sub_centro_costo LEFT OUTER JOIN
                         dbo.ct_centro_costo ON sc_dt_oc.IdEmpresa = dbo.ct_centro_costo.IdEmpresa AND sc_dt_oc.IdCentroCosto = dbo.ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                         dbo.ct_punto_cargo ON sc_dt_oc.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND sc_dt_oc.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo LEFT OUTER JOIN
                         dbo.in_Producto AS prod ON sc_dt_oc.IdEmpresa = prod.IdEmpresa AND sc_dt_oc.IdProducto = prod.IdProducto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[5] 2[72] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[24] 4[23] 3) )"
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
         Configuration = "(H (1[94] 3) )"
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
         Top = -780
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
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
         Width = 3855
         Width = 1860
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
         Alias = 4230
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt002';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwCOMP_Rpt002';

