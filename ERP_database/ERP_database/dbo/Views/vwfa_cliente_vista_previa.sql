

CREATE VIEW [dbo].[vwfa_cliente_vista_previa]
AS
SELECT        dbo.fa_cliente.IdEmpresa, dbo.fa_cliente.IdCliente, dbo.fa_cliente.Codigo, dbo.fa_cliente.IdPersona, 1 IdSucursal, '' AS nom_sucursal, dbo.fa_cliente.IdTipoCredito, 
                          dbo.fa_cliente.cl_plazo, dbo.fa_cliente.IdCtaCble_cxc, dbo.ct_plancta.pc_Cuenta AS nom_CtaCble_cxc, dbo.fa_cliente.IdCtaCble_Anti, 
                         ct_plancta_1.pc_Cuenta AS nom_CtaCble_Anti,   '' cl_observacion, con.IdCiudad, 
                         dbo.vwtb_Ciudad.Descripcion_Ciudad, dbo.fa_cliente.cl_Cupo,  dbo.fa_cliente.Estado, con.Correo Mail_Principal, 
                          dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_apellido, 
                         dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, dbo.tb_persona.pe_celular, dbo.tb_persona.pe_correo, null pe_fax, null pe_casilla, 
                         dbo.vwtb_Ciudad.IdProvincia, dbo.vwtb_Ciudad.IdPais, dbo.fa_cliente.IdCtaCble_cxc_Credito, dbo.fa_cliente.es_empresa_relacionada
FROM            dbo.fa_cliente INNER JOIN
fa_cliente_contactos con on fa_cliente.IdEmpresa = con.IdEmpresa and con.IdCliente = fa_cliente.IdCliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         dbo.ct_plancta ON dbo.fa_cliente.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.fa_cliente.IdEmpresa = dbo.ct_plancta.IdEmpresa AND dbo.fa_cliente.IdCtaCble_cxc = dbo.ct_plancta.IdCtaCble LEFT OUTER JOIN
                         dbo.ct_plancta AS ct_plancta_1 ON dbo.fa_cliente.IdEmpresa = ct_plancta_1.IdEmpresa AND dbo.fa_cliente.IdEmpresa = ct_plancta_1.IdEmpresa AND dbo.fa_cliente.IdCtaCble_Anti = ct_plancta_1.IdCtaCble LEFT OUTER JOIN
                         dbo.vwtb_Ciudad ON con.IdCiudad = dbo.vwtb_Ciudad.IdCiudad