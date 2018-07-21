using Core.Erp.Data.Reportes.CuentasPorPagar;
using Core.Erp.Info.Reportes.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.CuentasPorPagar
{
    public class CXP_009_Bus
    {
        CXP_009_Data odata = new CXP_009_Data();
        public List<CXP_009_Info> get_list(int IdEmpresa, DateTime FechaIni, DateTime FechaFin, ref List<CXP_009_resumen_Info> lst_resumen)
        {
            try
            {
                return odata.get_list(IdEmpresa, FechaIni, FechaFin, ref lst_resumen);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
