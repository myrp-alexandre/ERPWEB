using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_cliente_x_fa_Vendedor_x_sucursal_Data
    {
        public List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> get_list(int IdEmpresa , decimal IdCliente)
        {
            try
            {
                List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.fa_cliente_x_fa_Vendedor_x_sucursal
                             where q.IdEmpresa == IdEmpresa
                             && q.IdCliente == IdCliente
                             select new fa_cliente_x_fa_Vendedor_x_sucursal_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdCliente =q.IdCliente,
                                 IdSucursal = q.IdSucursal,
                                 IdVendedor = q.IdVendedor,
                                 observacion = q.observacion
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
