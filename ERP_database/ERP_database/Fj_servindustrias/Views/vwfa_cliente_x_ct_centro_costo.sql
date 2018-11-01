CREATE view [Fj_servindustrias].vwfa_cliente_x_ct_centro_costo
as
SELECT        dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, null pe_telefonoOfic, null pe_telefonoCasa, 
                         dbo.tb_persona.pe_correo, dbo.tb_persona.pe_Naturaleza, dbo.tb_persona.pe_estado, dbo.tb_persona.IdTipoDocumento, 
                         fa_cliente_x_ct_centro_costo_1.IdCliente_cli, fa_cliente_x_ct_centro_costo_1.IdCentroCosto_cc, fa_cliente_x_ct_centro_costo_1.IdEmpresa_cc, 
                         fa_cliente_x_ct_centro_costo_1.IdEmpresa_cli,  dbo.fa_cliente.Estado, dbo.ct_centro_costo.Centro_costo AS nom_Centro_costo, dbo.tb_persona.pe_nombreCompleto AS nom_Cliente, 
                         dbo.tb_persona.pe_celular, dbo.tb_persona.num_cta_acreditacion, dbo.ct_centro_costo.pc_Estado, dbo.ct_centro_costo.CodCentroCosto, 
                         dbo.ct_centro_costo.IdCentroCostoPadre
FROM            dbo.fa_cliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo AS fa_cliente_x_ct_centro_costo_1 ON 
                         dbo.fa_cliente.IdEmpresa = fa_cliente_x_ct_centro_costo_1.IdEmpresa_cli AND dbo.fa_cliente.IdCliente = fa_cliente_x_ct_centro_costo_1.IdCliente_cli INNER JOIN
                         dbo.ct_centro_costo ON fa_cliente_x_ct_centro_costo_1.IdEmpresa_cc = dbo.ct_centro_costo.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_1.IdCentroCosto_cc = dbo.ct_centro_costo.IdCentroCosto