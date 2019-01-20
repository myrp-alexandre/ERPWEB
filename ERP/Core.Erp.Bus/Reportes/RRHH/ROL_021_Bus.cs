using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.RRHH
{
   public class ROL_021_Bus
    {
        ROL_021_Data odata = new ROL_021_Data();
        public List<ROL_021_Info> get_list(int IdEmpresa, int IdNomina, int IdSucursal, int IdArea,
           int IdDivision, int IdNominaTipo, int IdPeriodo, string tipoRubro)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdNomina,  IdSucursal, IdArea, IdDivision, IdNominaTipo, IdPeriodo, tipoRubro);
            }
            catch (Exception)
            {

                throw;
            }
        }
        }
}
