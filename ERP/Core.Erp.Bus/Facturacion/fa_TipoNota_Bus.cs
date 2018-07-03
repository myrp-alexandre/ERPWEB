using Core.Erp.Data.Facturacion;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Facturacion
{
    public class fa_TipoNota_Bus
    {
        fa_TipoNota_Data odata = new fa_TipoNota_Data();
    
        public List<fa_TipoNota_Info> get_list(bool mostrar_anulados)
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
        public List<fa_TipoNota_Info> get_list(string Tipo, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(Tipo, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public fa_TipoNota_Info get_info(int IdTipoNota)
        {
            try
            {
                return odata.get_info(IdTipoNota);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(fa_TipoNota_Info info)
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
        public bool modificarDB(fa_TipoNota_Info info)
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
        public bool anularDB(fa_TipoNota_Info info)
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
