using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorCobrar
{
   public class cxc_Parametro_Info
    {
        public int IdEmpresa { get; set; }
        public int pa_tipoND_x_CheqProtestado { get; set; }
        public Nullable<int> pa_IdCaja_x_cobros_x_CXC { get; set; }
        public Nullable<int> pa_IdTipoMoviCaja_x_Cobros_x_cliente { get; set; }
        public Nullable<int> pa_IdTipoCbteCble_CxC { get; set; }
        public Nullable<int> pa_IdTipoCbteCble_CxC_ANU { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaUltMod { get; set; }
        public Nullable<int> pa_IdCaja_x_Default { get; set; }
        public Nullable<int> pa_IdTipoCbte_x_conciliacion { get; set; }
        public string pa_IdCobro_tipo_Comision_TC { get; set; }
        public string pa_IdCobro_tipo_default { get; set; }
    }
}
