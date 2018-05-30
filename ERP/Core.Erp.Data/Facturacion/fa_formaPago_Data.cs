using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_formaPago_Data
    {
        public List<fa_formaPago_Info> get_list()
        {
            try
            {
                List<fa_formaPago_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.fa_formaPago
                             select new fa_formaPago_Info
                             {
                                 IdFormaPago = q.IdFormaPago,
                                 nom_FormaPago = q.nom_FormaPago
                             
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
