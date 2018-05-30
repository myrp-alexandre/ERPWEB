using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_Acta_Finiquito_Data
    {
        public List<ro_Acta_Finiquito_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ro_Acta_Finiquito_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.ro_Acta_Finiquito
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_Acta_Finiquito_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdActaFiniquito=q.IdActaFiniquito,
                                     IdCargo = q.IdCargo,
                                     Estado = q.Estado
                                 }).ToList();
                    else
                        Lista = (from q in Context.ro_Acta_Finiquito
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new ro_Acta_Finiquito_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdCargo = q.IdCargo,
                                     Estado = q.Estado
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_Acta_Finiquito_Info get_info(int IdEmpresa, decimal IdEmpleado, decimal IdActaFiniquito)
        {
            try
            {
                ro_Acta_Finiquito_Info info = new ro_Acta_Finiquito_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Acta_Finiquito Entity = Context.ro_Acta_Finiquito.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpresa&& q.IdActaFiniquito== IdActaFiniquito);
                    if (Entity == null) return null;

                    info = new ro_Acta_Finiquito_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdActaFiniquito = Entity.IdActaFiniquito,
                        IdEmpleado=Entity.IdEmpleado,
                        IdCausaTerminacion =Entity.IdCausaTerminacion,
                        IdContrato = Entity.IdContrato,
                        IdCargo=Entity.IdCargo,
                        FechaIngreso=Entity.FechaIngreso,
                        FechaSalida=Entity.FechaSalida,
                        UltimaRemuneracion=Entity.UltimaRemuneracion,
                        Observacion=Entity.Observacion,
                        Ingresos=Entity.Ingresos,
                        Egresos=Entity.Ingresos,
                        IdCodSectorial=Entity.IdCodSectorial,
                        EsMujerEmbarazada=Entity.EsMujerEmbarazada,
                        EsDirigenteSindical=Entity.EsDirigenteSindical,
                        EsPorDiscapacidad=Entity.EsPorDiscapacidad,
                        EsPorEnfermedadNoProfesional=Entity.EsPorEnfermedadNoProfesional,
                        IdTipoCbte=Entity.IdTipoCbte,
                        IdCbteCble=Entity.IdCbteCble,
                        IdOrdenPago=Entity.IdOrdenPago

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
                    var lst = from q in Context.ro_Acta_Finiquito
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdActaFiniquito) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_Acta_Finiquito_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Acta_Finiquito Entity = new ro_Acta_Finiquito
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdActaFiniquito = info.IdActaFiniquito = get_id(info.IdEmpresa),
                        IdEmpleado = info.IdEmpleado,
                        IdCausaTerminacion = info.IdCausaTerminacion,
                        IdContrato = info.IdContrato,
                        IdCargo = info.IdCargo,
                        FechaIngreso = info.FechaIngreso,
                        FechaSalida = info.FechaSalida,
                        UltimaRemuneracion = info.UltimaRemuneracion,
                        Observacion = info.Observacion,
                        Ingresos = info.Ingresos,
                        Egresos = info.Ingresos,
                        IdCodSectorial = info.IdCodSectorial,
                        EsMujerEmbarazada = info.EsMujerEmbarazada,
                        EsDirigenteSindical = info.EsDirigenteSindical,
                        EsPorDiscapacidad = info.EsPorDiscapacidad,
                        EsPorEnfermedadNoProfesional = info.EsPorEnfermedadNoProfesional,
                        IdTipoCbte = info.IdTipoCbte,
                        IdCbteCble = info.IdCbteCble,
                        IdOrdenPago = info.IdOrdenPago,
                        Estado = info.Estado = "A",
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now
                    };
                    Context.ro_Acta_Finiquito.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_Acta_Finiquito_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Acta_Finiquito Entity = Context.ro_Acta_Finiquito.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdCargo == info.IdCargo);
                    if (Entity == null)
                        return false;
                    Entity.FechaIngreso = info.FechaIngreso;
                    Entity.FechaSalida = info.FechaSalida;
                    Entity.Observacion = info.Observacion;
                    Entity.UltimaRemuneracion = info.UltimaRemuneracion;

                    Entity.EsMujerEmbarazada = info.EsMujerEmbarazada;
                    Entity.EsDirigenteSindical = info.EsDirigenteSindical;
                    Entity.EsPorDiscapacidad = info.EsPorDiscapacidad;
                    Entity.EsPorEnfermedadNoProfesional = info.EsPorEnfermedadNoProfesional;
                    Entity.UltimaRemuneracion = info.UltimaRemuneracion;

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
        public bool anularDB(ro_Acta_Finiquito_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_Acta_Finiquito Entity = Context.ro_Acta_Finiquito.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdCargo == info.IdCargo);
                    if (Entity == null)
                        return false;
                    Entity.Estado = info.Estado = "I";
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
