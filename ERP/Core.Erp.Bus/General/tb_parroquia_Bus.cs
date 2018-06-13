using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.General
{
    public class tb_parroquia_Bus
    {
        tb_parroquia_Data odata = new tb_parroquia_Data();
        public List<tb_parroquia_Info> get_list(bool mostrar_anulados, string IdCiudad)
        {
            try
            {
                return odata.get_list(mostrar_anulados, IdCiudad);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<tb_parroquia_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }



        public tb_parroquia_Info get_info(string IdProvincia, string IdCiudad)
        {
            try
            {
                return odata.get_info(IdProvincia, IdCiudad);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(tb_parroquia_Info info)
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

        public bool modificarDB(tb_parroquia_Info info)
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

        public bool anularDB(tb_parroquia_Info info)
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
