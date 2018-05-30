using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_Solicitud_Vacaciones_x_empleado_Bus
    {

        ro_Solicitud_Vacaciones_x_empleado_Data odata = new ro_Solicitud_Vacaciones_x_empleado_Data();
        public List<ro_Solicitud_Vacaciones_x_empleado_Info> get_list(int IdEmpresa, bool estado)
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
        public ro_Solicitud_Vacaciones_x_empleado_Info get_info(int IdEmpresa, int IdCargo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdCargo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_Solicitud_Vacaciones_x_empleado_Info info)
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
        public bool modificarDB(ro_Solicitud_Vacaciones_x_empleado_Info info)
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
        public bool anularDB(ro_Solicitud_Vacaciones_x_empleado_Info info)
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
