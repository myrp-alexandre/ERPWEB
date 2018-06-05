using Core.Erp.Data.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.ActivoFijo
{
    public class ACTF_005_Bus
    {
        ACTF_005_Data odata = new ACTF_005_Data();
    
        public List<ACTF_005_Info> get_list(int IdEmpresa, int IdActivoFijoTipo, int IdCategoriaAF, DateTime fecha_corte, string Estado_Proceso)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdActivoFijoTipo, IdCategoriaAF, fecha_corte, Estado_Proceso);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
