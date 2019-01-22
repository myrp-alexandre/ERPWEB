using Core.Erp.Data.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.CuentasPorCobrar
{
    public class cxc_LiquidacionTarjeta_x_cxc_cobro_Bus
    {
        cxc_LiquidacionTarjeta_x_cxc_cobro_Data odata = new cxc_LiquidacionTarjeta_x_cxc_cobro_Data();
        public List<cxc_LiquidacionTarjeta_x_cxc_cobro_Info> get_list_cobros_pendientes(int IdEmpresa, int IdSucursal)
        {
            try
            {
                return odata.get_list_cobros_pendientes(IdEmpresa, IdSucursal);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
