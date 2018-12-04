using Core.Erp.Data.Presupuesto;
using Core.Erp.Info.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Presupuesto
{
    public class pre_Presupuesto_Bus
    {
        pre_Presupuesto_Data oData = new pre_Presupuesto_Data();


        public List<pre_Presupuesto_Info> GetList(int IdEmpresa, int IdSucursal, DateTime FechaInicio, DateTime FechaFin, bool MostrarAnulados)
        {
            try
            {
                return oData.get_list(IdEmpresa, IdSucursal, FechaInicio, FechaFin, MostrarAnulados);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public pre_Presupuesto_Info GetInfo(int IdEmpresa, int IdRubro)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdRubro);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
