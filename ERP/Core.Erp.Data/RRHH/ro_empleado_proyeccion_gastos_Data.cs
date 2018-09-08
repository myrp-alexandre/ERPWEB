using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_empleado_proyeccion_gastos_Data
    {
        public List<ro_empleado_proyeccion_gastos_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ro_empleado_proyeccion_gastos_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.ro_empleado_proyeccion_gastos
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_empleado_proyeccion_gastos_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     AnioFiscal = q.AnioFiscal,
                                     
                                    
                                 }).ToList();
                  
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_proyeccion_gastos_Info get_info(int IdEmpresa, decimal IdEmpleado, int anio)
        {
            try
            {
                ro_empleado_proyeccion_gastos_Info info = new ro_empleado_proyeccion_gastos_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_proyeccion_gastos Entity = Context.ro_empleado_proyeccion_gastos.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado && q.AnioFiscal==anio);
                    if (Entity == null) return null;

                    info = new ro_empleado_proyeccion_gastos_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        AnioFiscal = Entity.AnioFiscal,
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
       public bool guardarDB(ro_empleado_proyeccion_gastos_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_proyeccion_gastos Entity = new ro_empleado_proyeccion_gastos
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado = info.IdEmpleado,
                        AnioFiscal = info.AnioFiscal,
                        estado = true,
                        Fecha_Transac=DateTime.Now
                        
                    };
                    Context.ro_empleado_proyeccion_gastos.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
       public bool anularDB(ro_empleado_proyeccion_gastos_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_proyeccion_gastos Entity = Context.ro_empleado_proyeccion_gastos.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.AnioFiscal==info.AnioFiscal);
                    Context.Database.ExecuteSqlCommand("delete ro_empleado_x_Proyeccion_Gastos_Personales where idEmpresa='" + info.IdEmpresa + "' and IdEmpleado='" + info.IdEmpleado + "' and AnioFiscal='" + info.AnioFiscal + "'");
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
