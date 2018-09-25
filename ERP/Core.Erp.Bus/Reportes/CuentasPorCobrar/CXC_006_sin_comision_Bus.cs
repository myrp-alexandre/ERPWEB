using Core.Erp.Data.Reportes.CuentasPorCobrar;
using Core.Erp.Info.Reportes.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.CuentasPorCobrar
{
   public class CXC_006_sin_comision_Bus
    {
        CXC_006_sin_comision_Data odata = new CXC_006_sin_comision_Data();
        public List<CXC_006_sin_comision_Info> get_list(int IdEmpresa, decimal IdLiquidacion)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdLiquidacion);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
