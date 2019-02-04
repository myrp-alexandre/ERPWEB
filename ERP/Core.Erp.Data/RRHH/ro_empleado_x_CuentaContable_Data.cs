using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
    public class ro_empleado_x_CuentaContable_Data
    {
        
        public List<ro_empleado_x_CuentaContable_Info> GetList(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                List<ro_empleado_x_CuentaContable_Info> Lista;
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = Context.ro_empleado_x_CuentaContable.Where(q => q.IdEmpresa == IdEmpresa
                    && q.IdEmpleado == IdEmpleado
                    ).Select(q =>
                      new ro_empleado_x_CuentaContable_Info
                      {
                          IdEmpresa = q.IdEmpresa,
                          IdEmpleado = q.IdEmpleado,
                          IdCuentacon = q.IdCuentacon,
                          IdRubro = q.IdRubro,
                          Observacion= q.Observacion,
                          Secuencia = q.Secuencia
                      }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_empleado_x_CuentaContable_Info GetInfo(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                ro_empleado_x_CuentaContable_Info info = new ro_empleado_x_CuentaContable_Info();
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_x_CuentaContable Entity = Context.ro_empleado_x_CuentaContable.Where(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado).FirstOrDefault();
                    if (Entity == null) return null;

                    info = new ro_empleado_x_CuentaContable_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        IdCuentacon = Entity.IdCuentacon,
                        IdRubro = Entity.IdRubro,
                        Observacion = Entity.Observacion,
                        Secuencia = Entity.Secuencia
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool GuardarDB(int IdEmpresa, decimal IdEmpleado, List<ro_empleado_x_CuentaContable_Info> info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var list = Context.ro_empleado_x_CuentaContable.Where(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado).ToList();
                    Context.ro_empleado_x_CuentaContable.RemoveRange(list);
                    
                    if(info.Count()>0)
                    {
                        int Secuencia = 1;
                        foreach (var item in info)
                        {
                            Context.ro_empleado_x_CuentaContable.Add(new ro_empleado_x_CuentaContable
                            {
                                IdEmpresa = IdEmpresa,
                                IdEmpleado = IdEmpleado,
                                IdCuentacon = item.IdCuentacon,
                                IdRubro = item.IdRubro,
                                Observacion = item.Observacion,
                                Secuencia = Secuencia++
                            });
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
    }
}
