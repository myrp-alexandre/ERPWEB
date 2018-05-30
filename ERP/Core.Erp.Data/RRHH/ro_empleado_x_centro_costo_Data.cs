using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
  public  class ro_empleado_x_centro_costo_Data
    {
        public List<ro_empleado_x_centro_costo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ro_empleado_x_centro_costo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.ro_empleado_x_centro_costo
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_empleado_x_centro_costo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     IdCentroCosto = q.IdCentroCosto,
                                     IdCentroCosto_sub_centro_costo = q.IdCentroCosto_sub_centro_costo,
                                     FechaIngresa = q.FechaIngresa
                                                                         
                                 }).ToList();               
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_x_centro_costo_Info get_info(int IdEmpresa, int IdEmpleado)
        {
            try
            {
                ro_empleado_x_centro_costo_Info info = new ro_empleado_x_centro_costo_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_centro_costo Entity = Context.ro_empleado_x_centro_costo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado);
                    if (Entity == null) return null;

                    info = new ro_empleado_x_centro_costo_Info
                    {

                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        IdCentroCosto = Entity.IdCentroCosto,
                        IdCentroCosto_sub_centro_costo = Entity.IdCentroCosto_sub_centro_costo,
                        FechaIngresa = Entity.FechaIngresa
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
       public bool guardarDB(ro_empleado_x_centro_costo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_centro_costo Entity = new ro_empleado_x_centro_costo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado = info.IdEmpleado,
                        IdCentroCosto = info.IdCentroCosto,
                        IdCentroCosto_sub_centro_costo = info.IdCentroCosto_sub_centro_costo,
                        FechaIngresa = info.FechaIngresa,
                        UsuarioIngresa = info.UsuarioIngresa
                        
                    };
                    Context.ro_empleado_x_centro_costo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_empleado_x_centro_costo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_centro_costo Entity = Context.ro_empleado_x_centro_costo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa
                                                                                                            && q.IdEmpleado == info.IdEmpleado
                                                                                                            &&q.IdCentroCosto==info.IdCentroCosto
                                                                                                            &&q.IdCentroCosto_sub_centro_costo==info.IdCentroCosto_sub_centro_costo);
                                                                                                             
                                                                                                              
                    if (Entity == null)
                        return false;
                    Context.ro_empleado_x_centro_costo.Remove(Entity);
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
