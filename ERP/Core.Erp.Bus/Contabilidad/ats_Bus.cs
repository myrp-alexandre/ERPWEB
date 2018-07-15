using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Contabilidad.ATS.ATS_Info;
using Core.Erp.Data.Contabilidad;
namespace Core.Erp.Bus.Contabilidad
{
  public  class ats_Bus
    {
        ats_Data odata = new ats_Data();
        public ats_Info get_info(int IdEmpresa, int IdPeriodo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdPeriodo); 
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
