using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.ActivoFijo
{
    public class Af_Depreciacion_Det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdDepreciacion { get; set; }
        public int IdTipoDepreciacion { get; set; }
        public int Secuencia { get; set; }
        public int IdActivoFijo { get; set; }
        public int Ciclo { get; set; }
        public string Concepto { get; set; }
        public double Valor_Compra { get; set; }
        public double Valor_Salvamento { get; set; }
        public int Vida_Util { get; set; }
        public double Porc_Depreciacion { get; set; }
        public double Valor_Depreciacion { get; set; }
        public double Valor_Depre_Acum { get; set; }
        public double Valor_Importe { get; set; }
        public bool Es_Activo_x_Mejora { get; set; }
    }
}
