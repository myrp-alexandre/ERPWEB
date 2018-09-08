using Core.Erp.Data.Reportes.Facturacion;
using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Facturacion
{
    public class FAC_010_Bus
    {
        FAC_010_Data odata = new FAC_010_Data();
        public List<FAC_010_Info> get_list(int IdEmpresa, decimal IdProducto, string IdCategoria, int IdLinea, int IdGrupo, int IdSubGrupo, int IdMarca)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdProducto, IdCategoria, IdLinea, IdGrupo, IdSubGrupo, IdMarca);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
