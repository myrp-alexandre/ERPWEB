
CREATE VIEW [dbo].[vwcp_ProveedorRuc]
AS
SELECT        dbo.cp_proveedor.IdEmpresa, dbo.cp_proveedor.IdProveedor, tb_persona.pe_nombreCompleto pr_nombre, dbo.cp_proveedor.pr_codigo, '' pr_girar_cheque_a, 
                         '' IdTipoServicio, dbo.cp_proveedor.IdCtaCble_CXP, '' IdTipoGasto, dbo.cp_proveedor.pr_contribuyenteEspecial, 
                         dbo.cp_proveedor.pr_plazo, dbo.cp_proveedor.pr_estado, dbo.cp_proveedor.IdCiudad, '' pr_nacionalidad, dbo.cp_proveedor.idCredito_Predeter, 
                         dbo.cp_proveedor.codigoSRI_ICE_Predeter, dbo.cp_proveedor.codigoSRI_101_Predeter, dbo.cp_proveedor.IdUsuario, dbo.cp_proveedor.Fecha_Transac, 
                         dbo.cp_proveedor.Fecha_UltMod, dbo.cp_proveedor.IdUsuarioUltMod, dbo.cp_proveedor.IdUsuarioUltAnu, dbo.cp_proveedor.Fecha_UltAnu, 
                          
                         dbo.cp_proveedor.IdCentroCosot, dbo.cp_proveedor.IdCtaCble_Anticipo, dbo.cp_proveedor.IdCtaCble_Gasto, dbo.cp_proveedor.IdClaseProveedor, 
                         dbo.cp_proveedor.representante_legal, dbo.vwtb_Ciudad.Descripcion_Ciudad, dbo.vwtb_Ciudad.IdPais, dbo.vwtb_Ciudad.IdProvincia, dbo.tb_persona.CodPersona, 
                         dbo.tb_persona.pe_Naturaleza, dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, 
                         0 IdTipoPersona, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, null pe_telefonoCasa, 
                         null pe_telefonoOfic, null pe_telefonoInter, dbo.tb_persona.pe_telfono_Contacto, dbo.tb_persona.pe_celular, dbo.tb_persona.pe_correo, 
                         null pe_fax, null pe_casilla, dbo.tb_persona.pe_sexo, dbo.tb_persona.IdEstadoCivil, dbo.tb_persona.pe_fechaNacimiento, 
                         dbo.tb_persona.pe_estado, null pe_celularSecundario, null pe_correo_secundario1, null pe_correo_secundario2, 
                         dbo.cp_proveedor.IdTipoCta_acreditacion_cat, dbo.cp_proveedor.num_cta_acreditacion, dbo.tb_banco.CodigoLegal, dbo.tb_banco.ba_descripcion, 
                         dbo.cp_proveedor.IdBanco_acreditacion, dbo.cp_proveedor.IdPersona, dbo.cp_proveedor.IdPunto_cargo, dbo.cp_proveedor.IdPunto_cargo_grupo
						 ,dbo.cp_proveedor.es_empresa_relacionada
FROM            dbo.cp_proveedor INNER JOIN
                         dbo.tb_persona ON dbo.cp_proveedor.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         dbo.tb_banco ON dbo.cp_proveedor.IdBanco_acreditacion = dbo.tb_banco.IdBanco LEFT OUTER JOIN
                         dbo.vwtb_Ciudad ON dbo.cp_proveedor.IdCiudad = dbo.vwtb_Ciudad.IdCiudad inner join tb_persona
						 as per on cp_proveedor.IdPersona = per.IdPersona
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[69] 4[4] 2[19] 3) )"
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
         Begin Table = "cp_proveedor"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 303
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 25
         End
         Begin Table = "tb_persona"
            Begin Extent = 
               Top = 2
               Left = 936
               Bottom = 337
               Right = 1146
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_banco"
            Begin Extent = 
               Top = 222
               Left = 383
               Bottom = 430
               Right = 617
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwtb_Ciudad"
            Begin Extent = 
               Top = 85
               Left = 415
               Bottom = 214
               Right = 624
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
      Begin ColumnWidths = 67
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
         W', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_ProveedorRuc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'idth = 1500
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 2520
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_ProveedorRuc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vwcp_ProveedorRuc';

