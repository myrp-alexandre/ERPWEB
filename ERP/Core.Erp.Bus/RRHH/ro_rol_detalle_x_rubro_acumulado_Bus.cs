using Core.Erp.Data.RRHH;
using System;
namespace Core.Erp.Bus.RRHH
{
    public class ro_rol_detalle_x_rubro_acumulado_Bus
    {
        ro_rol_detalle_x_rubro_acumulado_Data odata = new ro_rol_detalle_x_rubro_acumulado_Data();
        public double get_valor_x_rubro_acumulado(int IdEmpresa, decimal IdEmpleado, string IdRubro)
        {
            try
            {
                return odata.get_valor_x_rubro_acumulado(IdEmpresa, IdEmpleado, IdRubro);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public double get_vac_x_mes_x_anio(int IdEmpresa, decimal IdEmpleado, int Anio, int mes)
        {
            try
            {
                return odata.get_vac_x_mes_x_anio(IdEmpresa, IdEmpleado, Anio, mes);
            }
            catch (Exception)
            {

                throw;
            }
        }
   }
}
