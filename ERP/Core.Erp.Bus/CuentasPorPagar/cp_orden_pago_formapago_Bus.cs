using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_orden_pago_formapago_Bus
    {
        cp_orden_pago_formapago_Data data = new cp_orden_pago_formapago_Data();
        public List<cp_orden_pago_formapago_Info> get_list()
        {
            return data.get_list();
        }
        }
}
