using Core.Erp.Data.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.ActivoFijo
{
    public class ACTF_004_resumen_Bus
    {
        ACTF_004_resumen_Data odata = new ACTF_004_resumen_Data();
    
        public List<ACTF_004_resumen_Info> get_list(int IdEmpresa, DateTime fecha_corte)
        {
            try
            {
                return odata.get_list(IdEmpresa, fecha_corte);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
