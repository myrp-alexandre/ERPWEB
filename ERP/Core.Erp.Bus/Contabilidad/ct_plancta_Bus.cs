using Core.Erp.Data.Contabilidad;
using Core.Erp.Info.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Contabilidad
{
    public class ct_plancta_Bus
    {
        ct_plancta_Data odata = new ct_plancta_Data();
        public List<ct_plancta_Info> get_list(int IdEmpresa, bool mostrar_anulados, bool mostrar_solo_cuentas_movimiento)
        {
            try
            {
                return odata.get_list(IdEmpresa, mostrar_anulados, mostrar_solo_cuentas_movimiento);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ct_plancta_Info get_info(int IdEmpresa, string IdCtaCble)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdCtaCble);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ct_plancta_Info info)
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

        public bool modificarDB(ct_plancta_Info info)
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

        public bool anularDB(ct_plancta_Info info)
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
        public ct_plancta_Info get_info_nuevo(int IdEmpresa, string IdCtaCble_padre)
        {
            try
            {
                return odata.get_info_nuevo(IdEmpresa, IdCtaCble_padre);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool validar_existe_id(int IdEmpresa, string IdCtaCble)
        {
            try
            {
                return odata.validar_existe_id(IdEmpresa, IdCtaCble);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
