using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito_Data
    {
        public List<ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito_Info> get_list(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                List<ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito_Info> Lista;

                using (Entities_banco Context = new Entities_banco())
                {
                    Lista = (from q in Context.ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito
                             where q.mba_IdEmpresa == IdEmpresa
                             && q.mba_IdTipocbte == IdTipoCbte
                             && q.mba_IdCbteCble == IdCbteCble
                             select new ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito_Info
                             {
                                 mcj_IdEmpresa = q.mcj_IdEmpresa,
                                 mcj_IdCbteCble = q.mcj_IdCbteCble,
                                 mcj_IdTipocbte = q.mcj_IdTipocbte,
                                 mba_IdEmpresa = q.mba_IdEmpresa,
                                 mba_IdCbteCble = q.mba_IdCbteCble,
                                 mba_IdTipocbte = q.mba_IdTipocbte,
                                 mcj_Secuencia = q.mcj_Secuencia,
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
