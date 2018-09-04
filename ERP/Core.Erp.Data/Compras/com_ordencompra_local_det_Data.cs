using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Compras
{
   public class com_ordencompra_local_det_Data
    {
        public List<com_ordencompra_local_det_Info> get_list(int IdEmpresa, int IdSucursal, decimal IdOrdenCompra, int Secuencia)
        {
            try
            {
                List<com_ordencompra_local_det_Info> Lista;
                using (Entities_compras Context = new Entities_compras())
                {
                    Lista = (from q in Context.com_ordencompra_local_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdOrdenCompra == IdOrdenCompra
                             && q.Secuencia == Secuencia
                             select new com_ordencompra_local_det_Info
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
