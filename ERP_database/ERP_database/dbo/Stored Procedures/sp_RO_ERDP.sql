
CREATE PROCEDURE  [dbo].[sp_RO_ERDP] 
        
        @Idempresa int,
        @Anio varchar(4)
AS

BEGIN
/*
declare 
 @Idempresa int,
 @Anio varchar(4)
		set @Idempresa=1
		set @Anio=2017
	*/	

 SELECT        dbo.ro_cargo.ca_descripcion AS cargo, dbo.ro_Departamento.de_descripcion AS departamento, dbo.ro_empleado.IdEmpresa, dbo.ro_empleado.IdEmpleado, 
                         dbo.ro_empleado.IdPersona, dbo.ro_empleado.IdTipoEmpleado, dbo.ro_empleado.em_codigo, 
                         dbo.ro_empleado.em_CarnetIees,  dbo.ro_empleado.em_fecha_ingreso, 
                         dbo.ro_empleado.em_fechaSalida, dbo.ro_empleado.em_fechaTerminoContra, dbo.ro_empleado.em_fechaIngaRol, 
                         dbo.ro_empleado.em_SePagaConTablaSec, 
                         dbo.ro_empleado.em_estado, dbo.ro_empleado.em_sueldoBasicoMen, dbo.ro_empleado.em_SueldoExtraMen,
                         dbo.ro_empleado.em_empEspecial, dbo.ro_empleado.em_pagoFdoRsv, dbo.ro_empleado.IdCodSectorial, 
                         dbo.ro_empleado.IdDepartamento,  dbo.ro_empleado.IdCargo,  
                         dbo.ro_empleado.IdCiudad AS IdUbicacion,  dbo.tb_persona.CodPersona, dbo.tb_persona.pe_Naturaleza, 
                         dbo.tb_persona.pe_nombreCompleto AS NomCompleto, dbo.tb_persona.pe_razonSocial, dbo.tb_persona.pe_apellido AS Apellido, 
                         dbo.tb_persona.pe_nombre AS Nombre, 0 IdTipoPersona, dbo.tb_persona.IdTipoDocumento, dbo.tb_persona.pe_cedulaRuc, 
                         dbo.tb_persona.pe_direccion, '' pe_telefonoCasa, '' pe_telefonoOfic, '' pe_telefonoInter, 
                         dbo.tb_persona.pe_celular,  '' pe_fax, dbo.tb_persona.pe_sexo, dbo.tb_persona.IdEstadoCivil, dbo.tb_persona.pe_fechaNacimiento, dbo.tb_persona.pe_estado, dbo.tb_persona.pe_fechaCreacion, 
                         dbo.tb_persona.pe_fechaModificacion, dbo.tb_sucursal.Su_Descripcion AS Sucursal, dbo.ro_empleado.IdSucursal,                          
                            
                         dbo.ro_empleado.por_discapacidad, dbo.ro_empleado.carnet_conadis,  
                         dbo.ro_empleado.em_status, dbo.ro_empleado.IdCondicionDiscapacidadSRI, 
                         dbo.ro_empleado.IdTipoIdentDiscapacitadoSustitutoSRI, dbo.ro_empleado.IdentDiscapacitadoSustitutoSRI, dbo.ro_empleado.IdAplicaConvenioDobleImposicionSRI, 
                         dbo.ro_empleado.IdTipoResidenciaSRI, dbo.ro_empleado.IdTipoSistemaSalarioNetoSRI, dbo.ro_empleado.es_AcreditaHorasExtras, 
                         dbo.ro_empleado.em_AnticipoSueldo, dbo.ro_empleado.CodigoSectorial AS CodigoSectorialIESS, dbo.ro_empleado.es_TruncarDecimalAnticipo, dbo.tb_pais.IdPais, 
                         dbo.tb_provincia.IdProvincia, dbo.tb_ciudad.IdCiudad, 
                                                 (select sum( Valor) from ro_rol_detalle where IdEmpleado=ro_empleado.IdEmpleado and IdRubro='24' and SUBSTRING( cast( IdPeriodo as varchar(10)),1,4)=@Anio) as tot_Sueldo_Ganado,-- obtengo el total de sueldo ganados
                                                 (select sum( Valor) from ro_rol_detalle where IdEmpleado=ro_empleado.IdEmpleado and IdRubro='289' and SUBSTRING( cast( IdPeriodo as varchar(10)),1,4)=@Anio) as tot_decimo_cuarto,-- total de decimo cuarto
												 (select sum( Valor) from ro_rol_detalle where IdEmpleado=ro_empleado.IdEmpleado and IdRubro='290' and SUBSTRING( cast( IdPeriodo as varchar(10)),1,4)=@Anio) as tot_decimo_tercero,-- total de decimo tercero 
                                                 (select sum( Valor) from ro_rol_detalle where IdEmpleado=ro_empleado.IdEmpleado and IdRubro='296' and SUBSTRING( cast( IdPeriodo as varchar(10)),1,4)=@Anio) as tot_fondo_reserva,-- total de fondos de reservas
                                                 (select sum( Valor) from ro_rol_detalle where IdEmpleado=ro_empleado.IdEmpleado and IdRubro in(7,8,9) and SUBSTRING(cast( IdPeriodo as varchar(10)),1,4)=@Anio) as tot_horasExtras,-- total de horas extras
												 (select sum( Valor) from ro_Ing_Egre_x_Empleado where IdEmpleado=ro_empleado.IdEmpleado and IngEgr='I' and SUBSTRING(cast( IdPeriodo as varchar(10)),0,4)=@Anio) as tot_ingreso,-- total de ingreso
                                                -- (select sum( ValorTotal) from ro_participacion_utilidad_empleado where IdEmpleado=ro_empleado.IdEmpleado and SUBSTRING(cast( IdPeriodo as varchar(10)),0,4)=@Anio) as tot_utilidad,-- total de utilidad




                                                (select sum( Valor) from ro_empleado_x_Proyeccion_Gastos_Personales where IdEmpleado=ro_empleado.IdEmpleado and AnioFiscal=@Anio and IdTipoGasto='VIV') as tot_vivienda,-- deducion de vivienda
												(select sum( Valor) from ro_empleado_x_Proyeccion_Gastos_Personales where IdEmpleado=ro_empleado.IdEmpleado and AnioFiscal=@Anio and IdTipoGasto='ALI') as tot_alimentacion,-- deducion de alimentacion
                                                (select sum( Valor) from ro_empleado_x_Proyeccion_Gastos_Personales where IdEmpleado=ro_empleado.IdEmpleado and AnioFiscal=@Anio and IdTipoGasto='SA') as tot_salud,-- deducion de salud
												(select sum( Valor) from ro_empleado_x_Proyeccion_Gastos_Personales where IdEmpleado=ro_empleado.IdEmpleado and AnioFiscal=@Anio and IdTipoGasto='EDU') as tot_educacion-- deducion de EDUCACION
FROM            dbo.tb_persona INNER JOIN
                         dbo.ro_empleado ON dbo.tb_persona.IdPersona = dbo.ro_empleado.IdPersona INNER JOIN
                         dbo.tb_ciudad ON dbo.ro_empleado.IdCiudad = dbo.tb_ciudad.IdCiudad INNER JOIN
                         dbo.tb_provincia ON dbo.tb_ciudad.IdProvincia = dbo.tb_provincia.IdProvincia INNER JOIN
                         dbo.tb_pais ON dbo.tb_provincia.IdPais = dbo.tb_pais.IdPais INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo INNER JOIN
                         dbo.ro_Departamento ON dbo.ro_empleado.IdEmpresa = dbo.ro_Departamento.IdEmpresa AND dbo.ro_empleado.IdDepartamento = dbo.ro_Departamento.IdDepartamento LEFT OUTER JOIN
                         dbo.tb_sucursal ON dbo.ro_empleado.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND dbo.ro_empleado.IdSucursal = dbo.tb_sucursal.IdSucursal 
                      where   dbo.ro_empleado.IdEmpresa=@Idempresa
						and dbo.ro_empleado.IdEmpresa=@Idempresa
						and  dbo.tb_sucursal.IdEmpresa=@Idempresa
END
