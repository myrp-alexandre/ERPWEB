using Core.Erp.Data.Facturacion;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Facturacion
{
    public class fa_formaPago_Bus
    {
        fa_formaPago_Data odata = new fa_formaPago_Data();
    
        public List<fa_formaPago_Info> get_list()
        {
            try
            {
                return odata.get_list();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
