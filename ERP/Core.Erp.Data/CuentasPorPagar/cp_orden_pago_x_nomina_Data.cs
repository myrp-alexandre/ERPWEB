using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Info.RRHH;

namespace Core.Erp.Data.CuentasPorPagar
{
  public  class cp_orden_pago_x_nomina_Data
    {
        public bool guardarDB(List< cp_orden_pago_x_nomina_Info> lsta, ro_rol_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                   // var lst_delete = Context.cp_orden_pago_x_nomina.Where(v => v.IdEmpresa == info.IdEmpresa && v.IdNominaTipo == info.IdNomina_Tipo && v.IdNominaTipoLiqui == info.IdNomina_TipoLiqui && v.IdPeriodo == info.IdPeriodo);
                    foreach (var item in lsta)
                    {
                        cp_orden_pago_x_nomina Entity = new cp_orden_pago_x_nomina
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdNominaTipo = item.IdNominaTipo,
                            IdNominaTipoLiqui = item.IdNominaTipoLiqui,
                            IdEmpleado=item.IdEmpleado,
                            IdPeriodo = item.IdPeriodo,
                            IdRubro = "950",
                            IdEmpresa_op = item.IdEmpresa_op,
                            IdOrdenPago = item.IdOrdenPago
                        };
                        Context.cp_orden_pago_x_nomina.Add(Entity);
                    }
                    Context.SaveChanges();

                }


                return true;
            }
            catch (Exception e)
            {
                throw;
            }
        }

    }
}
