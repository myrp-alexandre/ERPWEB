using Core.Erp.Data.Reportes.Inventario;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Inventario
{
    public class INV_012_Bus
    {
        INV_012_Data odata = new INV_012_Data();
        public List<INV_012_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdProducto, int IdMarca, DateTime? fechaIni, int dIAS)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, IdBodega, IdProducto, IdMarca, fechaIni, dIAS);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
