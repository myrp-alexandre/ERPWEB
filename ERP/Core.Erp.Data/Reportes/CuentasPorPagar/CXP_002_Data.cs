using Core.Erp.Info.Reportes.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.CuentasPorPagar
{ 
 public class CXP_002_Data
    {
    public List<CXP_002_Info> get_list( int IdEmpresa_Ogiro, int IdTipoCbte_Ogiro, decimal IdCbteCble_Ogiro)
        {
            try
            {
                List<CXP_002_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWCXP_002
                             where q.IdEmpresa_Ogiro == IdEmpresa_Ogiro
                             && q.IdTipoCbte_Ogiro == IdTipoCbte_Ogiro
                             && q.IdCbteCble_Ogiro == IdCbteCble_Ogiro
                             select new CXP_002_Info
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
