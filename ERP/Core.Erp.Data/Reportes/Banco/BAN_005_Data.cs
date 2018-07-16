using Core.Erp.Info.Reportes.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Banco
{
    public class BAN_005_Data
    {
        public List<BAN_005_Info> get_list(int IdEmpresa, int IdTipocbte, decimal IdCbteCble)
        {
            try
            {
                List<BAN_005_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWBAN_005
                             where q.IdEmpresa == IdEmpresa
                             && q.IdTipocbte == IdTipocbte
                             && q.IdCbteCble == IdCbteCble
                             select new BAN_005_Info
                             {

                                 IdEmpresa = q.IdEmpresa,
                                 IdTipocbte = q.IdTipocbte,
                                 IdCbteCble = q.IdCbteCble,
                                 cb_Fecha = q.cb_Fecha,
                                 cb_giradoA = q.cb_giradoA,
                                 cb_Valor  = q.cb_Valor,
                                 Descripcion_Ciudad = q.Descripcion_Ciudad,
                                 ValorEnLetras = q.ValorEnLetras
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
