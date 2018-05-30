using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
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
        }
}
