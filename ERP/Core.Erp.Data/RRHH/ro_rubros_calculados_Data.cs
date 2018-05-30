using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_rubros_calculados_Data
    {
        public List<ro_rubros_calculados_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ro_rubros_calculados_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.ro_rubros_calculados
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_rubros_calculados_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdRubro_dias_trabajados = q.IdRubro_dias_trabajados,
                                     IdRubro_iess_perso = q.IdRubro_iess_perso,
                                     IdRubro_sueldo = q.IdRubro_sueldo,
                                     IdRubro_tot_egr = q.IdRubro_tot_egr,
                                     IdRubro_tot_ing = q.IdRubro_tot_ing,
                                     IdRubro_tot_pagar = q.IdRubro_tot_pagar
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_rubros_calculados_Info get_info(int IdEmpresa, int IdCargo)
        {
            try
            {
                ro_rubros_calculados_Info info = new ro_rubros_calculados_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubros_calculados Entity = Context.ro_rubros_calculados.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;

                    info = new ro_rubros_calculados_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdRubro_dias_trabajados = Entity.IdRubro_dias_trabajados,
                        IdRubro_iess_perso = Entity.IdRubro_iess_perso,
                        IdRubro_sueldo = Entity.IdRubro_sueldo,
                        IdRubro_tot_egr = Entity.IdRubro_tot_egr,
                        IdRubro_tot_ing = Entity.IdRubro_tot_ing,
                        IdRubro_tot_pagar = Entity.IdRubro_tot_pagar
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool si_existe(int IdEmpresa)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_rubros_calculados
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        return true;
                    else
                        return false;
                }

            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_rubros_calculados_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubros_calculados Entity = new ro_rubros_calculados
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdRubro_dias_trabajados = info.IdRubro_dias_trabajados,
                        IdRubro_iess_perso = info.IdRubro_iess_perso,
                        IdRubro_sueldo = info.IdRubro_sueldo,
                        IdRubro_tot_egr = info.IdRubro_tot_egr,
                        IdRubro_tot_ing = info.IdRubro_tot_ing,
                        IdRubro_tot_pagar = info.IdRubro_tot_pagar

                    };
                    Context.ro_rubros_calculados.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_rubros_calculados_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubros_calculados Entity = Context.ro_rubros_calculados.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null)
                        return false;
                    Entity.IdRubro_dias_trabajados = info.IdRubro_dias_trabajados;
                    Entity.IdRubro_iess_perso = info.IdRubro_iess_perso;
                    Entity.IdRubro_sueldo = info.IdRubro_sueldo;
                    Entity.IdRubro_tot_egr = info.IdRubro_tot_egr;
                    Entity.IdRubro_tot_ing = info.IdRubro_tot_ing;
                    Entity.IdRubro_tot_pagar = info.IdRubro_tot_pagar;
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
