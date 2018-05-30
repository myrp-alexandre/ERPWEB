using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.General;
using Core.Erp.Data.General;
namespace Core.Erp.Bus.General
{
   public class tb_ciudad_Bus
    {
        tb_ciudad_Data odata = new tb_ciudad_Data();
        public List<tb_ciudad_Info> get_list(bool mostrar_anulados)
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
        public List<tb_ciudad_Info> get_list(string IdProvincia)
        {
            try
            {
                return odata.get_list(IdProvincia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public tb_ciudad_Info get_info(string IdProvincia,string IdCiudad)
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

        public bool guardarDB(tb_ciudad_Info info)
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

        public bool modificarDB(tb_ciudad_Info info)
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

        public bool anularDB(tb_ciudad_Info info)
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
