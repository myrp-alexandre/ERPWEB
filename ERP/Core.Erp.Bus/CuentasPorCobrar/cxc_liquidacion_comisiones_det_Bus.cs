using Core.Erp.Data.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.CuentasPorCobrar
{
  public  class cxc_liquidacion_comisiones_det_Bus
    {
        cxc_liquidacion_comisiones_det_Data odata = new cxc_liquidacion_comisiones_det_Data();
        public List<cxc_liquidacion_comisiones_det_Info> get_list(int IdEmpresa, decimal IdLiquidacion)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdLiquidacion);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<cxc_liquidacion_comisiones_det_Info> get_list_x_liquidar(int IdEmpresa, int IdVendedor)
        {
            try
            {
                return odata.get_list_x_liquidar(IdEmpresa, IdVendedor);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
