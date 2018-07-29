using Core.Erp.Data.Facturacion;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Facturacion
{
  public  class fa_guia_remision_det_Bus
    {
        fa_guia_remision_det_Data odata = new fa_guia_remision_det_Data();

        public List<fa_guia_remision_det_Info> get_list(int IdEmpresa, decimal IdOrdencompraext)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdOrdencompraext);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
