using Core.Erp.Data.Reportes.Caja;
using Core.Erp.Info.Reportes.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Caja
{
    public class VWCAJ_001_Bus
    {
        VWCAJ_001_Data odata = new VWCAJ_001_Data();
    
        public List<VWCAJ_001_Info> get_list(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
