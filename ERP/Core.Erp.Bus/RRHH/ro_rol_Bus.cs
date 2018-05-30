using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_rol_Bus
    {
        ro_rol_Data odata = new ro_rol_Data();
        public List< ro_rol_Info> get_list(int IdEmpresa )
        {
            try
            {
                return odata.get_list(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_rol_Info get_info(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiqui, int IdPeriodo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdNominaTipo, IdNominaTipoLiqui, IdPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool procesar( ro_rol_Info info)
        {
            try
            {
                return odata.procesar(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
