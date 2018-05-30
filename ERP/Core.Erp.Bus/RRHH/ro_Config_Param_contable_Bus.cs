using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_Config_Param_contable_Bus
    {
        ro_Config_Param_contable_Data odata = new ro_Config_Param_contable_Data();
        public List<ro_Config_Param_contable_Info> get_list(int IdEmpresa)
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
        public ro_Config_Param_contable_Info get_info(int IdEmpresa, int IdDivision, int IdArea, int IdDepartamento, string IdRubro)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdDivision, IdArea, IdDepartamento,IdRubro);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_Config_Param_contable_Info> info)
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
