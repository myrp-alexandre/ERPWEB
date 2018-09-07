using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_tabla_Impu_Renta_Info
    {
        public int AnioFiscal { get; set; }
        public int Secuencia { get; set; }
        public Nullable<double> FraccionBasica { get; set; }
        public Nullable<double> ExcesoHasta { get; set; }
        public Nullable<double> ImpFraccionBasica { get; set; }
        public Nullable<double> Por_ImpFraccion_Exce { get; set; }
    }
}
