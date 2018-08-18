using Core.Erp.Data.Reportes.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Inventario
{
   public class INV_009_Bus
    {
        INV_009_Data odata = new INV_009_Data();
        public List<INV_009_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, int IdMarca, decimal IdProducto_padre, DateTime fechaCorte)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, IdBodega, IdMarca, IdProducto_padre, fechaCorte);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
