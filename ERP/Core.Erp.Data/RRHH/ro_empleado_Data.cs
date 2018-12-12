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
                                     pe_cedulaRuc=q.pe_cedulaRuc,
                                     IdTipoNomina= q.IdNomina,
                                     IdSucursal=q.IdSucursal
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
                                     IdPersona=q.IdPersona,
                                     pe_cedulaRuc=q.pe_cedulaRuc,
                                     em_estado = q.em_estado,
                                     em_status=q.em_status,
                                     Empleado=q.Empleado,
                                     em_codigo=q.em_codigo,
                                     em_fechaIngaRol=q.em_fechaIngaRol,

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
                                     IdPersona = q.IdPersona,
                                     pe_cedulaRuc = q.pe_cedulaRuc,
                                     em_estado = q.em_estado,
                                     em_status = q.em_status,
                                     Empleado = q.Empleado,
                                     em_codigo = q.em_codigo,
                                     em_fechaIngaRol = q.em_fechaIngaRol,

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


        public List<ro_empleado_Info> get_list_profesores(int IdEmpresa)
        {
            try
            {
                List<ro_empleado_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.vwro_empleado_combo
                             where q.IdEmpresa == IdEmpresa
                             && q.Pago_por_horas==true
                             select new ro_empleado_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 Empleado = q.Empleado,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 IdTipoNomina = q.IdNomina,
                                 IdSucursal = q.IdSucursal,
                                 Valor_horas_matutino=q.Valor_horas_matutino,
                                 Valor_horas_vespertina=q.Valor_horas_vespertina,
                                 Valor_horas_nocturna=q.Valor_horas_nocturna,
                                 Valor_maximo_horas=q.Valor_maximo_horas
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
                        em_fechaIngaRol = info.em_fechaIngaRol,
                        em_tipoCta = info.em_tipoCta,
                        em_NumCta = info.em_NumCta,
                        em_estado = info.em_estado,
                        IdCodSectorial = info.IdCodSectorial,
                        IdDepartamento = info.IdDepartamento,
                        IdTipoSangre = info.IdTipoSangre,
                        IdCargo = info.IdCargo,
                        IdCtaCble_Emplea = info.IdCtaCble_Emplea,
                        IdCiudad = info.IdCiudad,
                        em_mail = info.em_mail,
                        IdTipoLicencia = info.IdTipoLicencia,
                        IdBanco = info.IdBanco,
                        IdArea = info.IdArea,
                        IdDivision = info.IdDivision,
                        por_discapacidad = info.por_discapacidad,
                        carnet_conadis = info.carnet_conadis,
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
                        em_AnticipoSueldo = info.em_AnticipoSueldo,
                        Marca_Biometrico = info.Marca_Biometrico,
                        IdHorario = info.IdHorario,
                        Tiene_ingresos_compartidos=info.Tiene_ingresos_compartidos,                       
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
                           pe_fechaNacimiento=info.pe_fechaNacimiento,
                           Pago_por_horas = info.Pago_por_horas,
                        Valor_horas_vespertina = info.Valor_horas_vespertina,
                        //Valor_horas_nocturna = info.Valor_horas_nocturna,
                        Valor_horas_matutino = info.Valor_horas_matutino,
                        //Valor_maximo_horas = info.Valor_maximo_horas

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
                        em_fechaSalida	=info.em_fechaSalida	,
                        em_fechaIngaRol	=info.	em_fechaIngaRol	,
                        em_tipoCta	=info.em_tipoCta	,
                        em_NumCta	=info.em_NumCta	,                     
                        em_estado	=info.	em_estado,                    
                        IdCodSectorial	=info.IdCodSectorial	,
                        IdDepartamento	=info.IdDepartamento	,
                        IdTipoSangre	=info.IdTipoSangre	,
                        IdCargo	=info.	IdCargo,
                        IdCtaCble_Emplea	=info.IdCtaCble_Emplea	,
                        IdCiudad	=info.IdCiudad	,
                        em_mail	=info.em_mail	,
                        IdTipoLicencia	=info.IdTipoLicencia	,
                        IdBanco	=info.IdBanco	,
                        IdArea	=info.IdArea	,
                        IdDivision	=info.IdDivision	,
                        Fecha_UltMod	=info.Fecha_UltMod	,
                        por_discapacidad	=info.	por_discapacidad	,
                        carnet_conadis	=info.	carnet_conadis	,
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
                        em_AnticipoSueldo	=info.	em_AnticipoSueldo	,
                        Marca_Biometrico	=info.	Marca_Biometrico	,
                        IdHorario	=info.	IdHorario	,
                        Tiene_ingresos_compartidos=info.Tiene_ingresos_compartidos,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transaccion = info.Fecha_Transaccion=DateTime.Now,
                        Pago_por_horas = info.Pago_por_horas,
                        Valor_horas_vespertina = info.Valor_horas_vespertina,
                        //Valor_horas_nocturna = info.Valor_horas_nocturna,
                        Valor_horas_matutino = info.Valor_horas_matutino,
                        //Valor_maximo_horas = info.Valor_maximo_horas

                    };
                    Context.ro_empleado.Add(Entity);
                    if (info.info_foto != null)
                    {
                        if (info.info_foto.Foto != null)
                            if (info.info_foto.Foto.Length != 0)
                            {
                                ro_EmpleadoFoto entity_foto = new ro_EmpleadoFoto
                                {
                                    IdEmpresa = info.IdEmpresa,
                                    IdEmpleado = info.IdEmpleado,
                                    Foto = info.info_foto.Foto
                                };
                                Context.ro_EmpleadoFoto.Add(entity_foto);
                            }
                    }
                    
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception )
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
                        Entity.em_fechaIngaRol = info.em_fechaIngaRol ;
                        Entity.em_tipoCta = info.em_tipoCta    ;
                        Entity.em_NumCta = info.em_NumCta ;
                        Entity.em_estado = info.em_estado;
                        Entity.IdCodSectorial = info.IdCodSectorial    ;
                        Entity.IdDepartamento = info.IdDepartamento    ;
                        Entity.IdTipoSangre = info.IdTipoSangre  ;
                        Entity.IdCargo = info.IdCargo;
                        Entity.IdCtaCble_Emplea = info.IdCtaCble_Emplea  ;
                        Entity.IdCiudad = info.IdCiudad  ;
                        Entity.em_mail = info.em_mail   ;
                        Entity.IdTipoLicencia = info.IdTipoLicencia    ;
                        Entity.IdBanco = info.IdBanco   ;
                        Entity.Pago_por_horas = info.Pago_por_horas;
                    //Entity.Valor_horas_nocturna = info.Valor_horas_nocturna;
                    Entity.Valor_horas_matutino = info.Valor_horas_matutino;
                    Entity.Valor_horas_vespertina = info.Valor_horas_vespertina;
                        //Entity.Valor_maximo_horas = info.Valor_maximo_horas;
                        Entity.IdArea = info.IdArea    ;
                        Entity.IdDivision = info.IdDivision    ;
                        Entity.Fecha_UltMod = info.Fecha_UltMod  ;
                        Entity.por_discapacidad = info.por_discapacidad    ;
                        Entity.carnet_conadis = info.carnet_conadis  ;
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
                        Entity.em_AnticipoSueldo = info.em_AnticipoSueldo   ;
                        Entity.Marca_Biometrico = info.Marca_Biometrico    ;
                        Entity.IdHorario = info.IdHorario   ;
                        Entity.IdUsuario = info.IdUsuarioUltModi;
                        Entity.Fecha_UltMod = info.Fecha_Transaccion = DateTime.Now;
                        Entity.Tiene_ingresos_compartidos = info.Tiene_ingresos_compartidos;
                    var foto = Context.ro_EmpleadoFoto.FirstOrDefault(v => v.IdEmpresa ==info. IdEmpresa && v.IdEmpleado ==info.IdEmpleado);
                    if(foto!=null)
                    Context.ro_EmpleadoFoto.Remove(foto);
                    if (info.info_foto != null)
                    {
                        if (info.info_foto.Foto != null)
                            if (info.info_foto.Foto.Length != 0)
                            {
                                ro_EmpleadoFoto entity_foto = new ro_EmpleadoFoto
                                {
                                    IdEmpresa = info.IdEmpresa,
                                    IdEmpleado = info.IdEmpleado,
                                    Foto = info.info_foto.Foto
                                };
                                Context.ro_EmpleadoFoto.Add(entity_foto);
                            }
                    }
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
