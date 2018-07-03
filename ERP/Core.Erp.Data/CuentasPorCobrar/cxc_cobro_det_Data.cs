using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
    public class cxc_cobro_det_Data
    {
        public List<cxc_cobro_Info> get_list_caetera(int IdEmpresa, int IdSucursal)
        {
            try
            {
                List<cxc_cobro_Info> Lista;

                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    Lista = new List<cxc_cobro_Info>();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
