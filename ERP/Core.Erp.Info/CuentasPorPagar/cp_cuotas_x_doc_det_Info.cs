using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorPagar
{
  public  class cp_cuotas_x_doc_det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdCuota { get; set; }
        public int Secuencia { get; set; }
        public int Num_cuota { get; set; }
        public System.DateTime Fecha_vcto_cuota { get; set; }
        public double Valor_cuota { get; set; }
        public string Observacion { get; set; }
        public bool Estado { get; set; }
        public Nullable<int> IdEmpresa_op { get; set; }
        public Nullable<decimal> IdOrdenPago { get; set; }
        public Nullable<int> Secuencia_op { get; set; }
    }
}
