using Core.Erp.Data.Reportes.Facturacion;
using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Facturacion
{
    public class FAC_002_Bus
    {
        FAC_002_Data odata = new FAC_002_Data();
    
        public List<FAC_002_Info> get_list(int IdEmpresa, int IdSucursal, decimal IdCliente, int IdClienteContacto, DateTime fechaCorte)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, IdCliente, IdClienteContacto, fechaCorte);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
