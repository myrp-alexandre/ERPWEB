CREATE VIEW dbo.vwFAC_Rpt001
AS
SELECT        fa_factura.IdEmpresa, fa_factura.IdSucursal, fa_factura.IdBodega, fa_factura.vt_tipoDoc AS IdTipoDocumento, CASE WHEN dbo.fa_factura.vt_NumFactura IS NULL 
                         THEN dbo.fa_factura.vt_tipoDoc + '#' + CAST(dbo.fa_factura.IdCbteVta AS varchar(20)) ELSE dbo.fa_factura.vt_tipoDoc + '-' + isnull(dbo.fa_factura.vt_serie1, '') + '-' + isnull(dbo.fa_factura.vt_serie2, '') 
                         + '-' + isnull(dbo.fa_factura.vt_NumFactura, '') + '/' + CAST(dbo.fa_factura.IdCbteVta AS varchar(20)) END AS numDocumento, fa_factura.IdCliente, tb_persona.pe_nombreCompleto AS nombreCliente, fa_factura.vt_fecha, 
                         tb_Calendario.IdCalendario, tb_Calendario.AnioFiscal, tb_Calendario.NombreMes, tb_Calendario.NombreCortoFecha, in_Producto.IdProducto, in_Producto.pr_descripcion AS nombreProducto, fa_factura_det.vt_cantidad, 
                         fa_factura_det.vt_PrecioFinal, fa_factura_det.vt_Subtotal, fa_factura_det.vt_iva, fa_factura_det.vt_total, tb_sucursal.Su_Descripcion, vwin_Cate_Lin_Grup_SubGrup.IdCategoria, vwin_Cate_Lin_Grup_SubGrup.IdLinea, 
                         vwin_Cate_Lin_Grup_SubGrup.IdGrupo, vwin_Cate_Lin_Grup_SubGrup.IdSubgrupo, vwin_Cate_Lin_Grup_SubGrup.ca_Categoria, vwin_Cate_Lin_Grup_SubGrup.nom_linea, vwin_Cate_Lin_Grup_SubGrup.nom_grupo, 
                         vwin_Cate_Lin_Grup_SubGrup.nom_subgrupo, fa_cliente_tipo.Idtipo_cliente, fa_cliente_tipo.Descripcion_tip_cliente, fa_factura.vt_Observacion, fa_Vendedor.IdVendedor, fa_Vendedor.Ve_Vendedor AS Vendedor
FROM            fa_factura INNER JOIN
                         tb_bodega ON fa_factura.IdEmpresa = tb_bodega.IdEmpresa AND fa_factura.IdSucursal = tb_bodega.IdSucursal AND fa_factura.IdBodega = tb_bodega.IdBodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         fa_cliente ON fa_factura.IdEmpresa = fa_cliente.IdEmpresa AND fa_factura.IdCliente = fa_cliente.IdCliente AND tb_sucursal.IdEmpresa = fa_cliente.IdEmpresa INNER JOIN
                         fa_cliente_tipo ON fa_cliente_tipo.IdEmpresa = fa_cliente.IdEmpresa AND fa_cliente_tipo.Idtipo_cliente = fa_cliente.Idtipo_cliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         tb_Calendario ON fa_factura.vt_fecha = tb_Calendario.fecha INNER JOIN
                         fa_factura_det ON fa_factura.IdEmpresa = fa_factura_det.IdEmpresa AND fa_factura.IdSucursal = fa_factura_det.IdSucursal AND fa_factura.IdBodega = fa_factura_det.IdBodega AND 
                         fa_factura.IdCbteVta = fa_factura_det.IdCbteVta INNER JOIN
                         in_Producto ON fa_factura_det.IdEmpresa = in_Producto.IdEmpresa AND fa_factura_det.IdProducto = in_Producto.IdProducto INNER JOIN
                         fa_Vendedor ON fa_factura.IdEmpresa = fa_Vendedor.IdEmpresa AND fa_factura.IdVendedor = fa_Vendedor.IdVendedor AND fa_factura.IdEmpresa = fa_Vendedor.IdEmpresa AND 
                         fa_factura.IdVendedor = fa_Vendedor.IdVendedor LEFT OUTER JOIN
                         vwin_Cate_Lin_Grup_SubGrup ON vwin_Cate_Lin_Grup_SubGrup.IdEmpresa = in_Producto.IdEmpresa AND vwin_Cate_Lin_Grup_SubGrup.IdCategoria = in_Producto.IdCategoria AND 
                         vwin_Cate_Lin_Grup_SubGrup.IdSubgrupo = in_Producto.IdSubGrupo
						  where fa_factura.Estado='A'
UNION
SELECT        fa_notaCreDeb.IdEmpresa, fa_notaCreDeb.IdSucursal, fa_notaCreDeb.IdBodega, (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN 'NTCR' ELSE 'NTDB' END) AS IdTipoDocumento, 
                         CASE WHEN dbo.fa_notaCreDeb.NumNota_Impresa IS NULL THEN SUBSTRING(dbo.fa_TipoNota.CodTipoNota, 1, 2) + '#' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) ELSE SUBSTRING(dbo.fa_TipoNota.CodTipoNota, 1, 2) 
                         + '-' + isnull(dbo.fa_notaCreDeb.Serie1, '') + '-' + isnull(dbo.fa_notaCreDeb.Serie2, '') + '-' + isnull(dbo.fa_notaCreDeb.NumNota_Impresa, '') + '/' + CAST(dbo.fa_notaCreDeb.IdNota AS varchar(20)) END AS numDocumento, 
                         fa_notaCreDeb.IdCliente, tb_persona.pe_nombreCompleto AS nombreCliente, fa_notaCreDeb.no_fecha, tb_Calendario.IdCalendario, tb_Calendario.AnioFiscal, tb_Calendario.NombreMes, tb_Calendario.NombreCortoFecha, 
                         in_Producto.IdProducto, in_Producto.pr_descripcion AS nombreProducto, (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN (dbo.fa_notaCreDeb_det.sc_cantidad * - 1) ELSE dbo.fa_notaCreDeb_det.sc_cantidad END) AS vt_cantidad, 
                         (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN (dbo.fa_notaCreDeb_det.sc_precioFinal * - 1) ELSE dbo.fa_notaCreDeb_det.sc_precioFinal END) AS vt_PrecioFinal, 
                         (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN (dbo.fa_notaCreDeb_det.sc_subtotal * - 1) ELSE dbo.fa_notaCreDeb_det.sc_subtotal END) AS vt_Subtotal, 
                         (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN (dbo.fa_notaCreDeb_det.sc_iva * - 1) ELSE dbo.fa_notaCreDeb_det.sc_iva END) AS vt_iva, (CASE dbo.fa_TipoNota.Tipo WHEN 'C' THEN (dbo.fa_notaCreDeb_det.sc_total * - 1) 
                         ELSE dbo.fa_notaCreDeb_det.sc_total END) AS vt_total, tb_sucursal.Su_Descripcion, vwin_Cate_Lin_Grup_SubGrup.IdCategoria, vwin_Cate_Lin_Grup_SubGrup.IdLinea, vwin_Cate_Lin_Grup_SubGrup.IdGrupo, 
                         vwin_Cate_Lin_Grup_SubGrup.IdSubgrupo, vwin_Cate_Lin_Grup_SubGrup.ca_Categoria, vwin_Cate_Lin_Grup_SubGrup.nom_linea, vwin_Cate_Lin_Grup_SubGrup.nom_grupo, vwin_Cate_Lin_Grup_SubGrup.nom_subgrupo, 
                         fa_cliente_tipo.Idtipo_cliente, fa_cliente_tipo.Descripcion_tip_cliente, fa_notaCreDeb.sc_observacion, 0 IdVendedor, '' AS Vendedor
						
FROM            fa_notaCreDeb INNER JOIN
                         tb_bodega ON fa_notaCreDeb.IdEmpresa = tb_bodega.IdEmpresa AND fa_notaCreDeb.IdSucursal = tb_bodega.IdSucursal AND fa_notaCreDeb.IdBodega = tb_bodega.IdBodega INNER JOIN
                         tb_sucursal ON tb_bodega.IdEmpresa = tb_sucursal.IdEmpresa AND tb_bodega.IdSucursal = tb_sucursal.IdSucursal INNER JOIN
                         fa_cliente ON fa_notaCreDeb.IdEmpresa = fa_cliente.IdEmpresa AND fa_notaCreDeb.IdCliente = fa_cliente.IdCliente AND tb_sucursal.IdEmpresa = fa_cliente.IdEmpresa INNER JOIN
                         fa_cliente_tipo ON fa_cliente_tipo.IdEmpresa = fa_cliente.IdEmpresa AND fa_cliente_tipo.Idtipo_cliente = fa_cliente.Idtipo_cliente INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona INNER JOIN
                         tb_Calendario ON fa_notaCreDeb.no_fecha = tb_Calendario.fecha INNER JOIN
                         fa_notaCreDeb_det ON fa_notaCreDeb.IdEmpresa = fa_notaCreDeb_det.IdEmpresa AND fa_notaCreDeb.IdSucursal = fa_notaCreDeb_det.IdSucursal AND fa_notaCreDeb.IdBodega = fa_notaCreDeb_det.IdBodega AND 
                         fa_notaCreDeb.IdNota = fa_notaCreDeb_det.IdNota INNER JOIN
                         in_Producto ON fa_notaCreDeb_det.IdEmpresa = in_Producto.IdEmpresa AND fa_notaCreDeb_det.IdProducto = in_Producto.IdProducto INNER JOIN
                         fa_TipoNota ON fa_notaCreDeb.IdTipoNota = fa_TipoNota.IdTipoNota LEFT OUTER JOIN
                         vwin_Cate_Lin_Grup_SubGrup ON vwin_Cate_Lin_Grup_SubGrup.IdEmpresa = in_Producto.IdEmpresa AND vwin_Cate_Lin_Grup_SubGrup.IdCategoria = in_Producto.IdCategoria AND 
                         vwin_Cate_Lin_Grup_SubGrup.IdSubgrupo = in_Producto.IdSubGrupo
						 where fa_notaCreDeb.Estado='A'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[9] 4[9] 2[66] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt001';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFAC_Rpt001';

