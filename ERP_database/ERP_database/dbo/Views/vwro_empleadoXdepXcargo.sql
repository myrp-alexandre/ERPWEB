CREATE VIEW [dbo].[vwro_empleadoXdepXcargo]
AS
SELECT        dbo.ro_cargo.ca_descripcion AS cargo, dbo.ro_Departamento.de_descripcion AS departamento, dbo.ro_empleado.IdEmpresa, dbo.ro_empleado.IdEmpleado, dbo.ro_empleado.IdEmpleado_Supervisor, 
                         dbo.ro_empleado.IdPersona, dbo.ro_empleado.IdTipoEmpleado, dbo.ro_empleado.em_codigo, dbo.ro_empleado.em_lugarNacimiento, dbo.ro_empleado.em_CarnetIees, dbo.ro_empleado.em_cedulaMil, 
                         dbo.ro_empleado.em_fecha_ingreso, dbo.ro_empleado.em_fechaSalida, dbo.ro_empleado.em_fechaTerminoContra, dbo.ro_empleado.em_fechaIngaRol, dbo.ro_empleado.em_SeAcreditaBanco, dbo.ro_empleado.em_tipoCta, 
                         dbo.ro_empleado.em_NumCta, dbo.ro_empleado.em_SepagaBeneficios, dbo.ro_empleado.em_SePagaConTablaSec, dbo.ro_empleado.em_estado, dbo.ro_empleado.em_sueldoBasicoMen, 
                         dbo.ro_empleado.em_SueldoExtraMen, dbo.ro_empleado.em_MovilizacionQuincenal, dbo.ro_empleado.em_foto, dbo.ro_empleado.em_empEspecial, dbo.ro_empleado.em_pagoFdoRsv, dbo.ro_empleado.em_huella, 
                         dbo.ro_empleado.IdCodSectorial, dbo.ro_empleado.IdDepartamento, dbo.ro_empleado.IdTipoSangre, dbo.ro_empleado.IdCargo, dbo.ro_empleado.IdCtaCble_Emplea, dbo.ro_empleado.IdCiudad AS IdUbicacion, 
                         dbo.ro_empleado.em_mail, dbo.tb_persona.CodPersona, dbo.tb_persona.pe_Naturaleza, dbo.tb_persona.pe_nombreCompleto AS NomCompleto, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_apellido AS Apellido, 
                         dbo.tb_persona.pe_nombre AS Nombre, 0 IdTipoPersona, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, dbo.tb_persona.pe_direccion,  null pe_telefonoCasa, 
                         null pe_telefonoOfic, null pe_telefonoInter, dbo.tb_persona.pe_telfono_Contacto, dbo.tb_persona.pe_celular, dbo.tb_persona.pe_correo, null pe_fax, null pe_casilla, 
                         dbo.tb_persona.pe_sexo, dbo.tb_persona.IdEstadoCivil, dbo.tb_persona.pe_fechaNacimiento, dbo.tb_persona.pe_estado, dbo.tb_persona.pe_fechaCreacion, dbo.tb_persona.pe_fechaModificacion, 
                         dbo.tb_sucursal.Su_Descripcion AS Sucursal, dbo.ro_empleado.IdSucursal, dbo.tb_sucursal.IdEmpresa AS Expr1, dbo.ro_empleado.IdTipoLicencia, dbo.ro_empleado.IdCentroCosto, dbo.ro_empleado.IdBanco, 
                         dbo.ro_empleado.Archivo, dbo.ro_empleado.NombreArchivo, dbo.ro_empleado.Codigo_Biometrico, dbo.ro_empleado.IdArea, dbo.ro_empleado.IdDivision, dbo.ro_empleado.IdCentroCosto_sub_centro_costo, 
                         dbo.ro_empleado.por_discapacidad, dbo.ro_empleado.carnet_conadis, dbo.ro_empleado.recibi_uniforme, dbo.ro_empleado.talla_pant, dbo.ro_empleado.talla_camisa, dbo.ro_empleado.talla_zapato, 
                         dbo.ro_empleado.em_status, dbo.ro_empleado.IdCondicionDiscapacidadSRI, dbo.ro_empleado.IdTipoIdentDiscapacitadoSustitutoSRI, dbo.ro_empleado.IdentDiscapacitadoSustitutoSRI, 
                         dbo.ro_empleado.IdAplicaConvenioDobleImposicionSRI, dbo.ro_empleado.IdTipoResidenciaSRI, dbo.ro_empleado.IdTipoSistemaSalarioNetoSRI, dbo.ro_empleado.es_AcreditaHorasExtras, dbo.ro_empleado.IdTipoAnticipo, 
                         dbo.ro_empleado.em_AnticipoSueldo, dbo.ro_empleado.CodigoSectorial AS CodigoSectorialIESS, dbo.ro_empleado.es_TruncarDecimalAnticipo, dbo.tb_pais.IdPais, dbo.tb_provincia.IdProvincia, dbo.tb_ciudad.IdCiudad, 
                         dbo.ro_empleado.MotivoAnulacion, dbo.ro_empleado.IdGrupo, dbo.ro_empleado.Marca_Biometrico, dbo.tb_provincia.Cod_Region,dbo.ro_cargo.considera_pago_utilidad, dbo.ro_Nomina_Tipo.IdNomina_Tipo
FROM            dbo.tb_persona INNER JOIN
                         dbo.ro_empleado ON dbo.tb_persona.IdPersona = dbo.ro_empleado.IdPersona INNER JOIN
                         dbo.tb_ciudad ON dbo.ro_empleado.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                         dbo.tb_provincia ON dbo.tb_ciudad.IdProvincia = dbo.tb_provincia.IdProvincia INNER JOIN
                         dbo.tb_pais ON dbo.tb_provincia.IdPais = dbo.tb_pais.IdPais INNER JOIN
                         dbo.ro_empleado_x_ro_tipoNomina ON dbo.ro_empleado.IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND dbo.ro_empleado_x_ro_tipoNomina.IdTipoNomina = dbo.ro_Nomina_Tipo.IdNomina_Tipo LEFT OUTER JOIN
                         dbo.tb_sucursal ON dbo.ro_empleado.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.ro_empleado.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento LEFT OUTER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo