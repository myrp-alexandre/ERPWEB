using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Contabilidad;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Contabilidad
{
    public class ct_cbtecble_Bus
    {
        ct_cbtecble_Data odata = new ct_cbtecble_Data();

        public List<ct_cbtecble_Info> get_list(int IdEmpresa, int IdSucursal, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, mostrar_anulados, fecha_ini, fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ct_cbtecble_Info get_info(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdTipoCbte, IdCbteCble);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ct_cbtecble_Info info)
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

        public bool modificarDB(ct_cbtecble_Info info)
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

        public bool anularDB(ct_cbtecble_Info info)
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
