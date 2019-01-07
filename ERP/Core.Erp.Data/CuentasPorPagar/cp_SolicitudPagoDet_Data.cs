using Core.Erp.Info.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorPagar
{
    public class cp_SolicitudPagoDet_Data
    {
        public List<cp_SolicitudPagoDet_Info> GetListPorPagar(int IdEmpresa, int IdSucursal)

        {
            try
            {
                List<cp_SolicitudPagoDet_Info> Lista;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.vwcp_orden_giro_x_pagar
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.Saldo_OG > 0
                             orderby q.co_fechaOg descending
                             select new cp_SolicitudPagoDet_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 TipoDocumento = q.cod_Documento,
                                 ValorAPagar = q.co_valorpagar

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
