using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Contabilidad;
using System;
using System.Collections.Generic;
namespace Core.Erp.Bus.Contabilidad
{
    public class ct_punto_cargo_Bus
    {
         ct_punto_cargo_Data odata = new  ct_punto_cargo_Data();
        public List< ct_punto_cargo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
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

        public  ct_punto_cargo_Info get_info(int IdEmpresa, int IdPuntoCargo)
        {
            try
            {
                return odata.get_info(IdEmpresa,IdPuntoCargo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB( ct_punto_cargo_Info info)
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

        public bool modificarDB( ct_punto_cargo_Info info)
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

        public bool anularDB( ct_punto_cargo_Info info)
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
