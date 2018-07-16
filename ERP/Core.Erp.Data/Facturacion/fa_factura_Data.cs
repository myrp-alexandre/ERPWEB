using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
   public class fa_factura_Data
    {
        public List<fa_factura_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<fa_factura_Info> Lista;
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
