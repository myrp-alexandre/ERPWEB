using Core.Erp.Data.Reportes.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Inventario
{
    public class VWINV_002_Bus
    {
        VWINV_002_Data odata = new VWINV_002_Data();

        public List<VWINV_002_Info> get_list(int IdEmpresa, int idSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)

        {
            try
            {
                return odata.get_list(IdEmpresa, idSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
