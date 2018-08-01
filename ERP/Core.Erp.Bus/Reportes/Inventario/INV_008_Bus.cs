using Core.Erp.Data.Reportes.Inventario;
using Core.Erp.Info.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Inventario
{
    public class INV_008_Bus
    {
        INV_008_Data odata = new INV_008_Data();
        public List<INV_008_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, bool mostrar_saldos_en_0, List<in_Producto_Info> lst_producto)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, IdBodega, mostrar_saldos_en_0, lst_producto);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
