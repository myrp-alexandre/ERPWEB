using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_orden_pago_cancelaciones_Bus
    {
        cp_orden_pago_cancelaciones_Data odata = new cp_orden_pago_cancelaciones_Data();
        public Boolean guardarDB(cp_orden_pago_cancelaciones_Info Info)
        {
            try
            {
                return odata.guardarDB(Info);
            }
            catch (Exception)
            {

                throw;
            }

        }

        public List<cp_orden_pago_cancelaciones_Info> Get_list_Cancelacion_x_CXP(int IdEmpresa_cxp, int IdTipoCbte_cxp, decimal IdCbteCble_cxp)
        {
            try
            {
                return odata.Get_list_Cancelacion_x_CXP(IdEmpresa_cxp, IdTipoCbte_cxp, IdCbteCble_cxp);
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
    }
