using Core.Erp.Data.Reportes.Banco;
using Core.Erp.Info.Reportes.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Reportes.Banco
{
    public class BAN_004_Bus
    {
        BAN_004_Data odata = new BAN_004_Data();
    
        public List<BAN_004_Info> get_list(int IdEmpresa, int Idbanco, decimal IdConciliacion)
        {
            try
            {
                return odata.get_list(IdEmpresa, Idbanco, IdConciliacion);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
