using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Inventario
{
    public class in_devolucion_inven_Bus
    {
        in_devolucion_inven_Data odata = new in_devolucion_inven_Data();
        public List<in_devolucion_inven_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, Fecha_ini, Fecha_fin);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
