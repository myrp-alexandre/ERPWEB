using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_area_x_departamento_Bus
    {
        ro_area_x_departamento_Data odata = new ro_area_x_departamento_Data();
        public List<ro_area_x_departamento_Info> get_list(int IdEmpresa)
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

        public ro_area_x_departamento_Info get_info(int IdEmpresa, int Secuencia)
        {
            try
            {
                return odata.get_info(IdEmpresa, Secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_area_x_departamento_Info info)
        {
            try
            {
                if (odata.si_existe(info.IdEmpresa, info.IdDivision, info.IdArea, info.IdDepartamento))
                    return odata.modificarDB(info);
                else
                    return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(ro_area_x_departamento_Info info)
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

        public bool anularDB(ro_area_x_departamento_Info info)
        {
            try
            {

                return odata.AnularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
