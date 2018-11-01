CREATE VIEW dbo.vwRo_Empleado_X_Nomina
AS
SELECT        dbo.vwro_empleadoXdepXcargo.cargo, dbo.vwro_empleadoXdepXcargo.departamento, dbo.vwro_empleadoXdepXcargo.IdEmpresa, 
                         dbo.vwro_empleadoXdepXcargo.IdEmpleado, dbo.vwro_empleadoXdepXcargo.IdEmpleado_Supervisor, dbo.vwro_empleadoXdepXcargo.IdPersona, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoEmpleado, dbo.vwro_empleadoXdepXcargo.em_codigo, dbo.vwro_empleadoXdepXcargo.em_lugarNacimiento, 
                         dbo.vwro_empleadoXdepXcargo.em_CarnetIees, dbo.vwro_empleadoXdepXcargo.em_cedulaMil, dbo.vwro_empleadoXdepXcargo.em_fecha_ingreso, 
                         dbo.vwro_empleadoXdepXcargo.em_fechaSalida, dbo.vwro_empleadoXdepXcargo.em_fechaTerminoContra, dbo.vwro_empleadoXdepXcargo.em_fechaIngaRol, 
                         dbo.vwro_empleadoXdepXcargo.em_SeAcreditaBanco, dbo.vwro_empleadoXdepXcargo.em_tipoCta, dbo.vwro_empleadoXdepXcargo.em_NumCta, 
                         dbo.vwro_empleadoXdepXcargo.em_SepagaBeneficios, dbo.vwro_empleadoXdepXcargo.em_SePagaConTablaSec, dbo.vwro_empleadoXdepXcargo.em_estado, 
                         dbo.vwro_empleadoXdepXcargo.em_sueldoBasicoMen, dbo.vwro_empleadoXdepXcargo.em_SueldoExtraMen, 
                         dbo.vwro_empleadoXdepXcargo.em_MovilizacionQuincenal, dbo.vwro_empleadoXdepXcargo.em_foto, dbo.vwro_empleadoXdepXcargo.em_empEspecial, 
                         dbo.vwro_empleadoXdepXcargo.em_pagoFdoRsv, dbo.vwro_empleadoXdepXcargo.em_huella, dbo.vwro_empleadoXdepXcargo.IdDepartamento, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoSangre, dbo.vwro_empleadoXdepXcargo.IdCargo, dbo.vwro_empleadoXdepXcargo.IdCodSectorial, 
                         dbo.vwro_empleadoXdepXcargo.IdCtaCble_Emplea, dbo.vwro_empleadoXdepXcargo.IdUbicacion, dbo.vwro_empleadoXdepXcargo.em_mail, 
                         dbo.vwro_empleadoXdepXcargo.CodPersona, dbo.vwro_empleadoXdepXcargo.pe_Naturaleza, dbo.vwro_empleadoXdepXcargo.NomCompleto, 
                         dbo.vwro_empleadoXdepXcargo.Apellido, dbo.vwro_empleadoXdepXcargo.pe_razonSocial, dbo.vwro_empleadoXdepXcargo.Nombre, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoPersona, dbo.vwro_empleadoXdepXcargo.IdTipoDocumento, dbo.vwro_empleadoXdepXcargo.pe_cedulaRuc, 
                         dbo.vwro_empleadoXdepXcargo.pe_direccion, dbo.vwro_empleadoXdepXcargo.pe_telefonoCasa, dbo.vwro_empleadoXdepXcargo.pe_telefonoOfic, 
                         dbo.vwro_empleadoXdepXcargo.pe_telefonoInter, dbo.vwro_empleadoXdepXcargo.pe_telfono_Contacto, dbo.vwro_empleadoXdepXcargo.pe_celular, 
                         dbo.vwro_empleadoXdepXcargo.pe_correo, dbo.vwro_empleadoXdepXcargo.pe_fax, dbo.vwro_empleadoXdepXcargo.pe_casilla, 
                         dbo.vwro_empleadoXdepXcargo.pe_sexo, dbo.vwro_empleadoXdepXcargo.IdEstadoCivil, dbo.vwro_empleadoXdepXcargo.pe_fechaNacimiento, 
                         dbo.vwro_empleadoXdepXcargo.pe_estado, dbo.vwro_empleadoXdepXcargo.pe_fechaCreacion, dbo.vwro_empleadoXdepXcargo.pe_fechaModificacion, 
                         dbo.vwro_empleadoXdepXcargo.Sucursal, dbo.vwro_empleadoXdepXcargo.IdSucursal, dbo.vwro_empleadoXdepXcargo.Expr1, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoLicencia, dbo.vwro_empleadoXdepXcargo.IdCentroCosto, dbo.vwro_empleadoXdepXcargo.IdBanco, 
                         dbo.vwro_empleadoXdepXcargo.Archivo, dbo.vwro_empleadoXdepXcargo.NombreArchivo, dbo.vwro_empleadoXdepXcargo.Codigo_Biometrico, 
                         dbo.vwro_empleadoXdepXcargo.IdArea, dbo.vwro_empleadoXdepXcargo.IdDivision, dbo.vwro_empleadoXdepXcargo.IdCentroCosto_sub_centro_costo, 
                         dbo.vwro_empleadoXdepXcargo.por_discapacidad, dbo.vwro_empleadoXdepXcargo.carnet_conadis, dbo.vwro_empleadoXdepXcargo.recibi_uniforme, 
                         dbo.vwro_empleadoXdepXcargo.talla_pant, dbo.vwro_empleadoXdepXcargo.talla_camisa, dbo.vwro_empleadoXdepXcargo.talla_zapato, 
                         dbo.vwro_empleadoXdepXcargo.em_status, dbo.vwro_empleadoXdepXcargo.IdCondicionDiscapacidadSRI, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoIdentDiscapacitadoSustitutoSRI, dbo.vwro_empleadoXdepXcargo.IdentDiscapacitadoSustitutoSRI, 
                         dbo.vwro_empleadoXdepXcargo.IdAplicaConvenioDobleImposicionSRI, dbo.vwro_empleadoXdepXcargo.IdTipoResidenciaSRI, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoSistemaSalarioNetoSRI, dbo.vwro_empleadoXdepXcargo.es_AcreditaHorasExtras, 
                         dbo.vwro_empleadoXdepXcargo.IdTipoAnticipo, dbo.vwro_empleadoXdepXcargo.em_AnticipoSueldo, dbo.vwro_empleadoXdepXcargo.CodigoSectorialIESS, 
                         dbo.vwro_empleadoXdepXcargo.es_TruncarDecimalAnticipo, dbo.ro_empleado_x_ro_tipoNomina.IdTipoNomina, dbo.ro_Nomina_Tipo.Descripcion AS Nomina, 
                         dbo.vwro_empleadoXdepXcargo.IdGrupo, dbo.vwro_empleadoXdepXcargo.Marca_Biometrico, dbo.vwro_empleadoXdepXcargo.Cod_Region
FROM            dbo.vwro_empleadoXdepXcargo INNER JOIN
                         dbo.ro_empleado_x_ro_tipoNomina ON dbo.vwro_empleadoXdepXcargo.IdEmpresa = dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa AND 
                         dbo.vwro_empleadoXdepXcargo.IdEmpleado = dbo.ro_empleado_x_ro_tipoNomina.IdEmpleado INNER JOIN
                         dbo.ro_Nomina_Tipo ON dbo.ro_empleado_x_ro_tipoNomina.IdEmpresa = dbo.ro_Nomina_Tipo.IdEmpresa AND 
                         dbo.ro_empleado_x_ro_tipoNomina.IdTipoNomina = dbo.ro_Nomina_Tipo.IdNomina_Tipo