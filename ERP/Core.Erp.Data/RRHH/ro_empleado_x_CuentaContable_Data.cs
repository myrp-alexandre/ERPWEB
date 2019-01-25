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

        public bool GuardarDB(ro_empleado_x_CuentaContable_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    foreach (var item in info.lstdet)
                    {
                        Context.ro_empleado_x_CuentaContable.Add(new ro_empleado_x_CuentaContable
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdEmpleado = info.IdEmpleado,
                            IdCuentacon = info.IdCuentacon,
                            IdRubro = info.IdRubro,
                            Observacion = info.Observacion,
                            Secuencia = info.Secuencia
                        });
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
