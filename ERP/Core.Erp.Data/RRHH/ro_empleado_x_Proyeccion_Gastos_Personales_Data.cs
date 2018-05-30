using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_empleado_x_Proyeccion_Gastos_Personales_Data
    {
        public List<ro_empleado_x_Proyeccion_Gastos_Personales_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ro_empleado_x_Proyeccion_Gastos_Personales_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.ro_empleado_x_Proyeccion_Gastos_Personales
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_empleado_x_Proyeccion_Gastos_Personales_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     AnioFiscal = q.AnioFiscal,
                                     IdTipoGasto = q.IdTipoGasto,
                                     Valor=q.Valor
                                     
                                    
                                 }).ToList();
                  
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_x_Proyeccion_Gastos_Personales_Info get_info(int IdEmpresa, int IdEmpleado, int anio)
        {
            try
            {
                ro_empleado_x_Proyeccion_Gastos_Personales_Info info = new ro_empleado_x_Proyeccion_Gastos_Personales_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_Proyeccion_Gastos_Personales Entity = Context.ro_empleado_x_Proyeccion_Gastos_Personales.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado && q.AnioFiscal==anio);
                    if (Entity == null) return null;

                    info = new ro_empleado_x_Proyeccion_Gastos_Personales_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        AnioFiscal = Entity.AnioFiscal,
                        IdTipoGasto = Entity.IdTipoGasto,
                        Valor = Entity.Valor
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
       public bool guardarDB(ro_empleado_x_Proyeccion_Gastos_Personales_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_Proyeccion_Gastos_Personales Entity = new ro_empleado_x_Proyeccion_Gastos_Personales
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado = info.IdEmpleado,
                        IdTipoGasto = info.IdTipoGasto,
                        AnioFiscal = info.AnioFiscal,
                        Valor = info.Valor,
                        FechaIngresa = info.FechaIngresa,
                        UsuarioIngresa = info.UsuarioIngresa
                        
                    };
                    Context.ro_empleado_x_Proyeccion_Gastos_Personales.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
       public bool anularDB(ro_empleado_x_Proyeccion_Gastos_Personales_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_Proyeccion_Gastos_Personales Entity = Context.ro_empleado_x_Proyeccion_Gastos_Personales.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.AnioFiscal==info.AnioFiscal);
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
