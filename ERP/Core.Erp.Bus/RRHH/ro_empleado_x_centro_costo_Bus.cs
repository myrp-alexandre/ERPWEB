using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_empleado_x_centro_costo_Bus
    {
        ro_empleado_x_centro_costo_Data odata = new ro_empleado_x_centro_costo_Data();
        public List<ro_empleado_x_centro_costo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_x_centro_costo_Info get_info(int IdEmpresa, int IdEmpleado)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_empleado_x_centro_costo_Info info)
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
        public bool anularDB(ro_empleado_x_centro_costo_Info info)
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
