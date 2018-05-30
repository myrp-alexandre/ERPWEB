using Core.Erp.Data.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.ActivoFijo
{
   public class VWACTF_001_Bus
    {
        VWACTF_001_Data odata = new VWACTF_001_Data();
        public List<VWACTF_001_Info> get_list(int IdEmpresa, decimal Id_Mejora_Baja_Activo, string Id_Tipo)
        {
            try
            {
                return odata.get_list(IdEmpresa , Id_Mejora_Baja_Activo, Id_Tipo);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
