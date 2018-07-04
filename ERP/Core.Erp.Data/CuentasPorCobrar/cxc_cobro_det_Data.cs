using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
    public class cxc_cobro_det_Data
    {
        public List<cxc_cobro_det_Info> get_list_cartera(int IdEmpresa, int IdSucursal, decimal IdCliente)
        {
            try
            {
                List<cxc_cobro_det_Info> Lista;

                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    Lista = (from q in Context.vwcxc_cartera_x_cobrar
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdCliente == IdCliente
                             && q.Saldo > 0
                             && q.Estado == "A"
                             select new cxc_cobro_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega_Cbte = q.IdBodega,
                                 dc_TipoDocumento = q.vt_tipoDoc,
                                 vt_NumDocumento = q.vt_NunDocumento,
                                 Observacion = q.Referencia,
                                 IdCbte_vta_nota = q.IdComprobante,
                                 vt_fecha = q.vt_fecha,
                                 vt_total = q.vt_total,
                                 Saldo = q.Saldo,                                 
                                 vt_Subtotal = q.vt_Subtotal,
                                 vt_iva = q.vt_iva,
                                 vt_fech_venc = q.vt_fech_venc,
                                 dc_ValorRetFu = q.dc_ValorRetFu,
                                 dc_ValorRetIva = q.dc_ValorRetIva,
                             }).ToList();

                    Lista.ForEach(q => q.secuencia = q.dc_TipoDocumento + q.IdCbte_vta_nota.ToString());
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
