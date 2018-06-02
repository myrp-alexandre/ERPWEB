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

        public List<Af_Depreciacion_Det_Info> get_list(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdDepreciacion);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<Af_Depreciacion_Det_Info> get_list_a_depreciar(int IdEmpresa, int IdPeriodo, string IdUsuario)
        {
            try
            {
                return odata.get_list_a_depreciar(IdEmpresa, IdPeriodo, IdUsuario);
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
