using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.ActivoFijo
{
    public class Af_Parametros_Info
    {
        public int IdEmpresa { get; set; }
        public int IdTipoCbte { get; set; }
        public int IdTipoCbteMejora { get; set; }
        public int IdTipoCbteBaja { get; set; }
        public int IdTipoCbteVenta { get; set; }
        public int IdTipoCbteRetiro { get; set; }
        public string IdCtaCble_Activo { get; set; }
        public string IdCtaCble_Dep_Acum { get; set; }
        public string IdCtaCble_Gastos_Depre { get; set; }
        public string FormaContabiliza { get; set; }
        public int DiasTransaccionesAFuturo { get; set; }
    }
}
