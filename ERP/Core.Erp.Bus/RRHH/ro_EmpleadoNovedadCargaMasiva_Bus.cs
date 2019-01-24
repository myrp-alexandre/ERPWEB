using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_EmpleadoNovedadCargaMasiva_Bus
    {
        ro_EmpleadoNovedadCargaMasiva_Data odata = new ro_EmpleadoNovedadCargaMasiva_Data();
        public List<ro_EmpleadoNovedadCargaMasiva_Info> get_list(int IdEmpresa, DateTime FechaInicio, DateTime FechaFin, int IdSucursal, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa, FechaInicio, FechaFin, IdSucursal);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool GuardarDB(ro_EmpleadoNovedadCargaMasiva_Info info)
        {
            try
            {
                return odata.GuardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool AnularDB(ro_EmpleadoNovedadCargaMasiva_Info info)
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


        public ro_EmpleadoNovedadCargaMasiva_Info get_info(int IdEmpresa, decimal IdCarga)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdCarga);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
