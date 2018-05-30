using Core.Erp.Data.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.ActivoFijo
{
    public class Af_Depreciacion_Det_Bus
    {
        Af_Depreciacion_Det_Data odata = new Af_Depreciacion_Det_Data();
    
        public Af_Depreciacion_Det_Info get_info(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdDepreciacion);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(Af_Depreciacion_Det_Info info)
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

        public bool eliminarDB(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                return odata.eliminarDB(IdEmpresa, IdDepreciacion);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
