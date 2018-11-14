using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.RRHH
{
   public class ro_archivos_bancos_generacion_x_empleado_Bus
    {
        ro_archivos_bancos_generacion_x_empleado_Data odata = new ro_archivos_bancos_generacion_x_empleado_Data();
        public List<ro_archivos_bancos_generacion_x_empleado_Info> get_list(int IdEmpresa, decimal IdArchivo)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdArchivo);
            }
            catch (Exception)
            {

                throw;
            }
        }

     
        public bool guardarDB(List<ro_archivos_bancos_generacion_x_empleado_Info> lista)
        {
            try
            {
                return odata.guardarDB(lista);
            }
            catch (Exception)
            {

                throw;
            }
        }

       

        public bool anularDB(ro_archivos_bancos_generacion_Info info)
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
