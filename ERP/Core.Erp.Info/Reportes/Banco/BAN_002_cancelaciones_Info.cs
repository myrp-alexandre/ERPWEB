using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Banco
{
    public class BAN_002_cancelaciones_Info
    {
        public int mcj_IdEmpresa { get; set; }
        public int mcj_IdTipocbte { get; set; }
        public decimal mcj_IdCbteCble { get; set; }
        public int mba_IdEmpresa { get; set; }
        public decimal mba_IdCbteCble { get; set; }
        public int mba_IdTipocbte { get; set; }
        public string Referencia { get; set; }
        public string Observacion { get; set; }
    }
}
