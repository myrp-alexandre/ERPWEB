using Core.Erp.Data.Reportes.CuentasPorPagar;
using Core.Erp.Info.Reportes.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.CuentasPorPagar
{
   public class CXP_006_diario_Bus
    {
        CXP_006_diario_Data odata = new CXP_006_diario_Data();

        public List<CXP_006_diario_Info> get_list(int IdEmpresa, decimal IdRetencion)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdRetencion);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
