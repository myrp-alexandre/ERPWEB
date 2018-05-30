using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_empleado_novedad_det_Bus
    {
        ro_empleado_novedad_det_Data odata = new ro_empleado_novedad_det_Data();
        public List<ro_empleado_novedad_det_Info> get_list(int IdEmpresa, decimal IdEmpleado, decimal IdNovedad)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdEmpleado,IdNovedad);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_novedad_det_Info get_info(int IdEmpresa, decimal IdEmpleado, decimal IdNovedad, int Secuencia)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado,IdNovedad,Secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_empleado_novedad_det_Info> info)
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
        public bool anularDB(ro_empleado_novedad_Info info)
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

        public List<ro_empleado_novedad_det_Info> get_list_nov_liq_empleado(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                return odata.get_list_nov_liq_empleado(IdEmpresa, IdEmpleado);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
