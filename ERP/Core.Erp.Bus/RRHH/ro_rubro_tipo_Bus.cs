using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
namespace Core.Erp.Bus.RRHH
{
    public class ro_rubro_tipo_Bus
    {
        ro_rubro_tipo_Data odata = new ro_rubro_tipo_Data();
        public List<ro_rubro_tipo_Info> get_list(int IdEmpresa, bool estado)
        {
            try
            {
                return odata.get_list(IdEmpresa, estado);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_rubro_tipo_Info> get_list_rub_acumula(int IdEmpresa)
        {
            try
            {
                return odata.get_list_rub_acumula(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_rubro_tipo_Info> get_list_rub_concepto(int IdEmpresa)
        {
            try
            {
                return odata.get_list_rub_concepto(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_rubro_tipo_Info get_info(int IdEmpresa, string IdRubro)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdRubro);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_rubro_tipo_Info info)
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

        public bool modificarDB(ro_rubro_tipo_Info info)
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

        public bool anularDB(ro_rubro_tipo_Info info)
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
