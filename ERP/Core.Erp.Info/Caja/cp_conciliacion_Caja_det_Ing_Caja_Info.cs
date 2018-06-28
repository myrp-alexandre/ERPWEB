using System;

namespace Core.Erp.Info.Caja
{
    public class cp_conciliacion_Caja_det_Ing_Caja_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdConciliacion_Caja { get; set; }
        public int secuencia { get; set; }
        public int IdEmpresa_movcaj { get; set; }
        public decimal IdCbteCble_movcaj { get; set; }
        public int IdTipocbte_movcaj { get; set; }
        public double valor_aplicado { get; set; }
        public double valor_disponible { get; set; }
        public object cm_observacion { get; set; }
        public object cm_fecha { get; set; }
        public object Total_movi { get; set; }
        public object Total_aplicado { get; set; }
        public object Saldo { get; set; }
    }
}
