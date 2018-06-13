using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorPagar
{
   public class cp_orden_pago_tipo_x_empresa_Info
    {
        public int IdEmpresa { get; set; }
        public string IdTipo_op { get; set; }
        public string IdCtaCble { get; set; }
        public string IdCentroCosto { get; set; }
        public Nullable<int> IdTipoCbte_OP { get; set; }
        public Nullable<int> IdTipoCbte_OP_anulacion { get; set; }
        public string IdEstadoAprobacion { get; set; }
        public string Buscar_FactxPagar { get; set; }
        public string IdCtaCble_Credito { get; set; }
        public Nullable<bool> Dispara_Alerta { get; set; }
    }
}
