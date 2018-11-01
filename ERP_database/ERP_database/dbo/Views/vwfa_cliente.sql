CREATE view [dbo].[vwfa_cliente]
as
SELECT        dbo.tb_persona.pe_nombreCompleto, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, NULL AS pe_telefonoOfic, NULL 
                         AS pe_fax, dbo.tb_persona.pe_sexo, dbo.tb_persona.pe_Naturaleza, dbo.fa_cliente.IdEmpresa, dbo.fa_cliente.IdCliente, dbo.fa_cliente.IdPersona, 0 AS IdSucursal, 1 AS IdVendedor, dbo.fa_cliente.Idtipo_cliente, 
                         dbo.fa_cliente.IdTipoCredito, dbo.fa_cliente.cl_plazo, dbo.fa_cliente.IdCtaCble_cxc, '' AS cl_observacion, '' IdCiudad, dbo.fa_cliente.cl_Cupo, 0 AS IdClienteRelacionado, dbo.fa_cliente.Estado, 
                         dbo.tb_persona.pe_fechaNacimiento, '' Descripcion_Ciudad, '' AS Su_Descripcion, dbo.fa_cliente.IdCtaCble_Anti, dbo.tb_persona.pe_correo, NULL AS pe_casilla, dbo.tb_persona.IdEstadoCivil, 
                         dbo.tb_persona.pe_estado, dbo.tb_persona.CodPersona, dbo.tb_persona.IdTipoDocumento, '' AS Mail_Principal, '' IdProvincia, '' IdPais, dbo.fa_cliente.IdCtaCble_cxc_Credito, 
                         0 AS IdTipoPersona, NULL AS pe_telefonoCasa, dbo.tb_persona.pe_telfono_Contacto, dbo.tb_persona.pe_celular, NULL AS pe_telefonoInter, NULL AS pe_correo_secundario1, NULL AS pe_correo_secundario2, NULL 
                         AS pe_celularSecundario, dbo.fa_cliente.Codigo, '' IdParroquia, dbo.fa_cliente.es_empresa_relacionada, dbo.fa_cliente.NivelPrecio, dbo.fa_cliente.FormaPago, '' Direccion, '' Telefono, '' Celular
FROM            dbo.fa_cliente INNER JOIN
                         dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona