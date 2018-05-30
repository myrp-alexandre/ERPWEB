using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_area_Bus
    {
        ro_area_Data odata = new ro_area_Data();
        public List<ro_area_Info> get_list(int IdEmpresa, bool estado)
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
        public List<ro_area_Info> get_list(int IdEmpresa, int IdDivision)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdDivision);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_area_Info get_info(int IdEmpresa, int IdArea)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdArea);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_area_Info info)
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

        public bool modificarDB(ro_area_Info info)
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

        public bool anularDB(ro_area_Info info)
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
