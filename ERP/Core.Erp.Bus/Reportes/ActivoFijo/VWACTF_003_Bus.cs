using Core.Erp.Data.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.ActivoFijo
{
    public class VWACTF_003_Bus
    {
        VWACTF_003_Data odata = new VWACTF_003_Data();

        public List<VWACTF_003_Info> get_list(int IdEmpresa, decimal IdRetiroActivo)

        {
            try
            {
                return odata.get_list(IdEmpresa, IdRetiroActivo);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
