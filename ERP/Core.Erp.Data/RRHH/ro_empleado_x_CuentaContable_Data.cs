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
    }
}
