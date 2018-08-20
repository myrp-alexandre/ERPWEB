using Core.Erp.Data.Reportes.CuentasPorCobrar;
using Core.Erp.Info.Reportes.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.CuentasPorCobrar
{
    public class CXC_004_Bus
    {
        CXC_004_Data odata = new CXC_004_Data();
        public List<CXC_004_Info> get_list(int IdEmpresa, decimal IdCliente, int IdContacto, DateTime fecha_corte, string Estado)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdCliente, IdContacto, fecha_corte, Estado);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
