using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.RRHH
{
  public  class ro_NominasPagosCheques_det_Bus
    {
        ro_NominasPagosCheques_det_Data odata = new ro_NominasPagosCheques_det_Data();
        public List<ro_NominasPagosCheques_det_Info> get_lis(int IdEmpresa, decimal IdTransaccion)
        {
            try
            {
                return odata.get_lis(IdEmpresa, IdTransaccion);
            }
            catch (Exception)
            {

                throw;
            }
        }
        }
}
