CREATE VIEW [dbo].[vwACTF_Rpt013]
AS
SELECT        'Depreacion' AS Tipo_Registro, vwAf_Activo_fijo.IdEmpresa, vwAf_Activo_fijo.IdActivoFijo, vwAf_Activo_fijo.CodActivoFijo, vwAf_Activo_fijo.Af_Nombre, 
                         vwAf_Activo_fijo.IdActijoFijoTipo, vwAf_Activo_fijo.IdDepartamento, vwAf_Activo_fijo.de_descripcion, vwAf_Activo_fijo.Marca, vwAf_Activo_fijo.Modelo, 
                         vwAf_Activo_fijo.Af_NumSerie, vwAf_Activo_fijo.Af_fecha_compra, vwAf_Activo_fijo.Af_fecha_ini_depre, vwAf_Activo_fijo.Af_fecha_fin_depre, 
                         vwAf_Activo_fijo.Af_Costo_historico, vwAf_Activo_fijo.Af_costo_compra, vwAf_Activo_fijo.Af_Vida_Util, vwAf_Activo_fijo.Af_Meses_depreciar, 
                         vwAf_Activo_fijo.Af_porcentaje_deprec, vwAf_Activo_fijo.Af_NumSerie_Motor, vwAf_Activo_fijo.Af_NumSerie_Chasis, Af_Depreciacion.Fecha_Depreciacion AS Fecha, 
                         Af_Depreciacion_Det.Valor_Depre_Acum AS Valor
/*
						 , Af_Depreciacion.IdPeriodo
                         Af_Depreciacion.Valor_Tot_Act, Af_Depreciacion.Valor_Tot_Depre, Af_Depreciacion.Valor_Tot_DepreAcum, Af_Depreciacion.Valot_Tot_Importe, 
                         Af_Depreciacion_Det.Valor_Compra, Af_Depreciacion_Det.Valor_Salvamento, Af_Depreciacion_Det.Vida_Util, Af_Depreciacion_Det.Porc_Depreciacion, 
                         Af_Depreciacion_Det.Valor_Depreciacion, , Af_Depreciacion_Det.Valor_Importe, 
                         Af_Depreciacion_Det.Es_Activo_x_Mejora
						 */ 
						 ,vwAf_Activo_fijo.IdSucursal,vwAf_Activo_fijo.nom_Sucursal
						 FROM
                          Af_Depreciacion_Det INNER JOIN
                         Af_Depreciacion ON Af_Depreciacion_Det.IdEmpresa = Af_Depreciacion.IdEmpresa AND Af_Depreciacion_Det.IdDepreciacion = Af_Depreciacion.IdDepreciacion 
                          INNER JOIN
                         vwAf_Activo_fijo ON Af_Depreciacion_Det.IdEmpresa = vwAf_Activo_fijo.IdEmpresa AND Af_Depreciacion_Det.IdActivoFijo = vwAf_Activo_fijo.IdActivoFijo


UNION
SELECT        'Retiro' AS Tipo_Registro, vwAf_Activo_fijo.IdEmpresa, vwAf_Activo_fijo.IdActivoFijo, vwAf_Activo_fijo.CodActivoFijo, vwAf_Activo_fijo.Af_Nombre, 
                         vwAf_Activo_fijo.IdActijoFijoTipo, vwAf_Activo_fijo.IdDepartamento, vwAf_Activo_fijo.de_descripcion, vwAf_Activo_fijo.Marca, vwAf_Activo_fijo.Modelo, 
                         vwAf_Activo_fijo.Af_NumSerie, vwAf_Activo_fijo.Af_fecha_compra, vwAf_Activo_fijo.Af_fecha_ini_depre, vwAf_Activo_fijo.Af_fecha_fin_depre, 
                         vwAf_Activo_fijo.Af_Costo_historico, vwAf_Activo_fijo.Af_costo_compra, vwAf_Activo_fijo.Af_Vida_Util, vwAf_Activo_fijo.Af_Meses_depreciar, 
                         vwAf_Activo_fijo.Af_porcentaje_deprec, vwAf_Activo_fijo.Af_NumSerie_Motor, vwAf_Activo_fijo.Af_NumSerie_Chasis, Af_Retiro_Activo.Fecha_Retiro Fecha, 
                         Af_Retiro_Activo.Valor_Depre_Acu
/*
						 , Af_Retiro_Activo.IdRetiroActivo, Af_Retiro_Activo.ValorActivo, 
                         Af_Retiro_Activo.Valor_Tot_Bajas, Af_Retiro_Activo.Valor_Tot_Mejora, , Af_Retiro_Activo.Valor_Neto, 
                         Af_Retiro_Activo.NumComprobante, Af_Retiro_Activo.Concepto_Retiro, 
						 */ 
						 ,vwAf_Activo_fijo.IdSucursal,vwAf_Activo_fijo.nom_Sucursal
						 FROM
                          vwAf_Activo_fijo INNER JOIN
                         Af_Retiro_Activo ON vwAf_Activo_fijo.IdEmpresa = Af_Retiro_Activo.IdEmpresa AND vwAf_Activo_fijo.IdActivoFijo = Af_Retiro_Activo.IdActivoFijo
UNION
SELECT        'Venta' AS Tipo_Registro, vwAf_Activo_fijo.IdEmpresa, vwAf_Activo_fijo.IdActivoFijo, vwAf_Activo_fijo.CodActivoFijo, vwAf_Activo_fijo.Af_Nombre, 
                         vwAf_Activo_fijo.IdActijoFijoTipo, vwAf_Activo_fijo.IdDepartamento, vwAf_Activo_fijo.de_descripcion, vwAf_Activo_fijo.Marca, vwAf_Activo_fijo.Modelo, 
                         vwAf_Activo_fijo.Af_NumSerie, vwAf_Activo_fijo.Af_fecha_compra, vwAf_Activo_fijo.Af_fecha_ini_depre, vwAf_Activo_fijo.Af_fecha_fin_depre, 
                         vwAf_Activo_fijo.Af_Costo_historico, vwAf_Activo_fijo.Af_costo_compra, vwAf_Activo_fijo.Af_Vida_Util, vwAf_Activo_fijo.Af_Meses_depreciar, 
                         vwAf_Activo_fijo.Af_porcentaje_deprec, vwAf_Activo_fijo.Af_NumSerie_Motor, vwAf_Activo_fijo.Af_NumSerie_Chasis, Af_Venta_Activo.Fecha_Venta Fecha, 
                         Af_Venta_Activo.Valor_Tot_Mejora AS Valor
/*, Af_Venta_Activo.IdVtaActivo, Af_Venta_Activo.ValorActivo, 
                         Af_Venta_Activo.Valor_Tot_Bajas, , Af_Venta_Activo.Valor_Depre_Acu, Af_Venta_Activo.Valor_Neto, Af_Venta_Activo.Valor_Venta, 
                         Af_Venta_Activo.Valor_Perdi_Gana, Af_Venta_Activo.NumComprobante, Af_Venta_Activo.Concepto_Vta, 
						 */ 
						 ,vwAf_Activo_fijo.IdSucursal,vwAf_Activo_fijo.nom_Sucursal
						 FROM
                          vwAf_Activo_fijo INNER JOIN
                         Af_Venta_Activo ON vwAf_Activo_fijo.IdEmpresa = Af_Venta_Activo.IdEmpresa AND vwAf_Activo_fijo.IdActivoFijo = Af_Venta_Activo.IdActivoFijo
UNION
SELECT        'Mejora' AS Tipo_Registro, vwAf_Activo_fijo.IdEmpresa, vwAf_Activo_fijo.IdActivoFijo, vwAf_Activo_fijo.CodActivoFijo, vwAf_Activo_fijo.Af_Nombre, 
                         vwAf_Activo_fijo.IdActijoFijoTipo, vwAf_Activo_fijo.IdDepartamento, vwAf_Activo_fijo.de_descripcion, vwAf_Activo_fijo.Marca, vwAf_Activo_fijo.Modelo, 
                         vwAf_Activo_fijo.Af_NumSerie, vwAf_Activo_fijo.Af_fecha_compra, vwAf_Activo_fijo.Af_fecha_ini_depre, vwAf_Activo_fijo.Af_fecha_fin_depre, 
                         vwAf_Activo_fijo.Af_Costo_historico, vwAf_Activo_fijo.Af_costo_compra, vwAf_Activo_fijo.Af_Vida_Util, vwAf_Activo_fijo.Af_Meses_depreciar, 
                         vwAf_Activo_fijo.Af_porcentaje_deprec, vwAf_Activo_fijo.Af_NumSerie_Motor, vwAf_Activo_fijo.Af_NumSerie_Chasis, Af_Mej_Baj_Activo.Fecha_Transac AS Fecha, 
                         Af_Mej_Baj_Activo.Valor_Mej_Baj_Activo Valor
/*, Af_Mej_Baj_Activo.Id_Mejora_Baja_Activo, Af_Mej_Baj_Activo.Cod_Mej_Baj_Activo, 
                         Af_Mej_Baj_Activo.ValorActivo, , Af_Mej_Baj_Activo.Compr_Mej_Baj, Af_Mej_Baj_Activo.DescripcionTecnica
						 */ 
						 ,vwAf_Activo_fijo.IdSucursal,vwAf_Activo_fijo.nom_Sucursal
						 FROM
                          vwAf_Activo_fijo INNER JOIN
                         Af_Mej_Baj_Activo ON vwAf_Activo_fijo.IdEmpresa = Af_Mej_Baj_Activo.IdEmpresa AND vwAf_Activo_fijo.IdActivoFijo = Af_Mej_Baj_Activo.IdActivoFijo

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[4] 2[55] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt013';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwACTF_Rpt013';

