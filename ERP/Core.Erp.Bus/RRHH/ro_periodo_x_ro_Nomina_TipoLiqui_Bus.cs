using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_periodo_x_ro_Nomina_TipoLiqui_Bus
    {
        ro_periodo_x_ro_Nomina_TipoLiqui_Data odata = new ro_periodo_x_ro_Nomina_TipoLiqui_Data();
        public List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> get_list(int IdEmpresa,int IdNominaTipo, int IdNominaTipoLiq)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdNominaTipo,IdNominaTipoLiq);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_periodo_x_ro_Nomina_TipoLiqui_Info get_info(int IdEmpresa, int IdNominaTipo, int IdNominaTipoLiq, int IdPeriodo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdNominaTipo, IdNominaTipoLiq, IdPeriodo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_periodo_x_ro_Nomina_TipoLiqui_Info info)
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

      
        public bool anularDB(ro_periodo_x_ro_Nomina_TipoLiqui_Info info)
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
