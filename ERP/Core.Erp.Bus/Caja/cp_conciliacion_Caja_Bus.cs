using Core.Erp.Data.Caja;
using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Caja
{
    public class cp_conciliacion_Caja_Bus
    {
        cp_conciliacion_Caja_Data odata = new cp_conciliacion_Caja_Data();

        public List<cp_conciliacion_Caja_Info> get_list(int IdEmpresa, int IdCaja, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdCaja, Fecha_ini, Fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cp_conciliacion_Caja_Info get_info(int IdEmpresa, decimal IdConciliacion_caja)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdConciliacion_caja);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(cp_conciliacion_Caja_Info info)
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

        public bool modificarDB(cp_conciliacion_Caja_Info info)
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
    }
}
