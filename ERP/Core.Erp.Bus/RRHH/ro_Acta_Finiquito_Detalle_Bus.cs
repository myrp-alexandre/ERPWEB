using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_Acta_Finiquito_Detalle_Bus
    {
        ro_Acta_Finiquito_Detalle_Data odata = new ro_Acta_Finiquito_Detalle_Data();


        public List<ro_Acta_Finiquito_Detalle_Info> get_list(int IdEmpresa, decimal IdActaFiniquito)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdActaFiniquito);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_Acta_Finiquito_Detalle_Info get_info(int IdEmpresa, decimal IdEmpleado, decimal IdActaFiniquito, int Secuencia)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado, IdActaFiniquito, Secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_Acta_Finiquito_Detalle_Info> info)
        {
            try
            {
                return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_Acta_Finiquito_Info info)
        {
            try
            {
                return odata.eliminarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
      
    }
}
