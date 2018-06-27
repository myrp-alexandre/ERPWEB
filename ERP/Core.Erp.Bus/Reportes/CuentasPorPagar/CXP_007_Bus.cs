using Core.Erp.Data.Reportes.CuentasPorPagar;
using Core.Erp.Info.Reportes.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.CuentasPorPagar
{
    public class CXP_007_Bus
    {
        CXP_007_Data odata = new CXP_007_Data();
    
        public List<CXP_007_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin, bool Mostrar_agrupado)
        {
            try
            {
                return odata.get_list(IdEmpresa, Fecha_ini, Fecha_fin, Mostrar_agrupado);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
