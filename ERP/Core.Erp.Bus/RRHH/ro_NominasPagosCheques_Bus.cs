using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.RRHH
{
   public class ro_NominasPagosCheques_Bus
    {
        ro_NominasPagosCheques_Data odata = new ro_NominasPagosCheques_Data();
        public List<ro_NominasPagosCheques_Info> get_list(int IdEmpresa, DateTime Fechainicio, DateTime fechafin, bool estado)
        {
            try
            {
                return odata.get_list(IdEmpresa, Fechainicio, fechafin, estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_NominasPagosCheques_Info get_info(int IdEmpresa, decimal IdArchivo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdArchivo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_NominasPagosCheques_Info info)
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

        public bool modificarDB(ro_NominasPagosCheques_Info info)
        {
            try
            {

                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ro_NominasPagosCheques_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        
    }
}
