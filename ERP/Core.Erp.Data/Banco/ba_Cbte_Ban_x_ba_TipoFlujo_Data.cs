using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
   public class ba_Cbte_Ban_x_ba_TipoFlujo_Data
    {
        public List<ba_Cbte_Ban_x_ba_TipoFlujo_Info> GetList(int IdEmpresa, decimal IdTipoFlujo)
        {
            try
            {
                List<ba_Cbte_Ban_x_ba_TipoFlujo_Info> Lista;
                using (Entities_banco Context = new Entities_banco())
                {
                    Lista = Context.ba_Cbte_Ban_x_ba_TipoFlujo.Where(q => q.IdEmpresa == IdEmpresa
                    && q.IdTipoFlujo == IdTipoFlujo).Select(q => new ba_Cbte_Ban_x_ba_TipoFlujo_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdTipoFlujo = q.IdTipoFlujo,
                        IdTipocbte = q.IdTipocbte,
                        IdCbteCble = q.IdCbteCble,
                        Porcentaje = q.Porcentaje,
                        Secuencia = q.Secuencia,
                        Valor = q.Valor
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
