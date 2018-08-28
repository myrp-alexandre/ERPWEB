using Core.Erp.Info.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorPagar
{
    public class cp_orden_giro_det_Data
    {
        public List<cp_orden_giro_det_Info> get_list(int IdEmpresa, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {
                List<cp_orden_giro_det_Info> Lista;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.cp_orden_giro_det
                             where q.IdEmpresa == IdEmpresa
                              && q.IdTipoCbte_Ogiro == IdTipoCbte_Ogiro
                              && q.IdCbteCble_Ogiro == IdCbteCble_Ogiro
                             select new cp_orden_giro_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdCbteCble_Ogiro = q.IdCbteCble_Ogiro,
                                 IdTipoCbte_Ogiro = q.IdTipoCbte_Ogiro,
                                 Secuencia = q.Secuencia,
                                 ing_IdEmpresa = q.ing_IdEmpresa,
                                 ing_IdSucursal = q.ing_IdSucursal,
                                 ing_IdMovi_inven_tipo = q.ing_IdMovi_inven_tipo,
                                 ing_IdNumMovi = q.ing_IdNumMovi,
                                 ing_Secuencia = q.ing_Secuencia,
                                 IdProducto = q.IdProducto,
                                 Cantidad = q.Cantidad,
                                 CostoUni = q.CostoUni,
                                 PorDescuento = q.PorDescuento,
                                 DescuentoUni = q.DescuentoUni,
                                 CostoUniFinal = q.CostoUniFinal,
                                 Subtotal = q.Subtotal,
                                 IdCod_Impuesto_Iva = q.IdCod_Impuesto_Iva,
                                 PorIva = q.PorIva,
                                 ValorIva = q.ValorIva,
                                 Total = q.Total,
                                 IdCtaCbleGasto = q.IdCtaCbleGasto
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
