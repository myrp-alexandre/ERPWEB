using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_orden_pago_Bus
    {
        cp_orden_pago_Data oData = new cp_orden_pago_Data();

        public List<cp_orden_pago_Info> get_list(int IdEmpresa)
        {
            try
            {
                return oData.get_list(IdEmpresa);
            }
            catch (Exception)
            {
                throw;
            }
        }

      
        public cp_orden_pago_Info get_info(int IdEmpresa, decimal IdOrdenPago)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdOrdenPago);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean GuardarDB(cp_orden_pago_Info info)
        {
            try
            {
                return oData.guardarDB(info);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean ModificarDB(cp_orden_pago_Info info)
        {
            try
            {
                return oData.modificarDB(info);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean AnularDB(cp_orden_pago_Info info)
        {
            try
            {
                return oData.anularDB(info);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
