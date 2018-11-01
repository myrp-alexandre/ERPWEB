CREATE VIEW [dbo].[vwFa_Documento_DeclaracionSRI]
AS
SELECT A.IdEmpresa, A.IdTipoDocumento, A.pe_cedulaRuc, A.vt_tipoDoc, A.SubTotal_0 AS baseNoGraIva, A.Subtotal_Iva AS baseImpGrav, A.vt_Subtotal AS baseImponible, A.vt_iva AS montoIva, A.IdCbteVta, A.IdCliente, A.vt_serie1, A.vt_fecha, 
                  'FA-' + A.vt_serie1 + '-' + A.vt_serie2 + '-' + CAST(A.vt_NumFactura AS varchar(20)) + '/' + CAST(A.IdCbteVta AS varchar(20)) AS vt_NumDocumento, per.pe_nombreCompleto AS Razon_Social
FROM     vwfa_factura AS A
inner join fa_cliente as cli on a.IdEmpresa = cli.IdEmpresa
and a.IdCliente = cli.IdCliente
inner join tb_persona as per on cli.IdPersona = per.IdPersona
UNION ALL
SELECT A.IdEmpresa, A.IdTipoDocumento, A.pe_cedulaRuc, A.CreDeb, vt_Subtotal0 AS baseNoGraIva, vt_subtotalIva AS baseImpGrav, A.sc_Subtotal AS baseImponible, A.sc_iva AS montoIva, A.IdNota, A.IdCliente, A.Serie1, A.no_fecha, 
                  A.CreDeb + '-' + cast(A.IdNota AS varchar(50)), isnull(A.pe_apellido, '') + ' ' + isnull(A.pe_nombre, '') AS Razon_Social
FROM     vwfa_Nota_Credito AS A
WHERE  A.Estado = 'A' AND LTRIM(RTRIM(A.NaturalezaNota)) = 'SRI'



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[8] 4[5] 2[70] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_Documento_DeclaracionSRI';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwFa_Documento_DeclaracionSRI';

