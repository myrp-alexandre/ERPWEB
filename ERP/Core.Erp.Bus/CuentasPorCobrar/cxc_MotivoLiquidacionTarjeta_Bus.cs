using Core.Erp.Data.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.CuentasPorCobrar
{
    public class cxc_MotivoLiquidacionTarjeta_Bus
    {
        cxc_MotivoLiquidacionTarjeta_Data odata = new cxc_MotivoLiquidacionTarjeta_Data();
        public List<cxc_MotivoLiquidacionTarjeta_Info> GetList(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.GetList(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public cxc_MotivoLiquidacionTarjeta_Info GEtInfo(int IdEmpresa, decimal IdMotivo)
        {
            try
            {
                return odata.GEtInfo(IdEmpresa, IdMotivo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool GuardarDB(cxc_MotivoLiquidacionTarjeta_Info info)
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
        public bool ModificarDB(cxc_MotivoLiquidacionTarjeta_Info info)
        {
            try
            {
                return odata.ModificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool AnularDB(cxc_MotivoLiquidacionTarjeta_Info info)
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

    }
}
