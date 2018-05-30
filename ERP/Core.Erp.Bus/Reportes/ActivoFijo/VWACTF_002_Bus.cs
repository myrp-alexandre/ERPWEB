using Core.Erp.Data.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.ActivoFijo
{
   public class VWACTF_002_Bus
    {
        VWACTF_002_Data odata = new VWACTF_002_Data();
    
        public List<VWACTF_002_Info> get_list(int IdEmpresa, decimal IdVtaActivo)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdVtaActivo);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
