using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
  public  class ro_Acta_Finiquito_Bus
    {
        ro_Acta_Finiquito_Data odata = new ro_Acta_Finiquito_Data();
        public List<ro_Acta_Finiquito_Info> get_list(int IdEmpresa, bool estado)
        {
            try
            {
                return odata.get_list(IdEmpresa, estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_Acta_Finiquito_Info get_info(int IdEmpresa, decimal IdEmpleado , decimal IdActaFiniquito)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado, IdActaFiniquito);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_Acta_Finiquito_Info info)
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

        public bool modificarDB(ro_Acta_Finiquito_Info info)
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

        public bool anularDB(ro_Acta_Finiquito_Info info)
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

