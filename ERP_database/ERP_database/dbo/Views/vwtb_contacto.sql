

CREATE VIEW [dbo].[vwtb_contacto]
AS
SELECT        con.IdEmpresa, con.IdContacto, con.CodContacto, con.Cargo, con.Mostrar_como, con.Notas, con.Organizacion, con.Pagina_Web, con.Codigo_postal, con.Estado, 
                         dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion, 
                         null pe_telefonoCasa, dbo.tb_persona.pe_celular, dbo.tb_persona.pe_correo, dbo.tb_persona.pe_sexo, dbo.tb_persona.pe_fechaNacimiento, 
                         con.IdPersona, con.Fecha_alta, con.Fecha_Ult_Contacto, tb_pais_1.IdPais, tb_pais_1.Nombre, dbo.tb_provincia.IdProvincia, dbo.tb_provincia.Descripcion_Prov, 
                         dbo.tb_ciudad.IdCiudad, dbo.tb_ciudad.Descripcion_Ciudad, con.IdNacionalidad, dbo.tb_pais.Nacionalidad, dbo.tb_persona.pe_razonSocial, 
                         dbo.tb_persona.pe_Naturaleza
FROM            dbo.tb_contacto AS con INNER JOIN
                         dbo.tb_persona ON con.IdPersona = dbo.tb_persona.IdPersona LEFT OUTER JOIN
                         dbo.tb_ciudad ON con.IdCiudad = dbo.tb_ciudad.IdCiudad LEFT OUTER JOIN
                         dbo.tb_provincia ON con.IdProvincia = dbo.tb_provincia.IdProvincia LEFT OUTER JOIN
                         dbo.tb_pais AS tb_pais_1 ON con.IdPais = tb_pais_1.IdPais LEFT OUTER JOIN
                         dbo.tb_pais ON con.IdNacionalidad = dbo.tb_pais.IdPais