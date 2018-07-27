using Core.Erp.Data.Reportes.Facturacion;
using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Facturacion
{
    public class FAC_008_cancelaciones_Bus
    {
        FAC_008_cancelaciones_Data odata = new FAC_008_cancelaciones_Data();
    
        public List<FAC_008_cancelaciones_Info> get_list(int IdEmpresa_nt, int IdSucursal_nt, int IdBodega_nt, decimal IdNota_nt, int secuencia)
        {
            try
            {
                return odata.get_list(IdEmpresa_nt, IdSucursal_nt, IdBodega_nt, IdNota_nt, secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
