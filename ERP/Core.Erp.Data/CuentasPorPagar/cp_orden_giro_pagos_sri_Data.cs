using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_orden_giro_pagos_sri_Data
    {
        public List<cp_orden_giro_pagos_sri_Info> Get_list_cuotas_x_doc_det(int IdEmpresa, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {
                List<cp_orden_giro_pagos_sri_Info> Lista;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.cp_orden_giro_pagos_sri
                             where q.IdEmpresa == IdEmpresa
                             && q.IdTipoCbte_Ogiro == IdTipoCbte_Ogiro
                             && q.IdCbteCble_Ogiro==IdCbteCble_Ogiro
                             select new cp_orden_giro_pagos_sri_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipoCbte_Ogiro = q.IdTipoCbte_Ogiro,
                                 IdCbteCble_Ogiro = q.IdCbteCble_Ogiro,
                                 codigo_pago_sri = q.codigo_pago_sri,
                                 formas_pago_sri = q.formas_pago_sri
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool EliminarDB(int IdEmpresa, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    string comando = "delete cp_orden_giro_pagos_sri where IdEmpresa = " + IdEmpresa + " and IdTipoCbte_Ogiro = '"+ IdTipoCbte_Ogiro + "' and IdCbteCble_Ogiro='"+ IdCbteCble_Ogiro + "'";
                    Context.Database.ExecuteSqlCommand(comando);
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarDB(List<cp_orden_giro_pagos_sri_Info> Lista)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    foreach (var item in Lista)
                    {
                        cp_orden_giro_pagos_sri Entity = new cp_orden_giro_pagos_sri
                        {
                         IdEmpresa = item.IdEmpresa,
                        IdTipoCbte_Ogiro = item.IdTipoCbte_Ogiro,
                        IdCbteCble_Ogiro = item.IdCbteCble_Ogiro,
                        codigo_pago_sri = item.codigo_pago_sri,
                        formas_pago_sri = item.formas_pago_sri,
                        };
                        Context.cp_orden_giro_pagos_sri.Add(Entity);
                    }
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}
