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
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.fa_factura
                             where q.IdEmpresa == IdEmpresa
                             select new fa_factura_Info
                             {

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
