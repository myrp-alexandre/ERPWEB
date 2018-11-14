using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
  public  class ro_archivos_bancos_generacion_Data
    {
        public List<ro_archivos_bancos_generacion_Info> get_list(int IdEmpresa, DateTime Fechainicio, DateTime FechaFin, bool mostrar_anulados)
        {
            try
            {
                List<ro_archivos_bancos_generacion_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.ro_archivos_bancos_generacion
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_archivos_bancos_generacion_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdArchivo = q.IdArchivo,
                                     IdNomina = q.IdNomina,
                                     IdNominaTipo =q.IdNominaTipo,
                                     IdCuentaBancaria=q.IdCuentaBancaria,
                                     IdProceso_Bancario=q.IdProceso_Bancario,
                                     Cod_Empresa=q.Cod_Empresa,
                                     Nom_Archivo=q.Nom_Archivo,
                                     archivo=q.archivo,
                                     estado = q.estado,
                                    IdRol=q.IdRol,
                                     EstadoBool = q.estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.ro_archivos_bancos_generacion
                                 where q.IdEmpresa == IdEmpresa
                                 && q.estado == "A"
                                 select new ro_archivos_bancos_generacion_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdArchivo = q.IdArchivo,
                                     IdNomina = q.IdNomina,
                                     IdNominaTipo = q.IdNominaTipo,
                                     IdCuentaBancaria = q.IdCuentaBancaria,
                                     IdProceso_Bancario = q.IdProceso_Bancario,
                                     Cod_Empresa = q.Cod_Empresa,
                                     Nom_Archivo = q.Nom_Archivo,
                                     archivo = q.archivo,
                                     estado = q.estado,
                                     IdRol = q.IdRol,
                                     EstadoBool = q.estado == "A" ? true : false
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_archivos_bancos_generacion_Info get_info(int IdEmpresa, decimal IdArchivo)
        {
            try
            {
                ro_archivos_bancos_generacion_Info info = new ro_archivos_bancos_generacion_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_archivos_bancos_generacion Entity = Context.ro_archivos_bancos_generacion.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdArchivo == IdArchivo);
                    if (Entity == null) return null;

                    info = new ro_archivos_bancos_generacion_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdArchivo = Entity.IdArchivo,
                        IdNomina = Entity.IdNomina,
                        IdNominaTipo = Entity.IdNominaTipo,
                        IdCuentaBancaria = Entity.IdCuentaBancaria,
                        IdProceso_Bancario = Entity.IdProceso_Bancario,
                        Cod_Empresa = Entity.Cod_Empresa,
                        Nom_Archivo = Entity.Nom_Archivo,
                        archivo = Entity.archivo,
                        estado = Entity.estado,
                        IdRol = Entity.IdRol,
                        EstadoBool = Entity.estado == "A" ? true : false
                    };
                }

                return info;
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
                    var lst = from q in Context.ro_archivos_bancos_generacion
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdArchivo) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_archivos_bancos_generacion Entity = new ro_archivos_bancos_generacion
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdArchivo = info.IdArchivo = get_id(info.IdEmpresa),
                        IdNomina = info.IdNomina,
                        IdNominaTipo = info.IdNomina ,
                        IdPeriodo = info.IdPeriodo,
                        IdProceso_Bancario=info.IdProceso_Bancario,
                        Cod_Empresa=info.Cod_Empresa,
                        Nom_Archivo=info.Nom_Archivo,
                        archivo=info.archivo,
                        estado=info.estado="A",
                        IdUsuario=info.IdUsuario,
                        IdRol=info.IdRol,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now
                    };
                    Context.ro_archivos_bancos_generacion.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_archivos_bancos_generacion Entity = Context.ro_archivos_bancos_generacion.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdArchivo == info.IdArchivo);
                    if (Entity == null)
                        return false;
                    Entity.IdNomina = info.IdNomina;
                    Entity.IdNominaTipo = info.IdNomina;
                    Entity.IdPeriodo = info.IdPeriodo;
                    Entity.IdProceso_Bancario = info.IdProceso_Bancario;
                    Entity.Cod_Empresa = info.Cod_Empresa;
                    Entity.Nom_Archivo = info.Nom_Archivo;
                    Entity.archivo = info.archivo;
                    Entity.estado = info.estado = "A";
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_archivos_bancos_generacion Entity = Context.ro_archivos_bancos_generacion.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdArchivo == info.IdArchivo);
                    if (Entity == null)
                        return false;
                    Entity.estado = info.estado = "I";

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

    }
}
