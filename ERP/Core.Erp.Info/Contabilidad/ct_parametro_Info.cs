using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Contabilidad
{
    public class ct_parametro_Info
    {
        public int IdEmpresa { get; set; }
        public Nullable<int> IdTipoCbte_SaldoInicial { get; set; }
        public Nullable<int> IdTipoCbte_AsientoCierre_Anual { get; set; }
        public bool P_Se_Muestra_Todas_las_ctas_en_combos { get; set; }
        
    }
}
