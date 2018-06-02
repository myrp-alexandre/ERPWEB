using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.ActivoFijo
{
    public class Af_Depreciacion_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdDepreciacion { get; set; }
        public string Cod_Depreciacion { get; set; }
        public int IdPeriodo { get; set; }
        public string Descripcion { get; set; }
        public System.DateTime Fecha_Depreciacion { get; set; }
        public int Num_Act_Depre { get; set; }
        public double Valor_Tot_Act { get; set; }
        public double Valor_Tot_Depre { get; set; }
        public double Valor_Tot_DepreAcum { get; set; }
        public double Valot_Tot_Importe { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string MotivoAnula { get; set; }
        public string Estado { get; set; }
        public Nullable<int> IdEmpresa_ct { get; set; }
        public Nullable<int> IdTipoCbte { get; set; }
        public Nullable<decimal> IdCbteCble { get; set; }

        //campos que no existen en la tabla

        public Af_Depreciacion_Det_Info info_Af_Depreciacion_Det { get; set; }
    }
}