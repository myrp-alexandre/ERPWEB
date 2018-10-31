using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_empleado_Data
    {
        public List<ro_empleado_Info> get_list_combo(int IdEmpresa)
        {
            try
            {
                List<ro_empleado_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.vwro_empleado_combo
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_empleado_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     Empleado=q.Empleado,
                                     pe_cedulaRuc=q.pe_cedulaRuc
                                 }).ToList();
                  
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<ro_empleado_Info> get_list_combo_liquidar(int IdEmpresa)
        {
            try
            {
                List<ro_empleado_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.vwro_empleado_combo
                             where q.IdEmpresa == IdEmpresa
                             && q.em_status== "EST_PLQ"
                             select new ro_empleado_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 Empleado = q.Empleado,
                                 pe_cedulaRuc = q.pe_cedulaRuc
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public List<ro_empleado_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ro_empleado_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.vwro_empleados_consulta
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_empleado_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     info_persona =new Info.General.tb_persona_Info
                                     {
                                         IdPersona=q.IdPersona,
                                         pe_cedulaRuc=q.pe_cedulaRuc
                                     },
                                     em_estado = q.em_estado,
                                     em_status=q.em_status,
                                     Empleado=q.Empleado,
                                     pe_cedulaRuc=q.pe_cedulaRuc,
                                     em_codigo=q.em_codigo,
                                     em_fechaIngaRol=q.em_fechaIngaRol,
                                     IdPersona=q.IdPersona,

                                     EstadoBool = q.em_estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.vwro_empleados_consulta
                                 where q.IdEmpresa == IdEmpresa
                                 && q.em_estado == "A"
                                 select new ro_empleado_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     em_estado = q.em_estado,
                                     em_status = q.em_status,
                                     Empleado = q.Empleado,
                                     pe_cedulaRuc = q.pe_cedulaRuc,
                                     em_codigo = q.em_codigo,
                                     em_fechaIngaRol = q.em_fechaIngaRol,
                                     IdPersona = q.IdPersona,

                                     EstadoBool = q.em_estado == "A" ? true : false
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_Info get_info(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                ro_empleado_Info info_ = new ro_empleado_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    vwro_empleado_datos_generales info = Context.vwro_empleado_datos_generales.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado);
                    if (info == null)
                        return null;

                    info_ = new ro_empleado_Info
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado =info.IdEmpleado,
                        IdEmpleado_Supervisor = info.IdEmpleado_Supervisor,
                        IdPersona = info.IdPersona,
                        IdSucursal = info.IdSucursal,
                        IdTipoEmpleado = info.IdTipoEmpleado,
                        em_codigo = (info.em_codigo) == null ? info.IdEmpleado.ToString() : info.em_codigo,
                        Codigo_Biometrico = info.Codigo_Biometrico,
                        em_lugarNacimiento = info.em_lugarNacimiento,
                        em_CarnetIees = info.em_CarnetIees,
                        em_cedulaMil = info.em_cedulaMil,
                        em_fecha_ingreso = info.em_fecha_ingreso,
                        em_fechaSalida = info.em_fechaSalida,
                        em_fechaTerminoContra = info.em_fechaTerminoContra,
                        em_fechaIngaRol = info.em_fechaIngaRol,
                        em_SeAcreditaBanco = info.em_SeAcreditaBanco,
                        em_tipoCta = info.em_tipoCta,
                        em_NumCta = info.em_NumCta,
                        em_SepagaBeneficios = info.em_SepagaBeneficios,
                        em_SePagaConTablaSec = info.em_SePagaConTablaSec,
                        em_estado = info.em_estado,
                        em_sueldoBasicoMen = info.em_sueldoBasicoMen,
                        em_SueldoExtraMen = info.em_SueldoExtraMen,
                        em_MovilizacionQuincenal = info.em_MovilizacionQuincenal,
                        em_foto = info.em_foto,
                        em_empEspecial = info.em_empEspecial,
                        em_pagoFdoRsv = info.em_pagoFdoRsv,
                        em_huella = info.em_huella,
                        IdCodSectorial = info.IdCodSectorial,
                        IdDepartamento = info.IdDepartamento,
                        IdTipoSangre = info.IdTipoSangre,
                        IdCargo = info.IdCargo,
                        IdCtaCble_Emplea = info.IdCtaCble_Emplea,
                        IdCiudad = info.IdCiudad,
                        em_mail = info.em_mail,
                        IdTipoLicencia = info.IdTipoLicencia,
                        IdCentroCosto = info.IdCentroCosto,
                        IdBanco = info.IdBanco,
                        Archivo = info.Archivo,
                        NombreArchivo = info.NombreArchivo,
                        IdArea = info.IdArea,
                        IdDivision = info.IdDivision,
                        IdCentroCosto_sub_centro_costo = info.IdCentroCosto_sub_centro_costo,
                        por_discapacidad = info.por_discapacidad,
                        carnet_conadis = info.carnet_conadis,
                        recibi_uniforme = info.recibi_uniforme,
                        talla_pant = info.talla_pant,
                        talla_camisa = info.talla_camisa,
                        talla_zapato = info.talla_zapato,
                        em_status = info.em_status,
                        IdCondicionDiscapacidadSRI = info.IdCondicionDiscapacidadSRI,
                        IdTipoIdentDiscapacitadoSustitutoSRI = info.IdTipoIdentDiscapacitadoSustitutoSRI,
                        IdentDiscapacitadoSustitutoSRI = info.IdentDiscapacitadoSustitutoSRI,
                        IdAplicaConvenioDobleImposicionSRI = info.IdAplicaConvenioDobleImposicionSRI,
                        IdTipoResidenciaSRI = info.IdTipoResidenciaSRI,
                        IdTipoSistemaSalarioNetoSRI = info.IdTipoSistemaSalarioNetoSRI,
                        es_AcreditaHorasExtras = info.es_AcreditaHorasExtras,
                        IdTipoAnticipo = info.IdTipoAnticipo,
                        ValorAnticipo = info.ValorAnticipo,
                        CodigoSectorial = info.CodigoSectorial,
                        es_TruncarDecimalAnticipo = info.es_TruncarDecimalAnticipo,
                        em_AnticipoSueldo = info.em_AnticipoSueldo,
                        IdBanco_Acreditacion = info.IdBanco_Acreditacion,
                        IdGrupo = info.IdGrupo,
                        Marca_Biometrico = info.Marca_Biometrico,
                        em_motivo_salisa = info.em_motivo_salisa,
                        IdHorario = info.IdHorario,
                        IdPuntoCargo = info.IdPuntoCargo,
                        info_persona=new Info.General.tb_persona_Info()
                        {
                           IdPersona=info.IdPersona,
                           pe_cedulaRuc=info.pe_cedulaRuc,
                           pe_nombre=info.pe_nombre,
                           pe_apellido=info.pe_apellido,
                           pe_sexo=info.pe_sexo,
                           IdEstadoCivil=info.IdEstadoCivil,
                           pe_direccion=info.pe_direccion,
                           pe_telfono_Contacto=info.pe_telfono_Contacto,
                           pe_celular=info.pe_celular,
                           IdTipoDocumento=info.IdTipoDocumento,
                           pe_correo=info.pe_correo,
                           pe_fechaNacimiento=info.pe_fechaNacimiento
                        }
                    };
                }

                return info_;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_empleado
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdEmpleado) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_empleado_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado Entity = new ro_empleado
                    {
                        IdEmpresa	=info.IdEmpresa	,
                        IdEmpleado	=info.IdEmpleado= get_id(info.IdEmpresa)	,
                        IdEmpleado_Supervisor=info.IdEmpleado_Supervisor,
                        IdPersona	=info.IdPersona,
                        IdSucursal	=info.IdSucursal,
                        IdTipoEmpleado	=info.IdTipoEmpleado,
                        em_codigo	=(info.em_codigo) ==null?info.IdEmpleado.ToString():info.em_codigo,
                        Codigo_Biometrico	=info.Codigo_Biometrico,
                        em_lugarNacimiento	=info.em_lugarNacimiento,
                        em_CarnetIees	=info.em_CarnetIees,
                        em_cedulaMil	=info.em_cedulaMil	,
                        em_fecha_ingreso	=info.em_fecha_ingreso	,
                        em_fechaSalida	=info.em_fechaSalida	,
                        em_fechaTerminoContra=info.	em_fechaTerminoContra	,
                        em_fechaIngaRol	=info.	em_fechaIngaRol	,
                        em_SeAcreditaBanco	=info.em_SeAcreditaBanco	,
                        em_tipoCta	=info.em_tipoCta	,
                        em_NumCta	=info.em_NumCta	,
                        em_SepagaBeneficios	=info.em_SepagaBeneficios	,
                        em_SePagaConTablaSec	=info.em_SePagaConTablaSec	,
                        em_estado	=info.	em_estado,
                        em_sueldoBasicoMen	=info.em_sueldoBasicoMen	,
                        em_SueldoExtraMen	=info.em_SueldoExtraMen	,
                        em_MovilizacionQuincenal=info.em_MovilizacionQuincenal	,
                        em_foto	=info.	em_foto,
                        em_empEspecial	=info.em_empEspecial	,
                        em_pagoFdoRsv	=info.em_pagoFdoRsv	,
                        em_huella	=info.em_huella	,
                        IdCodSectorial	=info.IdCodSectorial	,
                        IdDepartamento	=info.IdDepartamento	,
                        IdTipoSangre	=info.IdTipoSangre	,
                        IdCargo	=info.	IdCargo,
                        IdCtaCble_Emplea	=info.IdCtaCble_Emplea	,
                        IdCiudad	=info.IdCiudad	,
                        em_mail	=info.em_mail	,
                        IdTipoLicencia	=info.IdTipoLicencia	,
                        IdCentroCosto	=info.IdCentroCosto	,
                        IdBanco	=info.IdBanco	,
                        Archivo	=info.Archivo	,
                        NombreArchivo=info.	NombreArchivo	,
                        IdArea	=info.IdArea	,
                        IdDivision	=info.IdDivision	,
                        IdCentroCosto_sub_centro_costo	=info.IdCentroCosto_sub_centro_costo	,
                        Fecha_UltMod	=info.Fecha_UltMod	,
                        por_discapacidad	=info.	por_discapacidad	,
                        carnet_conadis	=info.	carnet_conadis	,
                        recibi_uniforme	=info.	recibi_uniforme	,
                        talla_pant	=info.	talla_pant	,
                        talla_camisa	=info.	talla_camisa	,
                        talla_zapato	=info.	talla_zapato	,
                        em_status	=info.	em_status	,
                        IdCondicionDiscapacidadSRI	=info.	IdCondicionDiscapacidadSRI	,
                        IdTipoIdentDiscapacitadoSustitutoSRI	=info.	IdTipoIdentDiscapacitadoSustitutoSRI	,
                        IdentDiscapacitadoSustitutoSRI	=info.	IdentDiscapacitadoSustitutoSRI	,
                        IdAplicaConvenioDobleImposicionSRI	=info.	IdAplicaConvenioDobleImposicionSRI	,
                        IdTipoResidenciaSRI	=info.	IdTipoResidenciaSRI	,
                        IdTipoSistemaSalarioNetoSRI	=info.	IdTipoSistemaSalarioNetoSRI	,
                        es_AcreditaHorasExtras	=info.	es_AcreditaHorasExtras	,
                        IdTipoAnticipo	=info.	IdTipoAnticipo	,
                        ValorAnticipo	=info.	ValorAnticipo	,
                        CodigoSectorial	=info.	CodigoSectorial	,
                        es_TruncarDecimalAnticipo	=info.	es_TruncarDecimalAnticipo	,
                        em_AnticipoSueldo	=info.	em_AnticipoSueldo	,
                        IdBanco_Acreditacion	=info.	IdBanco_Acreditacion	,
                        IdGrupo	=info.	IdGrupo	,
                        Marca_Biometrico	=info.	Marca_Biometrico	,
                        em_motivo_salisa	=info.	em_motivo_salisa	,
                        IdHorario	=info.	IdHorario	,
                        IdPuntoCargo	=info.	IdPuntoCargo,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transaccion = info.Fecha_Transaccion=DateTime.Now

                    };
                    Context.ro_empleado.Add(Entity);

                   
                    
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }
        public bool modificarDB(ro_empleado_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado Entity = Context.ro_empleado.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado);
                    if (Entity == null)
                        return false;
                        Entity.IdEmpleado_Supervisor = info.IdEmpleado_Supervisor;
                        Entity.IdPersona = info.IdPersona;
                        Entity.IdSucursal = info.IdSucursal;
                        Entity.IdTipoEmpleado = info.IdTipoEmpleado;
                        Entity.em_codigo = info.em_codigo;
                        Entity.Codigo_Biometrico = info.Codigo_Biometrico;
                        Entity.em_lugarNacimiento = info.em_lugarNacimiento;
                        Entity.em_CarnetIees = info.em_CarnetIees;
                        Entity.em_cedulaMil = info.em_cedulaMil  ;
                        Entity.em_fecha_ingreso = info.em_fecha_ingreso  ;
                        Entity.em_fechaSalida = info.em_fechaSalida    ;
                        Entity.em_fechaTerminoContra = info.em_fechaTerminoContra   ;
                        Entity.em_fechaIngaRol = info.em_fechaIngaRol ;
                        Entity.em_SeAcreditaBanco = info.em_SeAcreditaBanco    ;
                        Entity.em_tipoCta = info.em_tipoCta    ;
                        Entity.em_NumCta = info.em_NumCta ;
                        Entity.em_SepagaBeneficios = info.em_SepagaBeneficios   ;
                        Entity.em_SePagaConTablaSec = info.em_SePagaConTablaSec  ;
                        Entity.em_estado = info.em_estado;
                        Entity.em_sueldoBasicoMen = info.em_sueldoBasicoMen    ;
                        Entity.em_SueldoExtraMen = info.em_SueldoExtraMen ;
                        Entity.em_MovilizacionQuincenal = info.em_MovilizacionQuincenal  ;
                        Entity.em_foto = info.em_foto;
                        Entity.em_empEspecial = info.em_empEspecial    ;
                        Entity.em_pagoFdoRsv = info.em_pagoFdoRsv ;
                        Entity.em_huella = info.em_huella ;
                        Entity.IdCodSectorial = info.IdCodSectorial    ;
                        Entity.IdDepartamento = info.IdDepartamento    ;
                        Entity.IdTipoSangre = info.IdTipoSangre  ;
                        Entity.IdCargo = info.IdCargo;
                        Entity.IdCtaCble_Emplea = info.IdCtaCble_Emplea  ;
                        Entity.IdCiudad = info.IdCiudad  ;
                        Entity.em_mail = info.em_mail   ;
                        Entity.IdTipoLicencia = info.IdTipoLicencia    ;
                        Entity.IdCentroCosto = info.IdCentroCosto ;
                        Entity.IdBanco = info.IdBanco   ;
                        Entity.Archivo = info.Archivo   ;
                        Entity.NombreArchivo = info.NombreArchivo   ;
                        Entity.IdArea = info.IdArea    ;
                        Entity.IdDivision = info.IdDivision    ;
                        Entity.IdCentroCosto_sub_centro_costo = info.IdCentroCosto_sub_centro_costo    ;
                        Entity.Fecha_UltMod = info.Fecha_UltMod  ;
                        Entity.por_discapacidad = info.por_discapacidad    ;
                        Entity.carnet_conadis = info.carnet_conadis  ;
                        Entity.recibi_uniforme = info.recibi_uniforme ;
                        Entity.talla_pant = info.talla_pant  ;
                        Entity.talla_camisa = info.talla_camisa    ;
                        Entity.talla_zapato = info.talla_zapato    ;
                        Entity.em_status = info.em_status   ;
                        Entity.IdCondicionDiscapacidadSRI = info.IdCondicionDiscapacidadSRI  ;
                        Entity.IdTipoIdentDiscapacitadoSustitutoSRI = info.IdTipoIdentDiscapacitadoSustitutoSRI    ;
                        Entity.IdentDiscapacitadoSustitutoSRI = info.IdentDiscapacitadoSustitutoSRI  ;
                        Entity.IdAplicaConvenioDobleImposicionSRI = info.IdAplicaConvenioDobleImposicionSRI  ;
                        Entity.IdTipoResidenciaSRI = info.IdTipoResidenciaSRI ;
                        Entity.IdTipoSistemaSalarioNetoSRI = info.IdTipoSistemaSalarioNetoSRI ;
                        Entity.es_AcreditaHorasExtras = info.es_AcreditaHorasExtras  ;
                        Entity.IdTipoAnticipo = info.IdTipoAnticipo  ;
                        Entity.ValorAnticipo = info.ValorAnticipo   ;
                        Entity.CodigoSectorial = info.CodigoSectorial ;
                        Entity.es_TruncarDecimalAnticipo = info.es_TruncarDecimalAnticipo   ;
                        Entity.em_AnticipoSueldo = info.em_AnticipoSueldo   ;
                        Entity.IdBanco_Acreditacion = info.IdBanco_Acreditacion    ;
                        Entity.IdGrupo = info.IdGrupo ;
                        Entity.Marca_Biometrico = info.Marca_Biometrico    ;
                        Entity.em_motivo_salisa = info.em_motivo_salisa    ;
                        Entity.IdHorario = info.IdHorario   ;
                        Entity.IdPuntoCargo = info.IdPuntoCargo;
                        Entity.IdUsuario = info.IdUsuarioUltModi;
                        Entity.Fecha_UltMod = info.Fecha_Transaccion = DateTime.Now;            
                        Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_empleado_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado Entity = Context.ro_empleado.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado);
                    if (Entity == null)
                        return false;
                    Entity.em_estado = info.em_estado = "I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public bool modificar_estadoDB(int IdEmpresa, decimal IdEmpleado, string em_status, DateTime fecha_salida)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado Entity = Context.ro_empleado.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado);
                    if (Entity == null)
                        return false;
                    Entity.em_status = em_status;
                    Entity.em_fechaSalida = fecha_salida;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
