using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
  public  class ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Bus
    {
        ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Data odata = new ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Data();
        public List<ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info> get_list(int IdEmpresa)
        {
            try
            {
                return odata.get_list(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info get_info(int IdEmpresa, int IdNomina, int IdNominaTipo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdNomina, IdNominaTipo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info> info)
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
        public bool anularDB(int IdEmpresa)
        {
            try
            {
                return odata.eliminarDB(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
