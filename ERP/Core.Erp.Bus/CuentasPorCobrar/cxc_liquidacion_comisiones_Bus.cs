using Core.Erp.Data.CuentasPorCobrar;
using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.CuentasPorCobrar
{
   public  class cxc_liquidacion_comisiones_Bus
    {
        cxc_liquidacion_comisiones_Data odata = new cxc_liquidacion_comisiones_Data();
        public List<cxc_liquidacion_comisiones_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cxc_liquidacion_comisiones_Info get_info(int IdEmpresa, decimal IdLiquidacion)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdLiquidacion);
            }
            catch (Exception)
            {

                throw;
            }

        }

        public bool guardarDB(cxc_liquidacion_comisiones_Info info)
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

        public bool modificarDB(cxc_liquidacion_comisiones_Info info)
        {
            try
            {
                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }

        }

        public bool anularDB(cxc_liquidacion_comisiones_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}
