using Core.Erp.Data.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.ActivoFijo
{
    public class Af_Depreciacion_Bus
    {
        Af_Depreciacion_Data odata = new Af_Depreciacion_Data();

        public List<Af_Depreciacion_Info> get_list(int IdEmpresa, bool mostrar_anulados, DateTime Fecha_ini, DateTime Fecha_fin)

        {
            try
            {
                return odata.get_list(IdEmpresa, mostrar_anulados, Fecha_ini, Fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Af_Depreciacion_Info get_info(int IdEmpresa, decimal IdDepreciacion)
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

        public bool guardarDB(Af_Depreciacion_Info info)
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

        public bool modificarDB(Af_Depreciacion_Info info)
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

        public bool anularDB(Af_Depreciacion_Info info)
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
