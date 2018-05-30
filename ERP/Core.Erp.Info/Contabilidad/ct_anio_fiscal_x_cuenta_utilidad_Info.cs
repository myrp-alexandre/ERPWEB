using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Contabilidad
{
    public class ct_anio_fiscal_x_cuenta_utilidad_Info
    {
        public int IdEmpresa { get; set; }
        public int IdanioFiscal { get; set; }
        public string IdCtaCble { get; set; }
        public string observacion { get; set; }
        public Nullable<int> IdEmpresa_cbte_cierre { get; set; }
        public Nullable<int> IdTipoCbte_cbte_cierre { get; set; }
        public Nullable<decimal> IdCbteCble_cbte_cierre { get; set; }
        
       
    }
}
