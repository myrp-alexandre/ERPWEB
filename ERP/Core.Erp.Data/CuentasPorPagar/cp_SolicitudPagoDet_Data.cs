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
        public List<cp_SolicitudPago_Info> GetListPorPagar(int IdEmpresa, int IdSucursal)

        {
            try
            {
                List<cp_SolicitudPago_Info> Lista;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.vwcp_orden_giro_x_pagar
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.Saldo_OG > 0
                             orderby q.co_fechaOg descending
                             select new cp_SolicitudPago_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdProveedor = q.IdProveedor,
                                 Fecha = q.co_fechaOg,
                                 Concepto = q.co_observacion,
                                 Valor = q.co_valorpagar,
                                 info_proveedor = new cp_proveedor_Info
                                 {
                                     IdPersona = q.IdPersona,
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         pe_razonSocial = q.nom_proveedor,
                                         IdPersona = q.IdPersona,
                                         pe_nombreCompleto = q.nom_proveedor
                                     }
                                 },

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
