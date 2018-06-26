using Core.Erp.Data.Caja;
using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Caja
{
    public class cp_conciliacion_Caja_det_Ing_Caja_Bus
    {
        cp_conciliacion_Caja_det_Ing_Caja_Data odata = new cp_conciliacion_Caja_det_Ing_Caja_Data();

        public List<cp_conciliacion_Caja_det_Ing_Caja_Info> get_list(int IdEmpresa, decimal IdConciliacion_caja)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdConciliacion_caja);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
