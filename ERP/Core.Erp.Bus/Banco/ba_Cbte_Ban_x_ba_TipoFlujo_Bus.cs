using Core.Erp.Data.Banco;
using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Banco
{
    public class ba_Cbte_Ban_x_ba_TipoFlujo_Bus
    {
        ba_Cbte_Ban_x_ba_TipoFlujo_Data odata = new ba_Cbte_Ban_x_ba_TipoFlujo_Data();
        public List<ba_Cbte_Ban_x_ba_TipoFlujo_Info> GetList(int IdEmpresa, decimal IdTipoFlujo)
        {
            try
            {
                return odata.GetList(IdEmpresa, IdTipoFlujo);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
